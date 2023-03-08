Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0D6B0ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCHQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCHQfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:35:04 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C65262;
        Wed,  8 Mar 2023 08:35:01 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80F85FF811;
        Wed,  8 Mar 2023 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678293300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUqLGRcG0w1R1iyEPwO1Ebbfe3rcU5gyLFk3k2avVAA=;
        b=aHrGdIQeeaiSvYoxSkLc+KAYSRX4ac2bF5cebMcenP1fS2MSr2Knm0vLB2OazwSvbodCvH
        ngNLG2Qkv7cwBX15KF36vC4m+gfmMsAw32l/HChTK739+bFor3Ya7fTEwEfCsMB6j8F5IA
        RzZqXkwxa1dp7Wy86wS7S9tFCtqbmrM2NvGOeOoP02m8zdKIqAymEDeXyy0rwnfnaYf08F
        8MhV9B8uD4Ht0JD0Hhb1m2PiSPW1P8k7lUrV+dI4RkgATib9HdhOihqM4U60ZNPH2vr68V
        pF+33zGbMA2taiYfi7KHopl6udaUGxzqC8X2EXQaW80UuRJ95luD65pOC+ArPw==
Date:   Wed, 8 Mar 2023 17:34:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] nvmem: add explicit config option to read OF fixed
 cells
Message-ID: <20230308173256.3837b87b@xps-13>
In-Reply-To: <20230224072903.20945-1-zajec5@gmail.com>
References: <20230224072903.20945-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Fri, 24 Feb 2023 08:29:03 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
> default. This behaviour made sense in early days before adding support
> for dynamic cells.
>=20
> With every new supported NVMEM device with dynamic cells current
> behaviour becomes non-optimal. It results in unneeded iterating over DT
> nodes and may result in false discovery of cells (depending on used DT
> properties).
>=20
> This behaviour has actually caused a problem already with the MTD
> subsystem. MTD subpartitions were incorrectly treated as NVMEM cells.

That's true, but I expect this to be really MTD specific.

A concrete proposal below.

> Also with upcoming support for NVMEM layouts no new binding or driver
> should support fixed cells defined in device node.

I'm not sure I agree with this statement. We are not preventing new
binding/driver to use fixed cells, or...? We offer a new way to expose
nvmem cells with another way than "fixed-offset" and "fixed-size" OF
nodes.

> Solve this by modifying drivers for bindings that support specifying
> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsystem to
> read cells from DT.
>=20
> It wasn't clear (to me) if rtc and w1 code actually uses fixed cells. I
> enabled them to don't risk any breakage.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> [for drivers/nvmem/meson-{efuse,mx-efuse}.c]
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> V2: Fix stm32-romem.c typo breaking its compilation
>     Pick Martin's Acked-by
>     Add paragraph about layouts deprecating use_fixed_of_cells
> ---
>  drivers/mtd/mtdcore.c          | 2 ++
>  drivers/nvmem/apple-efuses.c   | 1 +
>  drivers/nvmem/core.c           | 8 +++++---
>  drivers/nvmem/imx-ocotp-scu.c  | 1 +
>  drivers/nvmem/imx-ocotp.c      | 1 +
>  drivers/nvmem/meson-efuse.c    | 1 +
>  drivers/nvmem/meson-mx-efuse.c | 1 +
>  drivers/nvmem/microchip-otpc.c | 1 +
>  drivers/nvmem/mtk-efuse.c      | 1 +
>  drivers/nvmem/qcom-spmi-sdam.c | 1 +
>  drivers/nvmem/qfprom.c         | 1 +
>  drivers/nvmem/rave-sp-eeprom.c | 1 +
>  drivers/nvmem/rockchip-efuse.c | 1 +
>  drivers/nvmem/sc27xx-efuse.c   | 1 +
>  drivers/nvmem/sprd-efuse.c     | 1 +
>  drivers/nvmem/stm32-romem.c    | 1 +
>  drivers/nvmem/sunplus-ocotp.c  | 1 +
>  drivers/nvmem/sunxi_sid.c      | 1 +
>  drivers/nvmem/uniphier-efuse.c | 1 +
>  drivers/nvmem/zynqmp_nvmem.c   | 1 +
>  drivers/rtc/nvmem.c            | 1 +
>  drivers/w1/slaves/w1_ds250x.c  | 1 +
>  include/linux/nvmem-provider.h | 2 ++
>  23 files changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 0feacb9fbdac..1bb479c0f758 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -523,6 +523,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>  	config.dev =3D &mtd->dev;
>  	config.name =3D dev_name(&mtd->dev);
>  	config.owner =3D THIS_MODULE;
> +	config.use_fixed_of_cells =3D of_device_is_compatible(node, "nvmem-cell=
s");

I am wondering how mtd specific this is? For me all OF nodes containing
the nvmem-cells compatible should be treated as cells providers and
populate nvmem cells as for each children.

Why don't we just check for this compatible to be present? in
nvmem_add_cells_from_of() ? And if not we just skip the operation.

This way we still follow the bindings (even though using nvmem-cells in
the compatible property to require cells population was a mistake in
the first place, as discussed in the devlink thread recently) but there
is no need for a per-driver config option?

>  	config.reg_read =3D mtd_nvmem_reg_read;
>  	config.size =3D mtd->size;
>  	config.word_size =3D 1;
> @@ -891,6 +892,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(st=
ruct mtd_info *mtd,
>  	config.name =3D kasprintf(GFP_KERNEL, "%s-%s", dev_name(&mtd->dev), com=
patible);
>  	config.id =3D NVMEM_DEVID_NONE;
>  	config.owner =3D THIS_MODULE;
> +	config.use_fixed_of_cells =3D true;
>  	config.type =3D NVMEM_TYPE_OTP;
>  	config.root_only =3D true;
>  	config.ignore_wp =3D true;
> diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
> index 9b7c87102104..0119bac43b2c 100644
> --- a/drivers/nvmem/apple-efuses.c
> +++ b/drivers/nvmem/apple-efuses.c
> @@ -36,6 +36,7 @@ static int apple_efuses_probe(struct platform_device *p=
dev)
>  	struct resource *res;
>  	struct nvmem_config config =3D {
>  		.dev =3D &pdev->dev,
> +		.use_fixed_of_cells =3D true,
>  		.read_only =3D true,
>  		.reg_read =3D apple_efuses_read,
>  		.stride =3D sizeof(u32),
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 174ef3574e07..6783cd8478d7 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -844,9 +844,11 @@ struct nvmem_device *nvmem_register(const struct nvm=
em_config *config)
>  	if (rval)
>  		goto err_remove_cells;
> =20
> -	rval =3D nvmem_add_cells_from_of(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> +	if (config->use_fixed_of_cells) {
> +		rval =3D nvmem_add_cells_from_of(nvmem);
> +		if (rval)
> +			goto err_remove_cells;
> +	}
> =20
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> =20

Thanks,
Miqu=C3=A8l
