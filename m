Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A66776B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjAWIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAWIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:50:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D57CC2E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:50:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y1so5552707wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tokXhkBB2O2paiGKKaoP2lzAxO7le6+XsVsC6OhvEps=;
        b=Zs2ENQaN/ddPOAPgdaSsg2/GbLd6ZEFs+pDO2+YLotqVUzSfHKe158EBIXmC8Dmv44
         fpP1XMESSNz+0YuFNbHB/W1r3uRW41i5vWqVXkOmoVnRpD9hzD5QvGWHi0uz+yDVpVpk
         2nL9Qb4/AkPd3fOmVK0PvMJDoYwzsjKZcp5EC8qOhc7Oi5cAwdKRcVKjljg+7vlbhYke
         KXjbAKbzyk6gP6OWdQ5H8N6iRF+cOSCOVO2MFj1L1qMsajnTrNvVLL1jbbVv5dLIniLs
         lYjYrUlUMEaTiwu8EcwJ3Hb/TEOsZQKV/UdGjZMlvxhqWOLUkFcS4OG4kiPtQ4L7AVEH
         h0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tokXhkBB2O2paiGKKaoP2lzAxO7le6+XsVsC6OhvEps=;
        b=XkH4PkUgNCdr3f3vAvjjv/s3Biymy6GFzmVm+clpGbFuHJCOFj1jIO1koEuPkC2mX9
         oDzPqjFgwrtFql5sZKpnrt04p3pBVn8tG4CC5oh9zpcaXFMZpppZdNIMh7qH+IxXprLH
         Zk5F4BhGa1J96V3D8pcQYHwLLIZ6cbvny5bVmmF2J7YQZz2nPSdoRKzOCRCAlNlGVkjq
         LuzXMMzQeSu4gKiHe7sEXSGtew9EE5iLIz+/sHqx4rG4zZfAPgduj6lb5usfx+qEjttQ
         Di+pj1nXITqdqrvORjCJ2ipTTm7IWAHhCClUj4i/2d5AFBpWfoP8EEePc61Jy7POP6MK
         lrYg==
X-Gm-Message-State: AFqh2krJxdcTpLLCQh80pIa/7xsYwGHdQQr4QC/YhndSqyEqUlT3ro9L
        OEF40D0abK8i1TvdWaL8qORA0/KfaarvwhBwp4k=
X-Google-Smtp-Source: AMrXdXvTUl7kFlmLjtHWLnsL790TrBTdbZup8iSTjctXdffjd74Qq6pz9pm0/YMDSA5Fa3pMRKHX3A==
X-Received: by 2002:a5d:4e4e:0:b0:2bd:ec13:8101 with SMTP id r14-20020a5d4e4e000000b002bdec138101mr20899265wrt.41.1674463837319;
        Mon, 23 Jan 2023 00:50:37 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b002bdbead763csm31087880wrf.95.2023.01.23.00.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:50:36 -0800 (PST)
Message-ID: <470ccb46-4d63-2951-0fb9-71edca59b01a@linaro.org>
Date:   Mon, 23 Jan 2023 09:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to S905X-P212 dts
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065834.2670125-1-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230123065834.2670125-1-christianshewitt@gmail.com>
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

On 23/01/2023 07:58, Christian Hewitt wrote:
> Add initial support for the HDMI and Analogue i2s audio outputs.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   .../boot/dts/amlogic/meson-gxl-s905x-p212.dts | 70 +++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> index 2602940c2077..c2bc7cec476d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -7,11 +7,19 @@
>   /dts-v1/;
>   
>   #include "meson-gxl-s905x-p212.dtsi"
> +#include <dt-bindings/sound/meson-aiu.h>
>   
>   / {
>   	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
>   	model = "Amlogic Meson GXL (S905X) P212 Development Board";
>   
> +	dio2133: analog-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		sound-name-prefix = "AU2";
> +		VCC-supply = <&hdmi_5v>;
> +		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> +	};
> +
>   	cvbs-connector {
>   		compatible = "composite-video-connector";
>   
> @@ -32,6 +40,68 @@ hdmi_connector_in: endpoint {
>   			};
>   		};
>   	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "S905X-P212";
> +		audio-aux-devs = <&dio2133>;
> +		audio-widgets = "Line", "Lineout";
> +		audio-routing = "AU2 INL", "ACODEC LOLN",
> +				"AU2 INR", "ACODEC LORN",
> +				"Lineout", "AU2 OUTL",
> +				"Lineout", "AU2 OUTR";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";

You can remove this.

With that removed:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +
> +		dai-link-3 {
> +			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&acodec>;
> +			};
> +		};
> +	};
> +};
> +
> +&acodec {
> +	AVDD-supply = <&vddio_ao18>;
> +	status = "okay";
> +};
> +
> +&aiu {
> +	status = "okay";
>   };
>   
>   &cec_AO {

