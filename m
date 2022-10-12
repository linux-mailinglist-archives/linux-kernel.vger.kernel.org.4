Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602B5FCE17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJLWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJLWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C142D4B;
        Wed, 12 Oct 2022 15:01:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so211689ejd.0;
        Wed, 12 Oct 2022 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c297Mx5GJtCyOHa14C0QACA80doQwDidPNZnmUy04NM=;
        b=FHXLEeY6zqLifb7KS6WgUhITH3TMoRVQQYGRO6ciD2t98IynD0Zd+YYR1Jdpy4Pgsr
         BxqyfV75rtmUO4CmwSSlh9GI3uDS2VELJcqwx3SQT3QoJ+CCQVwh1asY9I+ReaB8oU4G
         KXOlZtG3lTSByyou0tazsMQecpZFsMGCC1iU0c9PpXMM5xrImM7pST5y3DrtpW58cdP8
         2nvv5cza+Lthz4Myh1Z2RItqW3Hy98aWrny61hIvTEWVCXWT1tnCCbMNSVovyYR/ImYc
         aCaR6bNqmjieHxQllby61SoRk7JxgiM5t/GxG+IKddsU5rLRdDh9dc2DQCBlx4TlTarY
         gE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c297Mx5GJtCyOHa14C0QACA80doQwDidPNZnmUy04NM=;
        b=pcLMJ6MaJtlxYd0jDXHVNBh7BBrrTRzlJcmY7xfyQtEaejPMzN246FCJyLpqdNQf9L
         8swswjq3McbK56LYLm+Yo4nGPmIqSjqThHRy02vOf4wsJDJ8zJpCxBjhdietSHcfnnbN
         y+CLacsAr9Bt4KeWqxTHAyiwGbM/ONUYjEDgZAdSwyN3TJKlrt7MNr9vwkV0NVOL/eCf
         u93Tp/b5NCniYQfsN1PdYMRxue2s8wVhqw00ofj/e5CYG3i+7YJFDEhID7EKLhwMqqSb
         2tgojjdUM0F1rvch3gLATIkdV9m7EiiBeTnSwScuyAdz4cQTiWcSfe+g1NrG8Dhd70lk
         mUOA==
X-Gm-Message-State: ACrzQf1OtpsOEp76FSYL43TP+Cg1rvH3r3Mzwo4hc4ubHRUynGaLWl7D
        XGfmidV/OJRY58xOJQ7YG/E=
X-Google-Smtp-Source: AMsMyM4UR/dRvb2fTJVEbwytBHZZyA1se8KFEVUwu+TIl1ALRT3A19l1UGFCZ/jWtMTtNcZWUZorIw==
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id gs6-20020a1709072d0600b0078d50db130emr23152667ejc.371.1665612100206;
        Wed, 12 Oct 2022 15:01:40 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0073c0b87ba34sm1853442ejh.198.2022.10.12.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 1/2] ARM: dts: axp803/axp81x: Drop GPIO LDO pinctrl nodes
Date:   Thu, 13 Oct 2022 00:01:38 +0200
Message-ID: <4454781.cEBGB3zze1@kista>
In-Reply-To: <20220916042751.47906-2-samuel@sholland.org>
References: <20220916042751.47906-1-samuel@sholland.org> <20220916042751.47906-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Dne petek, 16. september 2022 ob 06:27:50 CEST je Samuel Holland napisal(a):
> The "ldo-io0" and "ldo-io1" regulators are enabled/disabled by toggling
> the pinmux between two functions. This happens in the regulator driver.
> Setting the pinmux to "ldo" in the DT is inappropriate because it would
> enable the regulator before the driver has a chance to set the correct
> initial voltage.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej
> ---
> 
> Changes in v3:
>  - Added patch to remove existing "ldo" pinctrl nodes
> 
>  arch/arm/boot/dts/axp81x.dtsi             | 14 --------------
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 10 ----------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index b93387b0c1c3..ebaf1c3ce8db 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -62,16 +62,6 @@ axp_gpio: gpio {
>  		compatible = "x-powers,axp813-gpio";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -
> -		gpio0_ldo: gpio0-ldo-pin {
> -			pins = "GPIO0";
> -			function = "ldo";
> -		};
> -
> -		gpio1_ldo: gpio1-ldo-pin {
> -			pins = "GPIO1";
> -			function = "ldo";
> -		};
>  	};
> 
>  	battery_power_supply: battery-power {
> @@ -144,15 +134,11 @@ reg_fldo3: fldo3 {
>  		};
> 
>  		reg_ldo_io0: ldo-io0 {
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&gpio0_ldo>;
>  			/* Disable by default to avoid conflicts with 
GPIO */
>  			status = "disabled";
>  		};
> 
>  		reg_ldo_io1: ldo-io1 {
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&gpio1_ldo>;
>  			/* Disable by default to avoid conflicts with 
GPIO */
>  			status = "disabled";
>  		};
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> b/arch/arm64/boot/dts/allwinner/axp803.dtsi index
> 578ef368e2b4..a6b4b87f185d 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -25,16 +25,6 @@ axp_gpio: gpio {
>  		compatible = "x-powers,axp803-gpio", "x-powers,axp813-
gpio";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -
> -		gpio0_ldo: gpio0-ldo-pin {
> -			pins = "GPIO0";
> -			function = "ldo";
> -		};
> -
> -		gpio1_ldo: gpio1-ldo-pin {
> -			pins = "GPIO1";
> -			function = "ldo";
> -		};
>  	};
> 
>  	battery_power_supply: battery-power {
> --
> 2.35.1


