Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC06662FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjAKSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:47:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F92F791;
        Wed, 11 Jan 2023 10:47:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD6FA61DD5;
        Wed, 11 Jan 2023 18:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17EEC433D2;
        Wed, 11 Jan 2023 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673462835;
        bh=LUwdBfI+Io1ch2RMgaYtsm8GKXDVco8UDikkgJQf+ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXT8KfXho7j5kLBrgXM5KTMKZlxJ1XRrtNULrZhtIeZHOxYqO76VH6GQIM4aUCqxS
         /1KVTTVBBI+fPA1B8+DKQcqEu8NUL3M+i2y0SYVG6F7mjhH/HZ8ewoTUKl+9A0KvPq
         7QQa6/8v8mTk/vtgZqXC46ITMwt+axPqlXBgtnRasbae3oDKJLuciRHu2dHypmyhzJ
         zj5vvJOUCuemAmTo8IRncAYSSqAiIk8CK7XCE4LvheH4UqI9xv/tPworzAFvjav/hd
         iJau6pARr5asjBQX9tnQUDQrpeb3+3IlgXYIegji3bUAaUk3o1iBx8lb+JEpvnjss0
         I7kM8112dBDzw==
Date:   Wed, 11 Jan 2023 12:47:12 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/4] arm64: dts: qcom: sc8280xp-crd: Enable EDP
Message-ID: <20230111184712.krrcsg7fto464e7a@builder.lan>
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
 <20230111035906.2975494-3-quic_bjorande@quicinc.com>
 <Y764pvrxF9Z8tgKU@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y764pvrxF9Z8tgKU@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:24:54PM +0100, Johan Hovold wrote:
> On Tue, Jan 10, 2023 at 07:59:04PM -0800, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The SC8280XP CRD has a EDP display on MDSS0 DP3, enable relevant nodes
> > and link it together with the backlight control.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v6:
> > - None
> > 
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 73 ++++++++++++++++++++++-
> >  1 file changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 551768f97729..db12d8678861 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -20,7 +20,7 @@ aliases {
> >  		serial0 = &qup2_uart17;
> >  	};
> >  
> > -	backlight {
> > +	backlight: backlight {
> >  		compatible = "pwm-backlight";
> >  		pwms = <&pmc8280c_lpg 3 1000000>;
> >  		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> > @@ -34,6 +34,22 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	vreg_edp_3p3: regulator-edp-3p3 {
> > +		compatible = "regulator-fixed";
> > +
> > +		regulator-name = "VREG_EDP_3P3";
> 
> Looks like you forgot to change this to "VCC3LCD" which should be the
> net name.
> 

That's because it's not called VCC3LCD on the CRD.

> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +
> > +		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&edp_reg_en>;
> > +
> > +		regulator-boot-on;
> > +	};
> > +
> >  	vreg_edp_bl: regulator-edp-bl {
> >  		compatible = "regulator-fixed";
> 
> > @@ -494,6 +559,12 @@ hastings_reg_en: hastings-reg-en-state {
> >  &tlmm {
> >  	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
> >  
> > +	edp_reg_en: edp-reg-en-state {
> > +		pins = "gpio25";
> > +		function = "gpio";
> > +		drive-strength = <16>;
> 
> 'bias-disable' as well?
> 

Sound like a good idea, adding that as I'm picking up the patches.

Regards,
Bjorn

> > +	};
> > +
> >  	kybd_default: kybd-default-state {
> >  		disable-pins {
> >  			pins = "gpio102";
> 
> Looks good otherwise,
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan
