Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27F64F94E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLQOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLQOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:25:48 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629410C6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:25:44 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s10so4970207ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbkQiFOGaUTxjVfMNbHPRgK4jY57Ynyi5LA7DMw6iGs=;
        b=i13UUw/qhReRwrqL2wm6Slq8OeTCbX4r2X1YqZsDGN909O0GDRgqmClAZehsNrOUfe
         j8ehCr0WdpoFV/UumV9+t7QDdrfHSt78ve8lzcfOMl8EzoG9bW+9uRjawht36GnArN9d
         QYThTxMghwgR0NyHrJoetyv3sCBsnMZ32WvornpMIToVAj8AUpkWhSA0pndpmJt6FNmH
         94aTUgge5Q7pZQEeGz52/BM0swwGaDZtbo3+uCPb57BLs9ilmhS+EhfrBF5+T0DwlNMb
         oVdnylK3ccjS7XTFCoLV+VtD32WihPmJFB3teag1AoKJUHBUZN/G9sKMPykZaI+DJnQN
         XjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbkQiFOGaUTxjVfMNbHPRgK4jY57Ynyi5LA7DMw6iGs=;
        b=5uZ0dkjl+wIaiSEgf7x8gHCEC9erFSlavz/K7v558G7NeQ+myZSzfFkdAFMRMgG+xC
         OYVSCxY0nY6x3jpLAHHde9pu3V/WwT7jhrmR5q4KL+yjfjEszpbKK2t7LnSma3YYmETT
         nTfdxWc+PW2voGXI9LH9ry94vFIRMhaAPPG+3eMfnMY7CHa6dtBa/Fe7z40mDMzIvExZ
         OTCAwttQkv+4py9Zf/SUZVvH1nsyNFUZl4m1BegtL6/CNpFcK71C0qOxWoJzy63CEjpc
         5NHsQV9vEfiLFAzxwM7dyp0qQZdlhTwowwwuAgRX/aYttH7+3PUR67EPms51GaBAXjPx
         LQew==
X-Gm-Message-State: ANoB5pnzZBRBqmjx2gcKsp/1noZ4k6ERHUAtcoFQg/Byl4AYUJVyPqJc
        eMlPCmibY2qcfVigZljHMLgHmQ==
X-Google-Smtp-Source: AA0mqf7xrFRwNMGb2RtvbMR7QSO+gl/dwgUlXXZ4xE24Pvbi68yb3d5sVWaljwReIh3irB0dFAUupg==
X-Received: by 2002:a05:651c:12c7:b0:276:103f:dc36 with SMTP id 7-20020a05651c12c700b00276103fdc36mr14388214lje.1.1671287142491;
        Sat, 17 Dec 2022 06:25:42 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id z14-20020a05651c11ce00b0027f770526ebsm106761ljo.75.2022.12.17.06.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:25:42 -0800 (PST)
Message-ID: <a20b17b5-385d-ec32-8fb9-beaa3b2fde15@linaro.org>
Date:   Sat, 17 Dec 2022 15:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Configure APPS SMMU
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216215819.1164973-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.12.2022 22:58, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add a node for the APPS SMMU, to which various devices such as USB and
> storage nodes are connected.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: add the new, generic, "qcom,smmu-500" compatible, add patch
>  description, reorder # properties]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 73 ++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index bf9e8d45ee44..347665c2067c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -573,6 +573,79 @@ spmi_bus: spmi@1c40000 {
>  			cell-index = <0>;
>  		};
>  
> +		apps_smmu: iommu@c600000 {
> +			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0xc600000 0x80000>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			#global-interrupts = <1>;
> +			#iommu-cells = <2>;
> +		};
> +
>  		apcs_glb: mailbox@f111000 {
>  			compatible = "qcom,sm6125-apcs-hmss-global";
>  			reg = <0x0f111000 0x1000>;
