Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBD67EAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjA0QYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjA0QYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:24:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C684186
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so3834453wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4SjPb+KQCCqXt5+UJSzCKnKOLQs9qLMQKD+w6awmLE=;
        b=aRo1LKtcLmlW7AqzdJ5P5K1H2cIVYIMH5rPcShdIajmE6UxnjjzGtP2X8/YLWL4f4J
         Elc1YEqHQK3XdceTc4l2ma6z8o0tkGOFZza5fxDiXdO1tF02bhR9SUNRGkSfWvftlWj/
         75IllQ5jN9q1jkZ/1u+cE6yDodU85IngsldPbBDpE7FkR/YmR9P6Ytz5RyOJtNYWOwp6
         X3LPDhXo4xGAA9FmWQt+CiQFK/mddsQv5+OQZsOMv376MvbxXtD8qMkywIC9f+Dysu8K
         tYtED7sOdZO1GJri4cGFU6I8oHw9EDXT3duhzlyf/qd9GAoRzMJ2rL8MXCQAfPdJWlkF
         laCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4SjPb+KQCCqXt5+UJSzCKnKOLQs9qLMQKD+w6awmLE=;
        b=euBZpY6zkcyuWDgggueiRX3Blrupn2X98McEE7YnBPPVzFuyrGbroFjHR5+F/gxW2r
         N1ZUAWCYMNeVnD4EzVDzmi+C7NxmKgP2nOhcThti31Zrql/prVSPtTsmQHxrDu5ncz4Q
         WQXoikz3hlyFbzbJdj59EbBVMjh0QCp4Qd8fUQDymArEk1o7VCz5Ob60wdQ878uK1RF8
         H5NnUlXuDDvuCQ1H5+t3wtlyPM6ul2VOHiCxT0m5Ip3xbVdEaTXx+G6IYGtCb9hJnPD0
         fcxe1tSBNHA3hlc5MWyxCND1CFA9Dst1gI2TDetM0opm/u1E5vrpZfeaiRRu+67f1TXa
         R0Fw==
X-Gm-Message-State: AFqh2krZYZe7O/fqR1/WWUaoBUkyCNVn/ppNo70znLAx6kxQZPC29uzV
        QdVFcTNjnPgIso9PUm4xraNewQ==
X-Google-Smtp-Source: AMrXdXuUKdqqIKA07OvubLoaqaeRIp3n4iTBC8331/4YrW210N0wx/YITmlKvn+2iYN2nxY7NvdFlQ==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr33088183wmq.40.1674836657969;
        Fri, 27 Jan 2023 08:24:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6? ([2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003d9fb04f658sm8988854wmq.4.2023.01.27.08.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:24:17 -0800 (PST)
Message-ID: <fa2d056d-d261-4974-621c-35a39c5aec44@linaro.org>
Date:   Fri, 27 Jan 2023 17:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/5] arm64: dts: meson: add support for BananaPi M2-Pro
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
 <20230127142221.3718184-6-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230127142221.3718184-6-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 15:22, Christian Hewitt wrote:
> BPI-M2-PRO is based upon the BPI-M5 design except for a different
> physical board layout and the following changes:
> 
> - USB 3.0 ports reduced from 4x to 2x
> - 3.5mm Combined CVBS/Audio Jack removed
> - RTL8821BU WiFi/BT module (internal USB connected)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>   .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 97 +++++++++++++++++++
>   2 files changed, 98 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 97b42e2100e0..644451794aca 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> new file mode 100644
> index 000000000000..586034316ec3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 BayLibre SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1-bananapi.dtsi"
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible = "bananapi,bpi-m2-pro", "amlogic,sm1";
> +	model = "Banana Pi BPI-M2-PRO";
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "BPI-M2-PRO";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
