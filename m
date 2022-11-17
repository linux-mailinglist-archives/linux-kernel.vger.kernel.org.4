Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C262D49F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiKQIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiKQIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:05:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065D716E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:05:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs21so2347856wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKXYExdFPBk6x5LL48YmrBCt/Ex+r4UJ3aXw7toOApc=;
        b=JbcW44dILJwm0wi2gWylt6XUA0QoEFA2sBCQ9vchinitjnk2CVTPOoED5IVzakXcko
         Mum8HNtrKiWiAXYGrXGaNNeIRt6YWRHbT7YmpbhopIX3X9pWf0KBztjMvyE43SMRyxYY
         uyVi7BAZdhRiFt73AtL74DeKif/2MjxAIjBvP6k1BoE6pRLSxsQxLknREs311LxHFSRZ
         Z9vdG21Mby0rs/9Q1EIFLfxIaJauGzqoMEMLS7u5qDo6nJb5CT+rroC4LWaxeRNHYW1r
         TjG/UEXMPyINJ/TZ+vawpX+rhK03JrFPZdQbdyX65J9otSrnVeEIeSh34fzH1m66qSC6
         sIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKXYExdFPBk6x5LL48YmrBCt/Ex+r4UJ3aXw7toOApc=;
        b=BDmtx6kE0dwtNREQYVB5f/UNsYgEMHJU/ursDGTugyIc/aSWhGfRRlBJ6R7pEHLwu6
         HznKtvyUVxkIhSYVuIXdBynj+5amM5HLCWt2vHRuZAoZSUXTwMOFcfbYYUKunep83mLu
         sz5WJziYUZndf0LIONFQrsiehhrL8N3/rQqunrkZkIeKBiPMg0DRmglEj//S0zKwtIPs
         8urx2xQ0R0RYpxSzQgvwoyEIt96nT2ur5QtTtvtxbjcjfMnqEKuTzG14IvOvzUqWtixS
         ITc2ycoZzZMCAjgvX+v9wfx7KAvexqG/KFGbNZ/FxIcV0ua1jXqJYlchDA3HM451nXRs
         7R+w==
X-Gm-Message-State: ANoB5pm/73Ni5ursPrJWUTV7qkT+hkaUSLOUrDrmhRNNiVWm3vknsnq5
        HuIdqT8m4c1cwiXFW8en2a8dlg==
X-Google-Smtp-Source: AA0mqf4z1Vw0osU9THOIqfd9q3COzRk87Bb9SpjfWJEe8ARfejulNJEeCFJYH4ns55QzuC7Fx9ys2A==
X-Received: by 2002:a5d:440a:0:b0:238:3dc7:2adc with SMTP id z10-20020a5d440a000000b002383dc72adcmr708168wrq.160.1668672324057;
        Thu, 17 Nov 2022 00:05:24 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003cffd3c3d6csm452796wmq.12.2022.11.17.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:05:23 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:05:22 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/9] clk: qcom: gdsc: Add configurable poll timeout
Message-ID: <Y3XrQrnT0dxTvc5S@linaro.org>
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-3-abel.vesa@linaro.org>
 <9c5b6037-c962-81d3-41c1-a9ec459c9adc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5b6037-c962-81d3-41c1-a9ec459c9adc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 12:19:09, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 11:47, Abel Vesa wrote:
> > Depending on the platform, the poll timeout delay might be different,
> > so allow the platform specific drivers to specify their own values.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/clk/qcom/gdsc.c | 5 ++++-
> >   drivers/clk/qcom/gdsc.h | 1 +
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 0f21a8a767ac..3753f3ef7241 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -107,7 +107,7 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
> >   	do {
> >   		if (gdsc_check_status(sc, status))
> >   			return 0;
> > -	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
> > +	} while (ktime_us_delta(ktime_get(), start) < sc->poll_timeout);
> What about the second usage of TIMEOUT_US (in gdsc_toggle_logic)? Is it fine
> for that to be the default value?

The usleep you mention is not really for polling the state.
So I think it should stay as is. Who knows, maybe in the future we will
need to have the configurable as well, but as a toggle delay rather than
a status poll timeout.

I added this configurable poll timeout just because I saw that
downstream, each driver has different values. And it kind of makes sense,
because the state machine inside the GDSC might be different between
platforms, and so, it might take different time to reach a certain on/off
state.

Thanks,
Abel

> 
> 
> Konrad
> >   	if (gdsc_check_status(sc, status))
> >   		return 0;
> > @@ -454,6 +454,9 @@ static int gdsc_init(struct gdsc *sc)
> >   	if (ret)
> >   		goto err_disable_supply;
> > +	if (!sc->poll_timeout)
> > +		sc->poll_timeout = 500;
> > +
> >   	return 0;
> >   err_disable_supply:
> > diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> > index 803512688336..9a1e1fb3d12f 100644
> > --- a/drivers/clk/qcom/gdsc.h
> > +++ b/drivers/clk/qcom/gdsc.h
> > @@ -36,6 +36,7 @@ struct gdsc {
> >   	struct generic_pm_domain	*parent;
> >   	struct regmap			*regmap;
> >   	unsigned int			gdscr;
> > +	unsigned int			poll_timeout;
> >   	unsigned int			collapse_ctrl;
> >   	unsigned int			collapse_mask;
> >   	unsigned int			gds_hw_ctrl;
