Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAA5BA2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIOWiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIOWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:38:50 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F944F64E;
        Thu, 15 Sep 2022 15:38:48 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B02AC11FE;
        Fri, 16 Sep 2022 00:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281527;
        bh=2Ct6MVeyoYb6dtKXKW6sQX2qdA4lO3IpMlc6S8ZVHZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kr5iOHkd3Pn/FmDuk0PDNec11o9mPloAwhGhRxCTrNQcRovjYscjaSwSMZJZvCeFl
         kL3ObEev0j2vZobb9GGQRHkWEE1BmhUvSrtXlrzfyBUscxn2MNYRuUFbKPN7jJWZIW
         DD0VXhMoeEYOpdYRafXFtM4w2Im13he/MteiFN+ccnnD7PlmPo2bZWGMeE+SaGufUC
         0WHM7WF6g1dvV8GO5WY4BucJ8Pmb+9p5ptXB5AdjeL+4eRFLx1nfy5dVv9zIYJF7AF
         rOQhZ/e6z8m287b9waUrqXJbjomLTVHrqi63cy0BFyKntqwGV3tIqEraz7HCafXqxQ
         A0ekGf8b7QN6E5xqtrXf4wlNwo5cd2OGj9blqMKhjQVvVnqz1UTSlrZDzRcjr4f0HJ
         Jucjz2drdx47KNFSKtKCBbLsCodnE4jImIHdDe3KBpSyJs80AgutayI/Xsu4N4DDff
         Q+KsU59ETf1MmDPqKlvcSjzgvKgL2Y8LpftqcofSBArEsECKXFekKcZ/FexL3iWM9D
         TPSIhyKCIyLBiu78ZWAI/KpSF8vhdQFvwOWAkv3AMh5aapcoRUNKynpleGWvI687qw
         mm08oHNRc6p8b1WFBa4pDajCDwzAfzCgtTljYaMUCwroXC1DyhWxt3pNA/gnzuw7lH
         qrJFgU7OUL3yPHHMxCnDJb+U=
Date:   Fri, 16 Sep 2022 00:38:46 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v4 02/18] a.out: remove define-only CMAGIC, previously magic
 number
Message-ID: <9cbea062df7125ef43e2e0b2a67ede6ad1c5f27e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgubbxsphv7oxy7x"
Content-Disposition: inline
In-Reply-To: <YyMlovoskUcHLEb7@kroah.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgubbxsphv7oxy7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The last user was removed in 5.1 in
commit 08300f4402ab ("a.out: remove core dumping support")
but this is part of the UAPI headers, so this may want to either wait
until a.out is removed entirely, or be removed from the magic number doc
and silently remain in the header

A cursory glance on DCS didn't show any user code actually using this
value

Found with
grep MAGIC Documentation/process/magic-number.rst | while read -r mag _;
do git grep -wF "$mag"  | grep -ve '^Documentation.*magic-number.rst:' \
-qe ':#define '"$mag" || git grep -wF "$mag" | while IFS=3D: read -r f _;
do sed -i '/\b'"$mag"'\b/d' "$f"; done ; done

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 include/uapi/linux/a.out.h                                | 3 ---
 5 files changed, 7 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index eb2db3608a15..f48c6c6efaf7 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -69,7 +69,6 @@ Changelog::
 Magic Name            Number           Structure                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 86ef47906f37..27f60133fbe5 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -75,7 +75,6 @@ Registro dei cambiamenti::
 Nome magico           Numero           Struttura                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index cbefdcbfbf53..520cc5cf4d63 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -58,7 +58,6 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 7fd6e494467b..7d6debd0117e 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -61,7 +61,6 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 =E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
index 5fafde3798e5..bb15da96df2a 100644
--- a/include/uapi/linux/a.out.h
+++ b/include/uapi/linux/a.out.h
@@ -70,9 +70,6 @@ enum machine_type {
    The first page is unmapped to help trap NULL pointer references */
 #define QMAGIC 0314
=20
-/* Code indicating core file.  */
-#define CMAGIC 0421
-
 #if !defined (N_BADMAG)
 #define N_BADMAG(x)	  (N_MAGIC(x) !=3D OMAGIC		\
 			&& N_MAGIC(x) !=3D NMAGIC		\
--=20
2.30.2

--lgubbxsphv7oxy7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqXYACgkQvP0LAY0m
WPHrEw//fk86vfZFRNVWVaS97xuG/31rh215afAT7Beuvk5ftASgN500LlPCUDqz
heAGSFguaH73eGfJ3IuP5ZnVlEoIxSdC0N2XSD+faszwQBimN37EQaVXIBBcQ7tE
nZH9QOxorrKj/gvc7WdIyEznsj3Vtg9Zn5pQ8W0wgIb6OZ1IUcxgOK0acUZXXo+Z
oZDviMwwfQFkjeiUfueOchifZPk/lnUd+07OpfV1puiHphEnqUur3DJJu0L2D+Fq
L59vV2m+wxTpPlz3KsrU5xBrOc5S7hn2UT0IYrxYgSXL0L9Skv9Lrm0hajgfE2Ir
wUJdL/BE72Qir4XvfxjJUKIR84ciFGNJf+Nsqz7MPZbRf62j/p1Dbvq9EH+y7JCF
bQHO/SLIFbJB9jqf8YyMbPB1hJG80TvXdJON8E1b6KyhJFCCPh6763AXERdR26Dr
jOhHtvxxtEihML4l0+QZTmV3/QlqfuWYv0Jc+p4Ruo+zB27ECnHpMNUKa2mHbfzX
5JuVcftObuCEXmuWzjxSiskdhFgvt4r/7O3GQcFOGhDrJtStJCPQd6uO3pf18TUz
z4wqhAjUaq+rL0Ks+WZ5TG6B1qBSJ5deV5XePRI8snwnKU23bZlS54vBecndsT0P
jocSg4Nhdyth0hJl8dJCGNdIjHlIqbOY3Yx9ZNrjQ2S9TiGDt/0=
=0YxH
-----END PGP SIGNATURE-----

--lgubbxsphv7oxy7x--
