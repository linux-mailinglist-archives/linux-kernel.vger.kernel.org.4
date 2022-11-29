Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5963BBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiK2Iha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiK2Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:36:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634025A6DD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:35:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r66-20020a1c4445000000b003d05a3775d4so4253830wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nFrj+28YyuR0eqY1nguFSdC/SUrYraG5B7QZglg6iPA=;
        b=ujNxPiyJBK+27e2UV5LExF7tASbXCmHBTpWP/RH/a2N/b3EbR9zCXcPRw52zCramKL
         b/T14DR90xpGsLypzyiwFS893323AO+s3BlDak017FuHP1E51BRm/s8it43KHe/NbzLs
         xP68JSc3OFe1G6cJbjNX6RS/H7GQY++kVDMsWV2im6N2hRffagou4am1CWRJjm1UXIKF
         zw73TChC5bnKS0T1X1yY9lpTfZC61L9sbGFGa9moVTvwEz0BvVm2hd8PCnNbbV9rk8P2
         x0ymg/G3bsDoAuLeRon5Ch9+Ts1z7i682/9cNO5HD8k/cBOM5fUSocVgZUoUT3WQakmZ
         Kbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFrj+28YyuR0eqY1nguFSdC/SUrYraG5B7QZglg6iPA=;
        b=gd3U3hJh8suZOltfQzN2dDkTdT8OJrgWLq6sszSpOdx033Wm+A4yRdOSbCWwwmhKGW
         /cBgmyiImdWHOiLQ897P/FfbeGZq2X93IC18ef395pBEwcS3D66jhvb1erBgK9b7Dgzk
         6rs3DS3CZqkKVuaadE/amjzKDpx2tkG53M+D4OhIAUI/nKoYykC3Ac02zZe0YOnv1iWS
         6on86iUXiLWts5Bhkr6NaJVHjmFHnYlP+xdlvfpfTUf310D7RZAYE/DHHxzgFhO02Eqi
         NX+eFUNAu35MEMylAVGL1zVCbvN2ZMYAqfzWG2HQOb0iL5Pgvn+uQnDd0u8t9dfxHBIc
         Ssyg==
X-Gm-Message-State: ANoB5pkgl/w2um6nDjAqlfQjp02fOmm87l0j3zurq/RZLJJaOjnZ13K/
        4iKLgrWe959oBnvLHdVXQ22xXw==
X-Google-Smtp-Source: AA0mqf5jyfHXkfUmC+Gip38Uos2hKiuERdUVeokOAKcyV7egdfjw73V5ejHd9sGDUqNPJniods1eLg==
X-Received: by 2002:a05:600c:2302:b0:3cf:a3c4:59b3 with SMTP id 2-20020a05600c230200b003cfa3c459b3mr33009149wmo.198.1669710923877;
        Tue, 29 Nov 2022 00:35:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b00241dd5de644sm12981186wrn.97.2022.11.29.00.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:35:23 -0800 (PST)
Message-ID: <f69c9db1-6274-6caa-e3bd-92ae4a7bff19@linaro.org>
Date:   Tue, 29 Nov 2022 09:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/5] arm64: dts: Add DT node for the VIPNano-QI on the
 A311D
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
 <20221128111740.39003-5-tomeu.vizoso@collabora.com>
Organization: Linaro Developer Services
In-Reply-To: <20221128111740.39003-5-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 12:17, Tomeu Vizoso wrote:
> This "NPU" is very similar to the Vivante GPUs and Etnaviv works well
> with it with just a few small changes.
> 
> v2: Add reference to RESET_NNA (Neil)
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     | 11 +++++++++++
>   .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts |  4 ++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..aaa629816e41 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>   #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/power/meson-g12a-power.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -2484,4 +2485,14 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	npu: npu@ff100000 {
> +		compatible = "vivante,gc";
> +		reg = <0x0 0xff100000 0x0 0x20000>;
> +		interrupts = <0 147 4>;
> +		clocks = <&clkc CLKID_NNA_CORE_CLK>,
> +			<&clkc CLKID_NNA_AXI_CLK>;

Nit pick, but this should be aligned.

> +		clock-names = "core", "bus";
> +		resets = <&reset RESET_NNA>;
> +		power-domains = <&pwrc PWRC_G12A_NNA_ID>;
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> index 124a80901084..73f3d87dcefd 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> @@ -15,6 +15,10 @@ / {
>   	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
>   };
>   
> +&npu {
> +	status = "okay";
> +};
> +
>   /*
>    * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>    * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between

With that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
