Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70522736C26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjFTMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:44:46 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D79E10DD;
        Tue, 20 Jun 2023 05:44:45 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 79E173A2694;
        Tue, 20 Jun 2023 14:44:43 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 58B873A25AA;
        Tue, 20 Jun 2023 14:44:43 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Tue, 20 Jun 2023 14:44:43 +0200 (CEST)
Content-Type: multipart/signed; 
 boundary=NoSpamProxy_caed715b-a7f6-4323-ba4d-c749779717db; 
 protocol="application/pkcs7-signature"; micalg="sha256"
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Topic: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Index: AdmjdCfpdU8NnQgrT4iRiz4+JBhVQw==
Date:   Tue, 20 Jun 2023 12:44:41 +0000
Message-ID: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27702.007
X-TMASE-Result: 10--14.337600-10.000000
X-TMASE-MatchedRID: U3PagEpWyqJvBOh2s92TSM2CuVPkCNzu2FA7wK9mP9fG5dXdQTj2OIGz
        z42T0DP5p3HiycuTwqB22LX9ExaXqivLSgqaAVoR9k0tWBWiOf/5UnqVnIHSz40nZyQtGDZRcQn
        7AixVvVx72aKohPmGR8+cZr5skxwlUIGCvH0MbYudx4sU8R+eYNUEOicf335Wyuet65/g7pDwbY
        qNisklFI8eV9xXSOFA5p98cjyQCaIdj9vNGYhpkfZOZ2c2VQUgrzD8YrC59vwQRik6+J7XSekgE
        vppMdRRihBIRRThmIoXIQarK0WBEPTxGqS5mxwxSHCU59h5KrGc0xEjtkduy0Jv2xLgykjPrcmm
        D7/hK1+jDiEYA0mQt2c8Uo6La8PbOwBXM346/+zMw/TUDMCQo6lkWO1bfLIA5CAYYsadb/lnUw9
        Y1e62m9Sq60+KNPxX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: b4ac2a58-d29d-4cc3-b17b-fb2b7a638e28-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_QP_LONG_LINE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NoSpamProxy_caed715b-a7f6-4323-ba4d-c749779717db
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Use=72=73pace curre=6Etly h=61=73 no =77ay =6F=66 =63heckin=67 for error =62it=
=73 of
=64=65=74=65c=74=69on mode X. The=73e =61re =65=72=72or b=69=74s that =61r=65 =
o=6El=79 d=65tec=74ed =62y
=74he car=64 w=68=65n executin=67 the =63=6F=6D=6Dand=2E For e.g. a s=61=6Ei=
=74=69ze =6F=70e=72at=69on
=74h=69=73 =6D=61y =62=65 minute=73 a=66ter t=68e RS=50 =77=61s =73=65=65n b=
=79 =74h=65 hos=74.

C=75rre=6Etl=79 userspace pr=6Fg=72=61=6D=73 ca=6Enot =73=65e th=65se er=72or =
b=69=74s relia=62=6Cy.
=54hey co=75l=64 is=73ue a multi =69octl cmd w=69th a =43M=44=313 =69=6Dme=64i=
=61tely =66oll=6F=77=69=6E=67
=69=74, =62ut sin=63e =65r=72ors o=66 de=74=65c=74ion mode =58 =61=72e =61u=74=
=6Fmat=69call=79 =63leare=64
(=74h=65=79 =61=72e all c=6Ce=61=72 =63o=6E=64iti=6F=6E =42=29.
mm=63=5Fpoll=5F=66or=5Fbusy =6Ff =74he fir=73t =69=6Fct=6C may ha=76=65 alread=
=79 =68=69dden =73uch =61n
=65=72=72or f=6Cag.

In =63ase o=66 the se=63u=72ity =6F=70era=74ions: =73=61=6Eit=69z=65, s=65=63u=
=72e e=72=61se=73 a=6Ed
R=50MB wri=74e=73, =74h=69s =63ould l=65ad to th=65 oper=61t=69on =6Eot be=69n=
=67 =70e=72f=6Frme=64
=73uccessfu=6Cly by =74=68e ca=72d w=69=74=68 t=68e us=65r =6E=6Ft kn=6Fw=69n=
=67.
If th=65 =75=73er trus=74s that t=68is op=65rati=6Fn i=73 =63om=70lete=64
(e.g. th=65i=72 =64=61t=61 =69s sani=74ized), thi=73 =63ould be =61 s=65=63uri=
ty issue.
=41=6E at=74ack=65r co=75l=64 e=2Eg. provoke =61 e=4D=4D=43 =28VCC) flash fail=
, wh=65=72e a
successful =73a=6Ei=74=69=7A=65 =6Ff a =63a=72d i=73 not p=6F=73=73ib=6C=65=2E=
 =41 card =6Da=79 m=6Fv=65 out
=6F=66 =50ROG state =62ut i=73s=75e a =62=69t 19 R=31 =65r=72=6Fr.

Th=69s =70=61=74ch =74=68e=72=65for=65 =77ill als=6F =68=61=76e the c=6F=6Es=
=65qu=65nce of a =6Dm=63=2Dut=69=6Cs
pat=63h=2C wh=69ch e=6E=61=62les =74he =62it f=6Fr the secu=72ity-=73e=6Esi=74=
=69=76e o=70=65r=61tions=2E

Signed=2Do=66f-=62y=3A =43=68=72isti=61n =4Coehl=65 =3Ccloe=68l=65=40h=79p=65=
=72ston=65=2E=63=6F=6D=3E
---
 d=72i=76e=72=73/mmc/core=2Fb=6Cock.=63   =7C =32=36 =2B++=2B++=2B+++=2B+++=2B=
=2D=2D----=2D-=2D=2D=2D
 driv=65=72s/m=6Dc/c=6Fr=65/=6Dm=63=5Fops=2E=63 =7C =314 +++=2B+=2B+=2D--=2D--=
-
 d=72iver=73=2F=6Dmc=2Fc=6Fre=2Fmmc=5F=6F=70s=2Eh =7C  9 =2B++=2B+++=2B+
 3 f=69=6Ce=73 changed, =331 i=6Ese=72tions(+=29, 18 delet=69ons=28=2D)

=64iff --git a/=64=72i=76ers/mmc/core/=62=6C=6F=63=6B.c =62/=64r=69=76er=73/mm=
c/core/=62loc=6B=2E=63
index =6546330815=34=38=34..c7e2=62=38=61e58=619 1=300644
-=2D- a/d=72ivers/=6Dmc/co=72e/=62loc=6B.c
+=2B=2B =62/d=72i=76=65r=73/mmc/c=6Fre=2Fblo=63k.c
@@ -=34=37=30=2C=37 +4=37=30=2C=37 =40@ =73tatic =69=6Et =5F=5Fmmc=5Fblk=5F=69=
oc=74l=5Fc=6Dd(str=75ct mmc=5Fc=61=72d *c=61rd, struct m=6Dc=5Fbl=6B=5F=64=61=
=74a *m=64=2C
 =09struct mmc=5F=64at=61 =64a=74a =3D {};
 =09=73=74=72uc=74 =6Dmc=5Freques=74 =6Dr=71 =3D {};
 =09=73tr=75c=74 scat=74erlis=74 =73=67;
-=09bo=6F=6C r1b=5F=72esp, use=5Fr1=62=5Fr=65sp =3D =66alse;
+=09=62=6Fol r1=62=5Fr=65=73=70=3B
 =09=75=6Es=69gne=64 =69n=74 busy=5Ft=69m=65o=75t=5Fms=3B
 =09int =65rr=3B
 =09uns=69g=6Eed =69=6Et tar=67et=5Fp=61=72t;
@@ -551=2C=38 +5=351=2C7 =40@ stat=69=63 i=6E=74 =5F=5Fmmc=5Fblk=5Fi=6Fc=74=6C=
=5Fc=6D=64=28=73=74ruct =6Dmc=5Fca=72d *c=61rd=2C s=74ruct mmc=5F=62l=6B=5Fdat=
a *m=64,
 =09bus=79=5Ftim=65o=75t=5F=6D=73 =3D idata-=3Eic=2E=63m=64=5Fti=6D=65out=5Fms=
 =3F =3A MMC=5FBL=4B=5FT=49=4D=45=4F=55T=5FMS;
 =09r=31=62=5Fre=73p =3D (=63m=64=2Ef=6Ca=67s =26 =4D=4DC=5F=52SP=5F=52=31B=29=
 =3D=3D M=4D=43=5F=52SP=5FR1B;
 =09if =28=721b=5Fresp)
=2D=09=09=75se=5F=721b=5Fresp =3D m=6Dc=5Fp=72=65=70are=5Fbusy=5Fc=6Dd(card-=
=3Ehost, &cmd=2C
-=09=09=09=09=09=09    b=75s=79=5Ftimeou=74=5Fm=73);
=2B=09=09=6Dm=63=5Fprepare=5Fb=75s=79=5F=63md(=63a=72=64->=68=6F=73t, &cmd=2C =
busy=5Ft=69=6D=65ou=74=5Fm=73=29=3B
 
 =09m=6D=63=5Fw=61it=5Ffor=5F=72eq(=63ar=64->host, &mr=71=29;
 =09m=65mcpy(=26i=64=61=74a=2D>ic=2Eres=70o=6Ese=2C cm=64.r=65sp, s=69=7Ae=6Ff=
(=63m=64.=72es=70=29);
@=40 =2D6=305=2C1=39 +604,=324 @=40 s=74=61t=69c int =5F=5Fmmc=5F=62lk=5Fi=6Fc=
tl=5Fcmd(=73tr=75ct m=6D=63=5Fc=61rd =2Acard, st=72=75=63=74 mmc=5Fb=6Ck=5Fd=
=61ta *=6Dd,
 =09if (id=61ta=2D>i=63.po=73=74s=6C=65ep=5Fmin=5Fus=29
 =09=09u=73leep=5F=72=61n=67=65(=69da=74=61->i=63.post=73le=65p=5Fmi=6E=5Fus, =
=69d=61t=61=2D=3Ei=63=2Epost=73le=65=70=5F=6D=61x=5F=75s=29;
 
=2D=09/* N=6F n=65e=64 to po=6C=6C when us=69ng =48W busy de=74e=63t=69on. */
-=09if (=28=63ar=64-=3Eh=6Fs=74->ca=70=73 & =4D=4D=43=5FCAP=5FW=41IT=5FWHIL=45=
=5FBU=53Y) &=26 =75se=5Fr1b=5Fresp=29
-=09=09r=65turn =30;
=2D
 =09i=66 (=6D=6D=63=5F=68os=74=5Fis=5Fspi=28=63a=72=64->h=6Fst)) =7B
 =09=09if (ida=74a->ic=2Ewrite=5F=66=6C=61g =7C=7C =72=31b=5Fr=65sp =7C| cm=64=
.flag=73 & MM=43=5F=52=53=50=5FSPI=5F=42U=53=59)
 =09=09=09re=74=75r=6E m=6D=63=5F=73=70i=5Ferr=5Fche=63k=28car=64=29;
 =09=09retur=6E =65=72=72;
 =09=7D
-=09=2F=2A En=73=75=72=65 RPMB/=521=42 =63omma=6E=64 h=61s c=6F=6Dpleted by po=
llin=67 w=69=74=68 CMD=313. */
-=09i=66 =28i=64ata->rpm=62 |=7C r1=62=5Fresp=29
-=09=09er=72 =3D m=6D=63=5F=70oll=5F=66or=5F=62=75s=79=28=63=61rd, busy=5Fti=
=6De=6Fu=74=5F=6Ds, fals=65=2C
=2D=09=09=09=09=09MM=43=5F=42USY=5FIO)=3B
+=09=2F* =50o=6C=6C f=6Fr R=50=4DB=2Fwrite/=521=42 =65=78e=63ut=69on error=73 =
*/
+=09if (idata->rpm=62 || i=64a=74=61->i=63=2E=77rit=65=5F=66=6C=61=67 =7C| r=
=31=62=5Fres=70) {
+=09=09struct =6Dm=63=5Fbus=79=5F=64=61ta cb=5Fdat=61;
+
=2B=09=09cb=5Fdata=2Ecar=64 =3D =63=61rd=3B
+=09=09c=62=5Fdata=2Eretr=79=5Fcrc=5Fe=72r =3D false;
=2B=09=09c=62=5F=64a=74a.a=67gr=65gate=5Fe=72=72=5Ff=6Ca=67s =3D tr=75=65;
+=09=09cb=5Fd=61ta=2Eb=75sy=5Fc=6Dd =3D M=4D=43=5F=42USY=5F=49O=3B
=2B=09=09cb=5Fd=61t=61=2Es=74at=75s =3D &id=61t=61=2D>i=63.resp=6F=6E=73e=5B=
=30=5D;
+=09=09er=72 =3D =5F=5F=6Dmc=5F=70oll=5F=66or=5Fbusy=28c=61=72=64=2D=3Eho=73t,=
 =30=2C =62usy=5Ftimeou=74=5Fms=2C
+=09=09=09=09&m=6D=63=5F=62usy=5Fcb, &cb=5F=64ata=29=3B
+
+=09}
 
 =09ret=75rn =65rr;
 }
di=66=66 --=67it =61=2Fdriv=65=72=73/=6Dmc/core/=6Dm=63=5Fops.c b/=64riv=65rs/=
mm=63=2F=63o=72e=2F=6Dm=63=5F=6Fps.=63
index 3=623=61=64b=64d=66=366=34..1=35d=38=628=30=36c670 10=30644
=2D-=2D =61=2Fdr=69ver=73=2Fmmc=2Fcor=65=2F=6Dmc=5Fop=73=2Ec
+++ b/d=72i=76=65r=73=2Fmmc=2F=63o=72=65/mmc=5Fops=2E=63
@@ =2D=35=34,11 +=354,=36 @=40 st=61=74i=63 =63=6Fnst u=38 =74u=6Ein=67=5F=62l=
k=5Fpa=74t=65rn=5F=38=62it=5B] =3D {
 =09=30=78=66f, 0x7=37=2C =30x7=37, 0xf=66, 0=78=377=2C 0xbb, 0=78dd, 0=78e=65=
,
 }=3B
 
-struc=74 mm=63=5Fbusy=5Fdata {
=2D=09s=74r=75ct m=6Dc=5F=63ar=64 *car=64=3B
-=09=62ool =72=65t=72y=5Fcr=63=5Ferr;
=2D=09enum mmc=5Fbu=73y=5Fc=6D=64 b=75sy=5Fc=6Dd;
-=7D=3B
 
 s=74=72=75=63=74 mmc=5F=6F=70=5F=63o=6Ed=5Fb=75=73y=5Fda=74a {
 =09str=75=63t mm=63=5Fho=73t *ho=73t;
@@ -45=37,1=34 +=3452,1=35 @=40 int m=6Dc=5F=73=77i=74c=68=5Fsta=74us(str=75=
=63=74 mm=63=5Fc=61rd =2A=63a=72d, bool =63rc=5F=65rr=5F=66a=74al)
 =09=72=65turn m=6Dc=5Fs=77itc=68=5F=73t=61tu=73=5Fe=72r=6Fr(=63=61r=64->=68os=
t, stat=75s=29;
 }
 
-=73t=61tic i=6E=74 =6D=6Dc=5Fb=75=73y=5Fcb(voi=64 *=63b=5Fd=61ta, bool =2Abus=
y)
+int =6D=6Dc=5Fbu=73y=5Fc=62=28void *=63b=5Fdat=61=2C bo=6Fl *=62=75s=79)
 {
 =09st=72=75=63=74 mmc=5F=62us=79=5F=64a=74=61 =2Ad=61ta =3D c=62=5Fdata;
 =09=73=74=72=75=63t mmc=5Fhos=74 *host =3D da=74=61=2D>ca=72d->=68os=74=3B
 =09u=332 =73tatus =3D =30;
 =09int =65r=72;
 
-=09=69f (=64=61ta=2D>=62=75sy=5Fcm=64 =21=3D M=4D=43=5F=42US=59=5F=49O && =68=
os=74-=3Eops->c=61r=64=5F=62usy) {
+=09if (dat=61-=3E=62usy=5F=63=6Dd =21=3D MMC=5F=42=55=53=59=5F=49O &=26 =68=
=6Fs=74=2D>=6Fp=73=2D>=63a=72d=5Fbus=79 &&
=2B=09=09=09!=64at=61->=61=67greg=61te=5Ferr=5Ff=6Cags=29 =7B
 =09=09*=62usy =3D host=2D=3Eo=70s=2D>card=5F=62u=73=79(=68ost);
 =09=09retur=6E 0;
 =09}
=40@ -=3477,=36 +=3473,9 =40=40 st=61=74=69c int m=6Dc=5F=62=75s=79=5F=63=62(v=
oid *c=62=5Fdata, =62=6Fol *busy)
 =09if =28e=72r)
 =09=09re=74u=72=6E =65=72r;
 
=2B=09=69=66 (=64a=74a->=61gg=72=65gate=5Ferr=5Ffl=61gs)
=2B=09=09*da=74=61->status =3D R1=5FS=54=41=54U=53=28*d=61=74a=2D>st=61tus) | =
=73tatus;
=2B
 =09switch =28data=2D>bu=73y=5Fcmd) =7B
 =09c=61se MMC=5FB=55SY=5FCMD6=3A
 =09=09err =3D mmc=5Fswi=74=63h=5Fs=74atus=5Ferror=28=68ost=2C st=61tus)=3B
=40@ =2D549,=36 +=35=348=2C7 =40=40 =69n=74 mmc=5Fp=6Fl=6C=5F=66=6Fr=5Fbus=79=
=28stru=63=74 m=6Dc=5F=63a=72d *car=64, unsigne=64 int t=69me=6Fut=5Fms,
 
 =09c=62=5Fda=74a.card =3D =63a=72d=3B
 =09cb=5F=64=61=74a.retry=5Fcrc=5F=65=72r =3D re=74=72y=5Fcr=63=5F=65r=72;
=2B=09cb=5Fdat=61=2Eagg=72egate=5Fe=72r=5Ffla=67s =3D =66alse=3B
 =09cb=5Fd=61ta.busy=5Fc=6D=64 =3D =62usy=5Fcm=64=3B
 
 =09=72=65=74u=72n =5F=5Fmmc=5Fpo=6Cl=5F=66o=72=5Fbusy=28host=2C 0, tim=65=6F=
=75=74=5F=6Ds, &mmc=5Fb=75sy=5Fc=62, &=63b=5Fdata)=3B
di=66f -=2Dgit a/=64=72iv=65=72s/mmc/c=6F=72e/m=6D=63=5Fops=2Eh b/driv=65rs=2F=
=6Dm=63=2Fcore=2F=6D=6Dc=5Fops=2E=68
index =30=39=66fbc=30090=38=62..a=357=37=351b83f1=39 10=30644
-=2D- =61=2Fd=72iver=73=2Fmmc/=63o=72e/m=6Dc=5F=6Fps=2Eh
+++ b/dr=69=76ers/mm=63/core/m=6Dc=5F=6Fp=73.h
=40@ =2D=31=38,=36 +18=2C14 @=40 e=6Eum mmc=5Fbus=79=5F=63=6Dd {
 =09MM=43=5FBUSY=5FIO,
 };
 
+struc=74 mm=63=5Fb=75sy=5Fd=61=74a =7B
+=09s=74=72u=63t mmc=5Fca=72d *car=64=3B
+=09bool r=65=74=72=79=5Fc=72c=5Fer=72=3B
+=09b=6Fo=6C =61ggregate=5Fe=72r=5Ffla=67=73=3B
=2B=09=65=6Eu=6D =6D=6Dc=5F=62=75=73y=5F=63=6Dd b=75s=79=5Fcmd=3B
+=09u32 *s=74atus;
+=7D;
+
 s=74r=75ct m=6Dc=5F=68o=73t=3B
 =73t=72u=63t mmc=5Fc=61=72d;
 s=74r=75ct mmc=5Fcomman=64=3B
=40@ -=34=31,6 +49,7 =40@ in=74 mm=63=5F=63=61=6E=5F=65=78=74=5Fc=73d(=73truc=
=74 m=6Dc=5F=63=61=72d *ca=72d=29=3B
 i=6Et =6Dmc=5Fswi=74=63h=5Fstatu=73(struct m=6Dc=5Fca=72d *ca=72=64, =62oo=6C=
 =63rc=5Ferr=5Ff=61=74al)=3B
 bo=6Fl m=6Dc=5Fprep=61re=5Fbu=73y=5Fcmd=28=73truc=74 mmc=5Fh=6Fst =2Aho=73t=
=2C =73t=72uc=74 m=6Dc=5Fc=6Fmma=6Ed *c=6D=64,
 =09=09=09  =75ns=69=67ne=64 int timeout=5Fms=29=3B
=2B=69n=74 mmc=5Fbusy=5Fc=62=28v=6F=69=64 *cb=5F=64ata, =62oo=6C *=62us=79=29;
 i=6Et =5F=5Fmmc=5F=70oll=5Ff=6Fr=5Fbusy=28s=74=72=75=63=74 mm=63=5Fho=73t =2A=
ho=73=74=2C uns=69gned =69n=74 =70erio=64=5Fu=73,
 =09=09=09unsi=67=6E=65d i=6E=74 timeou=74=5F=6D=73,
 =09=09=09=69=6E=74 =28=2Ab=75=73y=5Fcb=29(=76oid *cb=5F=64=61=74a, bool =2A=
=62usy),
=2D-
2.37.=33
--NoSpamProxy_caed715b-a7f6-4323-ba4d-c749779717db
Content-Transfer-Encoding: BASE64
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExDTALBglghkgBZQMEAgEwCwYJKoZIhvcNAQcBoIIjdjCCB+sw
ggXToAMCAQICFH/0ya9FbNqDP1mj8nwYIyzoDuazMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYT
AkNIMRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcxLTArBgNVBAMTJFN3aXNzU2lnbiBSU0EgU01JTUUg
TENQIElDQSAyMDIxIC0gMjAeFw0yMjEyMTUxMDIwNTJaFw0yMzEyMTUxMDIwNTJaMEgxJTAjBgkq
hkiG9w0BCQEWFmNsb2VobGVAaHlwZXJzdG9uZS5jb20xHzAdBgNVBAMMFmNsb2VobGVAaHlwZXJz
dG9uZS5jb20wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDbQs7vFtBkf7fsjeH5TOTl
4BCMTLaVKnaZGJ79z62g8ZSuOWg45uUJ6ti+RfIaS/gp8bAnHxrFDcYANbU2S/S19bwpqvKlOcV9
3mKFefUB7SVTnhD1EDsk3I2SCG7Bz61gflKcRnalJG74AXn4E4MAaRlrWCoLkZIeCSY4lNrQD1pw
70nmNRY41ICYzAVAb0RiP60audx4UP29YDXLUkrki5cpf3yt/eHS/KRjHiadq2uDnkGQI1oadBXa
u4B0nCVmN68LKWb8Ak5aSROJarWOPHLQ+wuL78NS11Yer5Mnngad5/pccQY0MjkC7e80HBNaOAOt
vrf2a7i8fFs278So63WAMt+XUM2rHMyIKsOEWqAHBY1GoAKT81NZ+5YMqfvUbK8SucXAy+UWZlzY
VXLCtxrqHcxNbTApkjDtxalDMn9bm4qyQE/qxbkuGSPdqIj8v7AOCgb1K4I8hzwOIiCpEJMhbIvp
bZK1GQ3BxE61FG599xyVZNf29aYdoUDIp4MwG3hcLHvYsRvSo6eHPYk8mr9SM+OhexuEdj3+St+Y
5MSdDdkvRdspx0gXwmffJ6iCBjChXDHa/W1uSBvM5SlKKsYH7ufOC31CptKkEdM8lGi0PPlevh7U
25ZI0QVH3EiLgBymsdqPc/7LifBKmp+xamIZAUVcfJqvdvTt+EkgEQIDAQABo4ICwDCCArwwIQYD
VR0RBBowGIEWY2xvZWhsZUBoeXBlcnN0b25lLmNvbTAOBgNVHQ8BAf8EBAMCBLAwEwYDVR0lBAww
CgYIKwYBBQUHAwQwHQYDVR0OBBYEFA+H5eoYx7aaS0slW7G0+hgo1ZqlMB8GA1UdIwQYMBaAFPpU
wIKm/pa9BMdfn1+CDD3DlU9HMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6Ly9jcmwuc3dpc3Nz
aWduLm5ldC9GQTU0QzA4MkE2RkU5NkJEMDRDNzVGOUY1RjgyMEMzREMzOTU0RjQ3MIGooIGloIGi
hoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3NpZ24ubmV0L0NOPUZBNTRDMDgyQTZGRTk2QkQwNEM3
NUY5RjVGODIwQzNEQzM5NTRGNDclMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZv
Y2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MGcGA1UdIARg
MF4wUgYIYIV0AVkCAQswRjBEBggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2ln
bi5jb20vU3dpc3NTaWduX0NQU19TTUlNRS5wZGYwCAYGBACPegEDMIHGBggrBgEFBQcBAQSBuTCB
tjBkBggrBgEFBQcwAoZYaHR0cDovL3N3aXNzc2lnbi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93
bmxvYWQvRkE1NEMwODJBNkZFOTZCRDA0Qzc1RjlGNUY4MjBDM0RDMzk1NEY0NzBOBggrBgEFBQcw
AYZCaHR0cDovL29jc3Auc3dpc3NzaWduLm5ldC9GQTU0QzA4MkE2RkU5NkJEMDRDNzVGOUY1Rjgy
MEMzREMzOTU0RjQ3MA0GCSqGSIb3DQEBCwUAA4ICAQCm+EvZobQCGMXgo2yeAD2ztkKXLEUmp7sp
to3Unk6h7xNT0k1XsLxQAyF+Ny/Ftd6GAnq02cWyupmU8OfcSbWIi91QT13TUUholbqV1ELlgMpa
slZ6qBAJLWLXQ8p/BWaGzpRBgJEsg4fc3XC5FRjysoZNOxZIwblQrQDD/cCTUAM43Ar086iZoM1B
5mqNZil+LoCaXR4q8KS2jV3cTseKK/yIHpOl3NNAU7tC10pO9PNkJ9Dd6W/ghKBvhNiSUucEmm4e
70b5cP3M0qJ1xdBkRhZ5BDFBPTNWq0pecXdRWILG0xz6neB8VCClW3tYYAriroYjXDZzBMVGfXKo
0pxnwg2B/+ppYGaji2Sf3IBZKFVS5hRFolcsRAqfxmDYfmVJA1lQqOfr0f1jURksb/+IEG7aZNyG
4iMIMFmDptXeEysz5ntJw5KAf0i6mJ2y/sEU9pzImRlvQc5kHV3GT9BdYs8GmSmdD8CI0S+/y/no
Ny4l2SzVjkc+3d+fdWSJV6y4gR+3FmG8B5dTvJBHNs0YSsG2rQSEzDxcZNzhjKA9c70FS1U3m3n6
bU2mErdOPQ4KtTu5v3D5RBKB2cgbdBI4B8gEHJhqxOdBO5E+Z8+FMqIWCITb1fN2NrgenRDYy4Bj
tax6L8HT5mEY+mS8Lx08gqY01qcfbiD8uD+qTtmsLjCCB+swggXToAMCAQICFH/0ya9FbNqDP1mj
8nwYIyzoDuazMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYTAkNIMRUwEwYDVQQKEwxTd2lzc1Np
Z24gQUcxLTArBgNVBAMTJFN3aXNzU2lnbiBSU0EgU01JTUUgTENQIElDQSAyMDIxIC0gMjAeFw0y
MjEyMTUxMDIwNTJaFw0yMzEyMTUxMDIwNTJaMEgxJTAjBgkqhkiG9w0BCQEWFmNsb2VobGVAaHlw
ZXJzdG9uZS5jb20xHzAdBgNVBAMMFmNsb2VobGVAaHlwZXJzdG9uZS5jb20wggIiMA0GCSqGSIb3
DQEBAQUAA4ICDwAwggIKAoICAQDbQs7vFtBkf7fsjeH5TOTl4BCMTLaVKnaZGJ79z62g8ZSuOWg4
5uUJ6ti+RfIaS/gp8bAnHxrFDcYANbU2S/S19bwpqvKlOcV93mKFefUB7SVTnhD1EDsk3I2SCG7B
z61gflKcRnalJG74AXn4E4MAaRlrWCoLkZIeCSY4lNrQD1pw70nmNRY41ICYzAVAb0RiP60audx4
UP29YDXLUkrki5cpf3yt/eHS/KRjHiadq2uDnkGQI1oadBXau4B0nCVmN68LKWb8Ak5aSROJarWO
PHLQ+wuL78NS11Yer5Mnngad5/pccQY0MjkC7e80HBNaOAOtvrf2a7i8fFs278So63WAMt+XUM2r
HMyIKsOEWqAHBY1GoAKT81NZ+5YMqfvUbK8SucXAy+UWZlzYVXLCtxrqHcxNbTApkjDtxalDMn9b
m4qyQE/qxbkuGSPdqIj8v7AOCgb1K4I8hzwOIiCpEJMhbIvpbZK1GQ3BxE61FG599xyVZNf29aYd
oUDIp4MwG3hcLHvYsRvSo6eHPYk8mr9SM+OhexuEdj3+St+Y5MSdDdkvRdspx0gXwmffJ6iCBjCh
XDHa/W1uSBvM5SlKKsYH7ufOC31CptKkEdM8lGi0PPlevh7U25ZI0QVH3EiLgBymsdqPc/7LifBK
mp+xamIZAUVcfJqvdvTt+EkgEQIDAQABo4ICwDCCArwwIQYDVR0RBBowGIEWY2xvZWhsZUBoeXBl
cnN0b25lLmNvbTAOBgNVHQ8BAf8EBAMCBLAwEwYDVR0lBAwwCgYIKwYBBQUHAwQwHQYDVR0OBBYE
FA+H5eoYx7aaS0slW7G0+hgo1ZqlMB8GA1UdIwQYMBaAFPpUwIKm/pa9BMdfn1+CDD3DlU9HMIH/
BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6Ly9jcmwuc3dpc3NzaWduLm5ldC9GQTU0QzA4MkE2RkU5
NkJEMDRDNzVGOUY1RjgyMEMzREMzOTU0RjQ3MIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5z
d2lzc3NpZ24ubmV0L0NOPUZBNTRDMDgyQTZGRTk2QkQwNEM3NUY5RjVGODIwQzNEQzM5NTRGNDcl
MkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVj
dENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MGcGA1UdIARgMF4wUgYIYIV0AVkCAQswRjBEBggr
BgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dpc3NTaWduX0NQU19T
TUlNRS5wZGYwCAYGBACPegEDMIHGBggrBgEFBQcBAQSBuTCBtjBkBggrBgEFBQcwAoZYaHR0cDov
L3N3aXNzc2lnbi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93bmxvYWQvRkE1NEMwODJBNkZFOTZC
RDA0Qzc1RjlGNUY4MjBDM0RDMzk1NEY0NzBOBggrBgEFBQcwAYZCaHR0cDovL29jc3Auc3dpc3Nz
aWduLm5ldC9GQTU0QzA4MkE2RkU5NkJEMDRDNzVGOUY1RjgyMEMzREMzOTU0RjQ3MA0GCSqGSIb3
DQEBCwUAA4ICAQCm+EvZobQCGMXgo2yeAD2ztkKXLEUmp7spto3Unk6h7xNT0k1XsLxQAyF+Ny/F
td6GAnq02cWyupmU8OfcSbWIi91QT13TUUholbqV1ELlgMpaslZ6qBAJLWLXQ8p/BWaGzpRBgJEs
g4fc3XC5FRjysoZNOxZIwblQrQDD/cCTUAM43Ar086iZoM1B5mqNZil+LoCaXR4q8KS2jV3cTseK
K/yIHpOl3NNAU7tC10pO9PNkJ9Dd6W/ghKBvhNiSUucEmm4e70b5cP3M0qJ1xdBkRhZ5BDFBPTNW
q0pecXdRWILG0xz6neB8VCClW3tYYAriroYjXDZzBMVGfXKo0pxnwg2B/+ppYGaji2Sf3IBZKFVS
5hRFolcsRAqfxmDYfmVJA1lQqOfr0f1jURksb/+IEG7aZNyG4iMIMFmDptXeEysz5ntJw5KAf0i6
mJ2y/sEU9pzImRlvQc5kHV3GT9BdYs8GmSmdD8CI0S+/y/noNy4l2SzVjkc+3d+fdWSJV6y4gR+3
FmG8B5dTvJBHNs0YSsG2rQSEzDxcZNzhjKA9c70FS1U3m3n6bU2mErdOPQ4KtTu5v3D5RBKB2cgb
dBI4B8gEHJhqxOdBO5E+Z8+FMqIWCITb1fN2NrgenRDYy4Bjtax6L8HT5mEY+mS8Lx08gqY01qcf
biD8uD+qTtmsLjCCB0cwggUvoAMCAQICDyxaqdlU/bKrlq0Xtl+M9DANBgkqhkiG9w0BAQsFADBT
MQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dpc3NTaWduIEFHMS0wKwYDVQQDEyRTd2lzc1NpZ24g
UlNBIFNNSU1FIFJvb3QgQ0EgMjAyMSAtIDEwHhcNMjEwODA0MTIxMjU5WhcNMzYwNzMxMTIxMjU5
WjBTMQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dpc3NTaWduIEFHMS0wKwYDVQQDEyRTd2lzc1Np
Z24gUlNBIFNNSU1FIExDUCBJQ0EgMjAyMSAtIDIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQC9BRnI1A1xPgMDELSTFgDrzyPawAcju1E8OBLTQHXDcmN46wsneV+NVoip2X1ZQ9GIF3bj
x0aLq9/iiKo9EsCdCO1BENfc70ngvzFS1oOdmfzymiKAZlWsEJSQocyLldDWSF03KN8a7Rgl30PD
IURBvBWlpIOCxiCAUgKogGYBvm7ZRZZ10BcgfGU/ga19jlhGI9xSJ9pCPjvcWPJKpiSbG+s0CR/M
4cXaQPO9ZEFYxIn7g4rNIYBYZwhsIjcPn5OtC9/7p/3F/2qKA9gfvK/CyQ14fPVOPVJaPECufMs4
+tRhh2edpGx4irQTaVV85iVU3wjPpi84TIgUlRwqUWloj158A5r7pGVMcI++Slyq3rudu319WjiC
57kAikVHryC+gwC4SUAYn0CqX//cApx+99nmLWAmWnGdeaRmHMJCmJfXy3Dji8SnVuggcXbErnkr
5sms1kyp5wiDR7YVIkdTuiJHpF2d7WZ/d5EOT7KBdS/k67/XgTrUwkWwKR2Vm/00b0Zpz3N4Hg9F
TrBP53A2uci2e7Lf3vR8hFJijhu08zGuClY7Khn+0BBU50YSOE2BnYWsBOe36ddw2470cM/iGtMM
aTXnA0rg4MsX9TP0vX4iQpWZMwqNwqcYk0ewMqy4RDAY7xH4GXNkRGT2nJngURbQS1wgScF1NMzR
W+rRrQIDAQABo4ICFjCCAhIwDgYDVR0PAQH/BAQDAgEGMBMGA1UdJQQMMAoGCCsGAQUFBwMEMBIG
A1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFPpUwIKm/pa9BMdfn1+CDD3DlU9HMB8GA1UdIwQY
MBaAFAkMvyqiHQQkDLL5QApBws9acqqAMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6Ly9jcmwu
c3dpc3NzaWduLm5ldC8wOTBDQkYyQUEyMUQwNDI0MENCMkY5NDAwQTQxQzJDRjVBNzJBQTgwMIGo
oIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3NpZ24ubmV0L0NOPTA5MENCRjJBQTIxRDA0
MjQwQ0IyRjk0MDBBNDFDMkNGNUE3MkFBODAlMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MB8G
A1UdIAQYMBYwCgYIYIV0AVkCAQswCAYGBACPegEDMHQGCCsGAQUFBwEBBGgwZjBkBggrBgEFBQcw
AoZYaHR0cDovL3N3aXNzc2lnbi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93bmxvYWQvMDkwQ0JG
MkFBMjFEMDQyNDBDQjJGOTQwMEE0MUMyQ0Y1QTcyQUE4MDANBgkqhkiG9w0BAQsFAAOCAgEABw8e
lwSFegmW7IGpGTOPwtOC2tzTwCQiRA2VC/EWGKckk8A3F9Q+M2A8lUYVlRKJt31pAezcXaP6OFW0
3IPiiXU70QA598nGqUxzzjn8rpFhZgCj6bi8MJd5MH5C2RRYFrhiRefx6pp42LLc0AFIF1ZqkaYa
1vz0EgTOL9XE3inXe39twPLoe3rc/f8gfpem/s1NIJk2azwyxZn226YSrSedvxhe7LiN6gOqvU7h
xpC8bXaiIYVy7DISXwEt902Gc+M4QbhUf8yQ+PiK3QexGIWiusOO46cn673dG/1KCzma/1Llp9Dx
aeUHlxjjeeer/2WtWWZNFhoInrxpcK58odaJZRMZQJwNljMb66gGb5OpeanN0su93/S9GrZgJqN6
spp171azfMuQzVqj9gxFy66yIdlrhZcba/QixC2eAJxm5fM/PZg9WXZ737G8jAbsuoREH1bxsglL
zxAIwboY7uVwIim6ZcieKb6Yy4n6TzperNmhU5UHiUZSJzIQ/qu9B14cfh0CAJo19p7fRvyeF/p7
INDH0ceTVTq5sF8kFtMM1bz+0/sWOTNqdi8kGO7I7iouC3+V4DDx4F1sGcaigFXtUpLmol5Lss+i
9NXGgWFcPFreexoLaBdckDJgBk6zOHKVYwZdnrg2CovIev/uumK0WyCa7ix1+SDcsd2PXxIwggaL
MIIEc6ADAgECAhAA3kxVIPbc9AIbDxFU940QMA0GCSqGSIb3DQEBCwUAMEUxCzAJBgNVBAYTAkNI
MRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcxHzAdBgNVBAMTFlN3aXNzU2lnbiBHb2xkIENBIC0gRzIw
HhcNMjEwODAzMTMxNDU1WhcNMzYxMDIzMTMxNDU1WjBTMQswCQYDVQQGEwJDSDEVMBMGA1UEChMM
U3dpc3NTaWduIEFHMS0wKwYDVQQDEyRTd2lzc1NpZ24gUlNBIFNNSU1FIFJvb3QgQ0EgMjAyMSAt
IDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDWsri0OI8mujfIASNFFn6+ZDiGcmZh
WI0kilmzDKEqq367hXxlZnCn6SLb7rsy+quxhj+rSIG4q/Mq3TfHLgv2q99VrVQgFDq3iURt5+g/
roghGI5HVpUAyexlblZHFE2tLibS1ItsyvMzLfnwm463hiaB5wueiwx8Bac8evnwhZCciWc5dRGx
Y7DUIyx93B8rdu0ErboRyQdJDeMoDy4RFNK2sv94uP5aU4AkrAtIuk4yMVHsqv67RCwL1/l9q43a
bKsI3fNBPY/1QUFcxsxRyg5EH7dqgHZVaVHmTP0XgPuzVO6wSh0zkwZ5uWERrOQOW7Pd4LElXLfU
0830e54BVCuCkKHhykON8EGkHAfA1jMWo0VGj4RMaf2TV53T5W/LJAwxLQOYwgA5RHkigW3k6vwL
ZCZu/MqeGgNE7X9NTekRsna9hn17u1Q/UZBHx4v4/04s8ggwjBnBLEc1nr2rU6Qirp8MIRkpvZ6b
z4TcjtE1SyIQgRti7cBL0yuQIkkfLSGukcXf8dZBVHIO3so0EPXJmp3VXBbkzSWxx6hxRqz4U4UX
iaskGjgYMiRz6VWu+IBjA2+EsN+glLWpU/CLavVUeeX/W5yibyLh/0ApZWxvjkhpMT6BGzuLWPpb
LztrfWsk8LzyjeWa5qx4y9iCKwAXHXlqCS7WbnbPMPvbWQIDAQABo4IBZzCCAWMwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUCQy/KqIdBCQMsvlACkHCz1pyqoAwHwYDVR0jBBgwFoAUWyV7lqRl
UX64OfPAeGZe6Drn8O4wDgYDVR0PAQH/BAQDAgEGMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6
Ly9jcmwuc3dpc3NzaWduLm5ldC81QjI1N0I5NkE0NjU1MTdFQjgzOUYzQzA3ODY2NUVFODNBRTdG
MEVFMIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3NpZ24ubmV0L0NOPTVCMjU3Qjk2
QTQ2NTUxN0VCODM5RjNDMDc4NjY1RUU4M0FFN0YwRUUlMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2Vy
dGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBv
aW50MA0GCSqGSIb3DQEBCwUAA4ICAQAC+Opd0IrMrAgDNlRm/wophuFUgywz6MdsrhCpVIF/Ki2I
Jq2mqDQoDxkGqZ3iApUEMmRMC8r5433DE1vol0COd+PjgoGHrQFgB8PF4SD9tzCXProccXSLX02n
sf5OfAl4eodf8ayhJRGXxywRnJDqchY9AjWpu+Uj2B9SQLfQjl3aI7wz6TL9uHWfQ749V0uHYd7t
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
--NoSpamProxy_caed715b-a7f6-4323-ba4d-c749779717db--

