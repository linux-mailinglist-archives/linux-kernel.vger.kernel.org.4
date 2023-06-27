Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4A73FA80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjF0KuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjF0KuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:50:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEF10F9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:50:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so37371521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687863003; x=1690455003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQv8jcNHh6YGNnlPQUGLzOBcoLFIikNnZeDEV9jIllE=;
        b=I1/SnR+94qSszD2rk39YnXZ8XbSPuKL50mLsB+pFFJiP2M2LxPPvjBQbnaMMD6iUq9
         S6ftvJIYGDSSyH4LVT0UGta88GFlNVZAopStGwpsXEXyBn5ZEW7BFVughnH35fTOOVfq
         BOxbPyr3dKdi9zJ+jVJ72j4OKTkbNqtJGK9GEz7ByeEHf7KDn4DeWvlGHymavEqgHw3z
         49AI3ZPkYkdVtwtSW/xNYDZP6+jbTlukcAV08qa779h9qzPKs1vYKgJj+SX/UbNS7MG2
         VlAhKrz+4iiZm7fw/alKUZANqjS9jOSO44gBDulpUVnodCDUd4zBC5Fmvya4u3UAA/3v
         suPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863003; x=1690455003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQv8jcNHh6YGNnlPQUGLzOBcoLFIikNnZeDEV9jIllE=;
        b=gZX46eoqRjl7HuGr0JkEnWK0UIoGkNU1O85/I/T/lQYMOHexlEF2y3V8GG7XJybasy
         E4CEoIMdZCoxNXfH7FbdgyKUCGjl3KOsnChCeootFRf5JsfLam5YiHfbkuYsYmvNpmio
         zoENV2RQPo4t7Vki/boGe64QERg4+Jl1cQW4+vOxWzTWUXK1UYJjkWPXdvSWixtIh0to
         GNqerpeni7gJb0VZpBDWZOOHaOBec3l9OMybJhDZAWDXkT/yWY2m98eFAhXxTT1qCuHE
         +jkdcEXlopXehJ6HyufB0zisj5757GRWgZghAxZTFDHO8/qnXandV3f6wZqCfSxQWpcB
         AExw==
X-Gm-Message-State: AC+VfDyIqESBQAecyraXcWBeOmES/FB4jxUPhUt1fW5I3H6HjWn/l96N
        9aZ0GKyDkBt/d3tymA1khrNC7A==
X-Google-Smtp-Source: ACHHUZ6t6l7fOHIrIW46zWuLD2Iu76LSS65MwKBWE+RVz74CzT7mQvevBJCJrn7gsgmdnwErwsyJ3w==
X-Received: by 2002:a05:651c:1184:b0:2b6:a662:b874 with SMTP id w4-20020a05651c118400b002b6a662b874mr1465095ljo.21.1687863003476;
        Tue, 27 Jun 2023 03:50:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e96c9000000b002b6988ca476sm1479046ljj.101.2023.06.27.03.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:50:03 -0700 (PDT)
Message-ID: <fcd71b48-bfe1-6307-ae40-544daf8afa67@linaro.org>
Date:   Tue, 27 Jun 2023 12:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: sm8450: Use standalone ICE node
 for UFS
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
 <20221209-dt-binding-ufs-v5-5-c9a58c0a53f5@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209-dt-binding-ufs-v5-5-c9a58c0a53f5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 10:28, Luca Weiss wrote:
> With the ICE driver now merged let's convert the ufs node to use the new
> style.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5cd7296c7660..79627117a776 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -4120,9 +4120,7 @@ system-cache-controller@19200000 {
>  		ufs_mem_hc: ufshc@1d84000 {
>  			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
>  				     "jedec,ufs-2.0";
> -			reg = <0 0x01d84000 0 0x3000>,
> -			      <0 0x01d88000 0 0x8000>;
> -			reg-names = "std", "ice";
> +			reg = <0 0x01d84000 0 0x3000>;
>  			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>  			phys = <&ufs_mem_phy_lanes>;
>  			phy-names = "ufsphy";
> @@ -4147,8 +4145,7 @@ ufs_mem_hc: ufshc@1d84000 {
>  				"ref_clk",
>  				"tx_lane0_sync_clk",
>  				"rx_lane0_sync_clk",
> -				"rx_lane1_sync_clk",
> -				"ice_core_clk";
> +				"rx_lane1_sync_clk";
>  			clocks =
>  				<&gcc GCC_UFS_PHY_AXI_CLK>,
>  				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> @@ -4157,8 +4154,7 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<&rpmhcc RPMH_CXO_CLK>,
>  				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>  				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> -				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
> -				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
>  			freq-table-hz =
>  				<75000000 300000000>,
>  				<0 0>,
> @@ -4167,8 +4163,9 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<75000000 300000000>,
>  				<0 0>,
>  				<0 0>,
> -				<0 0>,
> -				<75000000 300000000>;
> +				<0 0>;
> +			qcom,ice = <&ice>;
> +
>  			status = "disabled";
>  		};
>  
> @@ -4198,6 +4195,13 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		ice: crypto@1d88000 {
> +			compatible = "qcom,sm8450-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg = <0 0x01d88000 0 0x8000>;
> +			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +		};
> +
>  		cryptobam: dma-controller@1dc4000 {
>  			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>  			reg = <0 0x01dc4000 0 0x28000>;
> 
