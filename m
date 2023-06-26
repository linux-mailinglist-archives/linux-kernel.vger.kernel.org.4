Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675273EBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFZU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:26:10 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A3183;
        Mon, 26 Jun 2023 13:26:06 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7DB97CEF49;
        Mon, 26 Jun 2023 20:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687811164; bh=9Dd6Sb1LPtubpsUmqERQ2V++xS4zWW1SYkzFpWae+fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ANkFkbBIfxQGWRv7yIwCdXXzj0GsWSmLEgp6qKnS/ese4wCD9okQBQtDtSGHw8oFq
         v+C4DMTbCj6C89Kb4wuvHUJhmmgHsTHPMk5a/OokUBnEDrD/yq+KlCJFcnofhZvMwX
         i7jNhpkRQp0kAGIpPqq3V7MDxCHtYKMLQDnh+gTI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 3/7] arm64: dts: qcom: pm6150l: Add missing short interrupt
Date:   Mon, 26 Jun 2023 22:26:03 +0200
Message-ID: <5684422.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <2b14f2a7-7f65-1b9d-06dc-92f0ea7fe096@linaro.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
 <2684880.mvXUDI8C0e@z3ntu.xyz>
 <2b14f2a7-7f65-1b9d-06dc-92f0ea7fe096@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 26. Juni 2023 22:18:11 CEST Konrad Dybcio wrote:
> On 26.06.2023 22:17, Luca Weiss wrote:
> > On Montag, 26. Juni 2023 22:00:25 CEST Konrad Dybcio wrote:
> >> Add the missing short interrupt. This fixes the schema warning:
> >> 
> >> wled@d800: interrupt-names: ['ovp'] is too short
> >> 
> >> Fixes: fe508ced49dd ("arm64: dts: qcom: pm6150l: Add wled node")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >> 
> >>  arch/arm64/boot/dts/qcom/pm6150l.dtsi | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> >> b/arch/arm64/boot/dts/qcom/pm6150l.dtsi index 6a7fe1e59f15..d13a1ab7c20b
> >> 100644
> >> --- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> >> @@ -121,8 +121,9 @@ pm6150l_flash: led-controller@d300 {
> >> 
> >>  		pm6150l_wled: leds@d800 {
> >>  		
> >>  			compatible = "qcom,pm6150l-wled";
> >>  			reg = <0xd800>, <0xd900>;
> >> 
> >> -			interrupts = <0x5 0xd8 0x1 
IRQ_TYPE_EDGE_RISING>;
> >> -			interrupt-names = "ovp";
> >> +			interrupts = <0x5 0xd8 0x1 
IRQ_TYPE_EDGE_RISING>,
> >> +				     <0x5 0xd8 0x2 
IRQ_TYPE_EDGE_RISING>;
> >> +			interrupt-names = "ovp", "short";
> > 
> > Are you sure this interrupt really exists? It's not a thing used
> > downstream at least:
> > https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/
> > android-msm-bramble-4.19-android11-qpr1/qcom/pm6150l.dtsi#293
> Confirmed with a reliable source.

Fine by me then.

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> 
> Konrad
> 
> > Regards
> > Luca
> > 
> >>  			label = "backlight";
> >>  			
> >>  			status = "disabled";




