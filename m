Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7B168858C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjBBRgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjBBRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:36:34 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A887074C1E;
        Thu,  2 Feb 2023 09:36:33 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id F3703CD52C;
        Thu,  2 Feb 2023 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675359392; bh=OTyDkxpr2/8OyEpapjyVq0VRTuVQfP0EbcF0UYFilLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wg5K3m1vDyspNHizdP4SIt0k/XvIy7pXWILoGm8Jz+O1VjnNrH9ULfie6E0NPLuVW
         YDJ5FbAy0gQ38HRUBxf1JnbpXse3YjQss6sUckP5iU1WGIN2DpgrYE/gh3XXoxecw3
         AyJJuym6d4vJYvDcpgw3vgsm7BPi1eH/h+qT7R38=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Iskren Chernev <me@iskren.info>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 09/10] arm64: dts: qcom: msm8953: correct TLMM gpio-ranges
Date:   Thu, 02 Feb 2023 18:36:31 +0100
Message-ID: <6520866.4vTCxPXJkl@z3ntu.xyz>
In-Reply-To: <20230202104452.299048-10-krzysztof.kozlowski@linaro.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. Februar 2023 11:44:51 CET Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in TLMM pin controller.
> 
> Fixes: 9fb08c801923 ("arm64: dts: qcom: Add MSM8953 device tree")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Given msm8953 has gpio0 - gpio141, 142 looks correct.

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index 4e17bc9f8167..610f3e3fc0c2
> 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -399,7 +399,7 @@ tlmm: pinctrl@1000000 {
>  			reg = <0x1000000 0x300000>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
> -			gpio-ranges = <&tlmm 0 0 155>;
> +			gpio-ranges = <&tlmm 0 0 142>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;




