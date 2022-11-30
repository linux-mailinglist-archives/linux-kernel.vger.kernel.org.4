Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5263D44A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiK3LT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiK3LTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:19:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDF7B4D6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:19:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so26430040lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFIsvT51Wrc8AEADswZ6hxeryUff3byVSUzrQJGoVfU=;
        b=le4Xch2nyzzeVwKz1M51EeNRrUpaFDtDX4QhagI4NpvHnJB0sNgYhXN6WyGosXu0v4
         JFZrmNOARyq6gmK71OV9JtVhyyyxMfX2OH53yAoP0UmMoKsIC+Dgbvcqz9nr9bFVIn3w
         GALvD9/6mlGGnJ4h9YbLWAHSST4hyv0JF46tlVrQsh9WUQ1GLOIC+JVvAfmOj9c7bRXe
         J+Jmmt6dTjwvU2QYi00UXezUr6jmzL3Vfysk8Lt3PC/8DcU0lj6uo2OiEDxnke45/Jnk
         fzVNX9SH375kJYT64T6Pvn9HAXc1W+NFjZVkZnTQQoYxyiDHKxmaXZbmtoa2pROfrmTw
         OXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFIsvT51Wrc8AEADswZ6hxeryUff3byVSUzrQJGoVfU=;
        b=lo6X75UBa4HpCb+VT18Dfhwkjpakshha6J+IkWcW7f+aABGIcKikfOz2juBLOZTF2+
         iprOxEITauM2/DRFiiOWQNk0mC/z45jntN3+vhm1xRYf5HedDG7q2hiAVBcw9duKqICQ
         rAkFiTcSOmY+RBgn6YWFOD13WDwD7IJKXW4BAzhO9Qh5so1evA3Svhmr7fTAEV+hM0Sl
         0VWCbxZHG6M2XYVP9K03g/wiZ8OjASsnN02olkt6ZU75jnWZG1cZOky+/MrATzGyuxud
         tSTazV0hxEa3lz6y1RcsTSDPUwSyTq1goM2WiST0B7dR0EXJ8ITbHNYhITP/QO0EcFnY
         mcgw==
X-Gm-Message-State: ANoB5pmlSKjdFbe+BAfhD4BNeitLFi5KWrNP3tWwlBtixtsnn/H6HQUT
        /60l8c9V9pujC/PhJ2Omv2kBrA==
X-Google-Smtp-Source: AA0mqf67B1mIb5Epz/uGwtDLk61Rrh2XaO7mJ8+jxYGJKFGyDEEac/5JzzDcVDLFTU2zghbg3tWW6w==
X-Received: by 2002:ac2:4acc:0:b0:4b4:10ca:5240 with SMTP id m12-20020ac24acc000000b004b410ca5240mr22167633lfp.482.1669807142405;
        Wed, 30 Nov 2022 03:19:02 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id p9-20020ac246c9000000b004b01305732bsm216973lfo.216.2022.11.30.03.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:19:01 -0800 (PST)
Message-ID: <72aede7c-deb6-6ec8-0a8d-c27d2c26e1f2@linaro.org>
Date:   Wed, 30 Nov 2022 12:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/12] arm64: dts: qcom: sm6115: Add GPI DMA
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221129204616.47006-1-a39.skl@gmail.com>
 <20221129204616.47006-10-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221129204616.47006-10-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 29.11.2022 21:46, Adam Skladowski wrote:
> Add GPI DMA node which will be wired to i2c/spi/uart.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index b459f1746a7f..e9de7aa1efdd 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -673,6 +673,26 @@ ufs_mem_phy_lanes: phy@4807400 {
>  			};
>  		};
>  
> +		gpi_dma0: dma-controller@4a00000 {
> +			compatible = "qcom,sm6115-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0x04a00000 0x60000>;
> +			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels =  <10>;
> +			dma-channel-mask = <0xf>;
> +			iommus = <&apps_smmu 0xf6 0x0>;
> +			#dma-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		usb_1: usb@4ef8800 {
>  			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
