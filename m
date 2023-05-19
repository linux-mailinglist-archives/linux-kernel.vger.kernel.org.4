Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E108870948F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjESKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjESKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:13:35 -0400
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 03:13:30 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48711AD;
        Fri, 19 May 2023 03:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684491025; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HgouqRz/ghNoHWuKMf6PX8KPdqH+12xJPj2Lqz2I6OklvXY5A6AzUkYxf8zz3tpz4E
    kU9qYVWZhOwXXGVhWCg7lNfdtKSq26thyZka15mD2wf62dFFcRhEsPzUas2pnN11wN9k
    BwWcEGfRJDCaInWA0V9mZ37p0aSKYNZEpV4Cu0F8VDzdZqODKS8waABXFlrJ341Mk/Yb
    EXLSaNBw5ovplPhOLn577R7HOBAad5pdrVAuRhucFY27gr/gYZUIKIrwV99VnvigE8Ol
    lQVX0B7uYcfJMBjxgJcLSaUus4/d6x3mKUfwUirpGejPgiVtRrNOFjtiiKPEp5VP50z/
    PTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684491025;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=eRuHGpVTvQWAER09Wkg6bg13Zj7DEpwOzvgnktYZ170=;
    b=KaHbAy/ym2yhPolIhX/FXj4iZ5An++rlbx3wXBrlsQs3JTZGn7lih8FoIV9cmk4JdM
    gIOlpGDKR4TSWbI9X6QQY27Ql9O7m48Iw8kOnt7oxHg0I4hpipfjNbNas2Jns9Ev9p17
    kIdGJdyJ472cQcn2r3Gm1R83hZRUIzIOmr39EIZ/KzldadxVtZg/sVCvlOFSJHZgB32a
    eLkIWpdm6XB2GNmdCSA3x7W0qQpu5Bq3QMO3+8zn/SiEmp+kfBbdYg3OWXwQsBlTEj5L
    SduQJqJ7/V+ov+Q2ThMOWiV0Gbgn9eFLu6kpW/htgNnH0Hesz3LoYFn8JOZe7ShrTp1k
    o2XQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684491025;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=eRuHGpVTvQWAER09Wkg6bg13Zj7DEpwOzvgnktYZ170=;
    b=ScETnCUGxDV6vnxqkKAsWVbvj8b4pswuzLOHteNnjqjHR+jGTn/iwsBxUSX2MSIc4K
    lPD0m+eNtYIcSkgwQjd4G89IR8P5mxu3FZZ+MMr+RoHG3nPs1RVT93HDJQQrHNBSGZtX
    W3n+SMFetbcAESBRWofNmzihF2JDwfUMmFTzPRbQUR3d6xCboWoRa1s4nlkdJPNAAjM/
    kchO9vpttxVR9iNeDDJ5GzQy02j8sUsgUpVQ4cP0NGdevqPY6msa94iW0uG+iQTP/Uii
    lHYHLHeaWwX3QnZgbyrEWRlfvDAnauXqITuLGKROSeFga6HPbF0imqawnV82p3cqWbJJ
    sZ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684491025;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=eRuHGpVTvQWAER09Wkg6bg13Zj7DEpwOzvgnktYZ170=;
    b=8YTy2aZbMdRCJrQUpO9sgBSJBxaGuCpPael52wn3PFdbxrMprW76DpLYUCJsIVNL06
    MMFBAvW3QJxL2AWoLWAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4JAAPEQ7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 May 2023 12:10:25 +0200 (CEST)
Date:   Fri, 19 May 2023 12:10:17 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org
Subject: Re: [PATCH v6 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine
 support
Message-ID: <ZGdLCdSof027mk5u@gerhold.net>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-8-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405072836.1690248-8-bhupesh.sharma@linaro.org>
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

Hi Bhupesh,

Not sure if this is the latest version of this series since it's pretty 
old but I didn't find a new one. Just came here because you mentioned 
RB1/RB2 [1] in my bam_dma patch and they don't have any BAM defined
upstream yet.

[1]: https://lore.kernel.org/linux-arm-msm/CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com/

On Wed, Apr 05, 2023 at 12:58:32PM +0530, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm6115.dtsi'.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 2a51c938bbcb..ebac026b4cc7 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1b04000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x01b04000 0x0 0x24000>;
> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <8>;
> +			qcom,num-ees = <2>;
> +			iommus = <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;
> +		};
> +
> +		crypto: crypto@1b3a000 {
> +			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0x0 0x01b3a000 0x0 0x6000>;
> +			dmas = <&cryptobam 6>, <&cryptobam 7>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;

Shouldn't you have clocks = <&rpmcc RPM_SMD_CE1_CLK> here to make sure
the clock for the crypto engine is on? Your binding patch (PATCH 06/11)
says "Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290 do not
require clocks strictly" but doesn't say why.

Make sure you don't rely on having rpmcc keep unused clocks on
permanently. This is the case at the moment, but we would like to change
this [2]. Adding new users that rely on this broken behavior would just
make this effort even more complicated.

If you also add the clock to the cryptobam then you should be able to
see the advantage of my bam_dma patch [3]. It allows you to drop
"num-channels" and "qcom,num-ees" from the cryptobam in your changes
above because it can then be read directly from the BAM registers.

Thanks,
Stephan

[2]: https://lore.kernel.org/linux-arm-msm/20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org/
[3]: https://lore.kernel.org/linux-arm-msm/20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net/
