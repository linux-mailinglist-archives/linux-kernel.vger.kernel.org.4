Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21182726A79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFGUNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFGUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:13:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671D1BD2;
        Wed,  7 Jun 2023 13:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686168818; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IgYpLoYI88PuP7oxfU+8D4Mhwlf11riVuWY+c/S4acRK5JxvpsBe8T+gcsWrF8e6G0
    tZ96s1GnnU3oT0633I8uVLZzNy7ZlOY8y5cfq18YJQIsM0sbgrJZnYVgOnVyMtL9iYtB
    7n+BktHbK1A4CsXak4/t+kmEqV6NQWA+j523Xq9GctriMU3y9b4EyDfn1S9jEmmfyL/T
    uTWQ5eLeKS/sZ7ZHgSUsNcC/y5L97pQ7ZTv5ggn6wyFtmK0ori5YFhzf12aae9U1xYmE
    P9F2vI+e39Vmrm976jy6/sV5r5TMIkPmkkRzkSfO0fIobnTS9bpOYtearNtjq6PLZBnU
    bdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686168818;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=57dNky1WSV1Gg88IInb1YHiL1a4+3LhzPgnDq+D60K8=;
    b=OwIqBTNR9ZNuhi8Ye8BWlVbEioO1f+GW3LWuUrEPfVyVdLgamjFdcJs7ZSwnfvOmS6
    NPRKA0AUknbYZIf7wXbvu2/2BNvOMWMGsFYRWlltlceYa6EU5OkbzBGqtC4jFS9Wjpj8
    CT+HDbYigfGOHP/xHKU7Cm1RSTVlHjCeXXUOlcOoFasSMDX4PkZC1UCNx09hDwHyG0bd
    cF5qCOo4GT1tmdC7I6KGdw1AxlL5OzOS0Tzr6VtCt08YDgKjQVJvXzY+QNritlSsxMjX
    wzgoLX7aTgqLkx08MIr/PDBJk7WIgiEPSD1pirDLm+siFrFeMMfA3jl+OB7Bjz0HYvMr
    xIEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686168818;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=57dNky1WSV1Gg88IInb1YHiL1a4+3LhzPgnDq+D60K8=;
    b=I6JUq0CDJklqAcoZOxdxAtL6Zj4UHUnjdHrrXdfUDjCN78oqZu54vRRbyL3qCG9HY+
    lb67vsbYpotNGwB6MqDRtDlOwTPf2VRqp8jM6NSgo5c2ZQRm93CooXOtDltfFrHCIQND
    3P/UWIYeHZrwfT+ZbyYcTVNi0LfZ+hMYDd5MTFvEyswZlPCbQRHo1tYl27U+A0Ku0BMN
    VhSp7EvRuuuBrAS/o0tvMtyYQ3Nl3A1ruGDwJLSzuDuEG7exbH7COnd62xyxlNizouwq
    9AMfJgerSa7qFfjOQ8ZzBtlPUk2kKHKPxRuC+hsQgQgWUXQ4mADwcXWptZiXe36WJyke
    vkjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686168818;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=57dNky1WSV1Gg88IInb1YHiL1a4+3LhzPgnDq+D60K8=;
    b=5Wp5JDjxHOyWgKqDfdrOLGs8gn/L0w2FNCmiGx2FXcZdEo8uoerXFFqMSZ9wu+wEiU
    BEB/ymXAPhjl1b5dMdDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z57KDcJdM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 7 Jun 2023 22:13:38 +0200 (CEST)
Date:   Wed, 7 Jun 2023 22:13:30 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm2290: Add CPU idle states
Message-ID: <ZIDk6hdFJWIMesqR@gerhold.net>
References: <20230606-topic-qcm2290_idlestates-v2-1-580a5a2d28c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-qcm2290_idlestates-v2-1-580a5a2d28c9@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 01:04:19AM +0200, Konrad Dybcio wrote:
> Add the (scarce) idle states for the individual CPUs, as well as the
> whole cluster. This enables deeper-than-WFI cpuidle
                                                     .
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

FWIW:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
> Changes in v2:
> - Add missing BIT(24) ("last in power level")
> - Use the correct CPU low-power state (0x3 instead of 0x4)
> - Link to v1: https://lore.kernel.org/r/20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 61 +++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index b29bc4e4b837..0ed11e80e5e2 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -48,6 +48,8 @@ CPU0: cpu@0 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -65,6 +67,8 @@ CPU1: cpu@1 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -77,6 +81,8 @@ CPU2: cpu@2 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -89,6 +95,8 @@ CPU3: cpu@3 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>  		};
>  
>  		cpu-map {
> @@ -110,6 +118,30 @@ core3 {
>  				};
>  			};
>  		};
> +
> +		domain-idle-states {
> +			CLUSTER_SLEEP: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000043>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <2118>;
> +				min-residency-us = <7376>;
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <290>;
> +				exit-latency-us = <376>;
> +				min-residency-us = <1182>;
> +				local-timer-stop;
> +			};
> +		};
>  	};
>  
>  	firmware {
> @@ -135,6 +167,35 @@ pmu {
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		CPU_PD2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		CPU_PD3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cpu-cluster {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP>;
> +		};
>  	};
>  
>  	reserved_memory: reserved-memory {
> 
> ---
> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
> change-id: 20230606-topic-qcm2290_idlestates-5b6062b0f4c6
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
