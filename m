Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA52F6E20B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:27:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331F4C22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:27:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id si1so14233491ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681468068; x=1684060068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfsBlxdTSJzQBTJl1OQ8F2O5M+aBu5tpSg3iXmktVXg=;
        b=AF4HzdJP7Aw9KCPftS4DVfNYmqMCqiiYUSVCkM8WQyc2XPxROjGGKsGcT/xeeYTKpY
         8/14/qT3Zc0de4dg5rWYtABdHgnbxE2/LCyCqwNr9KPO+UUzsJtFxaNgh4al8PhfUoAN
         /xrWEJ2umqth+7YriTNHDTfpkTBXYZyYqjWF3E/XlziPjp7HLMDUl/ZOVfntgYVeRu8a
         U2EBVCKahePEqWxpoJS4bDwHinOVgJ4j6ezqJ+JiwRebuiU6IEQlkpoHwpefs1Y77Ti4
         hIcd33ZPFe2hsEPgJM8n7L4hCROi6KqyHdP5fFT0nu0MWEI2zlL0MBnfxGrXsKxG7VGr
         FiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468068; x=1684060068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfsBlxdTSJzQBTJl1OQ8F2O5M+aBu5tpSg3iXmktVXg=;
        b=UWoD5pDB8XIk6/EqrDCApV4Jq7F8tKXTBpXgqPAmyMCosoXVruZYJdOTij2beh4+Jz
         Flr8j9wZnVjPlm8/YqI5b6YLe5eQoXQxTs/QAk2l/ss6H/4DBfjtM/kKHGy6V33B2tL3
         3piqmcTMoV0UrN4AXkOmDLZQ2pcWk5tvFf7yiDanYIV56MKyiqSkVlb8q1qog3S/MNPb
         HYxBYx1gjvTYUUGxCZQC3utLKZgU0sfwZrBQIhKo9OosGWsQ2M/ryRXqOOPfI2EZgBnm
         x7Uxd+/TQAvHa5kYnAgfJKuEElbRAhVf8jmKGAI9PwMP2q1TB0TwWS4a7ong+q1YlrqG
         SoUg==
X-Gm-Message-State: AAQBX9dC8111F2GFkN4BRvFFzvVha2cOkIRirrLoNQYOxKt/448uE001
        wOnKXjxactyaoDCtOS5SDj55hw==
X-Google-Smtp-Source: AKy350YwjBYY/9l54IU4pggStT9CGvMLLTI4ZvcV36eCKzr4rR2yhO8Ku0K0cb8HDXLUNgTntWGhvw==
X-Received: by 2002:a17:906:7f98:b0:87b:6bbb:11ac with SMTP id f24-20020a1709067f9800b0087b6bbb11acmr5167654ejr.60.1681468067936;
        Fri, 14 Apr 2023 03:27:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090679c700b0094a8aa6338dsm2294826ejo.14.2023.04.14.03.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:27:47 -0700 (PDT)
Message-ID: <0cbafc31-9b46-54df-f569-810a8781743c@linaro.org>
Date:   Fri, 14 Apr 2023 12:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add vdd_cpu_big regulators to
 rk3588-rock-5b
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-4-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414093411.113787-4-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 11:34, Cristian Ciocaltea wrote:
> The RK8602 and RK8603 voltage regulators on the Rock 5B board provide
> the power lines vdd_cpu_big0 and vdd_cpu_big1, respectively.
> 
> Add the necessary device tree nodes and bind them to the corresponding
> CPU big core nodes.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 8cc97d146a73..3e4aee8f70c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -53,6 +53,62 @@ vcc5v0_sys: vcc5v0-sys-regulator {
>  	};
>  };
>  
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";

Looking at your next node, this is surprising... Double check if you
have correct compatibles everywhere.

> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

