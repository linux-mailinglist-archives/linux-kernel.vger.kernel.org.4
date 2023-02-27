Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777336A3E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB0Jpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0Jp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:45:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D0C170
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:45:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so6638976wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ua26S0OOCuDleiomq7x0dTgWypPN4gxw1xPzPvaSs7A=;
        b=v0sAE51WCuePK81jah8RSZHhUNUmBwGOyak/wsEjbU8MKJst6DSuZqErZTcduKN2G7
         E0XcdRr5hclFifNXOLCm5DfceTBzdSSaoIsfT80Nw5w0HcEpUwf+mQUPx0Gmm6t83z2h
         VZ+FGS2MKkBHTS1HyRTVYTQUgMK5sMUkc8aGO2K00jY2wkntOV9jvvfXqChAaGcUGUV0
         8T/YRUeiSvl3q4x0Ab1XOcknRJinvX4smsvjpMWcRA5jz5cAfKZ2d9AXBRTSyrQdeH6V
         VSVc2rS6fpWlCe36n+nvjWefAmsTAKhtA6+kCKB6O1bpVReT8xc8pFTpJHLPy1Wt/lip
         HcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua26S0OOCuDleiomq7x0dTgWypPN4gxw1xPzPvaSs7A=;
        b=V6xvLVJRwS8AJOWWydHQIRcMrWjDSEyqviHapHb13tAUd07I4JZtAerk8BlT/iqsxy
         w353sA816o+U+wWucRD9d7UXeMrSgnMTrOZxTcsRK8rKqgtehzWb3qmCF5Bpq6Eo6Nkx
         2PJCYmIvsKTcRgppLf2mPAzq6r5znz9oRXGB1top8Lv1jtOeo9E0pFH4okZV8kQ7LMdz
         TGA6qsgGnK29c18JwQuXrN/AOnG7Q6SpcEn2YHaHyG6YWmQfoWtxs6eQij9ajMlIs0L3
         0dVDy6VS9IX0zeWEm4meHmaEHEDNAEFYzHOP8GXU3frPJVYDCvpoPNkkJUdTjvkT36HF
         B3kQ==
X-Gm-Message-State: AO0yUKWO5ziWHzV8aEEqZBsCCpSi5N9zWEyBobbBSJg+XdIA09gW7Uj6
        vrpa46hhEfuqJq7TWQxMA+FhIzPYOoh2tNs3
X-Google-Smtp-Source: AK7set+XDZMVm9UrY2z1NIJtLjWws12IwUIHJ0nDTJ1iVP0oPfPGNftdN/oS+mEtsBjZ58HvXAZXfw==
X-Received: by 2002:a05:600c:329d:b0:3eb:3e24:59e2 with SMTP id t29-20020a05600c329d00b003eb3e2459e2mr2862898wmp.25.1677491123101;
        Mon, 27 Feb 2023 01:45:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y18-20020a5d4ad2000000b002c5584d0e3dsm6663392wrs.24.2023.02.27.01.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:45:21 -0800 (PST)
Message-ID: <3cfdcb16-0369-f3bd-1db3-d8ee1a82c0cb@linaro.org>
Date:   Mon, 27 Feb 2023 09:45:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 2/2] nvmem: add generic driver for devices with MMIO
 access
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230220174930.7440-1-zajec5@gmail.com>
 <20230220174930.7440-3-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230220174930.7440-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rafal for the patch,

On 20/02/2023 17:49, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some NVMEM devices can be accessed by simply mapping memory and reading
> from / writing to it. This driver adds support for a generic
> "mmio-nvmem" DT binding used by such devices.
> 
> One of such devices is Broadcom's NVRAM. It's already supported (see
> NVMEM_BRCM_NVRAM) but existing driver covers both:
> 1. NVMEM device access
> 2. NVMEM content parsing

> 
> Once we get support for NVMEM layouts then existing NVRAM driver will
> get converted into a layout and generic driver will take over
> responsibility for data access. That's why it claims "brcm,nvram"
> (conditionally for now).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: Support "reg-io-width", basic writing & "brcm,nvram" string
> ---
>   drivers/nvmem/Kconfig  |  10 ++++
>   drivers/nvmem/Makefile |   2 +
>   drivers/nvmem/mmio.c   | 125 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 137 insertions(+)
>   create mode 100644 drivers/nvmem/mmio.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 6dec38805041..189ea85bd67d 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -166,6 +166,16 @@ config NVMEM_MICROCHIP_OTPC
>   	  This driver enable the OTP controller available on Microchip SAMA7G5
>   	  SoCs. It controls the access to the OTP memory connected to it.
>   
> +config NVMEM_MMIO
> +	tristate "MMIO access based NVMEM support"
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides support for NVMEM devices that can be accessed
> +	  using MMIO.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-mmio.
> +
>   config NVMEM_MTK_EFUSE
>   	tristate "Mediatek SoCs EFUSE support"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 6a1efffa88f0..767a9db2bfc1 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -35,6 +35,8 @@ obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
>   nvmem_meson_mx_efuse-y			:= meson-mx-efuse.o
>   obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
>   nvmem-microchip-otpc-y			:= microchip-otpc.o
> +obj-$(CONFIG_NVMEM_MMIO)		+= nvmem-mmio.o
> +nvmem-mmio-y				:= mmio.o
>   obj-$(CONFIG_NVMEM_MTK_EFUSE)		+= nvmem_mtk-efuse.o
>   nvmem_mtk-efuse-y			:= mtk-efuse.o
>   obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
> diff --git a/drivers/nvmem/mmio.c b/drivers/nvmem/mmio.c
> new file mode 100644
> index 000000000000..e247c943eea2
> --- /dev/null
> +++ b/drivers/nvmem/mmio.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Rafał Miłecki <rafal@milecki.pl>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +struct mmio_nvmem {
> +	void __iomem *base;
> +	u32 io_width;
> +};
> +
> +static int mmio_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct mmio_nvmem *priv = context;
> +	u32 *dst32;
> +	u16 *dst16;
> +	u8 *dst8;
> +
> +	if (priv->io_width && WARN_ON(bytes % priv->io_width))
> +		return -EINVAL;
> +
If there is a code path in core that would allow this to happen then it 
needs to be fixed at core level rather than handling it in provider.

> +	switch (priv->io_width) {
> +	case 1:
> +		for (dst8 = val; bytes; bytes -= 1, offset += 1)
> +			*dst8++ = readb(priv->base + offset);
> +		break;
> +	case 2:
> +		for (dst16 = val; bytes; bytes -= 2, offset += 2)
> +			*dst16++ = readw(priv->base + offset);
> +		break;
> +	case 4:
> +		for (dst32 = val; bytes; bytes -= 4, offset += 4)
> +			*dst32++ = readl(priv->base + offset);
> +		break;
> +	default:
> +		memcpy_fromio(val, priv->base + offset, bytes);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmio_nvmem_write(void *context, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct mmio_nvmem *priv = context;
> +
> +	switch (priv->io_width) {
If io_width is 0 core considers defaults it to 1. But in this patch its 
possible to still have priv->io_width 0. This is the behavior that you want?

> +	case 1:
> +	case 2:
> +	case 4:
> +		return -EOPNOTSUPP;
> +	default:
> +		memcpy_toio(priv->base + offset, val, bytes);
so, are we saying that we only support writes to 8 bytes io_width? Any 
reason for doing this way?

> +	}
> +
> +	return 0;
> +}
> +
> +static int mmio_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.name = "mmio-nvmem",
> +		.id = NVMEM_DEVID_AUTO,
> +		.read_only = true,
> +		.reg_read = mmio_nvmem_read,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct mmio_nvmem *priv;
> +	struct resource *res;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	of_property_read_u32(dev->of_node, "reg-io-width", &priv->io_width);
> +
> +	config.dev = dev;
> +	config.size = resource_size(res);
> +	config.word_size = priv->io_width;
> +	config.stride = priv->io_width;
> +	config.priv = priv;
> +	if (!device_property_present(dev, "read-only"))
> +		config.reg_write = mmio_nvmem_write;
core should have already marked it readonly based on this property.

> +
> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
> +}
> +
> +static const struct of_device_id mmio_nvmem_of_match_table[] = {
> +	{ .compatible = "mmio-nvmem", },
> +	/* Custom bindings */
> +#if !IS_ENABLED(CONFIG_NVMEM_BRCM_NVRAM)
> +	{ .compatible = "brcm,nvram", },
> +#endif

If CONFIG_NVMEM_BRCM_NVRAM is not enabled we want to add "brcm,nvram" 
to this driver compatibles, that is something confusing to be honest 
atleast at this transition stage.


How about making nvmem-mmio export functions for drivers like brcm to 
call directly.


> +	{},
> +};
> +
> +static struct platform_driver mmio_nvmem_driver = {
> +	.probe = mmio_nvmem_probe,
> +	.driver = {
> +		.name = "mmio_nvmem",
> +		.of_match_table = mmio_nvmem_of_match_table,
> +	},
> +};
> +
> +static int __init mmio_nvmem_init(void)
> +{
> +	return platform_driver_register(&mmio_nvmem_driver);
> +}
> +
> +subsys_initcall_sync(mmio_nvmem_init);
> +
> +MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, mmio_nvmem_of_match_table);
