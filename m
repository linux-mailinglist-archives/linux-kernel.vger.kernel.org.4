Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E665AF16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjABJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjABJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:53:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F3300
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:53:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z16so9394653wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l+/g4OFevxQxj3ZDU3ipz6hKywBVT0qBoACJLcSqq4M=;
        b=uPhtFfxGx1PHn79fSh6g5TqdHIc5I+mE0Euh7ayeA62uFN0W6iPkzaWlzJnjAOukBz
         YfTAaMZrv/XYHR+FPBk6IC6fQGfKNloz0/DcMXvE0M8iym3aErj+VFJTJplo6xEQhhwj
         X2VsICQEDqqMAnRfyKKDBEqK53hNPGmvuMyd6J3ywo5JXTln8+F5DrD82ISz2vPvUMhg
         TZMnew8tvPBwYC180/DivQ/V5vLziCsxisWQqgayu94oVA/34OzPyq0aV5FwYarYoVq3
         PJi0ddgIO7PJtNkl/0Bgp4nFHVI69CSHNESYzCGn1MRNFLPFHdhX5dSyuGFYN/ezPVH+
         2ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+/g4OFevxQxj3ZDU3ipz6hKywBVT0qBoACJLcSqq4M=;
        b=riJFIL1NiwLOCKPSE597g0o6YyVj6APvMddWdjPsdxSGuaiGOlfrxGs4dIcwDrBYVu
         ssZLdQRbDKbaoE9XLC9cC+Kof9Ze88Fx//8h3GxopGjaDVvW6Yg4wMz9o1hzSgEsBYF3
         /RaT1Xh84IRKAF+R8j4PePEk6DahS4mDruL111k8AGxhIjrNOO5xMO+5dpHJC2FKSs3u
         BqkHXqVgPRdlmEqlmJRsIVKuxPzaQV+3a7eAqm8perAMrRY7d/0lAUQ8Y4AAOZQHf18J
         fA+7lGoHndootEe46ztsBT7q/lHLd7c5Zy2wdXQsEwGsnKnABzATMFmr2IJfD9/hugVZ
         ItDg==
X-Gm-Message-State: AFqh2kqf70eONEa5/LlRUWDD9SuDDeHQbSCYTWhsKjpOV2v2LfIrSrPf
        SQLLJMYjIezycmsSx4BSs+w7Tw==
X-Google-Smtp-Source: AMrXdXtn8MnvQhXsoUddUydMeU25/PmnIRF88UjZXtcC/hZzFGziSqo12v8zKsIJJzFrTNvZ08M9YQ==
X-Received: by 2002:adf:ee83:0:b0:270:213a:b53d with SMTP id b3-20020adfee83000000b00270213ab53dmr23568623wro.33.1672653234797;
        Mon, 02 Jan 2023 01:53:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4f32:f70:35be:acf9? ([2a01:e0a:982:cbb0:4f32:f70:35be:acf9])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d468d000000b00275970a85f4sm25889021wrq.74.2023.01.02.01.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 01:53:53 -0800 (PST)
Message-ID: <5e5babae-224d-51cf-4eac-6272df87a8e7@linaro.org>
Date:   Mon, 2 Jan 2023 10:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 4/8] arm64: dts: Add DT node for the VIPNano-QI on the
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
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
 <20221202115223.39051-5-tomeu.vizoso@collabora.com>
Organization: Linaro Developer Services
In-Reply-To: <20221202115223.39051-5-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 12:52, Tomeu Vizoso wrote:
> This "NPU" is very similar to the Vivante GPUs and Etnaviv works well
> with it with just a few small changes.
> 
> v2: Add reference to RESET_NNA (Neil)
> v3: Fix indentation (Neil)
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     | 11 +++++++++++
>   .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts |  4 ++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..61c8461df614 100644
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
> +			 <&clkc CLKID_NNA_AXI_CLK>;
> +		clock-names = "core", "bus";
> +		resets = <&reset RESET_NNA>;
> +		power-domains = <&pwrc PWRC_G12A_NNA_ID>;

A status = "disable" is missing here.

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

Tomeu, I think until the user-space stack is clean this should be removed
and left disabled.

I can fix this while applying if you want,

Neil

> +};
> +
>   /*
>    * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>    * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between

