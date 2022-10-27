Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384460EDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiJ0CAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ0CAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825126564;
        Wed, 26 Oct 2022 19:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA67620ED;
        Thu, 27 Oct 2022 02:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53A7C433D6;
        Thu, 27 Oct 2022 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666836010;
        bh=fEmNsHQQ9juIELz/DqPpbf8dPuEX8/DoLTXLcXs/7vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLlYHemIJNjy8Vlfqm3abshkq+/C78tb/qpwJPNWeNURRUoggCTAScIoZLvTeYmKJ
         mNBdd+/m/ZyWpQ0CjCaWGjDl6uepoPpevVQNRghI4OgMISXIX37F19ZLjQvzQiC9yP
         NZok2HF26kx6Y2JWilgU0nVVjG/ncM2XKE39V32Ls47NuQgEsrAcBYqknC/pVpUEO7
         WhjEuWhnbQe4GxbSzYakLVkScWWsnf3SINrRvLhANYeRsXMdUGMm2bI46MPT9QQNw1
         wkxQzOR6ZX2yHfTpshT9sXS3H1DI8zb3b+/+R7DEj2gesFgMcMmXG3yOGLd6uPbaxc
         NWRrUnV4eML0w==
Date:   Wed, 26 Oct 2022 21:00:07 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: sa8295-adp: Enable DP
 instances
Message-ID: <20221027020007.bkbmqbodihxlefnl@builder.lan>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-13-quic_bjorande@quicinc.com>
 <Y1ke9xp8m5zWg+Mu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ke9xp8m5zWg+Mu@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:50:15PM +0200, Johan Hovold wrote:
> On Tue, Oct 25, 2022 at 08:26:24PM -0700, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The SA8295P ADP has, among other interfaces, six MiniDP connectors which
> > are connected to MDSS0 DP2 and DP3, and MDSS1 DP0 through DP3.
> > 
> > Enable Display Clock controllers, MDSS instanced, MDPs, DP controllers,
> > DP PHYs and link them all together.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> 
> >  &apps_rsc {
> > @@ -156,13 +240,169 @@ vreg_l7g: ldo7 {
> >  
> >  		vreg_l8g: ldo8 {
> >  			regulator-name = "vreg_l8g";
> > -			regulator-min-microvolt = <880000>;
> > -			regulator-max-microvolt = <880000>;
> > +			regulator-min-microvolt = <912000>;
> > +			regulator-max-microvolt = <912000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +			regulator-allow-set-load;
> 
> Did you really intend to allow set-load here?
> 
> I'm guessing this wasn't the case, but otherwise you also need to
> specify the valid modes.
> 

I see no reason for keeping it at this point in time, will drop it.

Thanks,
Bjorn

> > +		};
> > +
> > +		vreg_l11g: ldo11 {
> > +			regulator-name = "vreg_l11g";
> > +			regulator-min-microvolt = <912000>;
> > +			regulator-max-microvolt = <912000>;
> >  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> >  		};
> >  	};
> >  };
> 
> > +&mdss0_dp2_phy {
> > +	status = "okay";
> > +
> > +	vdda-phy-supply = <&vreg_l8g>;
> > +	vdda-pll-supply = <&vreg_l3g>;
> > +};
> 
> Johan
