Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068775B310D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIIH4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIIH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:56:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944916F25F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:53:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f9so604793lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SjYG2PFaNt0xECOYddkqlrk70qFfhobeiXgcTEQwROc=;
        b=GN9JSxri6PHjWcOv6NDc4cgT9TtEg02B7jt8LGyIcXEH1kBi+ibdKX1EzAn9yPswHU
         Hm1DEOsq0VzKp9FCTV/v75soeA+Z+2rI0rwa/LwEjdNilREutomUc8QUfIEkbgxnU7Oi
         xt2UyDw+kfGQ/V/+cve9rN1tgOcuz2PdTjn6rX3uhnKBLnQzZQbxed8vR2FdUx/Z0KRV
         UhTqmr47QUCSWp91btZP9JTH0k4fonUJOVL5uJen+clO5AH30WcVtDdnes2NJI6U7UBE
         U2fnydaQrzDJdjM76C5iS4ghtRqYIQHLYhWs5OjrPEVamj6BvfN+V37H4Ha999gjRL/J
         vPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SjYG2PFaNt0xECOYddkqlrk70qFfhobeiXgcTEQwROc=;
        b=CevDVf9MDKgwh3uwq4jaRNdm+L7OOs6Oo3SuG63WG1jqusavUgdSrmYHB8E/nxQqDa
         ay0nWp0e6KnBxwh7QgjZaTmwCLAqOzVBht7rWHqh26Ob7S8DloEVhLPQHksKYXie+Vgd
         lODmH4uhGKZW0mFCigHqey4RntKAahrZbL3uDtS82IbjrRxtb1HWWWEWZnzM4o2Zmw7y
         7uG6mZ1fUqcqloz11OzzORxrLk6duLKmbeSCsKH0IdYJ7d6b0UD5Tpv8nbwzmK7hJQd3
         ZIj3wFXtO/+Zt/0Q9lfO5cBANlhADfdLr+ULyZlGjHgzh+C8NKP2lYwqDiJAF0FhQ9rS
         dT3Q==
X-Gm-Message-State: ACgBeo3DOH5touiEBjyJMXIk2CxJ/gqEJnpx4bqXVlNMLCmM6F0A4njj
        2/WabnZaBeynBbFdqiX+3OclcOehPuZtdg==
X-Google-Smtp-Source: AA6agR69XlB0N1Y4F2sFDuVhLxBpAU4/bu1X383HDNAMMYLF35HPUz+ANBnwZBoPsRmWeNG8cOctXw==
X-Received: by 2002:a05:6512:2828:b0:498:f87f:465e with SMTP id cf40-20020a056512282800b00498f87f465emr612449lfb.522.1662710017837;
        Fri, 09 Sep 2022 00:53:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512390300b00494942bec60sm180227lfu.17.2022.09.09.00.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:53:37 -0700 (PDT)
Message-ID: <c162f4b5-9af3-a62b-aa2c-ce16662d30bb@linaro.org>
Date:   Fri, 9 Sep 2022 09:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [linux][PATCH v8 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220908222125.19059-1-jerry.ray@microchip.com>
 <20220908222125.19059-2-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908222125.19059-2-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 00:21, Jerry Ray wrote:
> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
> evaluating many Microchip ethernet switch and PHY products.  Various
> daughter cards can connect via an RGMII connector or an RMII connector.
> 
> The EDS board is not intended for stand-alone use and has no ethernet
> capabilities when no daughter board is connected.  As such, this device
> tree is intended to be used with a DT overlay defining the add-on board.
> To better ensure consistency, some items are defined here as a form of
> documentation so that all add-on overlays will use the same terms.
> 
> Link: https://www.microchip.com/en-us/development-tool/SAMA5D3-ETHERNET-DEVELOPMENT-SYSTEM
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v7->v8:
>  - correcting patch subject line.
> v6->v7:
>  - Renamed regulators, making things more consistent.
>  - Made slow_xtal and main_xtal entries direct overrides.
> v5->v6:
>  - Replaced underscores in names where I can, improving naming.
> v4->v5:
>  - patch now applies to v6.0-rc2
> v3->v4:
>  - Fixed regulators as necessary to get the board to boot from SD Card.
> v2->v3:
>  - Alphabetized pinctrl entries.
>  - cleaned up a warning in the regulators section.
>  - License tweaked to 'OR MIT'
>  - Included Makefile change
> v1->v2:
>  - Modified the compatible field in the device tree to reflect Microchip
>    Ethernet Development System Board.
> ---
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/at91-sama5d3_eds.dts | 307 +++++++++++++++++++++++++
>  2 files changed, 308 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..e92e639a2dc3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d2_icp.dtb \
>  	at91-sama5d2_ptc_ek.dtb \
>  	at91-sama5d2_xplained.dtb \
> +	at91-sama5d3_eds.dtb \
>  	at91-sama5d3_ksz9477_evb.dtb \
>  	at91-sama5d3_xplained.dtb \
>  	at91-dvk_som60.dtb \
> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> new file mode 100644
> index 000000000000..c7fbf7aa7826
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
> + *    Development System board.
> + *
> + * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Jerry Ray <jerry.ray@microchip.com>
> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +
> +/ {
> +	model = "SAMA5D3 Ethernet Development System";
> +	compatible = "microchip,sama5d3-eds", "atmel,sama5d36",
> +		     "atmel,sama5d3", "atmel,sama5";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio {

gpio is for GPIO controller. These are keys/buttons and usually it is
'gpio-keys' as node name.


Best regards,
Krzysztof
