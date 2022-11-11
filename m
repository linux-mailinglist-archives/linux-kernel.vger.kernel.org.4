Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB4626315
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiKKUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:40:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A183BBA;
        Fri, 11 Nov 2022 12:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288EF620EA;
        Fri, 11 Nov 2022 20:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BC8C433C1;
        Fri, 11 Nov 2022 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668199224;
        bh=7WEo0XEdF37ad3EKSE0JnRvIRzSv8as0e854gPjKdVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gS9iygnD8njjdMi9uvK01Y9cMjjVNQSpj3WQldG5XseUPMgMhAmebjMBmKPe1bvn7
         Xw4ZmqaUPhBUpRgFsrHJfzAlTh9t62zJ88V8D+2Knp5VDYD/MZ9kraYoMixooNXB50
         7r+q0ano1GSTBnsUJTPLF8T2Cta/I71/yNqdTIQQaMTsbPRL7tn/SrMjL5C9PpOJBK
         0dYCN/LBqIgyacmGf8HzQ4mU5A+hzCDxBx6ObVVrry2usrGXsgAe2kzZR337bBgd4c
         he1HYE6jo+YIYwsw07r0cnGw4FFx40dFKsgbPzgTGmFcCBaGRU7lF3fFTHf6eGt2UU
         g8O3Y7EET5Tgg==
Date:   Fri, 11 Nov 2022 14:40:21 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi
 controller
Message-ID: <20221111204021.myjms5c2rntu4a76@builder.lan>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-7-johan+linaro@kernel.org>
 <20221110113513.GA18247@thinkpad>
 <Y254AvMKyDQ+tY0q@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y254AvMKyDQ+tY0q@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:27:46PM +0100, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 05:05:13PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 10, 2022 at 11:35:55AM +0100, Johan Hovold wrote:
> > > Enable the Qualcomm QCNFA765 Wireless Network Adapter connected to
> > > PCIe4.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > index 5b9e37a16f9f..ab5b0aadeead 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > > @@ -81,6 +81,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
> > >  		regulator-always-on;
> > >  	};
> > >  
> > > +	vreg_wlan: regulator-wlan {
> > > +		compatible = "regulator-fixed";
> > > +
> > > +		regulator-name = "VCC_WLAN_3R9";
> > > +		regulator-min-microvolt = <3900000>;
> > > +		regulator-max-microvolt = <3900000>;
> > > +
> > > +		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&hastings_reg_en>;
> > 
> > Hastings is the family name of QCA639x WLAN chipsets. I don't think it would be
> > applicable here. Please use "wlan_reg_en" as that matches the convention used
> > throughout this file.
> 
> The pin name here comes from the schematics, which is what we should use
> for naming when we can.
> 

Following the naming in the schematics is the right thing to do.

Regards,
Bjorn
