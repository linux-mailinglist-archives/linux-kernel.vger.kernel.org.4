Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8665892C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiL2Deq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Den (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:34:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BADFBB;
        Wed, 28 Dec 2022 19:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59040B818B9;
        Thu, 29 Dec 2022 03:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3107DC433D2;
        Thu, 29 Dec 2022 03:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672284879;
        bh=ejt+OXLyDQo0MjucsaexNekRIuQpY4FgVYViadWiGDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjxF5Do4VUhcHJ4gFm8eQD8u6OOPuZRFIC0hzBksdKFIuI09yxoMVJivrp9Nrb9J0
         vSMw6zIP50vFhG/tpdDmlTrFbhs5qlh4Pr578MEw7whX44MXC5YCUkdFwZ/z5P4JiF
         OWUjEXATofADcGMpQrucewypVjXdwAFKOThc0zTvsxEf8OqGlz2QSdtFhh4FTnpPMv
         NsccKZ1FG5JYjMm/sulqPJPak+hwHAQKjRJAdaKaWS15LV3lVjc7gkt85fCEK7ljKo
         E/h6bp5Y5mo2zAXUOUyVc9NtlY7e+0zz5EUfIz2CXx93yydBzDMf6eDWKNLOViGVSz
         P+ZMtTfsji54Q==
Date:   Wed, 28 Dec 2022 21:34:37 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pm8226: add IADC node
Message-ID: <20221229033437.kxwe73bomxw6sfi2@builder.lan>
References: <20221223193403.781355-1-rayyan@ansari.sh>
 <20221223193403.781355-4-rayyan@ansari.sh>
 <4448368.LvFx2qVVIh@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4448368.LvFx2qVVIh@g550jk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 01:14:59PM +0100, Luca Weiss wrote:
> Hi Rayyan,
> 
> On Freitag, 23. Dezember 2022 20:34:03 CET Rayyan Ansari wrote:
> > Add a node for the current ADC (IADC) found in PM8226.
> > 
> > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> > ---
> >  arch/arm/boot/dts/qcom-pm8226.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> > b/arch/arm/boot/dts/qcom-pm8226.dtsi index 403324a35cf5..82470549f240
> > 100644
> > --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> > +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> > @@ -88,6 +88,12 @@ adc-chan@f {
> >  			};
> >  		};
> > 
> > +		pm8226_iadc: iadc@3600 {
> 
> Make this adc@ to conform to qcom,spmi-pmic.yaml docs
> 
> > +			compatible = "qcom,spmi-iadc";
> 
> Make this "qcom,pm8226-iadc", "qcom,spmi-iadc" and add to docs to conform to 
> qcom,spmi-iadc.yaml
> 

I adjusted the patch according to your requests and applied it. Rayyan,
please update dt binding documentation per Luca's request.

Thanks,
Bjorn

> Regards
> Luca
> 
> > +			reg = <0x3600>;
> > +			interrupts = <0x0 0x36 0x0 
> IRQ_TYPE_EDGE_RISING>;
> > +		};
> > +
> >  		rtc@6000 {
> >  			compatible = "qcom,pm8941-rtc";
> >  			reg = <0x6000>, <0x6100>;
> 
> 
> 
> 
