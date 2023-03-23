Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE56C60AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjCWH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCWH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:27:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272D2A9A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:27:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so49634325edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToMu+RdmbnNsy0OZQSnVmDUbWaHiYbL8P0vd9oJXtEI=;
        b=gKxjAG0PWtQezTkFsrc45pjCcZc06LpkviYlVH0nMmjQqQUI+iBvAVZyn1HmLKnw0V
         CXNygbnFUKI8xBytn7DFx8b7aRRujpIHJZOke8WlaoiNKUsXfPAvN7kzMHtlfcmk4v2w
         8P5fL8CKQzrt9svViHYxd8/CElL33SFA7T7+S5adF1j9bg6YcZPmrM5geoC+cbAg9B4Y
         n9l0xZ61LoxrCNW8wRNiQ/0XM1mTCdj5onBltdMrCCxb6IZKTujmd5qwB37pWqNV54n+
         QGhf4XujKMoxeIML4ShyfwkEdzXF8XrDbKE3gSigcBlrHX0s8NbpJkbAabMtfgeJIKEu
         kzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToMu+RdmbnNsy0OZQSnVmDUbWaHiYbL8P0vd9oJXtEI=;
        b=b8+DDcs78y3a7a80J9tf1tfQIOBtznC1AeM1QWIPwzSSdyUBqn/pIzUvLWvhtq83jT
         tRpFhDye861i/6m/ZUOUjvY32knaEpvoOwIOKmoNzd9x5yymsijNQdz7BUafZeUVlEvN
         Rppo0KteJaGQ871lLvUL0y6uZxzH2XWOy2OThIwWii/yUovY3CoZZ1/yUlnNFr9BXdnQ
         hASbiUcoOh1bWVf4p1iYMJf+K1Xq4e1Sdbo4izgx1+hWstDoUP3dEnexTIHIwFfUfVIc
         P5jEmYbnUU3uMRkVo/A6vqDb5Gyxc3KjWDWR0PoTs62WyndNyKnZIYP7zw6B06q13DYJ
         C7vA==
X-Gm-Message-State: AO0yUKVm7kcMBBeGRTGosfV3pl3r0eT4dUuo49m6kAMFOyIkAZj65BWA
        Lmb70iZYQL9aryWt3xmpCdkgbTZ+TsAS3sTVpcU=
X-Google-Smtp-Source: AK7set/uSENcq54nsOUS2mWQwLa7k1hFNTDmoviQMII0Uq1CmTjxKfNZewVYYgTS3BefvcmJOxcYJg==
X-Received: by 2002:a17:906:eb8b:b0:884:930:b017 with SMTP id mh11-20020a170906eb8b00b008840930b017mr10896269ejb.60.1679556429387;
        Thu, 23 Mar 2023 00:27:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id qx20-20020a170906fcd400b008eaf99be56esm8448234ejb.170.2023.03.23.00.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:27:08 -0700 (PDT)
Message-ID: <fc85ceb9-5699-99b8-caee-3da64851cee4@linaro.org>
Date:   Thu, 23 Mar 2023 07:27:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] nvmem: add new NXP QorIQ eFuse driver
Content-Language: en-US
To:     Richard Alpe <richard@bit42.se>
Cc:     niklas.soderlund@ragnatech.se, linux-kernel@vger.kernel.org
References: <20230320141408.1555041-1-richard@bit42.se>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230320141408.1555041-1-richard@bit42.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2023 14:14, Richard Alpe wrote:
> Add SFP (Security Fuse Processor) read support for NXP (Freescale)
> QorIQ series SOC's.
> 
> This patch adds support for the T1023 SOC using the SFP offset from
> the existing T1023 device tree. In theory this should also work for
> T1024, T1014 and T1013 which uses the same SFP base offset.
> 
> Signed-off-by: Richard Alpe <richard@bit42.se>
> ---
> v2: Rebase on v6.3-rc3
> 
>   drivers/nvmem/Kconfig       | 12 ++++++
>   drivers/nvmem/Makefile      |  2 +
>   drivers/nvmem/qoriq-efuse.c | 80 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 94 insertions(+)
>   create mode 100644 drivers/nvmem/qoriq-efuse.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 6dec38805041..43446e5f7d9b 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -377,4 +377,16 @@ config NVMEM_ZYNQMP
>   
>   	  If sure, say yes. If unsure, say no.
>   
> +config NVMEM_QORIQ_EFUSE
> +	tristate "NXP QorIQ eFuse support"
> +	depends on PPC_85xx || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides read support for the eFuses (SFP) on NXP QorIQ
> +	  series SoC's. This includes secure boot settings, the globally unique
> +	  NXP ID 'FUIDR' and the OEM unique ID 'OUIDR'.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_qoriq_efuse.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 6a1efffa88f0..b8fdf9b51953 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -74,3 +74,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
>   nvmem-vf610-ocotp-y			:= vf610-ocotp.o
>   obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
>   nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
> +obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
> +nvmem-qoriq-efuse-y			:= qoriq-efuse.o
> diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
> new file mode 100644
> index 000000000000..a332bb603e7a
> --- /dev/null
> +++ b/drivers/nvmem/qoriq-efuse.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2022  Westermo Network Technologies AB
2023 ?
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +
> +struct qoriq_efuse_priv {
> +	void __iomem *base;
> +};
> +
> +static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
> +			  size_t bytes)
> +{
> +	struct qoriq_efuse_priv *priv = context;
> +	u32 *_val = val;
> +
> +	while (bytes >= sizeof(u32)) {
> +		*_val++ = readl_relaxed(priv->base + offset);
> +		offset += sizeof(u32);
> +		bytes -= sizeof(u32);
> +	}

__ioread32_copy ?

> +
> +	return 0;
> +}
> +
> +static int qoriq_efuse_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.dev = &pdev->dev,
> +		.read_only = true,
> +		.reg_read = qoriq_efuse_read,
> +		.stride = sizeof(u32),
> +		.word_size = sizeof(u32),
> +		.name = "qoriq_efuse_read",
> +		.id = NVMEM_DEVID_AUTO,
> +		.root_only = true,
> +	};
> +	struct qoriq_efuse_priv *priv;
> +	struct nvmem_device *nvmem;
> +	struct resource *res;
> +
> +	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	config.size = resource_size(res);
> +	config.priv = priv;
> +	nvmem = devm_nvmem_register(config.dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id qoriq_efuse_of_match[] = {
> +	{ .compatible = "fsl,t1023-sfp", },

Have you already sent the bindings patch for this?

> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, qoriq_efuse_of_match);
> +
> +static struct platform_driver qoriq_efuse_driver = {
> +	.probe = qoriq_efuse_probe,
> +	.driver = {
> +		.name = "qoriq-efuse",
> +		.of_match_table = qoriq_efuse_of_match,
> +	},
> +};
> +module_platform_driver(qoriq_efuse_driver);
> +
> +MODULE_AUTHOR("Richard Alpe <richard.alpe@bit42.se>");
> +MODULE_DESCRIPTION("NXP QorIQ Security Fuse Processor (SFP) Reader");
> +MODULE_LICENSE("GPL");
