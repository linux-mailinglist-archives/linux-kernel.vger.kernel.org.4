Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648664FE99
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLRLMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLRLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:12:40 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509538BC;
        Sun, 18 Dec 2022 03:12:39 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D4D1E3EF0E;
        Sun, 18 Dec 2022 12:12:36 +0100 (CET)
Date:   Sun, 18 Dec 2022 12:12:30 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm6125: Reorder HSUSB PHY clocks to
 match bindings
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <U433NR.I7MNQ8Y3FNHT@somainline.org>
In-Reply-To: <20221216213343.1140143-1-marijn.suijten@somainline.org>
References: <20221216213343.1140143-1-marijn.suijten@somainline.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Dec 16 2022 at 10:33:43 PM +01:00:00, Marijn Suijten 
<marijn.suijten@somainline.org> wrote:
> Reorder the clocks and corresponding names to match the QUSB2 phy
> schema, fixing the following CHECK_DTBS errors:
> 
>     arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: 
> phy@1613000: clock-names:0: 'cfg_ahb' was expected
>             From schema: 
> /newdata/aosp-r/kernel/mainline/kernel/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
>     arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: 
> phy@1613000: clock-names:1: 'ref' was expected
>             From schema: 
> /newdata/aosp-r/kernel/mainline/kernel/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> 
> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi 
> b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7e25a4f85594..bf9e8d45ee44 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -442,9 +442,9 @@ hsusb_phy1: phy@1613000 {
>  			reg = <0x01613000 0x180>;
>  			#phy-cells = <0>;
> 
> -			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> -				 <&gcc GCC_AHB2PHY_USB_CLK>;
> -			clock-names = "ref", "cfg_ahb";
> +			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "cfg_ahb", "ref";
> 
Reviewed-by: Martin Botka <martin.botka@somainline.org>

-Martin
>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>  			status = "disabled";
> --
> 2.39.0
> 


