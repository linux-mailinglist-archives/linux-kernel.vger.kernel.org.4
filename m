Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514C266B6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjAPF2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjAPF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:27:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53818A41;
        Sun, 15 Jan 2023 21:27:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwLBh6m3Kz4x1N;
        Mon, 16 Jan 2023 16:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673846862;
        bh=Ob0t3QjCzRPVxFieNgWcUtD6U3hKnJ5VSBdZFVnXgqs=;
        h=Date:From:To:Cc:Subject:From;
        b=hIRhWnem3k6lYJ29KBcM8HEVtiYLhfg5Qxmn5YGGOXNifZ7XZGtjOWbVNc4Wk1MmI
         wFyQ+k1I6gnGgtFDOM0b76gvRlysihyIvSnU1sMsFCLWqm1+ZBdk5vP79nnqsLlSVD
         tvT2R4HIY8HYEdJMpjOX18JHDYfVswgy/8Pp6hc2/zJuGbxapE+GE4IxIKdN/41B/9
         tT6eyoFStdktj8Li6iExBh7d++y/5ia2mxPRh29EkF+a30+OTNF3gXLcWkl4wmbEu0
         haiuC3lby/kSkMXj87CUXZ9KBnwedbglbr7+lnPuJbWaRLFt717fuJm8wwILXmI0q2
         4t65nJiCAav6w==
Date:   Mon, 16 Jan 2023 16:27:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20230116162739.529247b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oH=QdF9p/_57RbRc1hV1rLD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oH=QdF9p/_57RbRc1hV1rLD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (various)
failed like this:

arch/arm/mach-sa1100/h3600.c:125:3: error: =E2=80=98struct irda_platform_da=
ta=E2=80=99 has no member named =E2=80=98shutdown=E2=80=99
arch/arm/mach-sa1100/h3600.c:124:3: error: =E2=80=98struct irda_platform_da=
ta=E2=80=99 has no member named =E2=80=98startup=E2=80=99
arch/arm/mach-sa1100/h3600.c:123:3: error: =E2=80=98struct irda_platform_da=
ta=E2=80=99 has no member named =E2=80=98set_speed=E2=80=99
arch/arm/mach-sa1100/h3600.c:122:3: error: =E2=80=98struct irda_platform_da=
ta=E2=80=99 has no member named =E2=80=98set_power=E2=80=99
arch/arm/mach-sa1100/h3600.c:121:34: error: storage size of =E2=80=98h3600_=
irda_data=E2=80=99 isn=E2=80=99t known
arch/arm/mach-sa1100/h3600.c:121:15: error: variable =E2=80=98h3600_irda_da=
ta=E2=80=99 has initializer but incomplete type
arch/arm/mach-sa1100/collie.c:148:3: error: =E2=80=98struct irda_platform_d=
ata=E2=80=99 has no member named =E2=80=98set_power=E2=80=99
arch/arm/mach-sa1100/collie.c:147:3: error: =E2=80=98struct irda_platform_d=
ata=E2=80=99 has no member named =E2=80=98shutdown=E2=80=99
arch/arm/mach-sa1100/collie.c:146:3: error: =E2=80=98struct irda_platform_d=
ata=E2=80=99 has no member named =E2=80=98startup=E2=80=99
arch/arm/mach-sa1100/collie.c:145:34: error: storage size of =E2=80=98colli=
e_ir_data=E2=80=99 isn=E2=80=99t known
arch/arm/mach-sa1100/collie.c:145:15: error: variable =E2=80=98collie_ir_da=
ta=E2=80=99 has initializer but incomplete type

Caused by commit

  56d3391e6c85 ("ARM: sa1100: remove irda references")

These came from the kernelci builds.

$ git grep -w irda_platform_data
arch/arm/mach-sa1100/assabet.c:static struct irda_platform_data assabet_ird=
a_data =3D {
arch/arm/mach-sa1100/collie.c:static struct irda_platform_data collie_ir_da=
ta =3D {
arch/arm/mach-sa1100/generic.c:void sa11x0_register_irda(struct irda_platfo=
rm_data *irda)
arch/arm/mach-sa1100/generic.h:struct irda_platform_data;
arch/arm/mach-sa1100/generic.h:void sa11x0_register_irda(struct irda_platfo=
rm_data *irda);
arch/arm/mach-sa1100/h3600.c:static struct irda_platform_data h3600_irda_da=
ta =3D {

--=20
Cheers,
Stephen Rothwell

--Sig_/oH=QdF9p/_57RbRc1hV1rLD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPE4EsACgkQAVBC80lX
0GwyBwf/UJXfEtAymFFDOVmJMtsFmdTLMi0SmTBIjTmdUe42V0KdlLQUc3L4MbA+
JK1UOUC2G7vKRBZk1PGgT9NEHxjkiKB7wMrDlylVImwAc1lhOJyKXAdxYgSf2EKB
wubKfP9exMfmMFepyPk6+UWl4gLo6QtFW07tn2nv+pRwQFoqPyDkC+lXmbmke6Hh
tzk7Hrm0zRM4ZnaMWMlvHvlC99JI+sk4mXkcvpD6Ay2UsXH0RpKRO3zACxffDVdl
xxEct06M2vCNDrPbcpP52FLty82g8T/1xSn2wapQ4AKitghb2MyFRsCGQYJHQzDZ
FF4rU78c3umd8ghJZv5xYF3IpoXTNw==
=08m8
-----END PGP SIGNATURE-----

--Sig_/oH=QdF9p/_57RbRc1hV1rLD--
