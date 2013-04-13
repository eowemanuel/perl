/* -*- buffer-read-only: t -*-
 * !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!!
 * This file is built by regen/unicode_constants.pl from Unicode data.
 * Any changes made here will be lost!
 */


#ifndef H_UNICODE_CONSTANTS   /* Guard against nested #includes */
#define H_UNICODE_CONSTANTS   1

/* This file contains #defines for various Unicode code points.  The values
 * the macros expand to are the native Unicode code point, or all or portions
 * of the UTF-8 encoding for the code point.  In the former case, the macro
 * name has the suffix "_NATIVE"; otherwise, the suffix "_UTF8".
 *
 * The macros that have the suffix "_UTF8" may have further suffixes, as
 * follows:
 *  "_FIRST_BYTE" if the value is just the first byte of the UTF-8
 *                representation; the value will be a numeric constant.
 *  "_TAIL"       if instead it represents all but the first byte.  This, and
 *                with no additional suffix are both string constants */


#define COMBINING_GRAVE_ACCENT_UTF8  "\xCC\x80"    /* U+0300 */
#define COMBINING_ACUTE_ACCENT_UTF8  "\xCC\x81"    /* U+0301 */
#define COMBINING_DIAERESIS_UTF8  "\xCC\x88"    /* U+0308 */

#define GREEK_SMALL_LETTER_IOTA_UTF8  "\xCE\xB9"    /* U+03B9 */

#define GREEK_SMALL_LETTER_UPSILON_UTF8  "\xCF\x85"    /* U+03C5 */

#define HYPHEN_UTF8  "\xE2\x80\x90"    /* U+2010 */
#define FIRST_SURROGATE_UTF8_FIRST_BYTE  0xED    /* U+D800 */
#define BOM_UTF8_FIRST_BYTE  0xEF    /* U+FEFF */
#define BOM_UTF8_TAIL  "\xBB\xBF"    /* U+FEFF */

#define DEL_NATIVE  0x7F    /* U+007F */
#define CR_NATIVE  0x0D    /* U+000D */
#define LF_NATIVE  0x0A    /* U+000A */
#define LATIN_SMALL_LETTER_SHARP_S_NATIVE  0xDF    /* U+00DF */
#define LATIN_SMALL_LETTER_A_WITH_RING_ABOVE_NATIVE  0xE5    /* U+00E5 */
#define LATIN_CAPITAL_LETTER_A_WITH_RING_ABOVE_NATIVE  0xC5    /* U+00C5 */
#define LATIN_SMALL_LETTER_Y_WITH_DIAERESIS_NATIVE  0xFF    /* U+00FF */
#define MICRO_SIGN_NATIVE  0xB5    /* U+00B5 */

#endif /* H_UNICODE_CONSTANTS */

/* ex: set ro: */
