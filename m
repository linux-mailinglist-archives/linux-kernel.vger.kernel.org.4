Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E66633D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKVNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiKVNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:14:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9063145;
        Tue, 22 Nov 2022 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669122834; x=1700658834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=inJva2GCFCG4wUV3qNo2FJXvTuxNSseUErHaBYwOxLI=;
  b=lUpoT3hE5vWdsQm39MS9/Cwgur/lWugaVonr0nFV3ptNy/p0zx2ivchq
   QP0E1dsBf6+XTq47tqbYOPbYjI5+nZDIz5MmwcCateKbW7YVOXyy77vFk
   RqjSnwXRl1jwvZJnSmhxMGU8AZji8Q2+NVBO8NlzEKuB0N7f/A9HU4qQi
   NDxoaejUajJJ3hllJXkkMJBDMW6ad37zwjJkUItvJy2MlQZ+ue/De/9Ll
   it1Mai1xlVd1fX+3zVEjq5Si+XY32Uri3jowgCZywH2yUhpC1DHnUinZE
   Z3eZ83cp/fEQJXk/F1CR0pctwsjV3uNiSj7iMIbbicT73D4BVuTfYKINR
   A==;
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="190092974"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 06:13:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 06:13:50 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 06:13:45 -0700
Message-ID: <af0390fd-e238-dbe4-f67e-feb47e5ad31f@microchip.com>
Date:   Tue, 22 Nov 2022 14:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <robh+dt@kernel.org>,
        <akpm@linux-foundation.org>
CC:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <broonie@kernel.org>, <qyousef@layalina.io>, <arnd@arndb.de>,
        <atishp@atishpatra.org>, <anup@brainfault.org>, <tkhai@ya.ru>,
        <quic_abhinavk@quicinc.com>, <vasily.averin@linux.dev>,
        <baolin.wang@linux.alibaba.com>, <colin.i.king@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221122125244.175295-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 at 13:52, Tudor Ambarus wrote:
> My professional email will change and the microchip one will bounce after
> mid-november of 2022.
> 
> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
> author mentions, and add an entry in the .mailmap file.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Tudor for the work during all these years!

Best regards,
   Nicolas

> ---
>   .mailmap                                               |  1 +
>   .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
>   .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
>   .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
>   .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
>   .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
>   MAINTAINERS                                            | 10 +++++-----
>   drivers/crypto/atmel-ecc.c                             |  4 ++--
>   drivers/crypto/atmel-i2c.c                             |  4 ++--
>   drivers/crypto/atmel-i2c.h                             |  2 +-
>   10 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index fdd7989492fc..f723a29af021 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -415,6 +415,7 @@ Tony Luck <tony.luck@intel.com>
>   TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
>   TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
>   Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
> +Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
>   Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
>   Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
>   Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> index 0ccaab16dc61..0b7383b3106b 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
>   
>   maintainers:
> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
> index 5163c51b4547..ee2ffb034325 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
>   
>   maintainers:
> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> index fcc5adf03cad..3d6ed24b1b00 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
>   
>   maintainers:
> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> index 4dd973e341e6..6c57dd6c3a36 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel SPI device
>   
>   maintainers:
> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>   
>   allOf:
>     - $ref: spi-controller.yaml#
> diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> index 1d493add4053..b0d99bc10535 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel Quad Serial Peripheral Interface (QSPI)
>   
>   maintainers:
> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>   
>   allOf:
>     - $ref: spi-controller.yaml#
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e04d944005ba..b13e67bed48e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13418,7 +13418,7 @@ F:	arch/microblaze/
>   
>   MICROCHIP AT91 DMA DRIVERS
>   M:	Ludovic Desroches <ludovic.desroches@microchip.com>
> -M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	dmaengine@vger.kernel.org
>   S:	Supported
> @@ -13464,7 +13464,7 @@ F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
>   F:	drivers/media/platform/atmel/microchip-csi2dc.c
>   
>   MICROCHIP ECC DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>   L:	linux-crypto@vger.kernel.org
>   S:	Maintained
>   F:	drivers/crypto/atmel-ecc.*
> @@ -13559,7 +13559,7 @@ S:	Maintained
>   F:	drivers/mmc/host/atmel-mci.c
>   
>   MICROCHIP NAND DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>   L:	linux-mtd@lists.infradead.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -13611,7 +13611,7 @@ S:	Supported
>   F:	drivers/power/reset/at91-sama5d2_shdwc.c
>   
>   MICROCHIP SPI DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>   S:	Supported
>   F:	drivers/spi/spi-atmel.*
>   
> @@ -19402,7 +19402,7 @@ F:	drivers/clk/spear/
>   F:	drivers/pinctrl/spear/
>   
>   SPI NOR SUBSYSTEM
> -M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>   M:	Pratyush Yadav <pratyush@kernel.org>
>   R:	Michael Walle <michael@walle.cc>
>   L:	linux-mtd@lists.infradead.org
> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
> index 82bf15d49561..dd7b561c4256 100644
> --- a/drivers/crypto/atmel-ecc.c
> +++ b/drivers/crypto/atmel-ecc.c
> @@ -3,7 +3,7 @@
>    * Microchip / Atmel ECC (I2C) driver.
>    *
>    * Copyright (c) 2017, Microchip Technology Inc.
> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
> + * Author: Tudor Ambarus
>    */
>   
>   #include <linux/delay.h>
> @@ -411,6 +411,6 @@ static void __exit atmel_ecc_exit(void)
>   module_init(atmel_ecc_init);
>   module_exit(atmel_ecc_exit);
>   
> -MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
> +MODULE_AUTHOR("Tudor Ambarus");
>   MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
> index 81ce09bedda8..55bff1e13142 100644
> --- a/drivers/crypto/atmel-i2c.c
> +++ b/drivers/crypto/atmel-i2c.c
> @@ -3,7 +3,7 @@
>    * Microchip / Atmel ECC (I2C) driver.
>    *
>    * Copyright (c) 2017, Microchip Technology Inc.
> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
> + * Author: Tudor Ambarus
>    */
>   
>   #include <linux/bitrev.h>
> @@ -390,6 +390,6 @@ static void __exit atmel_i2c_exit(void)
>   module_init(atmel_i2c_init);
>   module_exit(atmel_i2c_exit);
>   
> -MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
> +MODULE_AUTHOR("Tudor Ambarus");
>   MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
> index 48929efe2a5b..35f7857a7f7c 100644
> --- a/drivers/crypto/atmel-i2c.h
> +++ b/drivers/crypto/atmel-i2c.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (c) 2017, Microchip Technology Inc.
> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
> + * Author: Tudor Ambarus
>    */
>   
>   #ifndef __ATMEL_I2C_H__

-- 
Nicolas Ferre

