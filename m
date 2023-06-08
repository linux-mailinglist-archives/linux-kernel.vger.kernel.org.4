Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A87282EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjFHOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbjFHOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A32136;
        Thu,  8 Jun 2023 07:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89BD64E27;
        Thu,  8 Jun 2023 14:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B9BC433D2;
        Thu,  8 Jun 2023 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686235421;
        bh=rP0q3qjncgDpDKDDVXbYz3KOWj76WnWqmpcM80SQI28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3h4tUNxovyNgZ9WHKMe4NXuo32sj9oev4mwukKJEs+Qhgr8OZKzuOr2L0Q54qc6c
         6topEvPSjwcHuvEThPbum5M/hX1kxLyMkZ3elAmCJTGCxfUA0W2MrTK0CGqPiqI1tI
         L0uzADwhATyNAlk491+9N4Fr3v79lb0utWZjt1zqDCmU0OsHvf2iDkdeSREBTo7nK8
         6F0C+IkLB3Y5HyCodjcnhalXORzSMJ3YNDhpFNfeROYSysVIR/2b9xnNgV6t3YLs14
         AbcqT9e8CSZ6ONJnMgZF18NiAcAKkF9Tr8Q59KScjThCdvAa3388qNyf978suD4qdQ
         1sOmQY5zCg2Ig==
Date:   Thu, 8 Jun 2023 10:43:37 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, andy.shevchenko@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH 1/3] counter: i8254: Introduce the Intel 8254 interface
 library module
Message-ID: <ZIHpGUWZ8wE7tkJP@ishi>
References: <cover.1681665189.git.william.gray@linaro.org>
 <f6fe32c2db9525d816ab1a01f45abad56c081652.1681665189.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MrMSNaKdeZ7w23Mn"
Content-Disposition: inline
In-Reply-To: <f6fe32c2db9525d816ab1a01f45abad56c081652.1681665189.git.william.gray@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MrMSNaKdeZ7w23Mn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 16, 2023 at 01:36:53PM -0400, William Breathitt Gray wrote:
> Exposes consumer library functions providing support for interfaces
> compatible with the venerable Intel 8254 Programmable Interval Timer
> (PIT).
>=20
> The Intel 8254 PIT first appeared in the early 1980s and was used
> initially in IBM PC compatibles. The popularity of the original Intel
> 825x family of chips led to many subsequent variants and clones of the
> interface in various chips and integrated circuits. Although still
> popular, interfaces compatible with the Intel 8254 PIT are nowdays
> typically found embedded in larger VLSI processing chips and FPGA
> components rather than as discrete ICs.
>=20
> A CONFIG_I8254 Kconfig option is introduced by this patch. Modules
> wanting access to these i8254 library functions should select this
> Kconfig option, and import the I8254 symbol namespace.
>=20
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I've queued this patch to the counter-next branch of my Counter tree.

Jonathan, Bart, I've created an immutable branch with just this patch
for you to pull which should allow you each to merge the other patch in
this patchset for your respective tree.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/i8254

for you to fetch changes up to b923ba2c0829a1a22151139309b4ae5d47a99d34:

  counter: i8254: Introduce the Intel 8254 interface library module (2023-0=
6-08 10:14:10 -0400)

----------------------------------------------------------------
counter: i8254: Introduce the Intel 8254 interface library module

This exposes consumer library functions providing support for interfaces
compatible with the venerable Intel 8254 Programmable Interval Timer.

----------------------------------------------------------------
William Breathitt Gray (1):
      counter: i8254: Introduce the Intel 8254 interface library module

 Documentation/ABI/testing/sysfs-bus-counter |  54 ++++
 MAINTAINERS                                 |   7 +
 drivers/counter/Kconfig                     |  15 +
 drivers/counter/Makefile                    |   1 +
 drivers/counter/counter-sysfs.c             |   8 +-
 drivers/counter/i8254.c                     | 447 ++++++++++++++++++++++++=
++++
 include/linux/i8254.h                       |  21 ++
 include/uapi/linux/counter.h                |   6 +
 8 files changed, 558 insertions(+), 1 deletion(-)
 create mode 100644 drivers/counter/i8254.c
 create mode 100644 include/linux/i8254.h

Sincerely,

William Breathitt Gray

--MrMSNaKdeZ7w23Mn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZIHpGQAKCRC1SFbKvhIj
K7PzAQDN/DQ+bvzSdN4IW/6wiGR3cu+2SkNH6EXMQ4LGQlQ23gEA/ova0tmMl7q8
gLoE7FR8EQr+anvEkWTdZtX1FOHM1Qk=
=laO/
-----END PGP SIGNATURE-----

--MrMSNaKdeZ7w23Mn--
