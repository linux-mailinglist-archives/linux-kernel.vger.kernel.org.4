Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5096E6D34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjDRUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:00:58 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936855B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1681848010;
        bh=C8n+u6LGHwZMhPF+YX4nvzfsQzvMFbR9EYTHpXERbIQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J+GFblxL10crjZMM+rtTPaZRh3AysPVwW+jcdL/f1vDj9sjFe16oxOK6FYXgT3iik
         KnYKoExg6AILFRGeHqSonN6F3qjX7Kkrk1mRez8OK048Tr+Trc1yEm/L6WEIiFaJvP
         dwQ6NsN+xAFlAZfy0KxayXAOtCvBXUmq0ck8Q/g5lwhD2mQBRjhKbmausdlw6eM5Qg
         wAzgWiAcDv6sqJ4y4v1Ti+8YsSj/61B9BcpWO7gW3VfrUuvpIcKtQGCpMiQ3tenFiZ
         T0xwtO77djIl/miGtYGkNgt777d/k1yiERxEfvURpV3IyT7RuyiSE5jIQkwfIPutG5
         DMKa+24s0Vcvw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZUmi9/xwYP1tNtkugFXddhctvjq8xtZQA
Date:   Tue, 18 Apr 2023 20:00:03 +0000
Message-ID: <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
In-Reply-To: <20230309092254.56279-3-cniedermaier@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Niedermaier [mailto:cniedermaier@dh-electronics.com]
Sent: Thursday, March 9, 2023 10:23 AM
> This patch makes the use of IRQ optional to make the DA9061/62 usable
> for designs that don't have the IRQ pin connected, because the regulator
> is usable without IRQ.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@int=
el.com/
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rebase on current next 20230209
>     - Add Reviewed-by and Acked-by tags
> V3: - Rebase on current next 20230307
> v4: - Rebase on current next 20230309
>     - Fix a missing variable change reported by kernel test robot
> ---
>  drivers/regulator/da9062-regulator.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-regulator.c
> index 1a6324001027..ae7955afce86 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -924,7 +924,7 @@ static int da9062_regulator_probe(struct platform_dev=
ice *pdev)
>  	struct da9062_regulator *regl;
>  	struct regulator_config config =3D { };
>  	const struct da9062_regulator_info *rinfo;
> -	int irq, n, ret;
> +	int n, ret;
>  	int max_regulators;
>=20
>  	switch (chip->chip_type) {
> @@ -1012,12 +1012,11 @@ static int da9062_regulator_probe(struct platform=
_device *pdev)
>  	}
>=20
>  	/* LDOs overcurrent event support */
> -	irq =3D platform_get_irq_byname(pdev, "LDO_LIM");
> -	if (irq < 0)
> -		return irq;
> -	regulators->irq_ldo_lim =3D irq;
> +	regulators->irq_ldo_lim =3D platform_get_irq_byname_optional(pdev, "LDO=
_LIM");
> +	if (regulators->irq_ldo_lim < 0)
> +		return 0;
>=20
> -	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> +	ret =3D devm_request_threaded_irq(&pdev->dev, regulators->irq_ldo_lim,
>  					NULL, da9062_ldo_lim_event,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					"LDO_LIM", regulators);

Hi,

In V3 of this patch the kernel test robot found an issue. A fix is
important, because otherwise the normal path with IRQ could have
problems. So I fixed it in V4. Any comments or is it OK how I fixed it?


Regards
Christoph

