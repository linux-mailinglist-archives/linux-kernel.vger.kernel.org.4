Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EE64E2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLOVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLOVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:00:21 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DD5437E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:00:15 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 115EF3F319;
        Thu, 15 Dec 2022 22:00:12 +0100 (CET)
Date:   Thu, 15 Dec 2022 22:00:10 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8976: Declare and use SDC1 pins
Message-ID: <20221215210010.on44gmoefbnsokvt@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214232049.703484-1-marijn.suijten@somainline.org>
 <20221214232049.703484-5-marijn.suijten@somainline.org>
 <60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 14:19:41, Konrad Dybcio wrote:
> 
> 
> On 15.12.2022 00:20, Marijn Suijten wrote:
> > Add the pinctrl states for SDC1 and use them on sdhc_1.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8976.dtsi | 55 +++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> > index 05dcb30b0779..7d4c7548882c 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> > @@ -508,6 +508,56 @@ tlmm: pinctrl@1000000 {
> >  			interrupt-controller;
> >  			#interrupt-cells = <2>;
> >  
> > +			sdc1_off_state: sdc1-off-state {
> > +				clk-pins {
> > +					pins = "sdc1_clk";
> > +					drive-strength = <2>;
> > +					bias-disable;
> > +				};
> > +
> > +				cmd-pins {
> > +					pins = "sdc1_cmd";
> > +					drive-strength = <2>;
> > +					bias-pull-up;
> > +				};
> > +
> > +				data-pins {
> > +					pins = "sdc1_data";
> > +					drive-strength = <2>;
> > +					bias-pull-up;
> > +				};
> > +
> > +				rclk-pins {
> > +					pins = "sdc1_rclk";
> > +					bias-pull-down;
> > +				};
> > +			};
> > +
> > +			sdc1_on_state: sdc1-on-state {
> > +				clk-pins {
> > +					pins = "sdc1_clk";
> > +					drive-strength = <16>;
> > +					bias-disable;
> > +				};
> > +
> > +				cmd-pins {
> > +					pins = "sdc1_cmd";
> > +					drive-strength = <10>;
> > +					bias-pull-up;
> > +				};
> > +
> > +				data-pins {
> > +					pins = "sdc1_data";
> > +					drive-strength = <10>;
> > +					bias-pull-up;
> > +				};
> > +
> > +				rclk-pins {
> > +					pins = "sdc1_rclk";
> > +					bias-pull-down;
> > +				};
> > +			};
> > +
> >  			spi1_default: spi0-default-state {
> >  				spi-pins {
> >  					pins = "gpio0", "gpio1", "gpio3";
> > @@ -680,6 +730,11 @@ sdhc_1: mmc@7824000 {
> >  				 <&gcc GCC_SDCC1_APPS_CLK>,
> >  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> >  			clock-names = "iface", "core", "xo";
> > +
> > +			pinctrl-0 = <&sdc1_on_state>;
> > +			pinctrl-1 = <&sdc1_off_state>;
> > +			pinctrl-names = "default", "sleep";
> pinctrl-names usually goes before pinctrl-N

I thought I had seen them _after_ nowadays, same for reg-names,
phy-names, interrupt-names and clock-names.  What is it?

Regardless, I'd rather keep this consistent across this file (sdc2 also
has it after, same for other *-names) and correct it at once in a
separate patch, if someone really cares.

But really, we should have a checker/autoformatter for these "rules",
instead of all this manual back-and-forth (is this order already set in
stone under Documentation/ or something?).

- Marijn
