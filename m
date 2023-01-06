Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8E65FDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjAFJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjAFJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:25:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817826DB9E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:22:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso3099731wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIBwhXreyLm6L8pvnZwtbHNyGe5mj7GJLNgz4Wh6wQo=;
        b=rUSG4pEdZZLrEOMBnA8mTNPsn7JjkeFfcu9LagQ3wJ78obWtdOCbs/o/WuvChx67fD
         sQ4d/0Zy6qJ2bURTTu8YevguKYQF5FP2zjCxS8F0R2yFHERndGlPVLsrlesE/C4ZRF/2
         9zRpxtpep8sAJoSY5GLI0SDsZZVfNFH5TVsOmcON+O818kZGUzhJAKtLIl8cyb7V+aLl
         aE4VvJ7F/nbN0sr98J6iCdePjgv/lO1Z0lAipJeP0e3aeA9XgM2bY2Wdugybk53+1vSt
         9MvqNLM8Mgt117lsXOwrN/loBt0vm4XdjnIRIaTtxevLdzkdxR2kFtoXi6eNlyyQZe9F
         SPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIBwhXreyLm6L8pvnZwtbHNyGe5mj7GJLNgz4Wh6wQo=;
        b=Hb7Xvrif99dfTbCbmFXaZeEIMQkHkXZpFXVlqPLStSrOBv+qaZtkVY0KdqAbd7pBGv
         TE/zHyYgdEyU6z3kYDXB2Jg0uEyDBtFWUH+3CgYjtcCmoZ4XooUadPc0+E4+yy95rBJh
         eSqGkNkE6WEkbN2TMmLBp45hYuuD6Fe1DfGtsrsKKXGtQnQFK0RTWt9p1yJbuDsr/tON
         2MhbFWD3rvG0lyrbSVY+yEToHj5IfWtelId2xRaZGyxJAq8n0Ce/FAMW+4/dD2WVrNHD
         GDaCnr1K7Mh5Hj5ShTRgCCJevoYzV06DxLw8/eH2u3HwPGI1Zy72KUYuggR3Ou+a8u52
         0umA==
X-Gm-Message-State: AFqh2koisMPzH7NPHZnf6KqVVUSV2KIKNFpVRs/tWpWRdV2PylQ+xoOp
        K3dfVYTCgnFedto/yNOxMt3R6Q==
X-Google-Smtp-Source: AMrXdXt1czt6+jNPwMhku9nPQSZYF/LqrQNaJuRT/gQVAVTaHXddn9UrPgdw+EhBKkv5Muaf+tmGYQ==
X-Received: by 2002:a7b:cb89:0:b0:3d2:2101:1f54 with SMTP id m9-20020a7bcb89000000b003d221011f54mr38609714wmi.4.1672996911573;
        Fri, 06 Jan 2023 01:21:51 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az20-20020a05600c601400b003d96bdddd3dsm1047604wmb.15.2023.01.06.01.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:21:51 -0800 (PST)
Message-ID: <93915db1-9089-9c58-62f3-6a424c57bfa5@linaro.org>
Date:   Fri, 6 Jan 2023 10:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] ARM: dts: sunxi: add MangoPi MQ-R board
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?B?QW5kcsOhcyBTemVtesO2?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org
References: <20230106010155.26868-1-andre.przywara@arm.com>
 <20230106010155.26868-5-andre.przywara@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106010155.26868-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 02:01, Andre Przywara wrote:
> The MangoPi MQ-R is a small SBC with the Allwinner T113-s3 SoC.
> The SoC features two Arm Cortex-A7 cores and 128 MB of co-packaged DDR3
> DRAM. The board adds mostly connectors and the required regulators, plus
> a Realtek RTL8189FTV WiFi chip.
> Power comes in via a USB-C connector wired as a peripheral, and there is
> a second USB-C connector usable as a host port.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts | 160 ++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d08a3c450ce72..39fd893682924 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1390,6 +1390,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-s3-elimo-initium.dtb \
>  	sun8i-s3-lichee-zero-plus.dtb \
>  	sun8i-s3-pinecube.dtb \
> +	sun8i-t113s-mangopi-mq-r.dtb \
>  	sun8i-t3-cqa3t-bv3.dtb \
>  	sun8i-v3-sl631-imx179.dtb \
>  	sun8i-v3s-licheepi-zero.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts b/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
> new file mode 100644
> index 0000000000000..ed4d5217d7b0d
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// Copyright (C) 2022 Arm Ltd.
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/dts-v1/;
> +
> +#include "sun8i-t113s.dtsi"
> +
> +/ {
> +	model = "MangoPi MQ-R";
> +	compatible = "widora,mangopi-mq-r", "allwinner,sun8i-t113s";
> +
> +	aliases {
> +		ethernet0 = &rtl8189ftv;
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
> +		};
> +	};
> +
> +	/* board wide 5V supply directly from the USB-C socket */
> +	reg_vcc5v: vcc5v {

Generic node names, so matching style of other - with regulator prefix.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	/* SY8008 DC/DC regulator on the board */
> +	reg_3v3: regulator-3v3 {


Best regards,
Krzysztof

