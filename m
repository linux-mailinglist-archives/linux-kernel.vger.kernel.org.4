Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73434724E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbjFFU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjFFU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:26:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C78B0;
        Tue,  6 Jun 2023 13:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686083193; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gs+J12EncTVtxIWLeg/NHtjR3DE5Ea3zVH+suiZPMjU05IVcwbzmiwBCI9a+1aY4Iq
    yOP+txfCgZIBYFifmzwS0xz+kUEa1hgFcEDgwicnuv/9RLEPeF311wO1lJsaF97NaAlN
    dxvDMDgf1q1xnKnGjRIUJ05lA3OiPt50Ay7psbf+ngHxjaOp8ectEglQCZAv50Opsiyd
    eEb9sQHZr58G63ojVcnCzszEkLVYbgjBAvUrkFNCLxdERqlNTKvqZybXGbK0yXROm6X+
    rYEvS0WAeICgi7TqV+Vy+upkuzbgE/kpxWNRiaUj/fSQb7epRWinY3X3UI3ZE1A4Bvyv
    ubiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686083193;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iDJzI5oKdv+thU5hp010LolTdr7zN3lfCn9865pYEj8=;
    b=r69BNV9Oy4qgdz2a0deQGXKBoFzmXArHqJRGyrWwp1sHcVnZD2Nb7URp9BBOnCuxd4
    vMLSn6KKGHfq01ihMFPqbaaHyJ2WoL0W0C6KLPuzmefiu9xOcX0MaUytjpMBBfjKTiao
    U3ErQ+QzyOdEKer4rfgOiUJuGWwLtJrlFqJCobTbGeESmHkVaj9w14ClXlN7i6+5/JTV
    tJCSc/cuAFe9wckibFzU67tW0DBTYJfpJCUCOeW0s0UYmTKgNWqH5NhyPDYBFJQZ2MTd
    PNfnnzgUbf9gmReulcMHo2KE9ypXFYOABiR7417PhcdGXlDoIs9oqrOAJ2wS3iy/wmxr
    d97Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686083193;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iDJzI5oKdv+thU5hp010LolTdr7zN3lfCn9865pYEj8=;
    b=C9lnzINgMG6Nrop+aMVa2FkmSkgBdFlVsKC/zuNsOd68VisjU6zt32PSIoDYvqwczB
    lWIK0v71BctpQgyq4kxoP4DlGAJrBWh6DfVBkfAVPZv12PZBZf7MLWE6tQq0rqPX0lmi
    UaPAaE7+JrbP0sw3/5INW/IP1SjgZ/yx/MhvpRtwdwTZzn2hWDexf4s4YJLNcgrrgeBk
    gojYBLyerxTANuwc1boFi5KB9L+GIdO1/hDENi4Eoer4yHKWEYfebVT9JBmwr57/XlnT
    fwU5yLU0EvCf+9FIyQi0SpViSM49lxknQRVrYU1wZbtC0l2d/CZ8YMfrNAmm4jC27MAQ
    pAkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686083193;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iDJzI5oKdv+thU5hp010LolTdr7zN3lfCn9865pYEj8=;
    b=EfTYZKHPEfDUJlSINg07z/9Dudv4iY1nbNqCyyvVWUB4i1ccPEe/u/gGkdC7O1XgvS
    G2dyTkAwBkBTgq2W/ZDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z56KQXFqu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 6 Jun 2023 22:26:33 +0200 (CEST)
Date:   Tue, 6 Jun 2023 22:26:27 +0200
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
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add CPU idle states
Message-ID: <ZH-Wcxy3aev9hjBU@gerhold.net>
References: <20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 06:15:28PM +0200, Konrad Dybcio wrote:
> Add the (scarce) idle states for the individual CPUs, as well as the
> whole cluster. This enables deeper-than-WFI cpuidle
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 61 +++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index b29bc4e4b837..a8a1ce58c0b7 100644
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
> +				arm,psci-suspend-param = <0x40000044>;

Are you sure this is correct? Based on lpm-levels/scuba-pm downstream
I would expect:

 - That the CPU mode part (last digit) is equal to the deepest per-CPU
   state (0x3) and only the cluster mode part (digit before) changes
 - That you pass the "last in power level" needed for OSI in << 24

Some of the numbers in sm6115.dtsi also look suspicious if you want to
recheck those...

Thanks,
Stephan
