Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E225B84CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiINJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiINJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD07E005;
        Wed, 14 Sep 2022 02:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7455619CC;
        Wed, 14 Sep 2022 09:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74AC433C1;
        Wed, 14 Sep 2022 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663146456;
        bh=a4oeQ9990DuYd/BWlXz07HHJJwmCGoY/tMmXJ6CXqdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nW3axlEo4kHzRRBGPoxZL2lW9pAs5a6QreRrjlJCGV9i4t9he44mAzsMbluWr5lqK
         Wht6BSMuum8kHJYiieuOI9Zrc2MM3KWtUrs+z1kKlkDCXnaRPRIswmP7AVcraDDA8T
         dn+nLXmaFHXnG3ktrC4pYqo49Ap2U9Oyc4vY+u0NaoLAFM8F51R8SDKsy222kp6CaZ
         22ktpAjP1695EYATILGIs1cgUT7+XJCdBdcQuRgvNBBNHoVr/D3Y8Tm2S9Bkb0jfXb
         9/ZCwu2aqmRorTSvhxFWvEUIs49WFZHSBcwNcPa9/4yim+IgW/LvbuAAEcLDqnIHDM
         Ofjv6ZJg6hTkw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYOMq-0001At-He; Wed, 14 Sep 2022 11:07:37 +0200
Date:   Wed, 14 Sep 2022 11:07:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, mka@chromium.org, johan+linaro@kernel.org,
        dianders@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Message-ID: <YyGZ2D9LYYyF31Ug@hovoldconsulting.com>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
 <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
 <32211aef-6b87-ab5b-637b-7cf9610f6926@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32211aef-6b87-ab5b-637b-7cf9610f6926@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please try to wrap your replies at 72 columns or so. ]

On Wed, Sep 14, 2022 at 02:28:31PM +0530, Rajendra Nayak wrote:
> 
> On 9/14/2022 2:07 PM, Krishna Kurapati PSSNV wrote:
> > 
> > 
> > On 9/14/2022 12:39 PM, Johan Hovold wrote:
> >> On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
> >>> USB on sc7280 cannot support wakeups from low power states
> >>> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
> >>> only transitions to RET in low power.
> >>
> >> It seems this isn't just needed for wakeup to work. On both sc7280 and
> >> sc8280xp the controller doesn't resume properly if the domain has been
> >> powered off (i.e. regardless of whether wakeup is enabled or not).
> >>
> > Hi Johan,
> > 
> >    I believe you are referring to the reinit that happens in xhci resume path after wakeup happens:
> > 
> > [   48.675839] xhci-hcd xhci-hcd.14.auto: xHC error in resume, USBSTS 0x411, Reinit
> > 
> > I see that when USB GDSC is not in retention, we don't retain controller state and go for reinit and re-enum of connected devices. We are seeing an additional delay of around ~0.7 sec (in chromebooks running on SC7280) in the wakeup path for re-enumeration of connected USB devices. To avoid this, we wanted to put GDSC in retention during PM suspend.
> 
> ok, so perhaps the commit msg should be updated to something like
> 
> 'USB on sc7280 needs to prevent the GDSC from being turned OFF for a couple of reasons
> 1. To prevent re-init and re-enumeration of all connected devices resulting in additional delay coming out of low power states
> 2. To support wakeups from connected devices from low power states'

The fundamental issue here is that state is lost during suspend which
the driver doesn't currently (or can not) restore. Doesn't hurt to
mention the specific consequences you list above as well.

> >> Are you sure there's no state that needs to be retained regardless of
> >> the wakeup setting?
> >>
> >>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> >>> ---
> >>>   drivers/clk/qcom/gcc-sc7280.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> >>> index 7ff64d4d5920..de29a034e725 100644
> >>> --- a/drivers/clk/qcom/gcc-sc7280.c
> >>> +++ b/drivers/clk/qcom/gcc-sc7280.c
> >>> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
> >>>       .pd = {
> >>>           .name = "gcc_usb30_prim_gdsc",
> >>>       },
> >>> -    .pwrsts = PWRSTS_OFF_ON,
> >>> +    .pwrsts = PWRSTS_RET_ON,
> >>>       .flags = VOTABLE,
> >>>   };
> >>
> >> And what about gcc_usb30_sec_gdsc?
> > 
> > Currently wakeup is not enabled on secondary controller as its not required for end product platform (herobrine variant). So leaving the usb30_sec_gdsc as it is for now.
> 
> It perhaps makes sense to update that as well, and given this is a compute specific chipset and we dont have to worry about
> USB in device mode, its safe to assume if and when that controller is used (in future designs) it would only support host mode?

What would be the problem when using the controller in peripheral mode?
Don't you want to retain the controller state when suspended also in
that case?

Johan
