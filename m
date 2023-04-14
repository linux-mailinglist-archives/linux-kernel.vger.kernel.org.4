Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4966E2767
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDNPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:50:15 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50866CC12;
        Fri, 14 Apr 2023 08:49:50 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A2046D0C6C;
        Fri, 14 Apr 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681487388; bh=5deGG8YgU39L1Frgo8v0yyglncVg1IVJihr5ucsOgwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FkU9900bN1eIkqyry8Nz/biLX4tEc0fOQ9U7oWDSCiJ73JpfWOFbX3ezwF9gbTT3X
         DradnDxwJSYpRV+qYrCKhWlfR0VuSklTM4Oig9t26UpxmmLDtoty2tR44ayIzrBumh
         +nvJc1W3wJcGkVgom6xliaYylE1639Gxvvq4pums=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
Date:   Fri, 14 Apr 2023 17:49:47 +0200
Message-ID: <5205040.31r3eYUQgx@z3ntu.xyz>
In-Reply-To: <96180862-6dbf-77e1-4aca-9a3b9ee39294@linaro.org>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-8-fe94dc414832@z3ntu.xyz>
 <96180862-6dbf-77e1-4aca-9a3b9ee39294@linaro.org>
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

On Freitag, 14. April 2023 01:36:38 CEST Konrad Dybcio wrote:
> On 14.04.2023 01:17, Luca Weiss wrote:
> > The phone features a notification LED connected to the pmi632. Configure
> > the RGB led found on it.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 29
> >  +++++++++++++++++++++++ 1 file changed, 29 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts index
> > 70e683b7e4fc..301eca9a4f31 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> > @@ -4,8 +4,10 @@
> > 
> >   */
> >  
> >  /dts-v1/;
> > 
> > +#include <dt-bindings/leds/common.h>
> > 
> >  #include "sdm632.dtsi"
> >  #include "pm8953.dtsi"
> > 
> > +#include "pmi632.dtsi"
> > 
> >  / {
> >  
> >  	model = "Fairphone 3";
> > 
> > @@ -83,6 +85,33 @@ &pm8953_resin {
> > 
> >  	linux,code = <KEY_VOLUMEDOWN>;
> >  
> >  };
> > 
> > +&pmi632_lpg {
> 
> qcom,power-source?

This property is only used if triled_has_src_sel is set in the driver (which 
it isn't on pmi632), only on pm8941 & pmi8994 it is set.

Regards
Luca

> 
> Konrad
> 
> > +	status = "okay";
> > +
> > +	multi-led {
> > +		color = <LED_COLOR_ID_RGB>;
> > +		function = LED_FUNCTION_STATUS;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		led@1 {
> > +			reg = <1>;
> > +			color = <LED_COLOR_ID_RED>;
> > +		};
> > +
> > +		led@2 {
> > +			reg = <2>;
> > +			color = <LED_COLOR_ID_GREEN>;
> > +		};
> > +
> > +		led@3 {
> > +			reg = <3>;
> > +			color = <LED_COLOR_ID_BLUE>;
> > +		};
> > +	};
> > +};
> > +
> > 
> >  &sdhc_1 {
> >  
> >  	status = "okay";
> >  	vmmc-supply = <&pm8953_l8>;




