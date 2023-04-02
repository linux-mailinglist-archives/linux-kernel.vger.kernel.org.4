Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF36B6D36D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDBKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjDBKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:04:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651DF10F5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:04:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so106401997edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680429842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWWy4/C/MQgzPNUE4XEgKsI2Wpmjz+E0b50/BZkhNms=;
        b=zHfMH1RqOgycPSQTA7+6D3Fz+l9Qn/YMk8q5q0EmI2US6wbZZ4i7Q/+cacvqPL3GKW
         1wQCaYv6ZapFjulMoPRBonzpFwCnLMc/WykELnBqXARckdOwOexryIbiNZMZO+6Q/32L
         RcC1QyQ3eNb3mweLXEJoXBFYkIK6Ala2COTplA1m0UB+JRTBallbGDPshUlTJaId6tua
         NKoUYqvvw5MXAsDOIXxWQ1W8HC5OKccsPMr1Xm4IYdCWWyyIYGc94nWrICRhqCTOTXl9
         /9xYG/nj7odPI05+QBe/VcfWNbdhBPCacQ6PUemuIA6Rhg0gBwlSevam5oL6wYcEMjKC
         ZtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWWy4/C/MQgzPNUE4XEgKsI2Wpmjz+E0b50/BZkhNms=;
        b=qAQqann57ZEXeiI1IONdQHhBVs+Z+ARXLduE1rVKCy13GDU7a14DVOvbxFjoAzCBzH
         msTX4uv9OLn+ja4/kVwSil1SdoWTUPCnHBcek1HfYAzfXuBarPCZ8o9lpFTm5fnkTuTK
         RHG2Syr4SIjaOqD4TDAGQ6lHP/qVYIuS3oiqpVr+s41/7b9IFePp2UAceYVLzI4gW1it
         CcwB5xC+ng9hzvScLCwBaq89J3fo02emLoWNn1GiTZrv3UfZOLjLlcqCBorSQmndEZL1
         oGmd3TBqo6KvB88OnxmOIwn5URy3HClK+JSeBiP2MPETZ8emyrQksYwIZ31z0TieSvMT
         1E0A==
X-Gm-Message-State: AAQBX9eEc+RNJFNqTxTY2eTzNiYY5P4Pxec1WWSNZg8GFf/JC9NCU9ej
        5eSbvFi8h4J9pl/8P6EJpO4nyA==
X-Google-Smtp-Source: AKy350Z6ozQ06SwDgcfVTIcnq2kml/s8Zkv04sjL3OVXwXRjTz5RHdXAIaCfn+dtxdMEcd1GVqU9Yw==
X-Received: by 2002:a17:906:3a43:b0:932:aa80:406 with SMTP id a3-20020a1709063a4300b00932aa800406mr36073258ejf.32.1680429841864;
        Sun, 02 Apr 2023 03:04:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b004c10b4f9ebesm3109562ede.15.2023.04.02.03.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 03:04:01 -0700 (PDT)
Message-ID: <9fcb66fa-aadc-8660-bd4a-452c4811ced9@linaro.org>
Date:   Sun, 2 Apr 2023 12:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 2/2] spi: loongson: add bus driver for the loongson spi
 controller
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401095652.17364-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 11:56, Yinbo Zhu wrote:
> This bus driver supports the Loongson spi hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register spi device resources.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---


...

> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include "spi-loongson.h"
> +
> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
> +					  unsigned char data)
> +{
> +	writeb(data, spi->base + reg);

This wrapper does not simplify anything.

> +}
> +
> +static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
> +{
> +	return readb(spi->base + reg);

Neither this one.

> +}
> +
> +static void loongson_spi_set_cs(struct spi_device *spi, bool val)
> +{
> +	int cs;
> +	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
> +

(...)

> +
> +static int __init loongson_spi_pci_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&loongson_spi_pci_driver);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void __exit loongson_spi_pci_exit(void)
> +{
> +	pci_unregister_driver(&loongson_spi_pci_driver);
> +}
> +
> +module_init(loongson_spi_pci_init);
> +module_exit(loongson_spi_pci_exit);

module_xxx_driver?

> +
> +MODULE_DESCRIPTION("Loongson spi pci driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
> new file mode 100644
> index 000000000000..8f4aa70168f3
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-plat.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Platform driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(dev, "cannot get io resource memory\n");
> +		return -ENOENT;
> +	}
> +
> +	ret = loongson_spi_init_master(dev, res);
> +	if (ret)
> +		dev_err(dev, "failed to initialize master\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id loongson_spi_id_table[] = {
> +	{ .compatible = "loongson,ls2k-spi", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
> +
> +static struct platform_driver loongson_spi_plat_driver = {
> +	.probe = loongson_spi_platform_probe,
> +	.driver	= {
> +		.name	= "loongson-spi",
> +		.owner	= THIS_MODULE,

Really? We get rid of it years ago. I bet you did not run coccicheck,
smatch, sparse...

> +		.bus = &platform_bus_type,
> +		.pm = &loongson_spi_dev_pm_ops,
> +		.of_match_table = loongson_spi_id_table,
> +	},
> +};
> +
> +static int __init loongson_spi_plat_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&loongson_spi_plat_driver);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void __exit loongson_spi_plat_exit(void)
> +{
> +	platform_driver_unregister(&loongson_spi_plat_driver);
> +}
> +
> +module_init(loongson_spi_plat_init);
> +module_exit(loongson_spi_plat_exit);

module_platform_driver.

> +
> +MODULE_DESCRIPTION("Loongson spi platform driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> new file mode 100644
> index 000000000000..44818340188d
> --- /dev/null
> +++ b/drivers/spi/spi-loongson.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Header File for Loongson SPI Driver. */
> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> +
> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H
> +
> +#define	LOONGSON_SPI_SPCR_REG	0x00

There is just one space after #define.


Best regards,
Krzysztof

