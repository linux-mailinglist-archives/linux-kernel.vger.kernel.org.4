Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207F731207
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbjFOIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbjFOIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:22:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB51FE5;
        Thu, 15 Jun 2023 01:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686817343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FaLjgn9vXsbIgsQMfjM7AmyD4jf593oXpI4yPU6DlTzmZfTC8f/LZiv3FXfmE42kBb
    8O1L0WgZxL18RodiBhTqYChMVRkv+fOLwntZnuA7NEP78Mw9iXtTJhVPWlQkUgTWqK00
    alpmUjwpJ5R/Q3KTMVsPG3iiVlq0TR6fUyWI/mnuNsDyMysbbF676kJP/FYRAtPiHGan
    6ggEn4lb/bTus1nlBf8+uJV+i6kO6+FKYLcDoLggUYdEyO+nKLshR6PpE/OpGpPrH8k6
    jGQ9b/Irz60xwPzuwblyGybc9TebEwc38WiGk/PbzSn2nt05pNzy1VR3bqssiWs4Z+z8
    vlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686817343;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9wy0kZTaLDB+nQbBxTTmH0OFUPaKM85WQOyRAqCXrhs=;
    b=gmBU4wwhfFGsSUCQO1uctt2GFSt45+NiQ2T4S3gJpQXoec8XV2dgMsTEv6E4pGhHS2
    Zci4e6PGGK9I6bVgP42NYZpoFqbfqqMNsZJGSCIkoC/YJ5jlibAB6EKHr/By3Pbr3M00
    eBPyXoi+94FzTL0RXvCrUOlhoJ2ZLTWXBJWSyiUUGaUxkz0EpToVM4Y45RAkp6Daq8Ju
    k5uC2fZQP4scIGOFpgkDZb9L7SHt+7tw/ksjd69TlnZ96dOWEuQzpyS2v45rwQDkKGbY
    kT0gza7YCPhbx+MajXT/GbzSQ3Gb3IFhK+GYjN2wwwzjp24TwZqaM0tY0lA9qibBUQ7a
    JZTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686817343;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9wy0kZTaLDB+nQbBxTTmH0OFUPaKM85WQOyRAqCXrhs=;
    b=Yl8qg3tro0sHB4dPL/jk3DTg+Ptxgbwuqq0d9CLqakwl/9IbyxlIVRcjV9gqs1MUUF
    gg6YrQLP27wiCZ23BcNOCagQw/NiXT1gxLXNdQ5IK6L9mzRu0jgg9EPjHRhGhuSoTjBa
    36r56az/9l/MlOShQVW/SZbuS8NVCQItBtPrWEjzX81m0B1DGdnmcgIG1CeAH+RCKvFe
    Kt/oj3fZEDhCQsRCMR3T3I9sazrJagpV1klV+xDG6Un2sXPNoGy4AuPvLeOhx7ZzPaHS
    46pAvE/UgRp0wPZlnwf7fW88vogLqw4n6c9HZvWZiuwauOqa4swPMMBiT06FelV8h6rg
    TSgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686817343;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9wy0kZTaLDB+nQbBxTTmH0OFUPaKM85WQOyRAqCXrhs=;
    b=+BQ/asWxIx/VRseV6EEyiAFbpX8pvNOnAeEmTwUZxSM0xNuOzdrhpuMyB7opmvQlzl
    4eqkj7gIb2FaI48ohIAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5F8MM1zd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 10:22:22 +0200 (CEST)
Date:   Thu, 15 Jun 2023 10:22:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Fix HDMI node
Message-ID: <ZIrJ86IsLOm_Scbc@gerhold.net>
References: <20230615-topic-8996hdmi-v1-1-39584bfd68d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-topic-8996hdmi-v1-1-39584bfd68d2@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:12:32AM +0200, Konrad Dybcio wrote:
> A recent commit messed up the node name and compatibles. Fix it.
> 
> Fixes: f43b6dc7d56e ("arm64: dts: qcom: msm8996: rename labels for HDMI nodes")

Looks like that commit did a simple search & replace without checking
the result :')

Can you also fix the weird pinctrl node names in apq8096-db820c?
(mdss_hdmi -> mdss-hdmi, or maybe even rename it back to just hdmi-
since that part doesn't really need grouping...)

The "hdmi-dai-link" was also changed to "mdss_hdmi-dai-link".

Thanks,
Stephan

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 0cb2d4f08c3a..40ac0a784a4a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1136,8 +1136,8 @@ mdss_dsi1_phy: phy@996400 {
>  				status = "disabled";
>  			};
>  
> -			mdss_hdmi: mdss_hdmi-tx@9a0000 {
> -				compatible = "qcom,mdss_hdmi-tx-8996";
> +			mdss_hdmi: hdmi-tx@9a0000 {
> +				compatible = "qcom,hdmi-tx-8996";
>  				reg =	<0x009a0000 0x50c>,
>  					<0x00070000 0x6158>,
>  					<0x009e0000 0xfff>;
> @@ -1180,7 +1180,7 @@ mdss_hdmi_in: endpoint {
>  
>  			mdss_hdmi_phy: phy@9a0600 {
>  				#phy-cells = <0>;
> -				compatible = "qcom,mdss_hdmi-phy-8996";
> +				compatible = "qcom,hdmi-phy-8996";
>  				reg = <0x009a0600 0x1c4>,
>  				      <0x009a0a00 0x124>,
>  				      <0x009a0c00 0x124>,
> 
> ---
> base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
> change-id: 20230615-topic-8996hdmi-520fb03bd36c
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
