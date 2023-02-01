Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D068659B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBALxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBALxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:53:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF235A9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:52:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l8so12466549wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXmJjnvo/FFiDzkfMcuSjrP2rIaxNKinvpLHDM3lDcI=;
        b=N0elckNXjFQvKZibhvSoRRoSC9/x4UVe0mh+gY0BT4kJJKugTLMh0K6VMgpok4HIJg
         Dh9YfRRKj7G+JSsy0KsMy9mVNhtsD5/IPKOB6anI8Se14qS79D09V4hamsOW7W/t/OUw
         DC4NVKRG/X2iPQPw1qftU7ruSEcTu/xupnbN9rS5TwGTCnWbdXDL8UC1/XZ6ZarZhv0Y
         NAXjvCIzkb4IXy/wYCE72TXZxoLBlSHjOlFmscy9bN8R5F8/s6W6eXSQo31vDJ1lN7aA
         fOFXkQ9DVgjvVJ26zKfatj74owxN6YmXerbOrPEx09gofYTkwo0ldQGHGiSvH5BkWhcS
         a8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXmJjnvo/FFiDzkfMcuSjrP2rIaxNKinvpLHDM3lDcI=;
        b=NJk2YgAnm81le1knSqKewSaQfuvJzPXoX95TALXeTThJov50VgZ0ekcexjjHXHBX0P
         fvq9dTqL9bBcvo/28ukU5aZUlMIE9wWWqlTHU2i2rq6CzHr9ch30YfNAjjvPmTTLt1Ku
         av63DYya7iFA3bZnaQVpV7Wxz6lNC2EAIzMrxpyCC4YvYFloSbGqGD71SissiD96oA/9
         2qGONeaNRtoJT7vzyvsfLvT3w+e5uS/c7Al64pvPZvPROb0IpJgyKTe6JqZFuDFCkuCW
         Ovl5y/oA/x4mjqyu5++994PqkX9MEP8TGRWkgBuxsAmVfkNz/qxiF0NgsJKI7XeZOI+H
         yepA==
X-Gm-Message-State: AO0yUKVETtfKLAYYvHsX2+z0SBE4CW5Z0cR2cf0zSsGp1rJZPSMmd6vE
        ZjFodxl6uJY8AlaHSZYxAMfYRA==
X-Google-Smtp-Source: AK7set/dRg45qD9OzdP33C522mFyZvo9JvWq76eRC7vcFbhRZPDOFP+Yn/7YzjHOSNSVsebueHhhAA==
X-Received: by 2002:a1c:7906:0:b0:3da:db4:6105 with SMTP id l6-20020a1c7906000000b003da0db46105mr1733058wme.37.1675252374488;
        Wed, 01 Feb 2023 03:52:54 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j25-20020a05600c1c1900b003daf6e3bc2fsm2977865wms.1.2023.02.01.03.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:52:53 -0800 (PST)
Message-ID: <88a8c2ef-8478-84b3-e4c9-6d3760313241@linaro.org>
Date:   Wed, 1 Feb 2023 11:52:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] nvmem: add generic driver for devices with MMIO
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
References: <20230201064717.18410-1-zajec5@gmail.com>
 <20230201064717.18410-3-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230201064717.18410-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2023 06:47, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With nvmem layouts in place we should now work on plain content access
> NVMEM drivers (e.g. MMIO one). Actual NVMEM content handling should go
> to layout drivers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/nvmem/Kconfig  | 10 ++++++
>   drivers/nvmem/Makefile |  2 ++
>   drivers/nvmem/mmio.c   | 80 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 92 insertions(+)
>   create mode 100644 drivers/nvmem/mmio.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 789729ff7e50..9eb5e93f0455 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -170,6 +170,16 @@ config NVMEM_MICROCHIP_OTPC
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
> index 442f9a4876a5..2f2bed7cdf24 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -36,6 +36,8 @@ obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
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
> index 000000000000..19c8880dc675
> --- /dev/null
> +++ b/drivers/nvmem/mmio.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Rafał Miłecki <rafal@milecki.pl>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +struct mmio_nvmem {
> +	void __iomem *base;
> +};
> +
> +static int mmio_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct mmio_nvmem *priv = context;
> +
> +	memcpy_fromio(val, priv->base, bytes);

How does this work with different register strides?

> +
> +	return 0;
> +}
> +
> +static int mmio_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.name = "mmio-nvmem",


you could use NVMEM_DEVID_AUTO.


But this is not great, this is going to break the existing abi for 
converted drivers. Either we find a way to pass compatible specific data 
and override the default values.

Also there are going to be cases where access to registers will require 
additional resources like clks or pd.


--srini

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
> +	config.dev = dev;
> +	config.size = resource_size(res);
> +	config.word_size = sizeof(u8);
> +	config.stride = sizeof(u8);
> +	config.priv = priv;
> +
> +	if (!device_property_present(dev, "read-only"))
> +		dev_warn(dev, "Writing is not supported yet");
> +
> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
> +}
> +
> +static const struct of_device_id mmio_nvmem_of_match_table[] = {
> +	{ .compatible = "mmio-nvmem", },
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
