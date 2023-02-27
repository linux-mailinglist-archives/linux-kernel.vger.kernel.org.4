Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4336A3C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB0IUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjB0ITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:19:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC0B459
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:19:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h14so5238098wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXuvfafdyhDz/l767ken4Q/9IQhFPgvoC+YA1kWuXxI=;
        b=XGD+Q106o43SituT8J2UBN1HgLF0DIYsczMKbXRnR+RbJ1ObEGmRf6lqNsMV3lNl9F
         4UewNq7QDbGhUIg5o8p607jqJmedX7fVUaMU3a16MNfaQTiq/lxRec+/xv9la2dWW9zn
         JpBRiprJCIyhksqTg64a7JD0AE9KpvfT8EUbmEZZCR26GAdl7OevXZgIsWFZFYBJiQ9A
         6ZmaZ+13akaHe5iFXXfhE6Vw7pou9G+/SJKbJyX6pVM2xbOrO4OibkGcp/iQaqZUtD4y
         o3jROw8BugDKUd09wANDSpnKx1k/Qufi4FYrlXjKIbbZVgpStnZe0BEc7L0CW3NbUFTu
         /4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXuvfafdyhDz/l767ken4Q/9IQhFPgvoC+YA1kWuXxI=;
        b=kHkBIkGnnyg7tBUk6WnXzCgHz91xD1i6bqSX8lDsqL6xL16ds9dm8D9dFFOm/lMyAV
         PaEqHJ65ZY7KI3vEi8R3vRbq0uLiI6umh/r1YHEH0Zn7eV0fEjvSl+2+cSqB7mQCxBbw
         oYKpXm//tpF9ec+fYqDyeJLKPEpY0F5ssNUx2axcO5DEa6h7KIDWyzqhEAs1pXSom/Qg
         0NZTupZ1fe4V01vTmmXiUduxPKNJQz3ulEO/ZkfFqWfLGLgOLhDoesRLcSLMiyU6KqTn
         EQwCFmyjbkpcEXNHXOfaoeWYVsRcOxSNZhvd8ZzmO9mhCsjsfmVDy7l7pHIswDBauBjG
         AMmg==
X-Gm-Message-State: AO0yUKVPWikII0ImDPVUzKwex/INAY3mwLjSU7GIuUTXFuDVbWS64s1+
        +UVyQioqkCT5p+3hdAO7XPzV6A==
X-Google-Smtp-Source: AK7set/w2HVn8l94jDwfXOAgPcj/Hxn7Ffd1NxVSeF5Wg7L26WaqUw4kkwNG2RWzX0e6ccn6o0QXqQ==
X-Received: by 2002:a05:6000:128d:b0:2c3:dd81:49ad with SMTP id f13-20020a056000128d00b002c3dd8149admr19966142wrx.33.1677485988193;
        Mon, 27 Feb 2023 00:19:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b002c5d3f0f737sm6357092wri.30.2023.02.27.00.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:19:47 -0800 (PST)
Message-ID: <15837e68-f447-1f6e-10e4-4466b2183c50@linaro.org>
Date:   Mon, 27 Feb 2023 09:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
 <20230225094246.261697-5-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230225094246.261697-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 10:42, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks and resets
> on the platform, and should be enough to bring up all essential blocks
> including PWRAP, MSDC and peripherals (UART, I2C, SPI).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                                  |   4 +
>  drivers/clk/mediatek/Kconfig                 |   9 +
>  drivers/clk/mediatek/Makefile                |   1 +
>  drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 139 ++++++
>  drivers/clk/mediatek/clk-mt6735-infracfg.c   |  78 ++++
>  drivers/clk/mediatek/clk-mt6735-pericfg.c    |  91 ++++
>  drivers/clk/mediatek/clk-mt6735-topckgen.c   | 450 +++++++++++++++++++
>  7 files changed, 772 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f617042790ee..d7ec4a36a934 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13106,6 +13106,10 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
>  L:	linux-clk@vger.kernel.org
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	drivers/clk/mediatek/clk-mt6735-apmixedsys.c
> +F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
> +F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
> +F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
>  F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>  F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>  F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 2d14855dd37e..593791c0a7d6 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -124,6 +124,15 @@ config COMMON_CLK_MT2712_VENCSYS
>  	help
>  	  This driver supports MediaTek MT2712 vencsys clocks.
>  
> +config COMMON_CLK_MT6735
> +	tristate "Main clock drivers for MediaTek MT6735"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	help
> +	  This enables drivers for clocks and resets provided
> +	  by apmixedsys, topckgen, infracfg and pericfg on the
> +	  MediaTek MT6735 SoC.
> +
>  config COMMON_CLK_MT6765
>         bool "Clock driver for MediaTek MT6765"
>         depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index e5d018270ed0..d2496a8d0467 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
>  obj-$(CONFIG_COMMON_CLK_MEDIATEK_FHCTL) += clk-fhctl.o clk-pllfh.o
>  
> +obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
>  obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
>  obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
> new file mode 100644
> index 000000000000..5ce395c34d92
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-apmixedsys.h>
> +
> +#define AP_PLL_CON_5		0x014
> +#define ARMPLL_CON0		0x200
> +#define ARMPLL_CON1		0x204
> +#define ARMPLL_PWR_CON0		0x20c
> +#define MAINPLL_CON0		0x210
> +#define MAINPLL_CON1		0x214
> +#define MAINPLL_PWR_CON0	0x21c
> +#define UNIVPLL_CON0		0x220
> +#define UNIVPLL_CON1		0x224
> +#define UNIVPLL_PWR_CON0	0x22c
> +#define MMPLL_CON0		0x230
> +#define MMPLL_CON1		0x234
> +#define MMPLL_PWR_CON0		0x23c
> +#define MSDCPLL_CON0		0x240
> +#define MSDCPLL_CON1		0x244
> +#define MSDCPLL_PWR_CON0	0x24c
> +#define VENCPLL_CON0		0x250
> +#define VENCPLL_CON1		0x254
> +#define VENCPLL_PWR_CON0	0x25c
> +#define TVDPLL_CON0		0x260
> +#define TVDPLL_CON1		0x264
> +#define TVDPLL_PWR_CON0		0x26c
> +#define APLL1_CON0		0x270
> +#define APLL1_CON1		0x274
> +#define APLL1_CON2		0x278
> +#define APLL1_PWR_CON0		0x280
> +#define APLL2_CON0		0x284
> +#define APLL2_CON1		0x288
> +#define APLL2_CON2		0x28c
> +#define APLL2_PWR_CON0		0x294
> +
> +#define CON0_RST_BAR		BIT(24)
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _rst_bar_mask,	\
> +	    _pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,		\
> +	    _tuner_en_bit, _pcw_reg, _pcwbits, _flags) {		\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.parent_name = "clk26m",				\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = _en_mask,					\
> +		.rst_bar_mask = _rst_bar_mask,				\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.tuner_reg = _tuner_reg,				\
> +		.tuner_en_reg = _tuner_en_reg,				\
> +		.tuner_en_bit = _tuner_en_bit,				\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_chg_reg = _pcw_reg,				\
> +		.pcwbits = _pcwbits,					\
> +		.flags = _flags,					\
> +	}
> +
> +static const struct mtk_pll_data apmixedsys_plls[] = {
> +	PLL(ARMPLL, "armpll", ARMPLL_CON0, ARMPLL_PWR_CON0, 0x00000001, 0, ARMPLL_CON1, 24, 0, 0, 0, ARMPLL_CON1, 21, PLL_AO),
> +	PLL(MAINPLL, "mainpll", MAINPLL_CON0, MAINPLL_PWR_CON0, 0xf0000101, CON0_RST_BAR, MAINPLL_CON1, 24, 0, 0, 0, MAINPLL_CON1, 21, HAVE_RST_BAR),
> +	PLL(UNIVPLL, "univpll", UNIVPLL_CON0, UNIVPLL_PWR_CON0, 0xfc000001, CON0_RST_BAR, UNIVPLL_CON1, 24, 0, 0, 0, UNIVPLL_CON1, 21, HAVE_RST_BAR),
> +	PLL(MMPLL, "mmpll", MMPLL_CON0, MMPLL_PWR_CON0, 0x00000001, 0, MMPLL_CON1, 24, 0, 0, 0, MMPLL_CON1, 21, 0),
> +	PLL(MSDCPLL, "msdcpll", MSDCPLL_CON0, MSDCPLL_PWR_CON0, 0x00000001, 0, MSDCPLL_CON1, 24, 0, 0, 0, MSDCPLL_CON1, 21, 0),
> +	PLL(VENCPLL, "vencpll", VENCPLL_CON0, VENCPLL_PWR_CON0, 0x00000001, CON0_RST_BAR, VENCPLL_CON1, 24, 0, 0, 0, VENCPLL_CON1, 21, HAVE_RST_BAR),
> +	PLL(TVDPLL, "tvdpll", TVDPLL_CON0, TVDPLL_PWR_CON0, 0x00000001, 0, TVDPLL_CON1, 24, 0, 0, 0, TVDPLL_CON1, 21, 0),
> +	PLL(APLL1, "apll1", APLL1_CON0, APLL1_PWR_CON0, 0x00000001, 0, APLL1_CON0, 4, APLL1_CON2, AP_PLL_CON_5, 0, APLL1_CON1, 31, 0),
> +	PLL(APLL2, "apll2", APLL2_CON0, APLL2_PWR_CON0, 0x00000001, 0, APLL2_CON0, 4, APLL2_CON2, AP_PLL_CON_5, 1, APLL2_CON1, 31, 0)
> +};
> +
> +int clk_mt6735_apmixed_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct clk_hw_onecell_data *clk_data;
> +	int ret;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixedsys_plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	ret = mtk_clk_register_plls(pdev->dev.of_node, apmixedsys_plls,
> +				   ARRAY_SIZE(apmixedsys_plls), clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register PLLs: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
> +					  clk_data);
> +	if (ret)
> +		dev_err(&pdev->dev,
> +			"Failed to register clock provider: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int clk_mt6735_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_match_mt6735_apmixedsys[] = {
> +	{ .compatible = "mediatek,mt6735-apmixedsys" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6735_apmixedsys = {
> +	.probe = clk_mt6735_apmixed_probe,
> +	.remove = clk_mt6735_apmixed_remove,
> +	.driver = {
> +		.name = "clk-mt6735-apmixedsys",
> +		.of_match_table = of_match_mt6735_apmixedsys,
> +	},
> +};
> +module_platform_driver(clk_mt6735_apmixedsys);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_DESCRIPTION("MediaTek MT6735 apmixedsys clock driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt6735-infracfg.c b/drivers/clk/mediatek/clk-mt6735-infracfg.c
> new file mode 100644
> index 000000000000..e9dd3caa5f97
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-infracfg.h>
> +
> +#define INFRA_RST0			0x30
> +#define INFRA_GLOBALCON_PDN0		0x40
> +#define INFRA_PDN1			0x44
> +#define	INFRA_PDN_STA			0x48
> +
> +static struct mtk_gate_regs infra_cg_regs = {
> +	.set_ofs = INFRA_GLOBALCON_PDN0,
> +	.clr_ofs = INFRA_PDN1,
> +	.sta_ofs = INFRA_PDN_STA,
> +};
> +
> +static const struct mtk_gate infracfg_gates[] = {
> +	GATE_MTK(CLK_DBG, "dbg", "axi_sel", &infra_cg_regs, 0, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_GCE, "gce", "axi_sel", &infra_cg_regs, 1, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_TRBG, "trbg", "axi_sel", &infra_cg_regs, 2, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_CPUM, "cpum", "axi_sel", &infra_cg_regs, 3, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_DEVAPC, "devapc", "axi_sel", &infra_cg_regs, 4, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_AUDIO, "audio", "aud_intbus_sel", &infra_cg_regs, 5, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_GCPU, "gcpu", "axi_sel", &infra_cg_regs, 6, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_L2C_SRAM, "l2csram", "axi_sel", &infra_cg_regs, 7, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_M4U, "m4u", "axi_sel", &infra_cg_regs, 8, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_CLDMA, "cldma", "axi_sel", &infra_cg_regs, 12, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_CONNMCU_BUS, "connmcu_bus", "axi_sel", &infra_cg_regs, 15, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_KP, "kp", "axi_sel", &infra_cg_regs, 16, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK_FLAGS(CLK_APXGPT, "apxgpt", "axi_sel", &infra_cg_regs, 18, &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL),
> +	GATE_MTK(CLK_SEJ, "sej", "axi_sel", &infra_cg_regs, 19, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_CCIF0_AP, "ccif0ap", "axi_sel", &infra_cg_regs, 20, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_CCIF1_AP, "ccif1ap", "axi_sel", &infra_cg_regs, 21, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PMIC_SPI, "pmicspi", "pmicspi_sel", &infra_cg_regs, 22, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PMIC_WRAP, "pmicwrap", "axi_sel", &infra_cg_regs, 23, &mtk_clk_gate_ops_setclr)
> +};
> +
> +static u16 infracfg_rst_ofs[] = { INFRA_RST0 };
> +
> +static const struct mtk_clk_rst_desc infracfg_resets = {
> +	.version = MTK_RST_SIMPLE,
> +	.rst_bank_ofs = infracfg_rst_ofs,
> +	.rst_bank_nr = ARRAY_SIZE(infracfg_rst_ofs)
> +};
> +
> +static const struct mtk_clk_desc infracfg_clks = {
> +	.clks = infracfg_gates,
> +	.num_clks = ARRAY_SIZE(infracfg_gates),
> +
> +	.rst_desc = &infracfg_resets
> +};
> +
> +static const struct of_device_id of_match_mt6735_infracfg[] = {
> +	{ .compatible = "mediatek,mt6735-infracfg", .data = &infracfg_clks },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6735_infracfg = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt6735-infracfg",
> +		.of_match_table = of_match_mt6735_infracfg,
> +	},
> +};
> +module_platform_driver(clk_mt6735_infracfg);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_DESCRIPTION("MediaTek MT6735 infracfg clock and reset driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/mediatek/clk-mt6735-pericfg.c
> new file mode 100644
> index 000000000000..4d74e345509b
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-pericfg.h>
> +
> +#define PERI_GLOBALCON_RST0		0x00
> +#define PERI_GLOBALCON_RST1		0x04
> +#define PERI_GLOBALCON_PDN0_SET		0x08
> +#define PERI_GLOBALCON_PDN0_CLR		0x10
> +#define	PERI_GLOBALCON_PDN0_STA		0x18
> +
> +static struct mtk_gate_regs peri_cg_regs = {
> +	.set_ofs = PERI_GLOBALCON_PDN0_SET,
> +	.clr_ofs = PERI_GLOBALCON_PDN0_CLR,
> +	.sta_ofs = PERI_GLOBALCON_PDN0_STA,
> +};
> +
> +static const struct mtk_gate pericfg_gates[] = {
> +	GATE_MTK(CLK_DISP_PWM, "disp_pwm", "disppwm_sel", &peri_cg_regs, 0, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_THERM, "therm", "axi_sel", &peri_cg_regs, 1, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM1, "pwm1", "axi_sel", &peri_cg_regs, 2, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM2, "pwm2", "axi_sel", &peri_cg_regs, 3, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM3, "pwm3", "axi_sel", &peri_cg_regs, 4, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM4, "pwm4", "axi_sel", &peri_cg_regs, 5, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM5, "pwm5", "axi_sel", &peri_cg_regs, 6, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM6, "pwm6", "axi_sel", &peri_cg_regs, 7, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM7, "pwm7", "axi_sel", &peri_cg_regs, 8, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_PWM, "pwm", "axi_sel", &peri_cg_regs, 9, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_USB0, "usb0", "usb20_sel", &peri_cg_regs, 10, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_IRDA, "irda", "irda_sel", &peri_cg_regs, 11, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_APDMA, "apdma", "axi_sel", &peri_cg_regs, 12, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_MSDC30_0, "msdc30_0", "msdc30_0_sel", &peri_cg_regs, 13, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_MSDC30_1, "msdc30_1", "msdc30_1_sel", &peri_cg_regs, 14, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_MSDC30_2, "msdc30_2", "msdc30_2_sel", &peri_cg_regs, 15, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_MSDC30_3, "msdc30_3", "msdc30_3_sel", &peri_cg_regs, 16, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_UART0, "uart0", "uart_sel", &peri_cg_regs, 17, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_UART1, "uart1", "uart_sel", &peri_cg_regs, 18, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_UART2, "uart2", "uart_sel", &peri_cg_regs, 19, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_UART3, "uart3", "uart_sel", &peri_cg_regs, 20, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_UART4, "uart4", "uart_sel", &peri_cg_regs, 21, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_BTIF, "btif", "axi_sel", &peri_cg_regs, 22, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_I2C0, "i2c0", "axi_sel", &peri_cg_regs, 23, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_I2C1, "i2c1", "axi_sel", &peri_cg_regs, 24, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_I2C2, "i2c2", "axi_sel", &peri_cg_regs, 25, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_I2C3, "i2c3", "axi_sel", &peri_cg_regs, 26, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_AUXADC, "auxadc", "axi_sel", &peri_cg_regs, 27, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_SPI0, "spi0", "spi_sel", &peri_cg_regs, 28, &mtk_clk_gate_ops_setclr),
> +	GATE_MTK(CLK_IRTX, "irtx", "irtx_sel", &peri_cg_regs, 29, &mtk_clk_gate_ops_setclr)
> +};
> +
> +static u16 pericfg_rst_ofs[] = { PERI_GLOBALCON_RST0, PERI_GLOBALCON_RST1 };
> +
> +static const struct mtk_clk_rst_desc pericfg_resets = {
> +	.version = MTK_RST_SIMPLE,
> +	.rst_bank_ofs = pericfg_rst_ofs,
> +	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs)
> +};
> +
> +static const struct mtk_clk_desc pericfg_clks = {
> +	.clks = pericfg_gates,
> +	.num_clks = ARRAY_SIZE(pericfg_gates),
> +
> +	.rst_desc = &pericfg_resets
> +};
> +
> +static const struct of_device_id of_match_mt6735_pericfg[] = {
> +	{ .compatible = "mediatek,mt6735-pericfg", .data = &pericfg_clks },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6735_pericfg = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt6735-pericfg",
> +		.of_match_table = of_match_mt6735_pericfg,
> +	},
> +};
> +module_platform_driver(clk_mt6735_pericfg);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_DESCRIPTION("MediaTek MT6735 pericfg clock driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c b/drivers/clk/mediatek/clk-mt6735-topckgen.c
> new file mode 100644
> index 000000000000..5fa743e4b0fc
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
> +
> +#define CLK_CFG_0		0x40
> +#define CLK_CFG_0_SET		0x44
> +#define CLK_CFG_0_CLR		0x48
> +#define CLK_CFG_1		0x50
> +#define CLK_CFG_1_SET		0x54
> +#define CLK_CFG_1_CLR		0x58
> +#define CLK_CFG_2		0x60
> +#define CLK_CFG_2_SET		0x64
> +#define CLK_CFG_2_CLR		0x68
> +#define CLK_CFG_3		0x70
> +#define CLK_CFG_3_SET		0x74
> +#define CLK_CFG_3_CLR		0x78
> +#define CLK_CFG_4		0x80
> +#define CLK_CFG_4_SET		0x84
> +#define CLK_CFG_4_CLR		0x88
> +#define CLK_CFG_5		0x90
> +#define CLK_CFG_5_SET		0x94
> +#define CLK_CFG_5_CLR		0x98
> +#define CLK_CFG_6		0xa0
> +#define CLK_CFG_6_SET		0xa4
> +#define CLK_CFG_6_CLR		0xa8
> +#define CLK_CFG_7		0xb0
> +#define CLK_CFG_7_SET		0xb4
> +#define CLK_CFG_7_CLR		0xb8
> +
> +static DEFINE_SPINLOCK(mt6735_topckgen_lock);
> +
> +/* Some clocks with unknown details are modeled as fixed clocks */
> +static const struct mtk_fixed_clk topckgen_fixed_clks[] = {
> +	/*
> +	 * This clock is available as a parent option for multiple
> +	 * muxes and seems like an alternative name for clk26m at first,
> +	 * but it appears alongside it in several muxes which should
> +	 * mean it is a separate clock.
> +	 */
> +	FIXED_CLK(AD_SYS_26M_CK, "ad_sys_26m_ck", "clk26m", 26 * MHZ),
> +	/*
> +	 * This clock is the parent of DMPLL divisors. It might be MEMPLL
> +	 * or its parent, as DMPLL appears to be an alternative name for
> +	 * MEMPLL.
> +	 */
> +	FIXED_CLK(CLKPH_MCK_O, "clkph_mck_o", NULL, 0),
> +	/*
> +	 * DMPLL clock (dmpll_ck), controlled by DDRPHY.
> +	 */
> +	FIXED_CLK(DMPLL, "dmpll", "clkph_mck_o", 0),
> +	/*
> +	 * MIPI DPI clock. Parent option for dpi0_sel. Unknown parent.
> +	 */
> +	FIXED_CLK(DPI_CK, "dpi_ck", NULL, 0),
> +	/*
> +	 * This clock is a child of WHPLL which is controlled by
> +	 * the modem.
> +	 */
> +	FIXED_CLK(WHPLL_AUDIO_CK, "whpll_audio_ck", NULL, 0)
> +};
> +
> +static const struct mtk_fixed_factor topckgen_factors[] = {
> +	FACTOR(SYSPLL_D2, "syspll_d2", "mainpll", 1, 2),
> +	FACTOR(SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
> +	FACTOR(SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
> +	FACTOR(SYSPLL1_D2, "syspll1_d2", "mainpll", 1, 2),
> +	FACTOR(SYSPLL1_D4, "syspll1_d4", "mainpll", 1, 4),
> +	FACTOR(SYSPLL1_D8, "syspll1_d8", "mainpll", 1, 8),
> +	FACTOR(SYSPLL1_D16, "syspll1_d16", "mainpll", 1, 16),
> +	FACTOR(SYSPLL2_D2, "syspll2_d2", "mainpll", 1, 2),
> +	FACTOR(SYSPLL2_D4, "syspll2_d4", "mainpll", 1, 4),
> +	FACTOR(SYSPLL3_D2, "syspll3_d2", "mainpll", 1, 2),
> +	FACTOR(SYSPLL3_D4, "syspll3_d4", "mainpll", 1, 4),
> +	FACTOR(SYSPLL4_D2, "syspll4_d2", "mainpll", 1, 2),
> +	FACTOR(SYSPLL4_D4, "syspll4_d4", "mainpll", 1, 4),
> +	FACTOR(UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
> +	FACTOR(UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
> +	FACTOR(UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
> +	FACTOR(UNIVPLL_D26, "univpll_d26", "univpll", 1, 26),
> +	FACTOR(UNIVPLL1_D2, "univpll1_d2", "univpll", 1, 2),
> +	FACTOR(UNIVPLL1_D4, "univpll1_d4", "univpll", 1, 4),
> +	FACTOR(UNIVPLL1_D8, "univpll1_d8", "univpll", 1, 8),
> +	FACTOR(UNIVPLL2_D2, "univpll2_d2", "univpll", 1, 2),
> +	FACTOR(UNIVPLL2_D4, "univpll2_d4", "univpll", 1, 4),
> +	FACTOR(UNIVPLL2_D8, "univpll2_d8", "univpll", 1, 8),
> +	FACTOR(UNIVPLL3_D2, "univpll3_d2", "univpll", 1, 2),
> +	FACTOR(UNIVPLL3_D4, "univpll3_d4", "univpll", 1, 4),
> +	FACTOR(MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
> +	FACTOR(MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
> +	FACTOR(MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1, 8),
> +	FACTOR(MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1, 16),
> +	FACTOR(VENCPLL_D3, "vencpll_d3", "vencpll", 1, 3),
> +	FACTOR(TVDPLL_D2, "tvdpll_d2", "tvdpll", 1, 2),
> +	FACTOR(TVDPLL_D4, "tvdpll_d4", "tvdpll", 1, 4),
> +	FACTOR(DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
> +	FACTOR(DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
> +	FACTOR(DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
> +	FACTOR(AD_SYS_26M_D2, "ad_sys_26m_d2", "clk26m", 1, 2)
> +};
> +
> +static const char * const axi_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"syspll1_d4",
> +	"univpll_d5",
> +	"univpll2_d2",
> +	"dmpll",
> +	"dmpll_d2"
> +};
> +
> +static const char * const mem_sel_parents[] = {
> +	"clk26m",
> +	"dmpll"
> +};
> +
> +static const char * const ddrphycfg_parents[] = {
> +	"clk26m",
> +	"syspll1_d8"
> +};
> +
> +static const char * const mm_sel_parents[] = {
> +	"clk26m",
> +	"vencpll",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"syspll1_d4",
> +	"univpll_d5",
> +	"univpll2_d2",
> +	"dmpll"
> +};
> +
> +static const char * const pwm_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d4",
> +	"univpll3_d2",
> +	"univpll1_d4"
> +};
> +
> +static const char * const vdec_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"syspll1_d4",
> +	"univpll_d5",
> +	"syspll_d2",
> +	"syspll2_d2",
> +	"msdcpll_d2"
> +};
> +
> +static const char * const mfg_sel_parents[] = {
> +	"clk26m",
> +	"mmpll",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"syspll_d3",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"univpll_d3",
> +	"univpll1_d2"
> +};
> +
> +static const char * const camtg_sel_parents[] = {
> +	"clk26m",
> +	"univpll_d26",
> +	"univpll2_d2",
> +	"syspll3_d2",
> +	"syspll3_d4",
> +	"msdcpll_d4"
> +};
> +
> +static const char * const uart_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d8"
> +};
> +
> +static const char * const spi_sel_parents[] = {
> +	"clk26m",
> +	"syspll3_d2",
> +	"msdcpll_d8",
> +	"syspll2_d4",
> +	"syspll4_d2",
> +	"univpll2_d4",
> +	"univpll1_d8"
> +};
> +
> +static const char * const usb20_sel_parents[] = {
> +	"clk26m",
> +	"univpll1_d8",
> +	"univpll3_d4"
> +};
> +
> +static const char * const msdc50_0_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll2_d2",
> +	"syspll4_d2",
> +	"univpll_d5",
> +	"univpll1_d4"
> +};
> +
> +static const char * const msdc30_0_sel_parents[] = {
> +	"clk26m",
> +	"msdcpll",
> +	"msdcpll_d2",
> +	"msdcpll_d4",
> +	"syspll2_d2",
> +	"syspll1_d4",
> +	"univpll1_d4",
> +	"univpll_d3",
> +	"univpll_d26",
> +	"syspll2_d4",
> +	"univpll_d2"
> +};
> +
> +static const char * const msdc30_1_2_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d2",
> +	"msdcpll_d4",
> +	"syspll2_d2",
> +	"syspll1_d4",
> +	"univpll1_d4",
> +	"univpll_d26",
> +	"syspll2_d4"
> +};
> +
> +static const char * const msdc30_3_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d2",
> +	"msdcpll_d4",
> +	"syspll2_d2",
> +	"syspll1_d4",
> +	"univpll1_d4",
> +	"univpll_d26",
> +	"msdcpll_d16",
> +	"syspll2_d4"
> +};
> +
> +static const char * const audio_sel_parents[] = {
> +	"clk26m",
> +	"syspll3_d4",
> +	"syspll4_d4",
> +	"syspll1_d16"
> +};
> +
> +static const char * const aud_intbus_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d4",
> +	"syspll4_d2",
> +	"dmpll_d4"
> +};
> +
> +static const char * const pmicspi_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d8",
> +	"syspll3_d4",
> +	"syspll1_d16",
> +	"univpll3_d4",
> +	"univpll_d26",
> +	"dmpll_d4",
> +	"dmpll_d8"
> +};
> +
> +static const char * const scp_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d8",
> +	"dmpll_d2",
> +	"dmpll_d4"
> +};
> +
> +static const char * const atb_sel_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"dmpll"
> +};
> +
> +static const char * const dpi0_sel_parents[] = {
> +	"clk26m",
> +	"tvdpll",
> +	"tvdpll_d2",
> +	"tvdpll_d4",
> +	"dpi_ck"
> +};
> +
> +static const char * const scam_sel_parents[] = {
> +	"clk26m",
> +	"syspll3_d2",
> +	"univpll2_d4",
> +	"vencpll_d3"
> +};
> +
> +static const char * const mfg13m_sel_parents[] = {
> +	"clk26m",
> +	"ad_sys_26m_d2"
> +};
> +
> +static const char * const aud_1_2_sel_parents[] = {
> +	"clk26m",
> +	"apll1"
> +};
> +
> +static const char * const irda_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d4"
> +};
> +
> +static const char * const irtx_sel_parents[] = {
> +	"clk26m",
> +	"ad_sys_26m_ck"
> +};
> +
> +static const char * const disppwm_sel_parents[] = {
> +	"clk26m",
> +	"univpll2_d4",
> +	"syspll4_d2_d8",
> +	"ad_sys_26m_ck"
> +};
> +
> +static const struct mtk_mux topckgen_muxes[] = {
> +	MUX_CLR_SET_UPD(AXI_SEL, "axi_sel", axi_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 0, 3, 0, 0),
> +	MUX_CLR_SET_UPD(MEM_SEL, "mem_sel", mem_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 8, 1, 0, 0),
> +	MUX_CLR_SET_UPD(DDRPHY_SEL, "ddrphycfg_sel", ddrphycfg_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 1, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MM_SEL, "mm_sel", mm_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 24, 3, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(PWM_SEL, "pwm_sel", pwm_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 0, 2, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(VDEC_SEL, "vdec_sel", vdec_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 8, 3, 15, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MFG_SEL, "mfg_sel", mfg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 16, 4, 23, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(CAMTG_SEL, "camtg_sel", camtg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 24, 3, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(UART_SEL, "uart_sel", uart_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 0, 1, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(SPI_SEL, "spi_sel", spi_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 8, 3, 15, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(USB20_SEL, "usb20_sel", usb20_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 16, 2, 23, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 3, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MSDC30_0_SEL, "msdc30_0_sel", msdc30_0_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 0, 4, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 8, 3, 15, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MSDC30_2_SEL, "msdc30_2_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 16, 3, 23, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 24, 4, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(AUDIO_SEL, "audio_sel", audio_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 0, 2, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(AUDINTBUS_SEL, "aud_intbus_sel", aud_intbus_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 8, 2, 15, 0, 0),
> +	MUX_CLR_SET_UPD(PMICSPI_SEL, "pmicspi_sel", pmicspi_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 16, 3, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(SCP_SEL, "scp_sel", scp_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 24, 2, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(ATB_SEL, "atb_sel", atb_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 0, 2, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(DPI0_SEL, "dpi0_sel", dpi0_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 8, 3, 15, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(SCAM_SEL, "scam_sel", scam_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 16, 2, 23, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(MFG13M_SEL, "mfg13m_sel", mfg13m_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 24, 1, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(AUD1_SEL, "aud_1_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 0, 1, 7, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(AUD2_SEL, "aud_2_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 8, 1, 15, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(IRDA_SEL, "irda_sel", irda_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 16, 1, 23, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(IRTX_SEL, "irtx_sel", irtx_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 24, 1, 31, 0, 0),
> +	MUX_GATE_CLR_SET_UPD(DISPPWM_SEL, "disppwm_sel", disppwm_sel_parents, CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 0, 2, 7, 0, 0),
> +};
> +
> +int clk_mt6735_topckgen_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct clk_hw_onecell_data *clk_data;
> +	int ret;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(topckgen_fixed_clks) +
> +				      ARRAY_SIZE(topckgen_factors) +
> +				      ARRAY_SIZE(topckgen_muxes));
> +	if (!clk_data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	ret = mtk_clk_register_fixed_clks(topckgen_fixed_clks,
> +					  ARRAY_SIZE(topckgen_fixed_clks),
> +					  clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register fixed clocks: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = mtk_clk_register_factors(topckgen_factors, ARRAY_SIZE(topckgen_factors),
> +				       clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register dividers: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mtk_clk_register_muxes(topckgen_muxes, ARRAY_SIZE(topckgen_muxes),
> +				     pdev->dev.of_node, &mt6735_topckgen_lock,
> +				     clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register muxes: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
> +					  clk_data);
> +	if (ret)
> +		dev_err(&pdev->dev,
> +			"Failed to register clock provider: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int clk_mt6735_topckgen_remove(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	mtk_clk_unregister_muxes(topckgen_muxes, ARRAY_SIZE(topckgen_muxes),
> +				 clk_data);
> +	mtk_clk_unregister_factors(topckgen_factors, ARRAY_SIZE(topckgen_factors),
> +				   clk_data);
> +	mtk_clk_unregister_fixed_clks(topckgen_fixed_clks,
> +				      ARRAY_SIZE(topckgen_fixed_clks),
> +				      clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_match_mt6735_topckgen[] = {
> +	{ .compatible = "mediatek,mt6735-topckgen", },
> +	{ /* sentinel */ }
> +};

Missing module device table. Maybe in other pieces as well.

Best regards,
Krzysztof

