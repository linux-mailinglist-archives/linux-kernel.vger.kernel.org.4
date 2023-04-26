Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E646EEFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjDZIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbjDZIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:09:51 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A31992
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:09:48 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id raDepUY94jKvyraDepZTxa; Wed, 26 Apr 2023 10:09:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682496587;
        bh=3Dnct6syEmfol0OwB5y57UYOe2Ebjv/G1frdM6J2D2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KOsXkypVrNH0KqrELFWbVO44jVwy7NpAA45jduf5vUoI1PnrgF6myXhsk6DPTZg73
         YMiBSHe+eSenrv2OrpjNWPoxQnJIpDgIIWKtVPaiMQ6WB4C79hG+y8gqBHaNNWHAQd
         ubu8Tqs0bCpx7/2ZLi5d7xKGby3QoFX8L5WoS4dhfISqWh4nRV2WCfbyx5TqNEYBG8
         HW6BEpN7h0GwD8b9iGp7c3bvwXIJVnpKjO/+Z6n4jmrOc/RggjhuEX+X3EQLCjGdkx
         Hbm6G+RxoaytUmrBMV94NApD41jQEPKCOj+fiHlN7//+2IQDV1HcjjhoZ9YEB4iTNK
         ObHMOr+b0HCyQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 10:09:47 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b06ffea5-d631-dc1a-89af-71e72a4365c5@wanadoo.fr>
Date:   Wed, 26 Apr 2023 10:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/4] crypto: starfive - Add crypto engine support
Content-Language: fr
To:     jiajie.ho@starfivetech.com
Cc:     davem@davemloft.net, devicetree@vger.kernel.org,
        herbert@gondor.apana.org.au, kernel@esmil.dk,
        krzysztof.kozlowski+dt@linaro.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, robh+dt@kernel.org
References: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
 <20230426065848.842221-3-jiajie.ho@starfivetech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230426065848.842221-3-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/04/2023 à 08:58, Jia Jie Ho a écrit :
> Adding device probe and DMA init for StarFive cryptographic module.
> 
> Co-developed-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> Signed-off-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> Signed-off-by: Jia Jie Ho <jiajie.ho-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> ---
>   MAINTAINERS                           |   7 +
>   drivers/crypto/Kconfig                |   1 +
>   drivers/crypto/Makefile               |   1 +
>   drivers/crypto/starfive/Kconfig       |  17 +++
>   drivers/crypto/starfive/Makefile      |   4 +
>   drivers/crypto/starfive/jh7110-cryp.c | 199 ++++++++++++++++++++++++++
>   drivers/crypto/starfive/jh7110-cryp.h |  63 ++++++++
>   7 files changed, 292 insertions(+)
>   create mode 100644 drivers/crypto/starfive/Kconfig
>   create mode 100644 drivers/crypto/starfive/Makefile
>   create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
>   create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65140500d9f8..a6f7677db4db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19609,6 +19609,13 @@ F:	Documentation/devicetree/bindings/clock/starfive*
>   F:	drivers/clk/starfive/
>   F:	include/dt-bindings/clock/starfive*
>   
> +STARFIVE CRYPTO DRIVER
> +M:	Jia Jie Ho <jiajie.ho-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> +M:	William Qiu <william.qiu-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/crypto/starfive*
> +F:	drivers/crypto/starfive/
> +
>   STARFIVE PINCTRL DRIVER
>   M:	Emil Renner Berthing <kernel-sKpHZLTYfq0@public.gmane.org>
>   M:	Jianlong Huang <jianlong.huang-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 55e75fbb658e..64b94376601c 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -817,5 +817,6 @@ config CRYPTO_DEV_SA2UL
>   
>   source "drivers/crypto/keembay/Kconfig"
>   source "drivers/crypto/aspeed/Kconfig"
> +source "drivers/crypto/starfive/Kconfig"
>   
>   endif # CRYPTO_HW
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index 116de173a66c..212931c84412 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -53,3 +53,4 @@ obj-y += xilinx/
>   obj-y += hisilicon/
>   obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
>   obj-y += keembay/
> +obj-y += starfive/
> diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
> new file mode 100644
> index 000000000000..73f39b6bc09f
> --- /dev/null
> +++ b/drivers/crypto/starfive/Kconfig
> @@ -0,0 +1,17 @@
> +#
> +# StarFive crypto drivers configuration
> +#
> +
> +config CRYPTO_DEV_JH7110
> +	tristate "StarFive JH7110 cryptographic engine driver"
> +	depends on SOC_STARFIVE
> +	select CRYPTO_ENGINE
> +	select ARM_AMBA
> +	select DMADEVICES
> +	select AMBA_PL08X
> +	help
> +	  Support for StarFive JH7110 crypto hardware acceleration engine.
> +	  This module provides acceleration for public key algo,
> +	  skciphers, AEAD and hash functions.
> +
> +	  If you choose 'M' here, this module will be called starfive-crypto.


jh7110-cryp?


> diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
> new file mode 100644
> index 000000000000..41221acaee39
> --- /dev/null
> +++ b/drivers/crypto/starfive/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
> +jh7110-crypto-objs := jh7110-cryp.o

