Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53618663D37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjAJJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjAJJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:47:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1CF5006B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:47:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso5938773wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPHNOfbtw1EW7vXH7brxiTduNcLS830FFBzh0EZQIoc=;
        b=opoulNORb+0fxatETIKzqxH06hE9jYaBLMb8auqkajb3loOhVSblfk9gmiuUlfDMIf
         to+gzthP6JZGQv+DMPut4xsqEmsPSKnqZiitBONnUkucRwRIx2f2CCjaU4kq76yktZGG
         X3Mv+cTBoiqwMVPJl+dFOXrsV3WDCID2DkcVGjFNASGss3f8RLi+Ezqj8lRhdlCwVj04
         TXMe5t0gVYRcOoDe67laO/bV1khHAPZ5cCr0iokhY6nmJMd88Cyuyw0D6gcHDvm930hl
         6BLaxg+jRNz8TblYvm95CONwnUqbIvIRH6JHOWqEJOL4ZUwoKIkQAsj/T/h6wXHLpSFj
         lVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPHNOfbtw1EW7vXH7brxiTduNcLS830FFBzh0EZQIoc=;
        b=4vGSOhJsP+sMdy+lSbS0U+ZPfvDFa8b2KAPuCkYd4Oaf4gzDrfPxC+kC7uOZoSRUe2
         U0YfyksWqujiZG6SQ49IFVMAqxB/09W4D5FKswqN8e46npIJuSGT1yzc+Iy3+9f4zz9a
         vd2mmpgLljA/MnCnQIWcb6xXT3hwJDpslezNVUB7Q57PGMZCTrmPp6yh1XO2DmDyJhAy
         czWdqXMFACedE+OAJYFI/IRh1LH3cslOQxtHAH0YKwnv8qGgjbIVZfw1o28jNPRBrbTC
         PCznYbyJqEs3itgZ9aTurQJpC8q1JXSg3TOC2sxToZzhnEePRIamRR+zF4L+tK2u7MuY
         q7lQ==
X-Gm-Message-State: AFqh2koOAd7vlcNZ3mQT+wcWZ67ecvRnCZVR8VVYmue6uuDYGOOK2/N9
        6wdhsPuqkrhM0CG2TiomgwtJag==
X-Google-Smtp-Source: AMrXdXvp2ZP7Hjgrx6nxYXVPTK/swbn/+rUAeJoBkj+/fGEZU3b/HfUWTxXHSS7NRBIr/cFdfFZjEw==
X-Received: by 2002:a7b:c3c6:0:b0:3d2:3376:6f37 with SMTP id t6-20020a7bc3c6000000b003d233766f37mr48095610wmj.10.1673344019233;
        Tue, 10 Jan 2023 01:46:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm18782224wmc.2.2023.01.10.01.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:46:58 -0800 (PST)
Message-ID: <34191e6f-9a00-114e-4fd8-15ccaec3535b@linaro.org>
Date:   Tue, 10 Jan 2023 10:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] soc: hpe: Add GXP SROM Control Register Driver
Content-Language: en-US
To:     clayc@hpe.com, linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-2-clayc@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110042533.12894-2-clayc@hpe.com>
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

On 10/01/2023 05:25, clayc@hpe.com wrote:
> From: Clay Chang <clayc@hpe.com>
> 
> The GXP SROM control register can be used to configure LPC related
> legacy I/O registers. Currently only the SROM RAM Offset Register
> (vromoff) is exported.
> 
> The GXP SOCLIB is a common library used for creating the common
> "soc" class in the kernel.
> 
> Signed-off-by: Clay Chang <clayc@hpe.com>
> ---
>  drivers/soc/Kconfig          |   1 +
>  drivers/soc/Makefile         |   1 +
>  drivers/soc/hpe/Kconfig      |  29 +++++++
>  drivers/soc/hpe/Makefile     |   2 +
>  drivers/soc/hpe/gxp-soclib.c |  17 +++++
>  drivers/soc/hpe/gxp-soclib.h |   9 +++
>  drivers/soc/hpe/gxp-srom.c   | 141 +++++++++++++++++++++++++++++++++++
>  7 files changed, 200 insertions(+)
>  create mode 100644 drivers/soc/hpe/Kconfig
>  create mode 100644 drivers/soc/hpe/Makefile
>  create mode 100644 drivers/soc/hpe/gxp-soclib.c
>  create mode 100644 drivers/soc/hpe/gxp-soclib.h
>  create mode 100644 drivers/soc/hpe/gxp-srom.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 5dbb09f843f7..faff0f036b61 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/canaan/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/fujitsu/Kconfig"
> +source "drivers/soc/hpe/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
>  source "drivers/soc/litex/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fff513bd522d..d257b9d654b3 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
>  obj-y				+= fujitsu/
>  obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
> +obj-$(CONFIG_ARCH_HPE)		+= hpe/
>  obj-y				+= imx/
>  obj-y				+= ixp4xx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> diff --git a/drivers/soc/hpe/Kconfig b/drivers/soc/hpe/Kconfig
> new file mode 100644
> index 000000000000..88f5d46b06b6
> --- /dev/null
> +++ b/drivers/soc/hpe/Kconfig
> @@ -0,0 +1,29 @@
> +#
> +# HPE GXP SoC drivers
> +#
> +menu "HPE GXP SoC drivers"
> +	depends on ARCH_HPE || COMPILE_TEST
> +
> +config HPE_GXP_SOCLIB
> +	bool "GXP Common SoC Library"
> +	default y
> +	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	help
> +	  This is for the common library for all HPE SoC drivers. It
> +	  creates the root soc class (/sys/class/soc) for all GXP SoC
> +	  drivers. It must be yes if any one of the GXP SoC drivers were
> +	  added, so the config of all GXP SoC drivers must select this.

Don't open-code Kconfig dependencies in free-form text. IOW, drop last
sentence.

> +
> +
> +config HPE_GXP_SROM
> +	bool "GXP SROM Configuration Driver"
> +	default y
> +	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	select HPE_GXP_SOCLIB
> +	help
> +	  Say yes here to add support for SROM Configuration. The GXP SROM
> +	  control register can be used to configure LPC related legacy I/O
> +	  registers. Currently only the SROM RAM Offset Register (vromoff)
> +	  is exported.
> +
> +endmenu
> diff --git a/drivers/soc/hpe/Makefile b/drivers/soc/hpe/Makefile
> new file mode 100644
> index 000000000000..78de24ecb606
> --- /dev/null
> +++ b/drivers/soc/hpe/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_HPE_GXP_SOCLIB) += gxp-soclib.o
> +obj-$(CONFIG_HPE_GXP_SROM) += gxp-srom.o
> diff --git a/drivers/soc/hpe/gxp-soclib.c b/drivers/soc/hpe/gxp-soclib.c
> new file mode 100644
> index 000000000000..11b0afe09070
> --- /dev/null
> +++ b/drivers/soc/hpe/gxp-soclib.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett Packard Enteprise Development Company, L.P. */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +struct class *soc_class;
> +
> +static int __init gxp_soclib_init(void)
> +{
> +	soc_class = class_create(THIS_MODULE, "soc");
> +	if (IS_ERR(soc_class))
> +		return PTR_ERR(soc_class);
> +	return 0;
> +}
> +
> +module_init(gxp_soclib_init);

I don't see a point of making it a shared object and a "kernel library".
Module inits are not libraries. Drop entire file.

> diff --git a/drivers/soc/hpe/gxp-soclib.h b/drivers/soc/hpe/gxp-soclib.h
> new file mode 100644
> index 000000000000..eb0e72b67aee
> --- /dev/null
> +++ b/drivers/soc/hpe/gxp-soclib.h
> @@ -0,0 +1,9 @@


> +
> +static int sysfs_register(struct device *parent,
> +			  struct gxp_srom_drvdata *drvdata)
> +{
> +	struct device *dev;
> +
> +	dev = device_create_with_groups(soc_class, parent, 0,
> +					drvdata, srom_groups, "srom");
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +	drvdata->dev = dev;
> +	return 0;
> +}
> +
> +static int gxp_srom_probe(struct platform_device *pdev)
> +{
> +	struct gxp_srom_drvdata *drvdata;
> +	struct resource *res;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_srom_drvdata),

sizeof(*)

> +				GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->pdev = pdev;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no srom resource defined\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);

Combine these two. There is a helper for this.

> +	if (IS_ERR(drvdata->base)) {
> +		dev_err(&pdev->dev, "ioremap_resource error\n");
> +		ret = PTR_ERR(drvdata->base);

return dev_err_probe().
> +		goto ioremap_err;
> +	}
> +
> +	mutex_init(&drvdata->mutex);
> +
> +	ret = sysfs_register(&pdev->dev, drvdata);

Missing ABI documentation.

> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "sysfs error\n");

return dev_err_probe

> +		goto sysfs_err;
> +	}
> +
> +	dev_info(&pdev->dev, "initialized\n");

Drop silly probe successes.

> +	return 0;
> +
> +sysfs_err:
> +ioremap_err:
> +	platform_set_drvdata(pdev, NULL);
> +out:
> +	if (drvdata)
> +		devm_kfree(&pdev->dev, (void *)drvdata);

1. Why? if it is here, it must be in remove() callback. If it is invalid
(because it is really not correct) for remove(), it cannot be here, right?
2. Why cast?

> +	return ret;
> +}
> +
> +static const struct of_device_id gxp_srom_of_match[] = {
> +	{ .compatible = "hpe,gxp-srom" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_srom_of_match);
> +
> +static struct platform_driver gxp_srom_driver = {
> +	.probe = gxp_srom_probe,
> +	.driver = {
> +		.name = "gxp-srom",
> +		.of_match_table = of_match_ptr(gxp_srom_of_match),

That will cause a warning. Drop of_match_ptr.

> +	},
> +};
> +module_platform_driver(gxp_srom_driver);
> +
> +MODULE_AUTHOR("Clay Chang <clayc@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP SROM Configuration Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

