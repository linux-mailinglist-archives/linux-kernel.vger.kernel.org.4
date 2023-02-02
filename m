Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68E687811
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBBI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:59:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC230DF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:59:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so836574wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsJTBdBXvAT2vsiyDP+3ee1Ylym3acJqhZJzhX5LOJg=;
        b=KqQd7vhYI/iZ+SraS3+jN430dfeWKtC7dQnvjMKqIgRPLJA30+f3hzCpZZewoikvJa
         m6PK4TtaZzorXOGT3aK5T6PYaL82MiShIBQTta83ILNmB0ykCKJMtH91DkZnYafIzDoj
         RwaWjglaAb9oKO5PeA1IU4Y7hjLpxh+4R4A/k490DbyoEOBAiNFQXeJfxiN6LrtPlW9c
         E1hNfCpOESx332k4wS7LaY7LdMhrxH0+SBPnA5JOj5mDuy5/IBfbTrFQey3UWAtiMD0Q
         paDsz1GLNSkxTNJhx+HEJHu90oitIUQw1FAdQQqzYeB81e4C0bNJMbIRmiWssWqZPk9v
         TY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsJTBdBXvAT2vsiyDP+3ee1Ylym3acJqhZJzhX5LOJg=;
        b=g1QwdXjH0KB8i5fCCCGAeG3o3wAlUiAY0l17gqwnHq/M02AkLrPkhbF1lB0Rf3SHc9
         0ngUPTglIlfmqgf92Q5DSCyAS6kHlx+xrIctDWhJwPwnX42hoaF/Mq6gt74c/3VJcVxK
         6DrHktkaSUj5KTbhglrqPLK6srEUE6Dn5ZTP8wdwGwUr/gxXJlYndR+wTO+yJJKp241V
         aY5HAtj4yz31KUQuDRqG7D+ICSrR9QOSXolMCuYkZRgYV0TNE+qL+ULx9a0RfSul+vUE
         0H1AGzozJvZPLvKiA/IoUsYdqlj4tRykq/W31dt9N0/9Qy17RSm2/wrahvkJ+PHVGGyr
         LqWg==
X-Gm-Message-State: AO0yUKVaaFcxz4wDJ4SgSAEhisX8LctGdOcZuQM3Fb8JGd+JPdtsSp3L
        B0SQQJWcMKU5yq5si/gLqOv1mg==
X-Google-Smtp-Source: AK7set9/1FcFxPrq0WBVJMLzwCimgSNxARmXcry+CIZV/rUvfMFDq00iEwXyb32WVU4crlOmtuH89A==
X-Received: by 2002:a05:600c:314a:b0:3d9:f559:1f7e with SMTP id h10-20020a05600c314a00b003d9f5591f7emr1288370wmo.20.1675328364085;
        Thu, 02 Feb 2023 00:59:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003daffc2ecdesm4151880wmc.13.2023.02.02.00.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:59:23 -0800 (PST)
Message-ID: <0555a7ae-60b7-a10d-e444-c0b6c3a2cf59@linaro.org>
Date:   Thu, 2 Feb 2023 09:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/3] i2c: aspeed: support ast2600 i2c new register mode
 driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 11:33, Ryan Chen wrote:
> Add i2c new register mode driver to support AST2600 i2c
> new register mode. AST2600 i2c controller have legacy and
> new register mode. The new register mode have global register
> support 4 base clock for scl clock selection, and new clock
> divider mode. The i2c new register mode have separate register
> set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  MAINTAINERS                             |   10 +
>  drivers/i2c/busses/Kconfig              |   11 +
>  drivers/i2c/busses/Makefile             |    1 +
>  drivers/i2c/busses/i2c-ast2600-global.c |   94 ++
>  drivers/i2c/busses/i2c-ast2600-global.h |   19 +
>  drivers/i2c/busses/i2c-ast2600.c        | 1811 +++++++++++++++++++++++
>  6 files changed, 1946 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
>  create mode 100644 drivers/i2c/busses/i2c-ast2600.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 749710e22b4d..67d338d834b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3209,6 +3209,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
>  F:	drivers/usb/gadget/udc/aspeed_udc.c
>  
> +ASPEED AST2600 I2C DRIVER
> +M:	Ryan Chen <ryan_chen@aspeedtech.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> +F:	Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> +F:	drivers/i2c/busses/i2c-ast2600-global.c
> +F:	drivers/i2c/busses/i2c-ast2600-global.h
> +F:	drivers/i2c/busses/i2c-ast2600.c
> +
>  ASPEED XDMA ENGINE DRIVER
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 7284206b278b..5ef3ee6aa70f 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -389,6 +389,17 @@ config I2C_ALTERA
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-altera.
>  
> +config I2C_AST2600
> +	tristate "Aspeed AST2600 I2C Controller"
> +	depends on ARCH_ASPEED || MACH_ASPEED_G6 || COMPILE_TEST

MACH_ASPEED_G6 is useless and redundant

> +	select I2C_SMBUS
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Aspeed I2C controller with new register set.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-new-aspeed.
> +
>  config I2C_ASPEED
>  	tristate "Aspeed I2C Controller"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index c5cac15f075c..ce83dfdc2094 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
>  obj-$(CONFIG_I2C_AMD_MP2)	+= i2c-amd-mp2-pci.o i2c-amd-mp2-plat.o
>  obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
> +obj-$(CONFIG_I2C_AST2600)	+= i2c-ast2600-global.o i2c-ast2600.o

Why this cannot be merged to existing driver?

The same question for bindings... actually let me comment on this
separately.

(...)

> +static const struct of_device_id ast2600_i2c_global_of_match[] = {
> +	{ .compatible = "aspeed,ast2600-i2c-global", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ast2600_i2c_global_of_match);

This not how it works. You cannot have two drivers in one module.
(...)

> +
> +static const struct of_device_id ast2600_i2c_bus_of_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-i2c",

NAK. We already have it.



Best regards,
Krzysztof

