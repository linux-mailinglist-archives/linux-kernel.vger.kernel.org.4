Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0966155E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKAXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKAXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:08:02 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A22221242;
        Tue,  1 Nov 2022 16:06:12 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6110B5120;
        Wed,  2 Nov 2022 00:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343971;
        bh=zOWhuQMSZR1YwwRLd+QWN0gTTOwavh0dQxdEq8i52+U=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=nCyC+CGLNaGu4ktUXHMT9DnA7nIyCQPHxXPxXIgTmpQRFVmAgFrJxMZgfbUaT4wYL
         6ub9+Uf7pjrDBWg+Kmpq9DXKnk4hygcNe0tyI4mKQUUN3Q6EWlx+UvVXxydYQbLc/M
         8oi/kHrp2FJv2h2qjUqZemF8yCe5lE3EC5PS0c8Zqq7I34D3XnpSta7+K4Tsrbq5LH
         8FeApUaYYpUU9UjPu6zLgiFUk5eEbkM2s/SvvuwHmR6vdfL3CGafTh35lOY4AX8Vry
         ThR3KVmzslQyqhHrkwyYgHetY6NdDZb1lS5wXRmmiy+DWCkQfPBFOkqGspdv8qJx1/
         hI+TZ3jOjnc/n2XD3qyQ88huanZh0iHSCle62pTRBMc1S5OkvJcFY3hoVk1VO64+lY
         gQTUZndqDMDq8op3jaL6Ij4HTu8hbpIOYZOiMDTEXLq58X+S0UShW06KIp8ade1PYn
         wqXiBd9khl5Qwdv63aJEfUoATDadMOhnTDKmyGizDTUZerqg9L7xV2TGJ5fouvVnyc
         CmaoAU2TrPO8yOTxpaONZBeE1/laO8Y70CE2uI2K0h+e2lU2I0arQhqDqWA7yWEiNB
         Ol9WIgLIgQzsFIJXWAT++k+OYkE61izdXlBDogXKVV6boqEi+0OXYroWhq2fS47Gmj
         wvQNLB8vv/7K5ZiJ2bt5Q/FU=
Date:   Wed, 2 Nov 2022 00:06:10 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@intel.com>,
        David Vernet <void@manifault.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v2 15/15] Documentation: remove magic-number.rst
Message-ID: <9ebd25ab51a3b83d5d68edfe8d11a8b2c4b59f01.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jl27s4gcpgi27lhq"
Content-Disposition: inline
In-Reply-To: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jl27s4gcpgi27lhq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All noted magic numbers have been removed, and we don't want to encourage
magicking up kernel structs going forward.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/index.rst               |  1 -
 Documentation/process/magic-number.rst        | 71 -----------------
 .../translations/it_IT/process/index.rst      |  1 -
 .../it_IT/process/magic-number.rst            | 77 -------------------
 .../translations/zh_CN/process/index.rst      |  1 -
 .../zh_CN/process/magic-number.rst            | 60 ---------------
 .../translations/zh_TW/process/index.rst      |  1 -
 .../zh_TW/process/magic-number.rst            | 63 ---------------
 8 files changed, 275 deletions(-)
 delete mode 100644 Documentation/process/magic-number.rst
 delete mode 100644 Documentation/translations/it_IT/process/magic-number.r=
st
 delete mode 100644 Documentation/translations/zh_CN/process/magic-number.r=
st
 delete mode 100644 Documentation/translations/zh_TW/process/magic-number.r=
st

diff --git a/Documentation/process/index.rst b/Documentation/process/index.=
rst
index d4b6217472b0..a8c0c4bffa47 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -59,7 +59,6 @@ lack of a better place.
=20
    applying-patches
    adding-syscalls
-   magic-number
    volatile-considered-harmful
    botching-up-ioctls
    clang-format
diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
deleted file mode 100644
index 5a8c2755ac9c..000000000000
--- a/Documentation/process/magic-number.rst
+++ /dev/null
@@ -1,71 +0,0 @@
-.. _magicnumbers:
-
-Linux magic numbers
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-This file is a registry of magic numbers which are in use.  When you
-add a magic number to a structure, you should also add it to this
-file, since it is best if the magic numbers used by various structures
-are unique.
-
-It is a **very** good idea to protect kernel data structures with magic
-numbers.  This allows you to check at run time whether (a) a structure
-has been clobbered, or (b) you've passed the wrong structure to a
-routine.  This last is especially useful --- particularly when you are
-passing pointers to structures via a void * pointer.  The tty code,
-for example, does this frequently to pass driver-specific and line
-discipline-specific structures back and forth.
-
-The way to use magic numbers is to declare them at the beginning of
-the structure, like so::
-
-	struct tty_ldisc {
-		int	magic;
-		...
-	};
-
-Please follow this discipline when you are adding future enhancements
-to the kernel!  It has saved me countless hours of debugging,
-especially in the screwy cases where an array has been overrun and
-structures following the array have been overwritten.  Using this
-discipline, these cases get detected quickly and safely.
-
-Changelog::
-
-					Theodore Ts'o
-					31 Mar 94
-
-  The magic table is current to Linux 2.1.55.
-
-					Michael Chastain
-					<mailto:mec@shout.net>
-					22 Sep 1997
-
-  Now it should be up to date with Linux 2.1.112. Because
-  we are in feature freeze time it is very unlikely that
-  something will change before 2.2.x. The entries are
-  sorted by number field.
-
-					Krzysztof G. Baranowski
-					<mailto: kgb@knm.org.pl>
-					29 Jul 1998
-
-  Updated the magic table to Linux 2.5.45. Right over the feature freeze,
-  but it is possible that some new magic numbers will sneak into the
-  kernel before 2.6.x yet.
-
-					Petr Baudis
-					<pasky@ucw.cz>
-					03 Nov 2002
-
-  Updated the magic table to Linux 2.5.74.
-
-					Fabian Frederick
-					<ffrederick@users.sourceforge.net>
-					09 Jul 2003
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-Magic Name            Number           Structure                File
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documenta=
tion/translations/it_IT/process/index.rst
index 8d4e36a07ff4..71adf53bc297 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -56,7 +56,6 @@ perch=C3=A9 non si =C3=A8 trovato un posto migliore.
=20
    applying-patches
    adding-syscalls
-   magic-number
    volatile-considered-harmful
    clang-format
    ../riscv/patch-acceptance
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
deleted file mode 100644
index 2fbc1876534a..000000000000
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ /dev/null
@@ -1,77 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
-
-.. _it_magicnumbers:
-
-I numeri magici di Linux
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Questo documento =C3=A8 un registro dei numeri magici in uso.  Quando
-aggiungete un numero magico ad una struttura, dovreste aggiungerlo anche
-a questo documento; la cosa migliore =C3=A8 che tutti i numeri magici usati
-dalle varie strutture siano unici.
-
-=C3=88 **davvero** un'ottima idea proteggere le strutture dati del kernel =
con
-dei numeri magici.  Questo vi permette in fase d'esecuzione di (a) verific=
are
-se una struttura =C3=A8 stata malmenata, o (b) avete passato a una procedu=
ra la
-struttura errata.  Quest'ultimo =C3=A8 molto utile - particolarmente quand=
o si passa
-una struttura dati tramite un puntatore void \*.  Il codice tty, per esemp=
io,
-effettua questa operazione con regolarit=C3=A0 passando avanti e indietro =
le
-strutture specifiche per driver e discipline.
-
-Per utilizzare un numero magico, dovete dichiararlo all'inizio della strut=
tura
-dati, come di seguito::
-
-	struct tty_ldisc {
-		int	magic;
-		...
-	};
-
-Per favore, seguite questa direttiva quando aggiungerete migliorie al kern=
el!
-Mi ha risparmiato un numero illimitato di ore di debug, specialmente nei c=
asi
-pi=C3=B9 ostici dove si =C3=A8 andati oltre la dimensione di un vettore e =
la struttura
-dati che lo seguiva in memoria =C3=A8 stata sovrascritta.  Seguendo questa
-direttiva, questi casi vengono identificati velocemente e in sicurezza.
-
-Registro dei cambiamenti::
-
-					Theodore Ts'o
-					31 Mar 94
-
-  La tabella magica =C3=A8 aggiornata a Linux 2.1.55.
-
-					Michael Chastain
-					<mailto:mec@shout.net>
-					22 Sep 1997
-
-  Ora dovrebbe essere aggiornata a Linux 2.1.112. Dato che
-  siamo in un momento di congelamento delle funzionalit=C3=A0
-  (*feature freeze*) =C3=A8 improbabile che qualcosa cambi prima
-  della versione 2.2.x.  Le righe sono ordinate secondo il
-  campo numero.
-
-					Krzysztof G. Baranowski
-					<mailto: kgb@knm.org.pl>
-					29 Jul 1998
-
-  Aggiornamento della tabella a Linux 2.5.45. Giusti nel congelamento
-  delle funzionalit=C3=A0 ma =C3=A8 comunque possibile che qualche nuovo
-  numero magico s'intrufoli prima del kernel 2.6.x.
-
-					Petr Baudis
-					<pasky@ucw.cz>
-					03 Nov 2002
-
-  Aggiornamento della tabella magica a Linux 2.5.74.
-
-					Fabian Frederick
-					<ffrederick@users.sourceforge.net>
-					09 Jul 2003
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-Nome magico           Numero           Struttura                File
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documenta=
tion/translations/zh_CN/process/index.rst
index a1a35f88f4ae..300d579b3ad0 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -52,7 +52,6 @@
 .. toctree::
    :maxdepth: 1
=20
-   magic-number
    volatile-considered-harmful
=20
 .. only::  subproject and html
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
deleted file mode 100644
index f8ec4767bc4e..000000000000
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ /dev/null
@@ -1,60 +0,0 @@
-.. _cn_magicnumbers:
-
-.. include:: ../disclaimer-zh_CN.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-
-=E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E5=8F=91=E4=BF=A1=E5=88=B0LKML=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=
=E4=BD=BF=E7=94=A8=E8=8B=B1=E6=96=87=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=
=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=E4=B9=9F=E5=8F=AF
-=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=
=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=BB=E8=AF=91=E6=
=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=E7=BF=BB=E8=AF=
=91=E5=AD=98=E5=9C=A8=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=B7=E8=81=94=E7=B3=BB=
=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85::
-
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AF=91=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E6=A0=A1=E8=AF=91=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-
-Linux =E9=AD=94=E6=9C=AF=E6=95=B0
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E6=98=AF=E6=9C=89=E5=85=B3=E5=BD=93=
=E5=89=8D=E4=BD=BF=E7=94=A8=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E6=B3=A8=E5=
=86=8C=E8=A1=A8=E3=80=82=E5=BD=93=E4=BD=A0=E7=BB=99=E4=B8=80=E4=B8=AA=E7=BB=
=93=E6=9E=84=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=B8=80=E4=B8=AA=E9=AD=94=E6=9C=AF=
=E5=80=BC=EF=BC=8C=E4=BD=A0=E4=B9=9F=E5=BA=94=E8=AF=A5=E6=8A=8A=E8=BF=99=E4=
=B8=AA=E9=AD=94=E6=9C=AF=E5=80=BC=E6=B7=BB=E5=8A=A0=E5=88=B0=E8=BF=99=E4=B8=
=AA=E6=96=87=E4=BB=B6=EF=BC=8C=E5=9B=A0=E4=B8=BA=E6=88=91=E4=BB=AC=E6=9C=80=
=E5=A5=BD=E6=8A=8A=E7=94=A8=E4=BA=8E=E5=90=84=E7=A7=8D=E7=BB=93=E6=9E=84=E7=
=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E7=BB=9F=E4=B8=80=E8=B5=B7=E6=9D=A5=E3=80=
=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E6=9D=A5=E4=BF=9D=E6=8A=A4=
=E5=86=85=E6=A0=B8=E6=95=B0=E6=8D=AE=E7=BB=93=E6=9E=84=E6=98=AF=E4=B8=80=E4=
=B8=AA=E9=9D=9E=E5=B8=B8=E5=A5=BD=E7=9A=84=E4=B8=BB=E6=84=8F=E3=80=82=E8=BF=
=99=E5=B0=B1=E5=85=81=E8=AE=B8=E4=BD=A0=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=9C=9F=
=E6=A3=80=E6=9F=A5(a)=E4=B8=80=E4=B8=AA=E7=BB=93=E6=9E=84=E6=98=AF=E5=90=A6=
=E5=B7=B2=E7=BB=8F=E8=A2=AB=E6=94=BB=E5=87=BB=EF=BC=8C=E6=88=96=E8=80=85(b)=
=E4=BD=A0=E5=B7=B2=E7=BB=8F=E7=BB=99=E4=B8=80=E4=B8=AA=E4=BE=8B=E8=A1=8C=E7=
=A8=8B=E5=BA=8F=E9=80=9A=E8=BF=87=E4=BA=86=E4=B8=80=E4=B8=AA=E9=94=99=E8=AF=
=AF=E7=9A=84=E7=BB=93=E6=9E=84=E3=80=82=E5=90=8E=E4=B8=80=E7=A7=8D=E6=83=85=
=E5=86=B5=E7=89=B9=E5=88=AB=E5=9C=B0=E6=9C=89=E7=94=A8---=E7=89=B9=E5=88=AB=
=E6=98=AF=E5=BD=93=E4=BD=A0=E9=80=9A=E8=BF=87=E4=B8=80=E4=B8=AA=E7=A9=BA=E6=
=8C=87=E9=92=88=E6=8C=87=E5=90=91=E7=BB=93=E6=9E=84=E4=BD=93=E7=9A=84=E6=97=
=B6=E5=80=99=E3=80=82tty=E6=BA=90=E7=A0=81=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=
=8C=E7=BB=8F=E5=B8=B8=E9=80=9A=E8=BF=87=E7=89=B9=E5=AE=9A=E9=A9=B1=E5=8A=A8=
=E4=BD=BF=E7=94=A8=E8=BF=99=E7=A7=8D=E6=96=B9=E6=B3=95=E5=B9=B6=E4=B8=94=E5=
=8F=8D=E5=A4=8D=E5=9C=B0=E6=8E=92=E5=88=97=E7=89=B9=E5=AE=9A=E6=96=B9=E9=9D=
=A2=E7=9A=84=E7=BB=93=E6=9E=84=E3=80=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E7=9A=84=E6=96=B9=E6=B3=95=
=E6=98=AF=E5=9C=A8=E7=BB=93=E6=9E=84=E7=9A=84=E5=BC=80=E5=A7=8B=E5=A4=84=E5=
=A3=B0=E6=98=8E=E7=9A=84=EF=BC=8C=E5=A6=82=E4=B8=8B::
-
-        struct tty_ldisc {
-	        int	magic;
-        	...
-        };
-
-=E5=BD=93=E4=BD=A0=E4=BB=A5=E5=90=8E=E7=BB=99=E5=86=85=E6=A0=B8=E6=B7=BB=
=E5=8A=A0=E5=A2=9E=E5=BC=BA=E5=8A=9F=E8=83=BD=E7=9A=84=E6=97=B6=E5=80=99=EF=
=BC=8C=E8=AF=B7=E9=81=B5=E5=AE=88=E8=BF=99=E6=9D=A1=E8=A7=84=E5=88=99=EF=BC=
=81=E8=BF=99=E6=A0=B7=E5=B0=B1=E4=BC=9A=E8=8A=82=E7=9C=81=E6=95=B0=E4=B8=8D=
=E6=B8=85=E7=9A=84=E8=B0=83=E8=AF=95=E6=97=B6=E9=97=B4=EF=BC=8C=E7=89=B9=E5=
=88=AB=E6=98=AF=E4=B8=80=E4=BA=9B=E5=8F=A4=E6=80=AA=E7=9A=84=E6=83=85=E5=86=
=B5=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=95=B0=E7=BB=84=E8=B6=85=E5=87=BA=
=E8=8C=83=E5=9B=B4=E5=B9=B6=E4=B8=94=E9=87=8D=E6=96=B0=E5=86=99=E4=BA=86=E8=
=B6=85=E5=87=BA=E9=83=A8=E5=88=86=E3=80=82=E9=81=B5=E5=AE=88=E8=BF=99=E4=B8=
=AA=E8=A7=84=E5=88=99=EF=BC=8C=E2=80=AA=E8=BF=99=E4=BA=9B=E6=83=85=E5=86=B5=
=E5=8F=AF=E4=BB=A5=E8=A2=AB=E5=BF=AB=E9=80=9F=E5=9C=B0=EF=BC=8C=E5=AE=89=E5=
=85=A8=E5=9C=B0=E9=81=BF=E5=85=8D=E3=80=82
-
-		Theodore Ts'o
-		  31 Mar 94
-
-=E7=BB=99=E5=BD=93=E5=89=8D=E7=9A=84Linux 2.1.55=E6=B7=BB=E5=8A=A0=E9=AD=
=94=E6=9C=AF=E8=A1=A8=E3=80=82
-
-		Michael Chastain
-		<mailto:mec@shout.net>
-		22 Sep 1997
-
-=E7=8E=B0=E5=9C=A8=E5=BA=94=E8=AF=A5=E6=9C=80=E6=96=B0=E7=9A=84Linux 2.1.1=
12.=E5=9B=A0=E4=B8=BA=E5=9C=A8=E7=89=B9=E6=80=A7=E5=86=BB=E7=BB=93=E6=9C=9F=
=E9=97=B4=EF=BC=8C=E4=B8=8D=E8=83=BD=E5=9C=A82.2.x=E5=89=8D=E6=94=B9=E5=8F=
=98=E4=BB=BB=E4=BD=95=E4=B8=9C=E8=A5=BF=E3=80=82=E8=BF=99=E4=BA=9B=E6=9D=A1=
=E7=9B=AE=E8=A2=AB=E6=95=B0=E5=9F=9F=E6=89=80=E6=8E=92=E5=BA=8F=E3=80=82
-
-		Krzysztof G.Baranowski
-	        <mailto: kgb@knm.org.pl>
-		29 Jul 1998
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E6=9C=AF=E8=A1=A8=E5=88=B0Linux 2.5.45=E3=80=
=82=E5=88=9A=E5=A5=BD=E8=B6=8A=E8=BF=87=E7=89=B9=E6=80=A7=E5=86=BB=E7=BB=93=
=EF=BC=8C=E4=BD=86=E6=98=AF=E6=9C=89=E5=8F=AF=E8=83=BD=E8=BF=98=E4=BC=9A=E6=
=9C=89=E4=B8=80=E4=BA=9B=E6=96=B0=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E5=9C=
=A82.6.x=E4=B9=8B=E5=89=8D=E8=9E=8D=E5=85=A5=E5=88=B0=E5=86=85=E6=A0=B8=E4=
=B8=AD=E3=80=82
-
-		Petr Baudis
-		<pasky@ucw.cz>
-		03 Nov 2002
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E6=9C=AF=E8=A1=A8=E5=88=B0Linux 2.5.74=E3=80=82
-
-		Fabian Frederick
-                <ffrederick@users.sourceforge.net>
-		09 Jul 2003
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documenta=
tion/translations/zh_TW/process/index.rst
index c5c59b4fd595..cb3dea0b78ab 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -54,7 +54,6 @@
 .. toctree::
    :maxdepth: 1
=20
-   magic-number
    volatile-considered-harmful
=20
 .. only::  subproject and html
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
deleted file mode 100644
index 0ccc60bee3d6..000000000000
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ /dev/null
@@ -1,63 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. _tw_magicnumbers:
-
-.. include:: ../disclaimer-zh_TW.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-
-=E5=A6=82=E6=9E=9C=E6=83=B3=E8=A9=95=E8=AB=96=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=85=A7=E5=AE=B9=EF=BC=8C=E8=AB=8B=E7=9B=B4=E6=
=8E=A5=E7=99=BC=E4=BF=A1=E5=88=B0LKML=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=
=E4=BD=BF=E7=94=A8=E8=8B=B1=E6=96=87=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=
=9B=A3=E7=9A=84=E8=A9=B1=EF=BC=8C=E4=B9=9F=E5=8F=AF
-=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=
=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=BB=E8=AD=AF=E6=
=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=99=82=E6=88=96=E8=80=85=E7=BF=BB=E8=AD=
=AF=E5=AD=98=E5=9C=A8=E5=95=8F=E9=A1=8C=EF=BC=8C=E8=AB=8B=E8=81=AF=E7=B9=AB=
=E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85::
-
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AD=AF=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E6=A0=A1=E8=AD=AF=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-                      =E8=83=A1=E7=9A=93=E6=96=87 Hu Haowen <src.res@email=
=2Ecn>
-
-Linux =E9=AD=94=E8=A1=93=E6=95=B8
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-=E9=80=99=E5=80=8B=E6=96=87=E4=BB=B6=E6=98=AF=E6=9C=89=E9=97=9C=E7=95=B6=
=E5=89=8D=E4=BD=BF=E7=94=A8=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E8=A8=BB=E5=
=86=8A=E8=A1=A8=E3=80=82=E7=95=B6=E4=BD=A0=E7=B5=A6=E4=B8=80=E5=80=8B=E7=B5=
=90=E6=A7=8B=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=B8=80=E5=80=8B=E9=AD=94=E8=A1=93=
=E5=80=BC=EF=BC=8C=E4=BD=A0=E4=B9=9F=E6=87=89=E8=A9=B2=E6=8A=8A=E9=80=99=E5=
=80=8B=E9=AD=94=E8=A1=93=E5=80=BC=E6=B7=BB=E5=8A=A0=E5=88=B0=E9=80=99=E5=80=
=8B=E6=96=87=E4=BB=B6=EF=BC=8C=E5=9B=A0=E7=88=B2=E6=88=91=E5=80=91=E6=9C=80=
=E5=A5=BD=E6=8A=8A=E7=94=A8=E6=96=BC=E5=90=84=E7=A8=AE=E7=B5=90=E6=A7=8B=E7=
=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E7=B5=B1=E4=B8=80=E8=B5=B7=E4=BE=86=E3=80=
=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E4=BE=86=E4=BF=9D=E8=AD=B7=
=E5=85=A7=E6=A0=B8=E6=95=B8=E6=93=9A=E7=B5=90=E6=A7=8B=E6=98=AF=E4=B8=80=E5=
=80=8B=E9=9D=9E=E5=B8=B8=E5=A5=BD=E7=9A=84=E4=B8=BB=E6=84=8F=E3=80=82=E9=80=
=99=E5=B0=B1=E5=85=81=E8=A8=B1=E4=BD=A0=E5=9C=A8=E9=81=8B=E8=A1=8C=E6=9C=9F=
=E6=AA=A2=E6=9F=A5(a)=E4=B8=80=E5=80=8B=E7=B5=90=E6=A7=8B=E6=98=AF=E5=90=A6=
=E5=B7=B2=E7=B6=93=E8=A2=AB=E6=94=BB=E6=93=8A=EF=BC=8C=E6=88=96=E8=80=85(b)=
=E4=BD=A0=E5=B7=B2=E7=B6=93=E7=B5=A6=E4=B8=80=E5=80=8B=E4=BE=8B=E8=A1=8C=E7=
=A8=8B=E5=BA=8F=E9=80=9A=E9=81=8E=E4=BA=86=E4=B8=80=E5=80=8B=E9=8C=AF=E8=AA=
=A4=E7=9A=84=E7=B5=90=E6=A7=8B=E3=80=82=E5=BE=8C=E4=B8=80=E7=A8=AE=E6=83=85=
=E6=B3=81=E7=89=B9=E5=88=A5=E5=9C=B0=E6=9C=89=E7=94=A8---=E7=89=B9=E5=88=A5=
=E6=98=AF=E7=95=B6=E4=BD=A0=E9=80=9A=E9=81=8E=E4=B8=80=E5=80=8B=E7=A9=BA=E6=
=8C=87=E9=87=9D=E6=8C=87=E5=90=91=E7=B5=90=E6=A7=8B=E9=AB=94=E7=9A=84=E6=99=
=82=E5=80=99=E3=80=82tty=E6=BA=90=E7=A2=BC=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=
=8C=E7=B6=93=E5=B8=B8=E9=80=9A=E9=81=8E=E7=89=B9=E5=AE=9A=E9=A9=85=E5=8B=95=
=E4=BD=BF=E7=94=A8=E9=80=99=E7=A8=AE=E6=96=B9=E6=B3=95=E4=B8=A6=E4=B8=94=E5=
=8F=8D=E8=A6=86=E5=9C=B0=E6=8E=92=E5=88=97=E7=89=B9=E5=AE=9A=E6=96=B9=E9=9D=
=A2=E7=9A=84=E7=B5=90=E6=A7=8B=E3=80=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E7=9A=84=E6=96=B9=E6=B3=95=
=E6=98=AF=E5=9C=A8=E7=B5=90=E6=A7=8B=E7=9A=84=E9=96=8B=E5=A7=8B=E8=99=95=E8=
=81=B2=E6=98=8E=E7=9A=84=EF=BC=8C=E5=A6=82=E4=B8=8B::
-
-        struct tty_ldisc {
-	        int	magic;
-        	...
-        };
-
-=E7=95=B6=E4=BD=A0=E4=BB=A5=E5=BE=8C=E7=B5=A6=E5=85=A7=E6=A0=B8=E6=B7=BB=
=E5=8A=A0=E5=A2=9E=E5=BC=B7=E5=8A=9F=E8=83=BD=E7=9A=84=E6=99=82=E5=80=99=EF=
=BC=8C=E8=AB=8B=E9=81=B5=E5=AE=88=E9=80=99=E6=A2=9D=E8=A6=8F=E5=89=87=EF=BC=
=81=E9=80=99=E6=A8=A3=E5=B0=B1=E6=9C=83=E7=AF=80=E7=9C=81=E6=95=B8=E4=B8=8D=
=E6=B8=85=E7=9A=84=E8=AA=BF=E8=A9=A6=E6=99=82=E9=96=93=EF=BC=8C=E7=89=B9=E5=
=88=A5=E6=98=AF=E4=B8=80=E4=BA=9B=E5=8F=A4=E6=80=AA=E7=9A=84=E6=83=85=E6=B3=
=81=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=95=B8=E7=B5=84=E8=B6=85=E5=87=BA=
=E7=AF=84=E5=9C=8D=E4=B8=A6=E4=B8=94=E9=87=8D=E6=96=B0=E5=AF=AB=E4=BA=86=E8=
=B6=85=E5=87=BA=E9=83=A8=E5=88=86=E3=80=82=E9=81=B5=E5=AE=88=E9=80=99=E5=80=
=8B=E8=A6=8F=E5=89=87=EF=BC=8C=E2=80=AA=E9=80=99=E4=BA=9B=E6=83=85=E6=B3=81=
=E5=8F=AF=E4=BB=A5=E8=A2=AB=E5=BF=AB=E9=80=9F=E5=9C=B0=EF=BC=8C=E5=AE=89=E5=
=85=A8=E5=9C=B0=E9=81=BF=E5=85=8D=E3=80=82
-
-		Theodore Ts'o
-		  31 Mar 94
-
-=E7=B5=A6=E7=95=B6=E5=89=8D=E7=9A=84Linux 2.1.55=E6=B7=BB=E5=8A=A0=E9=AD=
=94=E8=A1=93=E8=A1=A8=E3=80=82
-
-		Michael Chastain
-		<mailto:mec@shout.net>
-		22 Sep 1997
-
-=E7=8F=BE=E5=9C=A8=E6=87=89=E8=A9=B2=E6=9C=80=E6=96=B0=E7=9A=84Linux 2.1.1=
12.=E5=9B=A0=E7=88=B2=E5=9C=A8=E7=89=B9=E6=80=A7=E5=87=8D=E7=B5=90=E6=9C=9F=
=E9=96=93=EF=BC=8C=E4=B8=8D=E8=83=BD=E5=9C=A82.2.x=E5=89=8D=E6=94=B9=E8=AE=
=8A=E4=BB=BB=E4=BD=95=E6=9D=B1=E8=A5=BF=E3=80=82=E9=80=99=E4=BA=9B=E6=A2=9D=
=E7=9B=AE=E8=A2=AB=E6=95=B8=E5=9F=9F=E6=89=80=E6=8E=92=E5=BA=8F=E3=80=82
-
-		Krzysztof G.Baranowski
-	        <mailto: kgb@knm.org.pl>
-		29 Jul 1998
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E8=A1=93=E8=A1=A8=E5=88=B0Linux 2.5.45=E3=80=
=82=E5=89=9B=E5=A5=BD=E8=B6=8A=E9=81=8E=E7=89=B9=E6=80=A7=E5=87=8D=E7=B5=90=
=EF=BC=8C=E4=BD=86=E6=98=AF=E6=9C=89=E5=8F=AF=E8=83=BD=E9=82=84=E6=9C=83=E6=
=9C=89=E4=B8=80=E4=BA=9B=E6=96=B0=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E5=9C=
=A82.6.x=E4=B9=8B=E5=89=8D=E8=9E=8D=E5=85=A5=E5=88=B0=E5=85=A7=E6=A0=B8=E4=
=B8=AD=E3=80=82
-
-		Petr Baudis
-		<pasky@ucw.cz>
-		03 Nov 2002
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E8=A1=93=E8=A1=A8=E5=88=B0Linux 2.5.74=E3=80=82
-
-		Fabian Frederick
-                <ffrederick@users.sourceforge.net>
-		09 Jul 2003
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
--=20
2.30.2

--jl27s4gcpgi27lhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpmEACgkQvP0LAY0m
WPGlFA//alBJaCSxz3MVOEZJOodsH/CRViJrofWwW+0V5Dby/Pc4XV/PsBcQwQL4
sp3pU5kVhFgAvYsPVhN04mzJCVEcJfbINpH4vnr8dUMOF0Y6jAuzF//cdChQJ8W3
/BqHtVwiBvcSe/GwQ4YaT9ELdGU6fVXWg0RvONwf4MlG8PSRgkkR8v7Bc3k3aFHZ
lRf2oD2J6CkbsLE54vY8n3U10CSviBZEnI1VCbka4vFatMTFZLgOoy0beTulRo8B
WZmTk9v61im2rljZSL392WpnH2jn8hOB1bNI4Fv4de9Az82UyxbshSE/bi/DLfZp
/JsCZOu2+22J/WEkYYgTP1jqpDUAfBP8e+ZmSnmPCtblWkXHrCqSwuPRnjaAKO8m
CKj+Iz4sTSybghKEIoVuqF8UtOJ/mdVpxIcyUWHSTMJbPEej5DDNuHzMV1QnmS2Y
ong5b+u7wMNjhoclHQMRhv62QjEzpbd1SUnJTY+o3p/hEG/Nd6sHdP4IJfNKDo0p
MtuJ/H5kfFClGA51d40DGF6qhSGBGZg/b8HcrydsSCzibfCop8bWWEil/RWG+ByX
Aku/YLL+W5n6gH8xEiorL8J0Q08Q/a8XjGyCh6JsRt139zw+BAqn/laPNwDyo1WX
nTj/dnKy00VEJz+7WKQhjvjLsfhhf1ZZEptUHotROOpiyjY+e3E=
=gwGg
-----END PGP SIGNATURE-----

--jl27s4gcpgi27lhq--
