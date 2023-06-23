Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4673BAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFWOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjFWOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:53:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451F2133
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:53:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f954d7309fso979294e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687532027; x=1690124027;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywWlQEVYzwfSZWC3nP0DnjTINAyN7bltwFnQGKJDDu0=;
        b=XUx/E7Y5eLDAkFap+YXIagMU8bPG2wW7Rw0ZzrfNRXlI8BHbAuodaCHPoDFx7TEjaZ
         lMKrdmv24I35rn04WzDifgYvOUiE8bt8+KTIs5nEWJJMNw3+D30tWJYKh7sYMkUguGsZ
         FMe/LA/ZUiRBl/zYHw6ZcHoxWu6/G+GyGrO+4/0FIRQty0LqnUyNRgtNKrJS0BK8mL3o
         se23G6FERNj1nU/6p/aPQbcal3CVO+mJPx9iXZf39St3FaGN5DJiSHu5HY5bj7jkH8YL
         IEkeMsx/uNpOhVM/WTxKotBrHs7O7eUur0CcvfyFnol4hE0x+Il/HsO6ZVan5ZqKfvVA
         OYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532027; x=1690124027;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywWlQEVYzwfSZWC3nP0DnjTINAyN7bltwFnQGKJDDu0=;
        b=RgpK7SYSHaMbG01C0fymy6LGHjCdqdQzbVm1PCvg7G+T1hS/r1s4VKB+P423nUOzXS
         ssoUp6h9zb74FM6DZvd40KESPP1MZ0X32SH6U9amcpjIJlQ3AjosPfqFzDmYGFL36QEy
         IVLfFHbzjzTw2OkWQ/F1147AW1oaldmdYDrlo65+53aO59YIZIdtsLBU8iyqI+sneYPZ
         gBkM7tPr/aQPDgELSoM0lROZabvpT3A7gDSPbx2wiPgaJyzjlswNR5Oo1EJWmkSHov02
         wlzWGlITl6Rhug6A118KW8OBDyrgD5agX1/VDA9BsmQfiFmUi4xtkDuMXb+U1X0Pgues
         Gxxg==
X-Gm-Message-State: AC+VfDyZJWnwlw1fmLqfrNXLHNqSJ/iVm+m1CwTkn5NL7CIlYxKWqKAk
        nyPouCVkmk3k/9es/yYWG45Asw==
X-Google-Smtp-Source: ACHHUZ4UqxKHsbpBQ/weiu7Z3t+7Vilm2xxQqFtDR6Ewg2XIpl9CLNFPsEoL+aQ8nWZY4jlLcg780g==
X-Received: by 2002:a19:650c:0:b0:4f8:6ac4:1aa9 with SMTP id z12-20020a19650c000000b004f86ac41aa9mr5951721lfb.21.1687532026789;
        Fri, 23 Jun 2023 07:53:46 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id w10-20020ac254aa000000b004e843d6244csm1466931lfk.99.2023.06.23.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 07:53:46 -0700 (PDT)
Message-ID: <ea4c49cd-17d1-6921-a447-5debaebb0cfd@linaro.org>
Date:   Fri, 23 Jun 2023 16:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-4-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support.
In-Reply-To: <20230623141806.13388-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 16:18, Komal Bajaj wrote:
> For some of the Qualcomm SoC's, it is possible that
> some of the fuse regions or entire qfprom region is
> protected from non-secure access. In such situations,
> linux will have to use secure calls to read the region.
> With that motivation, add secure qfprom driver. Ensuring
> the address to read is word aligned since our secure I/O
> only supports word size I/O.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/nvmem/Kconfig      |  12 ++++
>  drivers/nvmem/Makefile     |   2 +
>  drivers/nvmem/sec-qfprom.c | 116 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 drivers/nvmem/sec-qfprom.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index b291b27048c7..2b0dd73d899e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -216,6 +216,18 @@ config NVMEM_QCOM_QFPROM
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_qfprom.
>  
> +config NVMEM_QCOM_SEC_QFPROM
> +        tristate "QCOM SECURE QFPROM Support"
> +        depends on ARCH_QCOM || COMPILE_TEST
> +        depends on HAS_IOMEM
> +        select QCOM_SCM
You also need OF

> +        help
> +          Say y here to enable secure QFPROM support. The secure QFPROM provides access
> +          functions for QFPROM data to rest of the drivers via nvmem interface.
> +
> +          This driver can also be built as a module. If so, the module will be called
> +          nvmem_sec_qfprom.
> +
>  config NVMEM_RAVE_SP_EEPROM
>  	tristate "Rave SP EEPROM Support"
>  	depends on RAVE_SP_CORE
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index f82431ec8aef..4b4bf5880488 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
>  nvmem-nintendo-otp-y			:= nintendo-otp.o
>  obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
>  nvmem_qfprom-y				:= qfprom.o
> +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)     += nvmem_sec_qfprom.o
> +nvmem_sec_qfprom-y                          := sec-qfprom.o
>  obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>  nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
>  obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
> new file mode 100644
> index 000000000000..47b2c71593dd
> --- /dev/null
> +++ b/drivers/nvmem/sec-qfprom.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +
> +/**
> + * struct sec_sec_qfprom_priv - structure holding secure qfprom attributes
> + *
> + * @qfpseccorrected: iomapped memory space for secure qfprom corrected address space.
> + * @dev: qfprom device structure.
> + */
> +struct sec_qfprom_priv {
> +	phys_addr_t qfpseccorrected;
> +	struct device *dev;
> +};
> +
> +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
> +{
> +	struct sec_qfprom_priv *priv = context;
> +	u8 *val = _val;
> +	u8 *tmp;
> +	u32 read_val;
> +	unsigned int i;
Please sort this to look like a reverse-Christmas-tree


> +
> +	for (i = 0; i < bytes; i++, reg++) {
> +		if (i == 0 || reg % 4 == 0) {
> +			if (qcom_scm_io_readl(priv->qfpseccorrected + (reg & ~3), &read_val)) {
> +				dev_err(priv->dev, "Couldn't access fuse register\n");
> +				return -EINVAL;
> +			}
> +			tmp = (u8 *)&read_val;
> +		}
I don't understand this read-4-times dance.. qcom_scm_io_readl() reads
u32, so this should be as simple as:

val[i + 0] = FIELD_GET(GENMASK(7, 0), reg);
val[i + 1] = ..
val[i + 2] = ..
val[i + 3] = ..


> +
> +		val[i] = tmp[reg & 3];
> +	}
> +
> +	return 0;
> +}
> +
> +static void sec_qfprom_runtime_disable(void *data)
> +{
> +	pm_runtime_disable(data);
> +}
> +
> +static int sec_qfprom_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config econfig = {
> +		.name = "sec-qfprom",
> +		.stride = 1,
> +		.word_size = 1,
> +		.id = NVMEM_DEVID_AUTO,
> +		.reg_read = sec_qfprom_reg_read,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct nvmem_device *nvmem;
> +	struct sec_qfprom_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->qfpseccorrected = res->start;
> +	if (!priv->qfpseccorrected)
> +		return -ENOMEM;
While it works all the same, I think checking if(!res) would be more
logical

Also, ENOMEM seems weird here.. Perhaps EINVAL?

> +
> +	econfig.size = resource_size(res);
> +	econfig.dev = dev;
> +	econfig.priv = priv;
> +
> +	priv->dev = dev;
> +
> +	pm_runtime_enable(dev);
> +	ret = devm_add_action_or_reset(dev, sec_qfprom_runtime_disable, dev);
> +	if (ret)
> +		return ret;
Wouldn't devm_pm_runtime_enable() take care of this? Or do we need
for this block to be always-powered?

> +
> +	nvmem = devm_nvmem_register(dev, &econfig);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id sec_qfprom_of_match[] = {
> +	{ .compatible = "qcom,sec-qfprom",},
The comma inside is unnecessary, replacing it with a space would also
make the whitespacing match

> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
> +
> +static struct platform_driver qfprom_driver = {
> +	.probe = sec_qfprom_probe,
> +	.driver = {
> +		.name = "qcom,sec_qfprom",
Commas in driver names are rather.. rare? Let's make it qcom_

> +		.of_match_table = sec_qfprom_of_match,
> +	},
> +};
> +module_platform_driver(qfprom_driver);
> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
> +MODULE_LICENSE("GPL v2");
Please run scripts/checkpatch.pl on your patches before sending.

Konrad
