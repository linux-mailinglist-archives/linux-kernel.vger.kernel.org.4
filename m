Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE573C5F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFXBn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjFXBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:43:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23D273F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:43:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so1748046e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687571004; x=1690163004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJu328CuD0FpfwTO8re7cLemAMEGjdbgxO2wkNCuWs4=;
        b=Huvl/IsXBiNB6PHLiIGpsqlH//TabGsHUSokzqBsuO084KzFFFGnVpjHZ8I8BApZtC
         4nh5NY4dsFx2IhnOMvm5a6UvhPhznMX7vYaCung0sKFyh5sZJa3/YIsSsW3HTMbdFaGz
         xddKwRGKx8Oc57sGO9eNdU2I+f6sUfwgyfbFOo9tqWZWYvnXaPn29Z93WBxOM3ecgJpm
         8oPpvVMYAM7Ai12qSJzvEgopRO32Vwc/ZLVs/JGem5iQ2LsQ3bc5eJ95ejyMnei5LThW
         crFnDFVwBuvADU5AI2PFD8L7zIErCvJl6h4PPaWd9sIPH+ly9qnGa2iD71Sass4C8MTL
         NMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571004; x=1690163004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJu328CuD0FpfwTO8re7cLemAMEGjdbgxO2wkNCuWs4=;
        b=A7vOLJT80swYsspsPaDiP+VAsnhi2kHXt5vNwdj/Wz/VTiU9UXKrIHDuf+jhoO2pTf
         ZCO+tTL01M8Ue31+py9MsYuiYNvCpO5jntw4HrUvdtGPUs9UPzMhwZmctX6Vz2zDIUnl
         /5g5fx+oIZmsHIGwekk/+57CsVgQ3mCtTzqVVv2a481QG5GggnbeFjmBEFh1rngVIaoU
         hXKfHocyFmBcnnBXGFjWH7x6Py3iEYrDPmwBdEWEUoeURAoZPzdGevaLfUuR9kBB6PIX
         ZZy60oHWlNnHYp8wMeqiI2wC4mmtYOieJfjXKfcjf81lv3QauPS5lktU1I68d9SBPRlz
         ARnA==
X-Gm-Message-State: AC+VfDyKYxwcTcT1LvwjaNqB0y8SFzuuIz8WHlyi1WyuEc78eoIHbao+
        16ILzvKqmX9iT22hBdCT7JcMpg==
X-Google-Smtp-Source: ACHHUZ79nWqogKy/8Yh1jokr5cO+Vt//UYSZuqtf/o9Edq3PDMHTZ9jAcj594JH3NhOIPESHp42T/g==
X-Received: by 2002:a19:6755:0:b0:4f8:57b8:8efe with SMTP id e21-20020a196755000000b004f857b88efemr14798210lfj.55.1687571004247;
        Fri, 23 Jun 2023 18:43:24 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id g4-20020ac25384000000b004f26f437ad8sm99250lfh.53.2023.06.23.18.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:43:23 -0700 (PDT)
Message-ID: <a2a79b58-c7a9-9099-028c-5ca79cf8f711@linaro.org>
Date:   Sat, 24 Jun 2023 03:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/15] arm64: dts: qcom: sm6125: Sort spmi_bus node
 numerically by reg
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-1-1d5a638cebf2@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-1-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2023 02:40, Marijn Suijten wrote:
> This node has always resided in the wrong spot, making it somewhat
> harder to contribute new node entries while maintaining proper sorting
> around it.  Move the node up to sit after hsusb_phy1 where it maintains
> proper numerial
numerical

sorting on the (first of its many) reg address property.
> 
> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 38 ++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index a596baa6ce3e..722dde560bec 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -679,6 +679,24 @@ hsusb_phy1: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		spmi_bus: spmi@1c40000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x01c40000 0x1100>,
> +			      <0x01e00000 0x2000000>,
> +			      <0x03e00000 0x100000>,
> +			      <0x03f00000 0xa0000>,
> +			      <0x01c0a000 0x26000>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
> +
>  		rpm_msg_ram: sram@45f0000 {
>  			compatible = "qcom,rpm-msg-ram";
>  			reg = <0x045f0000 0x7000>;
> @@ -1184,27 +1202,9 @@ sram@4690000 {
>  			reg = <0x04690000 0x10000>;
>  		};
>  
> -		spmi_bus: spmi@1c40000 {
> -			compatible = "qcom,spmi-pmic-arb";
> -			reg = <0x01c40000 0x1100>,
> -			      <0x01e00000 0x2000000>,
> -			      <0x03e00000 0x100000>,
> -			      <0x03f00000 0xa0000>,
> -			      <0x01c0a000 0x26000>;
> -			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> -			interrupt-names = "periph_irq";
> -			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> -			qcom,ee = <0>;
> -			qcom,channel = <0>;
> -			#address-cells = <2>;
> -			#size-cells = <0>;
> -			interrupt-controller;
> -			#interrupt-cells = <4>;
> -		};
> -
>  		apps_smmu: iommu@c600000 {
>  			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> -			reg = <0xc600000 0x80000>;
> +			reg = <0x0c600000 0x80000>;
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> 
