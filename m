Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE45E7BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIWNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:19:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3628B07;
        Fri, 23 Sep 2022 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663939169; x=1695475169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cMGYQRBhEi7PMXJRQGC2o2noL96QUPhJ/68mPMMdlN8=;
  b=zv+pSquNqWP61R1e9ViY1gRWmBD5cz46JBGEmtRebnJ6ZfnSRf2oHoEB
   Mgim2Qg/nKlxySJauZcFQfkHOqOKjd8rIA5c7X/Qdiul2e0hoVNIuKT2i
   6U5tyOKu41tDq6Zq0ZrEHo3B9ITADMoAs40LYEnBmWnmQ1cpeWVAUz8zp
   9Gke3q2WKH9PpM6oD4VJ6zXxh79oZScWCY4tdEL5yt8rZw3Zct5pwoAx0
   x/aqhidOkrATEuZZT3ziJNui0U+5cQYTyAn4DYpse9ONNy5YeYCnREy+G
   O2d9K52r61M5VTUfs/uOJTkk+CifH6RdXceqOvTCS+vucauSnVJ0gmFkY
   A==;
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="181694207"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2022 06:19:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 23 Sep 2022 06:19:21 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 23 Sep 2022 06:19:19 -0700
Message-ID: <53b7639a-174f-7a49-10a2-60eaa838278a@microchip.com>
Date:   Fri, 23 Sep 2022 15:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Solve warning regarding inexistent
 atmel-usart binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        <gregkh@linuxfoundation.org>, <krzk@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220923113415.90236-1-sergiu.moga@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220923113415.90236-1-sergiu.moga@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 at 13:34, Sergiu Moga wrote:
> After the conversion to json-schema, what was previously known as
> `Documentation/devicetree/bindings/mfd/atmel-usart.txt`
> has been moved to another bindings directory and renamed to
> `Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml`.
> Thus, make `MAINTAINERS` reflect this change.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks for having fixed that Sergiu. Regards,
   Nicolas

> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d30f26e07cd3..7308dfba6f0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13292,7 +13292,7 @@ F:	include/dt-bindings/dma/at91.h
>   MICROCHIP AT91 SERIAL DRIVER
>   M:	Richard Genoud <richard.genoud@gmail.com>
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:	drivers/tty/serial/atmel_serial.c
>   F:	drivers/tty/serial/atmel_serial.h
>   
> @@ -13300,7 +13300,7 @@ MICROCHIP AT91 USART MFD DRIVER
>   M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
>   L:	linux-kernel@vger.kernel.org
>   S:	Supported
> -F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:	drivers/mfd/at91-usart.c
>   F:	include/dt-bindings/mfd/at91-usart.h
>   
> @@ -13308,7 +13308,7 @@ MICROCHIP AT91 USART SPI DRIVER
>   M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
>   L:	linux-spi@vger.kernel.org
>   S:	Supported
> -F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:	drivers/spi/spi-at91-usart.c
>   
>   MICROCHIP AUDIO ASOC DRIVERS


-- 
Nicolas Ferre
