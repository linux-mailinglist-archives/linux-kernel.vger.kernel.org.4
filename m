Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1546274E9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGKJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:10:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3F12E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:10:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e46e83d7fso4373772a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066599; x=1691658599;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5N3hprEj7uW61mEh1PLDp0Q1DNyZBWQj8+LgzS5pZjk=;
        b=QdhI+G0us/wRUovMvFBoDxaVrr1D2kXaqcFOBXBysRxpd9/JAOEvYC5Azqr/4bXd9C
         2Hns9sOmPiD4OF4ZAWG1LwuKMKUkjRA0Ll+cNK2dllIWysa/kC8Zq26K20brokd/guzw
         VCWzzegCT/1iBz6CQsJOYLA7/GFkZL48vBJ2ill9V8c7V6Dnr4E9Rnk0kHegTSzephkE
         R9Wma9xNRMXHbvgPbr0KUVdppiNS7L2d5sQwDq6EiMS3vnraSDdi9vZ1fHqNdScshEGS
         2VM/GigwG7m8/K4jgt7INO5MEcLppVpgoJIJ5wS/1RenxLJTtbvsW+/aJKy49RzdoVcx
         Rdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066599; x=1691658599;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N3hprEj7uW61mEh1PLDp0Q1DNyZBWQj8+LgzS5pZjk=;
        b=Oxv2Q5mo+kgbcL8eLVVIqsP9zBi/NekqsKIjYapXoYtAiTCrmbAFaczgceAqRkH6Pc
         VeM8D2ATpbLIvdiy8uD/y7nr7xIkH8b70WooQVyCNIy3BY+FCuXRi6lMjuYwDh+w+9Jw
         XxKzghTAyIRMNXrOPYqVHX6tJ/WrZVbfP1lXEzwOiMwGIX/k/CbrXE5TZllKFuI5JQ1j
         Ret6BImIiJOehjg8y+mkeXD6YstMKprwl5EgeVzkYw7ouT0e1AZSiJ1JDDWdb9IPDNG5
         MXJZf+QO99m9hMxKcm2a/s81GIq0AMHED0zCOoc3amWYLFouUINrnEPbrWcoPRwQngDW
         GHgg==
X-Gm-Message-State: ABy/qLY5MONs5R6fVYfMIW8dsBU9XzrZzhdQwxlq9IggLlMUI1rwy1/3
        TIeNsx8K/oEFBGHYXTd3uOMvSw==
X-Google-Smtp-Source: APBJJlHuUznV9FamEEhrbhzUGIBPlyjuZX2GlDThZC5NIevHwpPGzwg6VUScC9DVii5Ol7Xa/ot7uw==
X-Received: by 2002:a17:907:75db:b0:992:9a5e:3172 with SMTP id jl27-20020a17090775db00b009929a5e3172mr13467303ejc.59.1689066599181;
        Tue, 11 Jul 2023 02:09:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906131600b009927a49ba94sm868727ejb.169.2023.07.11.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:09:58 -0700 (PDT)
Message-ID: <8d3aa7fe-69fd-d0c1-9a94-32c3c7b18ed5@linaro.org>
Date:   Tue, 11 Jul 2023 11:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689065318.git.quic_varada@quicinc.com>
 <2489ac0b07c14e61bc471716e97237c385daec86.1689065318.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2489ac0b07c14e61bc471716e97237c385daec86.1689065318.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 10:51, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v1:
> 	Combine driver, makefile and kconfig into 1 patch
> 	Remove 'qscratch' region and its usage. The controller driver takes care
> 	of those settings
> 	Use compatible/data to handle ipq5332 init
> 	Drop the default case
> 	Get resources by index instead of name as there is only one resource
> 	Add clock
> 	Fix review comments in the driver
> ---
>  drivers/phy/qualcomm/Kconfig        |  11 ++
>  drivers/phy/qualcomm/Makefile       |   1 +
>  drivers/phy/qualcomm/phy-qcom-m31.c | 256 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 97ca595..76be191 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -197,3 +197,14 @@ config PHY_QCOM_SGMII_ETH
>  	help
>  	  Enable this to support the internal SerDes/SGMII PHY on various
>  	  Qualcomm chipsets.
> +
> +config PHY_QCOM_M31_USB
> +	tristate "Qualcomm M31 HS PHY driver support"
> +	depends on (USB || USB_GADGET) && ARCH_QCOM
> +	select USB_PHY
> +	help
> +	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
> +	  with DWC3 USB core. It handles PHY initialization, clock
> +	  management required after resetting the hardware and power
> +	  management. This driver is required even for peripheral only or
> +	  host only mode configurations.
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index b030858..0b5dd66 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
>  obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
>  obj-$(CONFIG_PHY_QCOM_SGMII_ETH)	+= phy-qcom-sgmii-eth.o
> +obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> new file mode 100644
> index 0000000..8700728
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/phy.h>
> +
> +enum clk_reset_action {
> +	CLK_RESET_DEASSERT	= 0,
> +	CLK_RESET_ASSERT	= 1
> +};

Drop entire enum. I don't see it being used.

...

> +
> +static int m31usb_phy_probe(struct platform_device *pdev)
> +{
> +	const struct m31_priv_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct m31usb_phy *qphy;
> +	int ret;
> +
> +	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
> +	if (!qphy)
> +		return -ENOMEM;
> +
> +	qphy->phy.dev = dev;
> +
> +	qphy->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(qphy->base))
> +		return PTR_ERR(qphy->base);
> +
> +	qphy->phy_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
> +	if (IS_ERR(qphy->phy_reset))
> +		return PTR_ERR(qphy->phy_reset);
> +
> +	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");

How do you handle errors? I don't see it.

> +	platform_set_drvdata(pdev, qphy);
> +
> +	data = of_device_get_match_data(dev);
> +	qphy->regs = data->regs;
> +	qphy->ulpi_mode = data->ulpi_mode;
> +
> +	qphy->phy.label			= "m31-usb-phy";
> +	qphy->phy.init			= m31usb_phy_init;
> +	qphy->phy.shutdown		= m31usb_phy_shutdown;
> +	qphy->phy.type			= USB_PHY_TYPE_USB2;
> +
> +	ret = usb_add_phy_dev(&qphy->phy);
> +
> +	return ret;
> +}
> +
> +static void m31usb_phy_remove(struct platform_device *pdev)
> +{
> +	struct m31usb_phy *qphy = platform_get_drvdata(pdev);
> +
> +	usb_remove_phy(&qphy->phy);
> +}
> +
> +struct m31_priv_data m31_ipq5332_data = {

static const

> +	.ulpi_mode = false,
> +	.regs = m31_ipq5332_regs,
> +};


Best regards,
Krzysztof

