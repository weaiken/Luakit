$!
$! Check operation of "bc".
$!
$! 2010-04-05 SMS.  New.  Based (loosely) on "bctest".
$!
$!
$ tmp_file_name = "tmp.bctest"
$ failure = ""
$!
$! Basic command test.
$!
$ on warning then goto bc_fail
$ bc
$ on error then exit
$!
$! Test for SunOS 5.[78] bc bug.
$!
$ if (failure .eqs. "")
$ then
$!
$     define /user_mode sys$output 'tmp_file_name'
$     bc
obase=16
ibase=16
a=AD88C418F31B3FC712D0425001D522B3AE9134FF3A98C13C1FCC1682211195406C1A6C66C6A\
CEEC1A0EC16950233F77F1C2F2363D56DD71A36C57E0B2511FC4BA8F22D261FE2E9356D99AF57\
10F3817C0E05BF79C423C3F66FDF321BE8D3F18F625D91B670931C1EF25F28E489BDA1C5422D1\
C3F6F7A1AD21585746ECC4F10A14A778AF56F08898E965E9909E965E0CB6F85B514150C644759\
3BE731877B16EA07B552088FF2EA728AC5E0FF3A23EB939304519AB8B60F2C33D6BA0945B66F0\
4FC3CADF855448B24A9D7640BCF473E
b=DCE91E7D120B983EA9A104B5A96D634DD644C37657B1C7860B45E6838999B3DCE5A555583C6\
9209E41F413422954175A06E67FFEF6746DD652F0F48AEFECC3D8CAC13523BDAAD3F5AF4212BD\
8B3CD64126E1A82E190228020C05B91C8B141F1110086FC2A4C6ED631EBA129D04BB9A19FC53D\
3ED0E2017D60A68775B75481449
(a/b)*b + (a%b) - a
$     status = $status
$     output_expected = "0"
$     gosub check_output
$     if (output .ne. 1)
$     then
$         failure = "SunOStest"
$     else
$         delete 'f$parse( tmp_file_name)'
$     endif
$ endif
$!
$! Test for SCO bc bug.
$!
$ if (failure .eqs. "")
$ then
$!
$     define /user_mode sys$output 'tmp_file_name'
$     bc
obase=16
ibase=16
-FFDD63BA1A4648F0D804F8A1C66C53F0D2110590E8A3907EC73B4AEC6F15AC177F176F2274D2\
9DC8022EA0D7DD3ABE9746D2D46DD3EA5B5F6F69DF12877E0AC5E7F5ADFACEE54573F5D256A06\
11B5D2BC24947724E22AE4EC3FB0C39D9B4694A01AFE5E43B4D99FB9812A0E4A5773D8B254117\
1239157EC6E3D8D50199 * -FFDD63BA1A4648F0D804F8A1C66C53F0D2110590E8A3907EC73B4\
AEC6F15AC177F176F2274D29DC8022EA0D7DD3ABE9746D2D46DD3EA5B5F6F69DF12877E0AC5E7\
F5ADFACEE54573F5D256A0611B5D2BC24947724E22AE4EC3FB0C39D9B4694A01AFE5E43B4D99F\
B9812A0E4A5773D8B2541171239157EC6E3D8D50199 - FFBACC221682DA464B6D7F123482522\
02EDAEDCA38C3B69E9B7BBCD6165A9CD8716C4903417F23C09A85B851961F92C217258CEEB866\
85EFCC5DD131853A02C07A873B8E2AF2E40C6D5ED598CD0E8F35AD49F3C3A17FDB7653E4E2DC4\
A8D23CC34686EE4AD01F7407A7CD74429AC6D36DBF0CB6A3E302D0E5BDFCD048A3B90C1BE5AA8\
E16C3D5884F9136B43FF7BB443764153D4AEC176C681B078F4CC53D6EB6AB76285537DDEE7C18\
8C72441B52EDBDDBC77E02D34E513F2AABF92F44109CAFE8242BD0ECBAC5604A94B02EA44D43C\
04E9476E6FBC48043916BFA1485C6093603600273C9C33F13114D78064AE42F3DC466C7DA543D\
89C8D71
AD534AFBED2FA39EE9F40E20FCF9E2C861024DB98DDCBA1CD118C49CA55EEBC20D6BA51B2271C\
928B693D6A73F67FEB1B4571448588B46194617D25D910C6A9A130CC963155CF34079CB218A44\
8A1F57E276D92A33386DDCA3D241DB78C8974ABD71DD05B0FA555709C9910D745185E6FE108E3\
37F1907D0C56F8BFBF52B9704 % -E557905B56B13441574CAFCE2BD257A750B1A8B2C88D0E36\
E18EF7C38DAC80D3948E17ED63AFF3B3467866E3B89D09A81B3D16B52F6A3C7134D3C6F5123E9\
F617E3145BBFBE9AFD0D6E437EA4FF6F04BC67C4F1458B4F0F47B64 - 1C2BBBB19B74E86FD32\
9E8DB6A8C3B1B9986D57ED5419C2E855F7D5469E35E76334BB42F4C43E3F3A31B9697C171DAC4\
D97935A7E1A14AD209D6CF811F55C6DB83AA9E6DFECFCD6669DED7171EE22A40C6181615CAF3F\
5296964
$     status = $status
$     output_expected = "0\0"
$     gosub check_output
$     if (output .ne. 1)
$     then
$         failure = "SCOtest"
$     else
$         delete 'f$parse( tmp_file_name)'
$     endif
$ endif
$!
$! Test for working 'print' command.
$!
$ if (failure .eqs. "")
$ then
$!
$     define /user_mode sys$output 'tmp_file_name'
$     bc
print "OK"
$     status = $status
$     output_expected = "OK"
$     gosub check_output
$     if (output .ne. 1)
$     then
$         failure = "printtest"
$     else
$         delete 'f$parse( tmp_file_name)'
$     endif
$ endif
$!
$ if (failure .nes. "")
$ then
$     write sys$output -
       "No working bc found.  Consider installing GNU bc."
$     exit %X00030000 ! %DCL-W-NORMAL
$ endif
$!
$ exit
$!
$!
$! Complete "bc" command failure.
$!
$ bc_fail:
$ write sys$output -
   "No ""bc"" program/symbol found.  Consider installing GNU bc."
$ exit %X00030000 ! %DCL-W-NORMAL
$!
$!
$! Output check subroutine.
$!
$ check_output:
$     eof = 0
$     line_nr = 0
$     open /read tmp_file 'tmp_file_name'
$     c_o_loop:
$         read /error = error_read tmp_file line
$         goto ok_read
$         error_read:
$         eof = 1
$         ok_read:
$         line_expected = f$element( line_nr, "\", output_expected)
$         line_nr = line_nr+ 1
$     if ((line_expected .nes. "\") .and. (.not. eof) .and. -
       (line_expected .eqs. line)) then goto c_o_loop
$!
$     if ((line_expected .eqs. "\") .and. eof)
$     then
$         output = 1
$     else
$         output = 0
$     endif
$     close tmp_file
$ return
$!
