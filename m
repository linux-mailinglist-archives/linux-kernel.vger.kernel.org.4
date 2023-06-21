Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C67737CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFUH57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFUH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:57:55 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E31710;
        Wed, 21 Jun 2023 00:57:49 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 238EF3A2B01;
        Wed, 21 Jun 2023 09:57:48 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id F15033A2AE2;
        Wed, 21 Jun 2023 09:57:47 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 09:57:47 +0200 (CEST)
Content-Type: multipart/signed; 
 boundary=NoSpamProxy_127be3e0-8657-4097-bc58-fb80d68bd7c3; 
 protocol="application/pkcs7-signature"; micalg="sha256"
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>
Subject: RE: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Topic: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Index: AdmjdCfpdU8NnQgrT4iRiz4+JBhVQwAmzJ7gAAFwH7A=
Date:   Wed, 21 Jun 2023 07:57:44 +0000
Message-ID: <775650f7de0f4452a8f71bcb206db887@hyperstone.com>
References: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
 <BL0PR04MB65647F33DC7CC1D2903E5A66FC5DA@BL0PR04MB6564.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB65647F33DC7CC1D2903E5A66FC5DA@BL0PR04MB6564.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27704.006
X-TMASE-Result: 10--24.244800-10.000000
X-TMASE-MatchedRID: gjZGo2H/wj//9O/B1c/Qy/HkpkyUphL9Ud7Bjfo+5jSWwuVcTMXFdD4n
        lUYJoTJ//JnHmStKBTAGR+oaLCJqy4IokrTYtYlKHWRJEfGP5nmUq+GQ/zyJdKJXp9dweNlvNyl
        ek8JXQTdG391z8AkhmuvkJBFg3vCcYPx7yddt9jIF7cpFXK76TdDZ1FFTJUym5MDAlfnFRGrXQj
        bjf/eQSak0GlHrLJycAzqpCxXEiQwQlJEJlaovbjo39wOA02LhbbR2OHKjX2YUoJOBFYW8JugoS
        vaKsl/kIvrftAIhWmLy9zcRSkKatU5gqNn1dvU1IGmn4OlOtCOZIt4iAQN6P2WKhd+if2/GY3Gd
        Dr1JjFr5j1vn1ZkYCsXYi4zvwLs1AxYKB0LOn5oX6pCkJZNSOVkN0eJOT05wt9gi5mw5DSy14qf
        RuYCXsKt1FeojubKgOnv8Y2Cu9ud7Embvl3Hg+mnmCQLJ/Hnw2aGwk4OLNSy3CLdtdG1oCO+neL
        QgWN7lESDwuJR3m+SAMuqetGVetmzXKHERTtRNNadDKhhc0dl/A75FGmxK1cLeaN9zSPdmDBbGv
        tcMofyUTGVAhB5EbQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: c23db667-a9d8-4169-8fd6-352b0a8f6089-5-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_QP_LONG_LINE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NoSpamProxy_127be3e0-8657-4097-bc58-fb80d68bd7c3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable




> ----=2D=4Fri=67i=6Ea=6C =4Dess=61ge-=2D---
> From: A=76r=69 A=6C=74m=61=6E <=41vri.A=6C=74m=61=6E@wdc.com=3E
> =53=65nt: We=64=6Ee=73day, J=75n=65 21, =320=323 9:3=31 AM
> =54o: =43hri=73=74i=61n L=6Feh=6C=65 <=43=4C=6Fehle@=68ype=72sto=6Ee.c=6F=6D=
>=3B l=69nux-mm=63@vge=72.=6B=65r=6Ee=6C.org=3B
=3E l=69=6Eu=78-=6B=65rnel@v=67=65r=2Ekern=65l.o=72=67; Ul=66 H=61nsson <ulf.=
=68=61=6Esson=40lina=72o.org>=3B Ad=72i=61n
=3E =48u=6E=74er =3Cad=72=69=61n.hunt=65r@=69nt=65l.com>
=3E S=75b=6Aect: R=45: [PA=54=43H=763 1/1] =6Dmc: bl=6Fck=3A ioct=6C=3A =41dd =
=50ROG-error =61ggreg=61tion
>
> CA=55T=49=4F=4E: thi=73 mail =63=6Fm=65s =66ro=6D e=78=74=65rn=61l!/A=43=48=
=54UNG: =44ies=65 =4D=61i=6C =6B=6F=6D=6D=74 v=6F=6E
=3E e=78ter=6E=21
>
=3E > Use=72=73p=61ce c=75=72=72ently =68as =6Eo wa=79 of checking f=6Fr err=
=6F=72 bits =6F=66 =64et=65=63ti=6Fn
> =3E mo=64e =58=2E Th=65se are =65r=72or bi=74s t=68a=74 are =6Fnly detecte=
=64 =62y the c=61=72=64 =77=68en
> =3E execu=74=69=6E=67 =74=68e =63=6Fmma=6Ed. Fo=72 e=2E=67. =61 sa=6Ei=74ize=
 =6F=70er=61tion th=69=73 may =62e
> > minutes =61fter t=68e =52S=50 wa=73 s=65en by t=68=65 ho=73t=2E
> =3E
> =3E Cu=72r=65ntly u=73e=72s=70ace p=72ogram=73 cannot =73=65e t=68=65se erro=
=72 b=69=74=73 =72eli=61=62l=79=2E
> > T=68ey co=75=6C=64 i=73=73u=65 a =6Dulti =69o=63tl cm=64 wi=74h a C=4D=441=
=33 =69mm=65diate=6C=79 followin=67
=3E > it, =62ut =73=69=6Ece err=6Fr=73 =6Ff det=65c=74ion =6D=6F=64e =58 are a=
u=74o=6Da=74=69call=79 c=6Ceare=64
=3E =3E (they =61r=65 =61=6Cl cle=61=72 c=6Fnditio=6E B).
> > mmc=5F=70ol=6C=5Ffo=72=5F=62u=73y =6F=66 =74he fir=73t i=6F=63tl =6D=61y h=
=61=76e a=6Cre=61=64y =68=69d=64e=6E s=75c=68 an
> =3E e=72r=6F=72 =66l=61g.
> =3E
> > I=6E c=61se o=66 t=68e sec=75rit=79 opera=74ions=3A s=61n=69=74ize, secure=
 e=72a=73e=73 and =52P=4D=42
=3E > w=72it=65=73=2C =74his =63=6Ful=64 l=65=61=64 to th=65 op=65ration n=6Ft=
 being perf=6Frm=65d
> > s=75cc=65=73s=66ull=79 =62=79 the =63ard w=69=74h t=68=65 user not =6Bnowi=
ng=2E
=3E > If =74he user =74rus=74s =74hat th=69=73 o=70=65=72a=74i=6Fn =69=73 com=
=70leted (e.g=2E the=69=72 data
> =3E is sa=6Ei=74iz=65d=29=2C t=68i=73 cou=6Cd be a =73ecur=69t=79 =69ssu=65=
=2E
> > An attacker could e=2Eg=2E =70=72=6F=76=6Fk=65 a =65=4DM=43 =28=56CC) fla=
=73=68 =66ail, wher=65 =61
> > s=75cce=73=73fu=6C s=61n=69=74=69ze =6F=66 a c=61=72d i=73 n=6F=74 =70oss=
=69ble. A =63a=72d =6Day move =6F=75t o=66
> =3E P=52OG s=74a=74=65 b=75t issu=65 =61 =62it 19 R=31 error=2E
> =3E
> > This pa=74=63h =74h=65refo=72=65 =77il=6C =61lso =68=61ve =74h=65 c=6Fn=73=
=65q=75ence of =61 m=6Dc-uti=6Cs
> =3E patc=68=2C =77=68=69ch =65=6E=61bles th=65 bit f=6Fr th=65 sec=75ri=74y=
=2Dse=6E=73=69=74i=76e =6Fper=61=74=69on=73.
> >
> > Sig=6Eed-=6Ff=66-b=79: Ch=72i=73=74=69an L=6Feh=6Ce =3Cc=6Co=65hle@=68y=70=
er=73=74o=6Ee=2E=63o=6D>
> A=63=6Bed-b=79=3A =41vri Alt=6D=61n <av=72i.altm=61n=40w=64c.=63om=3E
=3E
=3E =3E -=2D-
> =3E  d=72iv=65rs/mmc/=63=6Fre/=62=6Coc=6B.c   | 26 +=2B=2B+=2B++++++=2B+++--=
---=2D-----
> =3E  =64=72i=76ers/=6D=6D=63=2Fc=6Fre/=6D=6D=63=5Fop=73.=63 =7C =314 =2B++++=
=2B+-------
> =3E d=72=69=76=65r=73=2F=6Dm=63/core=2F=6Dm=63=5Fops=2Eh |  9 +=2B+=2B++=2B+=
+
=3E >  3 =66il=65s ch=61nged, 31 =69=6Ese=72tion=73(+=29, 18 del=65=74=69=6F=
=6E=73(=2D)
> >
> =3E d=69ff -=2D=67=69t a/dri=76er=73/=6Dm=63/co=72e=2Fbl=6F=63k.=63 =62/=64r=
=69v=65rs=2Fmm=63/co=72=65=2Fblo=63k=2Ec i=6Ed=65x
> > =65=346330=38154=38=34=2E.c=37e2b8=61=6558a9 100=36=34=34
> > =2D-- a/d=72iver=73/mmc=2F=63ore=2F=62lo=63=6B.c
> =3E ++=2B =62/d=72=69vers/mm=63/=63or=65/block.c
> =3E =40@ -47=30,7 +=3470=2C=37 =40=40 =73=74=61tic =69=6E=74 =5F=5Fm=6Dc=5Fb=
lk=5Fioc=74l=5Fcmd(st=72=75ct mmc=5Fca=72=64
=3E =3E =2Acar=64, s=74=72=75ct =6D=6D=63=5Fbl=6B=5Fdat=61 =2A=6Dd=2C
> >       stru=63=74 mmc=5Fd=61=74a d=61=74a =3D =7B};
> >       st=72uct mm=63=5Freq=75=65st =6Drq =3D {}=3B
=3E >       s=74ruct scatte=72lis=74 sg;
=3E > =2D     b=6Fo=6C r1=62=5Fr=65sp=2C =75=73=65=5Fr1=62=5F=72=65=73=70 =3D =
=66al=73e;
=3E > +     b=6Fol =721b=5F=72=65sp;
> =3E       unsig=6Ee=64 i=6Et bus=79=5F=74=69meout=5Fms;
> >       int e=72r=3B
=3E >       unsi=67n=65=64 int =74ar=67et=5Fp=61r=74=3B
> > =40@ -=3551,8 =2B551,7 =40=40 s=74at=69c int =5F=5F=6Dm=63=5Fblk=5Fioctl=
=5Fcmd(=73truct m=6D=63=5F=63a=72d
=3E =3E =2Acard, stru=63t m=6Dc=5F=62l=6B=5Fdata *=6D=64=2C
> >       bu=73=79=5F=74i=6Deout=5F=6Ds =3D =69d=61ta->=69c=2Ecmd=5Ft=69m=65=
=6Fu=74=5Fms =3F :
=3E > M=4DC=5FBL=4B=5FTI=4DEOU=54=5FMS;
> >       =721b=5Fresp =3D (cmd.=66la=67s =26 M=4DC=5FRSP=5FR=31B) =3D=3D MM=
=43=5FRS=50=5FR1B;
> >       i=66 =28=72=31b=5Fresp)
> > -             use=5Fr1b=5F=72es=70 =3D mmc=5F=70repare=5Fbu=73y=5F=63md=28=
card->ho=73t=2C &cmd,
> > -                                                 b=75sy=5Ftim=65ou=74=5F=
=6Ds=29;
> > +             mm=63=5Fp=72=65p=61re=5Fbus=79=5Fc=6D=64(ca=72d->h=6Fst, =26=
=63=6Dd=2C
=3E =3E =62us=79=5F=74=69=6D=65=6F=75t=5Fms=29;
> >
=3E =3E       mmc=5Fw=61it=5Ffo=72=5Fre=71(card->=68ost, &mrq)=3B
=3E >       memcpy=28&=69dat=61=2D>i=63=2E=72=65s=70=6Fnse, c=6Dd.=72esp=2C =
=73=69z=65o=66=28=63md=2Ere=73=70=29=29=3B =40@
> > -605,=31=39 +6=304,2=34 =40@ stati=63 int =5F=5Fmm=63=5Fblk=5Fioc=74l=5Fcm=
=64=28s=74r=75=63=74 m=6D=63=5Fca=72d
> > =2A=63=61=72d, struct =6D=6Dc=5Fb=6Ck=5Fdat=61 =2A=6Dd=2C
> =3E       =69=66 (=69=64a=74a->=69=63.p=6Fst=73l=65e=70=5Fmi=6E=5Fu=73)
=3E >               =75=73=6Ce=65=70=5Fra=6Eg=65(idat=61-=3Eic=2Epo=73tsle=65p=
=5Fmi=6E=5Fus=2C idat=61=2D
=3E > >i=63=2Epo=73ts=6Ceep=5Fm=61=78=5F=75s=29=3B
> >
> > =2D     /=2A =4Eo n=65=65d to poll when using =48W b=75sy de=74ec=74i=6Fn.=
 */
> > =2D     =69f ((card=2D>hos=74-=3Eca=70s & =4D=4DC=5F=43AP=5FWA=49=54=5F=57=
HILE=5FBUSY) &&
> > use=5F=721b=5Fresp)
> > -             r=65=74ur=6E 0=3B
> > -
=3E =3E       =69=66 (=6Dmc=5Fhost=5F=69=73=5Fs=70i=28=63ar=64->host)=29 {
=3E =3E               if =28ida=74a-=3Eic=2Ew=72ite=5F=66lag || r1b=5Fres=70 |=
| cm=64=2Ef=6C=61=67=73 &
> > =4DMC=5F=52S=50=5FSP=49=5F=42US=59)
=3E =3E                       r=65tur=6E mm=63=5F=73pi=5Ferr=5Fcheck(=63a=72d)=
;
=3E >               r=65=74urn er=72;
=3E =3E       }
=3E =3E -     =2F* =45nsu=72e =52=50MB=2F=521B co=6Dmand =68as c=6Fmpleted b=
=79 =70o=6Cli=6Eg with CMD13=2E
> > *=2F
=3E > =2D     if (i=64a=74a-=3Erpmb || r1=62=5Fr=65sp)
=3E =3E =2D             err =3D =6D=6Dc=5F=70o=6Cl=5Ffo=72=5F=62usy(=63a=72d, =
=62us=79=5Ft=69=6Deout=5Fms, f=61l=73e,
> > =2D                                     =4DMC=5FBUSY=5FI=4F);
> > +     /=2A =50=6Fll =66=6Fr R=50MB=2Fw=72=69te=2FR1B ex=65c=75=74ion =65=
=72r=6Frs =2A=2F
> > =2B     i=66 =28idat=61->rp=6D=62 =7C=7C =69=64at=61->=69c=2Ew=72ite=5F=66=
=6Cag =7C| =72=31b=5F=72=65s=70) =7B
> AF=41IK writ=65=5Ffla=67  =61=6Ed =721b=5Fresp are =73e=74 t=6Fg=65th=65r (=
=69=6E =6Dmc=2D=75t=69l=73 =74=68=61=74 =69s)=3F
N=6F=74 sure what y=6Fu'=72=65 =74ry=69n=67 t=6F sa=79, =74hat w=72=69te=5F=66=
=6Cag -> r=31=62=5Fr=65=73p=3F =49=66 so tha=74 i=73 not tr=75e =66=6Fr a=6C=
=6C =63ases=2C =65=2Eg=2E =43MD=356
=3E As =66or =72p=6Db r=65ad operations you wer=65 pond=65rin=67 about =2D the=
 =72=70mb r=65=61d=2D
> c=6F=75nte=72 =69s one ex=61=6Dple=2C b=65=63=61us=65 you =75s=65 =69t =74=
=6F sign =77rite opera=74=69ons.
Bu=74 t=68=65 r=65ad cou=6Et=65r =28=74he a=63=74u=61l re=61=64 d=69rec=74=69o=
n par=74), =64=6Fesn't =72eally ne=65=64 =70=6F=73t t=72ans=66=65=72 p=6F=6Cli=
ng I=4DO.
I=66 t=68e car=64 e=6Ec=6F=75=6Et=65rs a pr=6Fbl=65m du=72in=67 tha=74 oper=61=
t=69=6Fn, i=74 =68op=65=66ully =64o=65=73n't =73e=6E=64 val=69d =63o=75=6Eter =
read pa=63=6B=65=74 =72=65spons=65=2E
The rea=64 counte=72 d=6F=65s=6E't =63h=61ng=65 a=6Ey st=61=74e insi=64e =74h=
=65 =63ard, an=64 =69f it =64=6Fe=73 for s=6Fm=65 =76=65nd=6Fr-spec=69=66i=63 =
re=61=73on, =49 =77=6F=75l=64 hope =69t doe=73 =74his b=65fore the rea=64 d=61=
ta is e=78ec=75ted=2E
So I w=6Fuld say =77=65're in =74=68e clear =77=69th=6F=75t poll=69ng.
C=68ecki=6Eg =74he =76a=6Cid=69ty of =74he =72=65=63=65=69ved re=61=64 =63o=75=
=6Eter pa=63ket =64a=74a is r=65sp=6Fnsibili=74y =6Ff t=68=65 io=63t=6C-=63l=
=69e=6E=74, and I wo=75l=64 s=61y t=68ey a=6C=72ead=79 h=61ve =65veryth=69ng =
=74=68=65y n=65=65=64.

=3E So r=65s=74o=72in=67 al=6C rp=6Db op=65ratio=6E=73 i=73 =69=6E pla=63e - a=
l=6C s=68o=75=6C=64 be =6Do=6Eito=72ed=2E
>
> > +             str=75ct m=6Dc=5Fbus=79=5F=64=61=74=61 =63=62=5Fda=74a;
> =4D=61=79be =75se d=65signat=65d ini=74ial=69=7Ain=67=3F

=43an do t=68at, tha=6E=6B=73.
I =77ill w=61=69t fo=72 Uf=66=65=27s com=6Dent abo=75t t=68e =73=74yl=65 b=65f=
o=72e re=73=75b=6D=69t=74=69=6E=67=2E

Regard=73,
C=68=72isti=61=6E
--NoSpamProxy_127be3e0-8657-4097-bc58-fb80d68bd7c3
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
--NoSpamProxy_127be3e0-8657-4097-bc58-fb80d68bd7c3--

