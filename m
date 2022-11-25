Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0997F638B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKYNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:52:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733117AAC;
        Fri, 25 Nov 2022 05:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B0DBB82AED;
        Fri, 25 Nov 2022 13:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823DC433D6;
        Fri, 25 Nov 2022 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669384370;
        bh=qykFV7spweRMrT4EZcOj7Wfb2nv3rXRTU0mrl/58Hbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTSC8q8bDGdhwXkTWWuFycfOPPGJXlGJub23lsUHzvK83E6CP6VQa7oeGPikzyz+j
         Ez+RfpT3TwKAkdOoods7a77H5GJIEatWyLi+tatnv9nloG37ATnQF1d25ROSuyBuyj
         09o77V4qgZ4H+nDZUID0842bIIW7qjxZfTzLbfYrBUOnMddzEy3927+NUH4M25EeAW
         KlzY/mDZt5F6e1kmMOwVJxuaHW4fyfDxTrAaJ7eyrxuuNizso8ipoHCWg+gkrKb60M
         jvw0y2lU/xkf5MSoW+veF4jbXnYwyUT6SdTOOfsFGVLnVsIkKB9hucJiOMdVLfiE/f
         hiRdaxUfHtyDg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyZ7y-0004v6-59; Fri, 25 Nov 2022 14:52:26 +0100
Date:   Fri, 25 Nov 2022 14:52:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add
 sm6350 compatible
Message-ID: <Y4DImjwHQNlWPEKh@hovoldconsulting.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
 <Y4CP9fwhDXsLu57Q@hovoldconsulting.com>
 <COLABNHBQ1DG.1PB8SDY3FW1YY@otso>
 <Y4CWoT52Q8jnm/dF@hovoldconsulting.com>
 <COLE3UWQCQ8R.XY36EY07DDDK@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <COLE3UWQCQ8R.XY36EY07DDDK@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 01:53:25PM +0100, Luca Weiss wrote:
> On Fri Nov 25, 2022 at 11:19 AM CET, Johan Hovold wrote:
> > On Fri, Nov 25, 2022 at 10:55:31AM +0100, Luca Weiss wrote:
> > > On Fri Nov 25, 2022 at 10:50 AM CET, Johan Hovold wrote:

> > > > Yeah, you may need to add a platform specific section of the clocks,
> > > > which appear to be different, even if I'm not sure they are currently
> > > > described correctly (xo_board as cfg_ahb and "QLINK" as ref). How are
> > > > they named in the vendor's dts?
> > > 
> > > This is the msm-4.19 dts:
> > > https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/lagoon-usb.dtsi#354
> >
> > 		clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> > 			<&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>,
> > 			<&rpmhcc RPMH_QLINK_CLK>,
> > 			<&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> > 			<&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> > 		clock-names = "aux_clk", "pipe_clk", "ref_clk_src",
> > 				"ref_clk", "com_aux_clk";
> >
> > So it looks like you don't need update the binding for the clocks as the
> > above matches sc8280xp:
> >
> > 	aux
> > 	ref
> > 	com_aux
> > 	usb3_pipe
> 
> Thanks for checking!
> 
> >
> > Parent clocks (ref_clk_src) should not be included in the binding, but
> > rather be handled by the clock driver. For example, see:
> >
> > 	https://lore.kernel.org/all/20221121085058.31213-4-johan+linaro@kernel.org/
> > 	https://lore.kernel.org/all/20221115152956.21677-1-quic_shazhuss@quicinc.com/
> 
> So I assume you mean that I shouldn't do this:
> 
> clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>      <&rpmhcc RPMH_QLINK_CLK>,
>      <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>      <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> 
> But for "ref" use GCC_USB3_PRIM_CLKREF_CLK? That also seems to work
> fine, also if RPMH_QLINK_CLK is not used from Linux-side (checked in
> debugfs).

Exactly. Since the vendor dts describes RPMH_QLINK_CLK as parent of ref,
I'd suggest modelling that in the clock driver. Perhaps it has just been
left on by the boot firmware. Someone with access to docs may be able
explain how it is supposed to be used.

> And for the driver patch, I've discovered that this phy doesn't have
> separate txa/tbx region, so dts was also wrong there. Do you know if
> there's a way to test DP phy initialization without having all the USB-C
> plumbing in place? Might be good to validate at least phy init works if
> we're already touching all of this.

Do you mean that it appears to work as sc8280xp with txa/txb shared by
both the USB and DP parts?

I guess you need a proper setup to test it properly. Not sure what
you'll be able to learn otherwise, apart from whether it passes basic
smoke testing.

Johan
