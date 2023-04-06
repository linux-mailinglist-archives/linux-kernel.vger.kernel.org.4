Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7F6D9EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjDFRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjDFRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5111992;
        Thu,  6 Apr 2023 10:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F74A64A66;
        Thu,  6 Apr 2023 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB393C433EF;
        Thu,  6 Apr 2023 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680801726;
        bh=6S/67Dpkn+c4teeGqF2QJn7eQBBjGDbIM8p7vVVCfxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTePh2R8YK4QR589LdgsFQmSjLP0EBHdg8XVumlvAwpz/tejlY4GsLplKvml5QbN9
         xcPfIrcbJk4ziO8lQjBcUkX5KEs6cHa37t4bMqLanpw+D4IjaUp1IBuI4g8KeXqr4a
         zqfuNt0ggbfUr9ycQ+C222ZuUdcFJ+xRmVT526JzDUTYKHc0tUTASbdaRSzEq2fK/A
         XQDCwMnp1h0I11P5bJOLp58vhTX36tJjl90ydvRfzRuW6ONJ29KBqhQv/e62ciPy4m
         rDDtXYze7lqPJsqd/YiszMW2g5iA8og6+9YmRVMxAf7s4hxyi4JqCJhlASRcMKUE/y
         sgunoPx1Ts3fA==
Date:   Thu, 6 Apr 2023 18:22:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        William Breathitt Gray <william.gray@linaro.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <6cd5dba5-2241-458d-9791-30d0851eee22@sirena.org.uk>
References: <20230406120055.11fcfe5b@canb.auug.org.au>
 <20230406073646.GW8371@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YKVx4Er2cI58EMgd"
Content-Disposition: inline
In-Reply-To: <20230406073646.GW8371@google.com>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YKVx4Er2cI58EMgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 08:36:46AM +0100, Lee Jones wrote:

> Applied, squashed and credit given, thanks:

> Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Date:   Thu Feb 16 22:22:12 2023 +0000
>=20
>     mfd: qcom-pm8008: Convert irq chip to config regs
>=20
>     Replace type and virtual registers, which are both deprecated,
>     with config registers. This also simplifies the driver because
>     IRQ types are set in one place, the set_type_config() callback.

You should need this I think:

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-set-type-irq-drv-data

for you to fetch changes up to 7697c64b9e4908196f0ae68aa6d423dd40607973:

  regmap: Pass irq_drv_data as a parameter for set_type_config() (2023-04-0=
5 17:19:24 +0100)

----------------------------------------------------------------
regmap: Pass irq_drv_data as a parameter for set_type_config()

Allow callbacks to access irq_drv_data.

----------------------------------------------------------------
William Breathitt Gray (1):
      regmap: Pass irq_drv_data as a parameter for set_type_config()

 drivers/base/regmap/regmap-irq.c | 8 +++++---
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

--YKVx4Er2cI58EMgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu/7cACgkQJNaLcl1U
h9BEmwf5AbbQK6uYa8E2kZr2HbtFWxxPLAkraF+8KZJNPH+WPijZ2H7CWzbXo0D+
FHOnL/nERJ6NgSxpvUhiZ4Kso79tN9lS3+ER369cqfjOAkduyhRrvfkHWQ0VL7M8
+X+R2Nbioc0YDx+7ZCkq2rHYlhrTYlyaLPy9aSBel1Upithl5jC0BpE5rTKdx78E
Won6FP7FCLWp+AIrvXusZJjyJTTlh+VySCiSow1AX057i68h3XJvD3W4wKNQUlgD
PcUwtNCz7v6q9mE5wO7qrWNKGLw+QLnGOkjpCPUaXNKtjFWUIDjl1TQMJ3wO0loS
1wp3vU68wfnH0XAKA9SEczFehC2Yyg==
=2ePA
-----END PGP SIGNATURE-----

--YKVx4Er2cI58EMgd--
