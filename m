Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFF67EA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjA0QPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjA0QPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:15:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C207AE59
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so1480716wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCnQvs4k+RsVxmk5hbaJTKv6OSpPLB/I5YR+Z678LJQ=;
        b=OpFQhIKqlOlrFxqED4JLUirFh3ZaiWAH9Yg4vS+YyJ9kvKAX6AGzDqBXlmDdQMLLST
         DG3/Ead425z+bVErrTwKs8/G/rUAQ6TF8HXshvK2F/4II+gVpgmy4hvSJmuTnaV7in24
         PwQnHzOIy6bUwMF+aAIjEV4C8KPpNNpTw5539MkJynbyKuL0OtjvPuxZtts8j253bPW/
         X33+49gmh94NNr5GgQEr+OK/mTfeFdxCjH2R+vItRDTbXJg4G4n2NKtTlAgAQEGhI087
         gP3DITzofiar2c1Ma10fVWo2QJ625eoLtjsKLsuoZzgO2IxXU1ltWG4gmLOabAX6LQlg
         ND2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCnQvs4k+RsVxmk5hbaJTKv6OSpPLB/I5YR+Z678LJQ=;
        b=pluhSei0BUsU6S/lXHEN9Uy+H9F8Y3BufmzKfitYnUvmzmgU/1N8JByGTz42uvJZFL
         4xc2I7QWh3kfqKNxPvb6nl09VRDEuzV08kc9/DirqXr/MfSbMVQz2e+buTqMi4mEEKM/
         UR0ybLEFzckoW6z0uB+EgmoteekPkkpf4lFanqnTmWxOeWWADskPXIMAqshZtNDOj58E
         IivIsyTmFfK49HdppEhcKo5T3wDAh8s8nRF+FiPqi8aE3n3vNtmKvdiB/SgxVoN3crZX
         98zI47cohczVG1cJ2qXQ36SEQesQkMg6vr4Li3grClT1lBgTXAxv7JlWktFcmRgP+jnj
         Xhew==
X-Gm-Message-State: AFqh2kpic5W31w8XQwfl4FQfJsYcRSCoogBrt78hraTJaZwoDYsrN4r/
        h+iAJsAmllgWcfrBh1KVk+Wd5w==
X-Google-Smtp-Source: AMrXdXsWvYVaDXnaOI9NPoFW70XXGq3cJCqwZ+jzXypn1dndt2N9okp2CHRoYHrKauKTp+X/paSbPA==
X-Received: by 2002:a05:600c:3d8d:b0:3d2:bca5:10a2 with SMTP id bi13-20020a05600c3d8d00b003d2bca510a2mr39652457wmb.22.1674836105224;
        Fri, 27 Jan 2023 08:15:05 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c071500b003db1ca20170sm4676925wmn.37.2023.01.27.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:15:04 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:15:03 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Disable HW control until supported
Message-ID: <Y9P4h5H78ZkgTpIY@linaro.org>
References: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
 <40b90d7309246484afa09b2d2b2e23e7.sboyd@kernel.org>
 <20230112215038.7rl6fzbprj7xsny4@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112215038.7rl6fzbprj7xsny4@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-12 15:50:38, Bjorn Andersson wrote:
> On Thu, Jan 12, 2023 at 11:10:40AM -0800, Stephen Boyd wrote:
> > Quoting Bjorn Andersson (2023-01-12 05:52:24)
> > > Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but in
> > > some scenarios it's beneficial to let the hardware perform this without
> > > software intervention.
> > > 
> > > This is done by configuring the GDSC in "hardware control" state, in
> > > which case the SW_COLLAPSE bit is ignored and some hardware signal is
> > > relies upon instead.
> > > 
> > > The GDSCs are modelled as power-domains in Linux and as such it's
> > > reasonable to assume that the device drivers intend for the hardware
> > > block to be accessible when their power domain is active.
> > > 
> > > But in the current implementation, any GDSC that is marked to support
> > > hardware control, gets hardware control unconditionally while the
> > > client driver requests it to be active. It's therefor conceivable that
> > > the hardware collapses a GDSC while Linux is accessing resources
> > > depending on it.
> > 
> > Why would software want the GDSC to be enabled and accessing resources
> > while the hardware signals that it isn't required?
> 
> Wouldn't you want a logical OR between these two? As currently written,
> no attention is given to the software's need for keeping the GDSC
> active.

Looking at this more closely, it is weird nobody complained about GDSC
consumers collapsing out of the blue yet.

> 
> > It sounds like hardware control isn't complete?
> > 
> 
> Correct, we're lacking the means for a client driver to affect the
> hardware vs software control.
> 
> > > 
> > > There are ongoing discussions about how to properly expose this control
> > 
> > Any link? When we implemented hardware clk gating years ago the design
> > was to have software override hardware control when the clk was enabled
> > in software and let the hardware control go into effect when the clk was
> > disabled in software.

Discussion is off list for now.

> 
> That sounds very reasonable, but it is not what's implemented in this
> file.
> 
> In gdsc_enable() we disable SW_COLLAPSE and then immediately give the
> control to the hardware, and in gdsc_disable() we disable hardware
> control and then set SW_COLLAPSE.
> 
> So effectively the GDSC state is either off when Linux says so, or in
> hardware control.
> 

The discussed solution is the have a generic genpd API that is
specifically for marking a PD in HW-controlled mode, while keeping other
resources enabled from the consumer driver.

> > Hopefully with power domains this could be
> > implemented in a better way by connecting hardware mode to some
> > performance state so that enabling the power domain goes to software
> > mode and then transitioning to a performance state switches to hardware
> > control mode.
> > 
> 
> Right, this would allow the software to keep the GDSC on, give the
> control to the hardware or collapse it.
> 
> The question is how the "some performance state" should be implemented.
> 
> > > to the client drivers, but until conclusion in that discussion is
> > > reached, the safer option would be to keep the GDSC in software control
> > > mode.
> > > 
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---
> > >  drivers/clk/qcom/gdsc.c | 48 ++++++-----------------------------------
> > >  1 file changed, 7 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > index 9e4d6ce891aa..6d3b36a52a48 100644
> > > --- a/drivers/clk/qcom/gdsc.c
> > > +++ b/drivers/clk/qcom/gdsc.c
> > > @@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
> > >                 on = true;
> > >         }
> > >  
> > > +       /* Disable HW trigger mode until propertly supported */
> > > +       if (sc->flags & HW_CTRL) {
> > > +               ret = gdsc_hwctrl(sc, false);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }
> > > +
> > 
> > Is it a problem for all hardware controlled gdscs? Or just some of them?
> > Should we backport this to stable kernels?
> 
> Sorry, I probably wasn't clear enough. There is no observed problem,
> this simply knocks out the hardware control mode.
> 
> The reason for sending this ahead of a design conclusion is that the
> current behavior doesn't make sense to me (Linux says "enable!" and we
> just ignore that) and consider how the "some performance state" would
> relate to this, I don't see that it will be an amendment to the current
> flow.

I agree. The fact that this did not create any issues yet doesn't mean
we should stick with the current implementation. In fact, disabling
HW-control altogether (for now) is more reasonable.

> 
> > I seem to recall that hardware mode was required for some drivers like
> > camera and video?
> 
> Given that the current implementation only adhere to the hardware signal
> in-between gdsc_enable() and gdsc_disable(), the drivers for these
> blocks must have been written such that the software-state covers the
> needs of the hardware.
> 
> As mentioned above, the opposite is however not clear. The GDSC might be
> collapsed at any time, even if Linux thinks it has the GDSC
> non-collapsed. I not clear to me why the current logic hasn't caused
> strange issues for us over the years...
> 
> > Are they going to keep working if we simply knock out the hardware
> > control mode here?
> 
> If anything, we might keep the light on longer than today by missing
> opportunities where the hardware control currently collapses the GDSC
> behind Linux's back - and we haven't noticed.
> 
> Regards,
> Bjorn
