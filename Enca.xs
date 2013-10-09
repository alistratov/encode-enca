#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "enca.h"

#include "const-c.inc"

MODULE = Encode::Enca		PACKAGE = Encode::Enca

INCLUDE: const-xs.inc


int
get_number_of_charsets()
	PROTOTYPE:
	CODE:
		RETVAL = enca_number_of_charsets();
	OUTPUT:
		RETVAL


SV*
get_charset_properties(int charset)
	PROTOTYPE:
		$
	INIT:
		HV *result;
		result = (HV *)sv_2mortal((SV *)newHV());
	CODE:
		//DEBUG
		//printf("[-] charset props: %d\n", charset);

		EncaCharsetFlags f = enca_charset_properties(charset);
		EncaSurface s = enca_charset_natural_surface(charset);
		int has_ucs2 = enca_charset_has_ucs2_map(charset);

		hv_store(result, "id", 			 2, newSViv(charset), 0);

		hv_store(result, "flags", 		 5, newSViv(f), 0);
		hv_store(result, "nsurface_id", 	11, newSViv(s), 0);
		hv_store(result, "has_ucs2_map", 	12, newSViv(has_ucs2), 0);
		
		hv_store(result, "name_enca", 		 9, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_ENCA), 0), 0);
		hv_store(result, "name_rfc1345",       	12, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_RFC1345), 0), 0);
		hv_store(result, "name_cstocs", 	11, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_CSTOCS), 0), 0);
		hv_store(result, "name_iconv", 		10, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_ICONV), 0), 0);
		hv_store(result, "name_mime", 		 9, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_MIME), 0), 0);
		hv_store(result, "name_human", 		10, newSVpv(enca_charset_name(charset, ENCA_NAME_STYLE_HUMAN), 0), 0);
		
		AV *aliases = (AV *)sv_2mortal((SV *)newAV());
		size_t num_aliases, j;
		const char **aliases_list = enca_get_charset_aliases(charset, &num_aliases);
		for (j = 0; j < num_aliases; j++) {
			av_push(aliases, newSVpv(aliases_list[j], 0));
		}
		hv_store(result, "aliases", 7, newRV((SV *)aliases), 0);

		RETVAL = newRV((SV *)result);
	OUTPUT:
		RETVAL


SV*
get_surface_properties(int surface)
	PROTOTYPE: $
	INIT:
		HV *result;
		result = (HV *)sv_2mortal((SV *)newHV());
	CODE:
		//DEBUG
		//printf("[-] surface props: %d\n", surface);

		hv_store(result, "id", 			 2, newSViv(surface), 0);

		hv_store(result, "name_enca", 		 9, newSVpv(enca_get_surface_name(surface, ENCA_NAME_STYLE_ENCA), 0), 0);
		hv_store(result, "name_human", 		10, newSVpv(enca_get_surface_name(surface, ENCA_NAME_STYLE_HUMAN), 0), 0);

		RETVAL = newRV((SV *)result);
	OUTPUT:
		RETVAL


SV*
get_list_of_languages()
	PROTOTYPE:
	INIT:
		AV *result;
		size_t num_lang, i;
		const char **lang;
		result = (AV *)sv_2mortal((SV *)newAV());
	CODE:
		lang = enca_get_languages(&num_lang);
		for (i = 0; i < num_lang; i++) {
			av_push(result, newSVpv(lang[i], 0));
		}
		RETVAL = newRV((SV *)result);
	OUTPUT:
		RETVAL


SV*
get_language_properties(char *language)
	PROTOTYPE: $
	INIT:
		HV *result;
		result = (HV *)sv_2mortal((SV *)newHV());
	CODE:
		hv_store(result, "id", 		 	 2, newSVpv(language, 0), 0);
		hv_store(result, "name", 		 4, newSVpv(enca_language_english_name(language), 0), 0);

		AV *charsets = (AV *)sv_2mortal((SV *)newAV());
		size_t num_charsets, j;
		int *charsets_list = enca_get_language_charsets (language, &num_charsets);
		for (j = 0; j < num_charsets; j++) {
			av_push(charsets, newSViv(charsets_list[j]));
		}
		hv_store(result, "ncharsets_ids", 13, newRV((SV *)charsets), 0);

		RETVAL = newRV((SV *)result);
	OUTPUT:
		RETVAL


void
parse_encoding_by_name(char *name)
	PROTOTYPE: $
	PPCODE:
		EncaEncoding e = enca_parse_encoding_name(name);
		XPUSHs(sv_2mortal(newSViv(e.charset)));
		XPUSHs(sv_2mortal(newSViv(e.surface)));


EncaAnalyser
create_analyzer(char *language, SV *multibyte, SV *interpreted_surfaces, SV *ambiguity, SV *filtering, SV *garbage_test, SV *termination_strictness, SV *significant, SV *threshold)
	PROTOTYPE: $$$$$$$$$
	CODE:
		EncaAnalyser an = enca_analyser_alloc(language);
		
		if (an) {
			if (SvOK(multibyte)) {
				printf("Set multibyte: %d", SvTRUE(multibyte));
				enca_set_multibyte(an, SvTRUE(multibyte));
			}
			if (SvOK(interpreted_surfaces)) {
				printf("Set interpreted_surfaces: %d", SvTRUE(interpreted_surfaces));
				enca_set_interpreted_surfaces(an, SvTRUE(interpreted_surfaces));
			}
			if (SvOK(ambiguity)) {
				printf("Set ambiguity: %d", SvTRUE(ambiguity));
				enca_set_ambiguity(an, SvTRUE(ambiguity));
			}
			if (SvOK(filtering)) {
				printf("Set filtering: %d", SvTRUE(filtering));
				enca_set_filtering(an, SvTRUE(filtering));
			}
			if (SvOK(garbage_test)) {
				printf("Set garbage_test: %d", SvTRUE(garbage_test));
				enca_set_garbage_test(an, SvTRUE(garbage_test));
			}
			if (SvOK(termination_strictness)) {
				printf("Set termination_strictness: %d", SvTRUE(termination_strictness));
				enca_set_termination_strictness(an, SvTRUE(termination_strictness));
			}
			if (SvOK(significant)) {
				printf("Set significant: %d", (int)SvIV(significant));
				enca_set_significant(an, SvIV(significant));
			}
			if (SvOK(threshold)) {
				printf("Set threshold: %g", SvNV(threshold));
				enca_set_threshold(an, SvNV(threshold));
			}
		}
		
		RETVAL = an;
	OUTPUT:
		RETVAL


void
delete_analyzer(EncaAnalyser analyser)
	PROTOTYPE: $
	CODE:
		enca_analyser_free(analyser);


int
analyzer_error_errno(EncaAnalyser analyser)
	PROTOTYPE: $
	INIT:
	CODE:
		RETVAL = enca_errno(analyser);
	OUTPUT:
		RETVAL


const char*
analyzer_error_errmsg(EncaAnalyser analyser)
	PROTOTYPE: $
	INIT:
		int errnum;
	CODE:
		errnum = enca_errno(analyser);
		RETVAL = enca_strerror(analyser, errnum);
	OUTPUT:
		RETVAL


void
analyze(EncaAnalyser analyser, SV *sample)
	PROTOTYPE: $$
	INIT:
		STRLEN len;
		char *buf;
		EncaEncoding e;
	PPCODE:
		buf = SvPV(sample, len);
		e = enca_analyse_const(analyser, buf, len);
		XPUSHs(sv_2mortal(newSViv(e.charset)));
		XPUSHs(sv_2mortal(newSViv(e.surface)));
