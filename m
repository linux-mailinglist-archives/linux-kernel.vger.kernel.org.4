Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804F85B7D24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIMWga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIMWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4AD2CDC0;
        Tue, 13 Sep 2022 15:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF21A6162D;
        Tue, 13 Sep 2022 22:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66203C433D6;
        Tue, 13 Sep 2022 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663108586;
        bh=sTxeYnX0H9Aq6JVrBf2pIXdeCFg8vJ4G3YDg/hrlXf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJChLg70voKjeriCi4tl4sUVPZUlFF7Hx+u7O6xeryu9JcYY+ASMBKYV9bM6AsDEg
         atZDWhxK581YFIY24vjKRLIJH8aFhn1R/WUCzslOYyA2TCcEgnLEJIhWdhJNgeG2dX
         dIrPzCPYK0GWfSPb8gftEMBXMgK0BQvtTjVsgEtvXhZnUr3dQr2fUIBdG6kkOk4Hp5
         SI/ckmXKvuPk+XvCW1KzQnIrO/KwNwoqGVlvWFlEVZnza+Uj73LjpbSDkYsJo2dPJq
         03IcZe6kDrVemhbZzt5jUNe91MD5VwaCDU9N8m+xfnJ50uy4pQFpx+87r+Bs9+kvNC
         JdEkR2dwgO1yA==
Date:   Tue, 13 Sep 2022 17:36:23 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/15] arm64: dts: qcom: msm8953: add missing TCSR
 syscon compatible
Message-ID: <20220913223623.zzencwgzuqygbtnr@builder.lan>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092035.223915-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:20:26AM +0200, Krzysztof Kozlowski wrote:
> TCSR syscon node should come with dedicated compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 8416a45ca4fd..ed05897d33f1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -722,7 +722,7 @@ tcsr: syscon@1937000 {
>  		};
>  
>  		tcsr_phy_clk_scheme_sel: syscon@193f044 {
> -			compatible = "syscon";
> +			compatible = "qcom,tcsr-msm8953", "syscon";
>  			reg = <0x193f044 0x4>;

I'm okay with the proposed change, but this node is not good.

This exposes a single register from TCSR to the HSUSB driver. We have a
couple of these cases (and have had more popping up in discussions) and
I think that nvmem would be a better abstraction than syscon.

Regards,
Bjorn

>  		};
>  
> -- 
> 2.34.1
> 
