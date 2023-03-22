Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602A6C4084
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVCri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVCrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2C52904;
        Tue, 21 Mar 2023 19:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C50B61F1D;
        Wed, 22 Mar 2023 02:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCF3C433D2;
        Wed, 22 Mar 2023 02:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679453254;
        bh=SPOc+sENXiBCVO4AI8Jed9UIOqMKW+rWUAuqxHfKg3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8CABjKUa8jjdDsopBfvFdUFewZATA4jnVooD4mdZ1uMR7foBBUtlMSu6E83ChOCP
         rAEvOAUNv/6g4gYFjYEGsEPuTWn2isaFv98SFcVth3sH2GOnIKWYdS2y9+RW36GcMa
         cFnxFURgVsHc7wjXzqtCs1eDXDjsdDeM0gtHPOI8u3Cr0BZh1i8wLaZRfq/F0Wax60
         L3wJdiGoAlTGuXjrT8mSBWW1Mnk82n/1EaFZ+d7nr3bFx2TZGqDOCkbURRPSzBGcNQ
         IbIrSvOm2IaD+RD9tMTJH4sc6VG/0Q0B4bBeI6/R6oAt8MC+Txmnc0mvWVSLYN5ahV
         on8Ln8yzbGkqw==
Date:   Tue, 21 Mar 2023 19:50:47 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 12/15] arm64: dts: qcom: sa8775p: pmic: add thermal
 zones
Message-ID: <20230322025047.gvo252mh2flcbzuc@ripper>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-13-brgl@bgdev.pl>
 <a215c54b-c12e-4463-f9fe-588053f74300@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a215c54b-c12e-4463-f9fe-588053f74300@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:28:20PM +0100, Konrad Dybcio wrote:
> 
> 
> On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Add the thermal zones and associated alarm nodes for the PMICs that have
> > them hooked up on sa8775p-ride.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 58 +++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> > index 8616ead3daf5..276070b62ccd 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> > @@ -6,6 +6,50 @@
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/spmi/spmi.h>
> >  
> > +/ {
> > +	thermal-zones {
> > +		pmm8654au_1_thermal: pm8775-1-thermal {
> Please reindex this, downstream uses _1 for pmic@0, but this
> makes little sense. Make it match the SID.
> 

Please use the naming from the schematics for these things, rather than
just an iterator (which might be what Bartosz is doing here).

Regards,
Bjorn

> > +			polling-delay-passive = <100>;
> > +			polling-delay = <0>;
> > +			thermal-sensors = <&pmm8654au_1_temp_alarm>;
> > +
> > +			trips {
> > +				trip0 {
> > +					temperature = <105000>;
> > +					hysteresis = <0>;
> > +					type = "passive";
> > +				};
> > +
> > +				trip1 {
> > +					temperature = <125000>;
> > +					hysteresis = <0>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> What happened to the downstream _2 (pmic@2) one and _4 (pmic@6)?
> 
> Konrad
> 
> > +		pmm8654au_3_thermal: pm8775-3-thermal {
> > +			polling-delay-passive = <100>;
> > +			polling-delay = <0>;
> > +			thermal-sensors = <&pmm8654au_3_temp_alarm>;
> > +
> > +			trips {
> > +				trip0 {
> > +					temperature = <105000>;
> > +					hysteresis = <0>;
> > +					type = "passive";
> > +				};
> > +
> > +				trip1 {
> > +					temperature = <125000>;
> > +					hysteresis = <0>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >  &spmi_bus {
> >  	pmm8654au_0: pmic@0 {
> >  		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
> > @@ -41,6 +85,13 @@ pmm8654au_1: pmic@2 {
> >  		reg = <0x2 SPMI_USID>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +
> > +		pmm8654au_1_temp_alarm: temp-alarm@a00 {
> > +			compatible = "qcom,spmi-temp-alarm";
> > +			reg = <0xa00>;
> > +			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> > +			#thermal-sensor-cells = <0>;
> > +		};
> >  	};
> >  
> >  	pmm8654au_2: pmic@4 {
> > @@ -55,5 +106,12 @@ pmm8654au_3: pmic@6 {
> >  		reg = <0x6 SPMI_USID>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +
> > +		pmm8654au_3_temp_alarm: temp-alarm@a00 {
> > +			compatible = "qcom,spmi-temp-alarm";
> > +			reg = <0xa00>;
> > +			interrupts-extended = <&spmi_bus 0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> > +			#thermal-sensor-cells = <0>;
> > +		};
> >  	};
> >  };
