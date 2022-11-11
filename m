Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985BB625F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiKKQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiKKQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:28:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66407F576;
        Fri, 11 Nov 2022 08:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54BDC62057;
        Fri, 11 Nov 2022 16:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D30AC433D6;
        Fri, 11 Nov 2022 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668184093;
        bh=oskG4N4w1LS67QnYKG6094gwrkubDpJuJjbmW/oB4w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0NiLl1GEeTWa57ChuX+PM3JA4RphDzPJgQovxipPe8T8WUOfVPRqlIP9bEwu1m6P
         kbXhGsYWfTVGj2RRwW+UNdCwVxmkxZPpw4BZ/pxUcu4mhAQSJMK2YLpwSycWJkD956
         z6rNwOA6pKfXNBaggjXXuiIqkBeVqlOU4GSiMp1pt8bx3y2javGRmFDzu+LFqSHeS4
         lkd3VTvoxRy1l6SRtx15L+djnT4sBX3LdjaBYqco1PMYwfx4AXkfiJypRPUHvR8UYp
         6K0+LrCWUVMwbH1pFg/7F4LMpde/n5OIx9GhhNjxhALV5REPeH3V7hGimHUJ84ZZm+
         4bJOZ9KZSIv+A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1otWsc-0003jD-2Q; Fri, 11 Nov 2022 17:27:46 +0100
Date:   Fri, 11 Nov 2022 17:27:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi
 controller
Message-ID: <Y254AvMKyDQ+tY0q@hovoldconsulting.com>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-7-johan+linaro@kernel.org>
 <20221110113513.GA18247@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110113513.GA18247@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:05:13PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 10, 2022 at 11:35:55AM +0100, Johan Hovold wrote:
> > Enable the Qualcomm QCNFA765 Wireless Network Adapter connected to
> > PCIe4.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 5b9e37a16f9f..ab5b0aadeead 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -81,6 +81,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
> >  		regulator-always-on;
> >  	};
> >  
> > +	vreg_wlan: regulator-wlan {
> > +		compatible = "regulator-fixed";
> > +
> > +		regulator-name = "VCC_WLAN_3R9";
> > +		regulator-min-microvolt = <3900000>;
> > +		regulator-max-microvolt = <3900000>;
> > +
> > +		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&hastings_reg_en>;
> 
> Hastings is the family name of QCA639x WLAN chipsets. I don't think it would be
> applicable here. Please use "wlan_reg_en" as that matches the convention used
> throughout this file.

The pin name here comes from the schematics, which is what we should use
for naming when we can.

Johan
