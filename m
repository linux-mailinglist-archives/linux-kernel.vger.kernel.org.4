Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4F667A20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjALP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjALP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:59:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43194261A;
        Thu, 12 Jan 2023 07:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 201EFCE1E7B;
        Thu, 12 Jan 2023 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F747C433A0;
        Thu, 12 Jan 2023 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673538566;
        bh=sF0ezM+HFkfL1CfTp3012TuYafZ/7llu2ivf2JNXegI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kiWi/GUIFZo7uni7Zr3NCtMMcqukssB81CDpPXmoVSWLISF9CN1qGu+Upf+jYnhmz
         aUlS+rduvno03ku/ybeTbypVRl81wbCkCgtCbc1q1v2Ce3B7NQA3IphSEwz1GH4acR
         IqUXB8yyRCQ1822i1KT6MbGsfm4bdGDLQ0g6PLalwnaYcePcxKZllotWuVE3TvPeA7
         vL7+sBG4pzmqCevS5hP6bv6rvwyB8u69c9iyxeuyR4ng9ULPm9z+Aidyq33j9aTIDi
         MrkGPw1ujeB+w8LE8CzyHgNEtO9zWwrhZT8aT/vsrEB14A0O7tGQ6FLjFHvIOToXFh
         TVG7x8KFBTLrQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFzpd-0002WT-TH; Thu, 12 Jan 2023 16:49:33 +0100
Date:   Thu, 12 Jan 2023 16:49:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Vote for CX in USB
 controllers
Message-ID: <Y8AsDR7Un4D+k6Be@hovoldconsulting.com>
References: <20230112135117.3836655-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112135117.3836655-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:51:17AM -0800, Bjorn Andersson wrote:
> Running GCC_USB30_*_MASTER_CLK at 200MHz requires CX at nominal level,
> not doing so results in occasional lockups. This was previously hidden
> by the fact that the display stack incorrectly voted for CX (instead of
> MMCX).
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 2ed17baf50d3..4f4353f84cba 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2265,6 +2265,7 @@ usb_0: usb@a6f8800 {
>  					  "ss_phy_irq";
>  
>  			power-domains = <&gcc USB30_PRIM_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
>  
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>  
> @@ -2319,6 +2320,7 @@ usb_1: usb@a8f8800 {
>  					  "ss_phy_irq";
>  
>  			power-domains = <&gcc USB30_SEC_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
>  
>  			resets = <&gcc GCC_USB30_SEC_BCR>;

Looks good. Perhaps you can send a binding patch adding 'required-oops'
as well.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
