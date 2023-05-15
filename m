Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B88702142
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjEOBoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEOBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:44:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB159170B;
        Sun, 14 May 2023 18:44:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKMbj3Qynz4x4G;
        Mon, 15 May 2023 11:44:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684115041;
        bh=KWZ5J3oaKA06cGONfeJWEtOE5wG3To69U0OGW1xKIDA=;
        h=Date:From:To:Cc:Subject:From;
        b=Ok3v+60sAjiI+70htKHFxlzcnwsobCrQthlnHQ3/t0tNtK5IFSie9CXsGirX7sgqF
         UphhFrusUDpHBjzYut3PRDmJJ8Xv2M2i+/HQVQ8JzWU2iAv8xLovWgIq+CbifiQVdO
         9GLh95fvZaz3nOPX4P2mZyF/Iul/+sI3JyJWiv7kEgsHdmi33AYIUGyyQeXZ1bBd9q
         qYOMWf2tHBiWE8Exew4e5tG2tooBvrKD4tTcK+86cZPaZ+Jfu/m1uWjcaWnsQYiJHb
         Oe4+mfqxIlTPUNqlzT6Q4Wii21ht6qq7/Oheotw9F5ffv+1PPQ1i46nny4MfemLSNU
         7EbTGMyhaobTw==
Date:   Mon, 15 May 2023 11:43:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20230515114359.3a2aac25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/50hsj/pBY4R=HTcFPlrPaUG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/50hsj/pBY4R=HTcFPlrPaUG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/amd/yc/acp6x-mach.c:320:9: error: braces around scalar initialize=
r [-Werror]
  320 |         {
      |         ^
sound/soc/amd/yc/acp6x-mach.c:320:9: note: (near initialization for 'yc_acp=
_quirk_table[38].driver_data')
sound/soc/amd/yc/acp6x-mach.c:321:17: error: field name not in record or un=
ion initializer
  321 |                 .driver_data =3D &acp6x_card,
      |                 ^
sound/soc/amd/yc/acp6x-mach.c:321:17: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
sound/soc/amd/yc/acp6x-mach.c:322:17: error: field name not in record or un=
ion initializer
  322 |                 .matches =3D {
      |                 ^
sound/soc/amd/yc/acp6x-mach.c:322:17: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
sound/soc/amd/yc/acp6x-mach.c:322:17: error: braces around scalar initializ=
er [-Werror]
sound/soc/amd/yc/acp6x-mach.c:322:17: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
sound/soc/amd/yc/acp6x-mach.c:323:25: error: braces around scalar initializ=
er [-Werror]
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:323:25: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
In file included from include/linux/of.h:18,
                 from include/sound/soc.h:13,
                 from sound/soc/amd/yc/acp6x-mach.c:8:
include/linux/mod_devicetable.h:588:27: error: field name not in record or =
union initializer
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                           ^
sound/soc/amd/yc/acp6x-mach.c:323:25: note: in expansion of macro 'DMI_MATC=
H'
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                         ^~~~~~~~~
include/linux/mod_devicetable.h:588:27: note: (near initialization for 'yc_=
acp_quirk_table[38].driver_data')
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                           ^
sound/soc/amd/yc/acp6x-mach.c:323:25: note: in expansion of macro 'DMI_MATC=
H'
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:323:35: error: initialization of 'void *' fro=
m 'int' makes pointer from integer without a cast [-Werror=3Dint-conversion]
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                                   ^~~~~~~~~~~~~~~~
include/linux/mod_devicetable.h:588:35: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                   ^
sound/soc/amd/yc/acp6x-mach.c:323:35: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                                   ^~~~~~~~~~~~~~~~
include/linux/mod_devicetable.h:588:35: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                   ^
include/linux/mod_devicetable.h:588:38: error: field name not in record or =
union initializer
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                      ^
sound/soc/amd/yc/acp6x-mach.c:323:25: note: in expansion of macro 'DMI_MATC=
H'
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                         ^~~~~~~~~
include/linux/mod_devicetable.h:588:38: note: (near initialization for 'yc_=
acp_quirk_table[38].driver_data')
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                      ^
sound/soc/amd/yc/acp6x-mach.c:323:25: note: in expansion of macro 'DMI_MATC=
H'
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:323:53: error: excess elements in scalar init=
ializer [-Werror]
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                                                     ^~~~~~~~~~
include/linux/mod_devicetable.h:588:48: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                                ^
sound/soc/amd/yc/acp6x-mach.c:323:53: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
  323 |                         DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
      |                                                     ^~~~~~~~~~
include/linux/mod_devicetable.h:588:48: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                                ^
sound/soc/amd/yc/acp6x-mach.c:324:25: error: braces around scalar initializ=
er [-Werror]
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:324:25: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
include/linux/mod_devicetable.h:588:27: error: field name not in record or =
union initializer
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                           ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
include/linux/mod_devicetable.h:588:27: note: (near initialization for 'yc_=
acp_quirk_table[38].driver_data')
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                           ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:324:35: error: initialization of 'void *' fro=
m 'int' makes pointer from integer without a cast [-Werror=3Dint-conversion]
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                                   ^~~~~~~~~~~~~~~~~~~
include/linux/mod_devicetable.h:588:35: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                   ^
sound/soc/amd/yc/acp6x-mach.c:324:35: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                                   ^~~~~~~~~~~~~~~~~~~
include/linux/mod_devicetable.h:588:35: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                   ^
include/linux/mod_devicetable.h:588:38: error: field name not in record or =
union initializer
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                      ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
include/linux/mod_devicetable.h:588:38: note: (near initialization for 'yc_=
acp_quirk_table[38].driver_data')
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                      ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:324:56: error: excess elements in scalar init=
ializer [-Werror]
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                                                        ^~~~~~~~
include/linux/mod_devicetable.h:588:48: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                                ^
sound/soc/amd/yc/acp6x-mach.c:324:56: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                                                        ^~~~~~~~
include/linux/mod_devicetable.h:588:48: note: in definition of macro 'DMI_M=
ATCH'
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                                                ^
include/linux/mod_devicetable.h:588:25: error: excess elements in scalar in=
itializer [-Werror]
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                         ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
include/linux/mod_devicetable.h:588:25: note: (near initialization for 'yc_=
acp_quirk_table[38].driver_data')
  588 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
      |                         ^
sound/soc/amd/yc/acp6x-mach.c:324:25: note: in expansion of macro 'DMI_MATC=
H'
  324 |                         DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
      |                         ^~~~~~~~~
sound/soc/amd/yc/acp6x-mach.c:322:28: error: excess elements in scalar init=
ializer [-Werror]
  322 |                 .matches =3D {
      |                            ^
sound/soc/amd/yc/acp6x-mach.c:322:28: note: (near initialization for 'yc_ac=
p_quirk_table[38].driver_data')
sound/soc/amd/yc/acp6x-mach.c:327:9: error: extra brace group at end of ini=
tializer
  327 |         {}
      |         ^
sound/soc/amd/yc/acp6x-mach.c:327:9: note: (near initialization for 'yc_acp=
_quirk_table[38]')
sound/soc/amd/yc/acp6x-mach.c:327:9: error: excess elements in struct initi=
alizer [-Werror]
sound/soc/amd/yc/acp6x-mach.c:327:9: note: (near initialization for 'yc_acp=
_quirk_table[38]')
sound/soc/amd/yc/acp6x-mach.c:328:2: error: expected '}' before ';' token
  328 | };
      |  ^
sound/soc/amd/yc/acp6x-mach.c:47:58: note: to match this '{'
   47 | static const struct dmi_system_id yc_acp_quirk_table[] =3D {
      |                                                          ^

Caused by commit

  af233bd2931b ("ASoC: Merge up fixes for CI")

I have used the sound-asoc tree from next-20230512 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/50hsj/pBY4R=HTcFPlrPaUG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhjl8ACgkQAVBC80lX
0Gz+xQf+MYoIb574PqqqEL37XePn9w0Srmrwt/Ig64+wSvgt4Py32Jida1nf/QV/
55ToFSBZr5C2ky59y+EpgmrmZqMtVg1ha6LMMa5ReaahBYvdweNi5rNbbaRlupe1
0vG8M+AyM1h4axU9GQ8ZkG0DErXhxqqYJxClEMFMhZ4GNzrdraapiw/Zo+8GDfaK
XVbboVoYkHV5h3w/2ufOxKBpGSfNqVMS/pmnJT9gyLn34DBEtOV7zpPIWBEW1C3Y
Ezzuzct7ZM06O4WIE7729A1fmsRa1bupBSJQD5eVxhjtDh9feOeZUgpU/lG3RGDz
k48rokwtQ+uuTxS0coDxnVoAWu56rw==
=4Egb
-----END PGP SIGNATURE-----

--Sig_/50hsj/pBY4R=HTcFPlrPaUG--
