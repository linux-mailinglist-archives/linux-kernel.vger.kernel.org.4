Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921663B62F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiK1X5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiK1X5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:57:31 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64251571C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:57:30 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id z9so5856114ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00pKbn9+H6xDvVmnJr0fVpmzLwRZcBMKb+33fEVyHU=;
        b=K41om2VBwJS7GGOdv9iQ58m39n/LVpqFq38dghn4Zur/nZMX0nuq0Ivlk+ezKJ5fIt
         lqaF1a8paZc9SaZiiVy3qUwVA209bJP0lCbuyFDyXP0fEFG0t8Mx+7b85M/CZPl2wtvC
         CkkDNNpND1/abyyWgjwT9n+OZU0zSFTGeXBu3D5MvyK3kINXZIvM3jCcsC3mFO/Vw1ec
         RSxX0k/1TGQmYamLuNMck04mhGeasSRhm2CG1HyoG6/BTWeQQ4nRQzo54BHqFWrJz5E+
         hYqc3f5em31WO49wKcxdP8PSAh1dU1z4c6OhVtL9OfuJj+ve52eR7jVsG42somZWVKzX
         bhaQ==
X-Gm-Message-State: ANoB5pmbOT9ACmAqNU5qTLP7mr6DAtdpJUfEsGP2ZpFo9q2rVJs8c72P
        3ZFs49lS0TMBNXujG6teSgmO2A==
X-Google-Smtp-Source: AA0mqf5SlAkoGQ/TCkMXOmL4n4pQuC48iVJEBauxfEbjXjep4YjY3Xye9sciBmjr3kykO/yVPeMpjA==
X-Received: by 2002:a05:6e02:4ac:b0:303:395:7359 with SMTP id e12-20020a056e0204ac00b0030303957359mr5806045ils.253.1669679849932;
        Mon, 28 Nov 2022 15:57:29 -0800 (PST)
Received: from google.com (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with ESMTPSA id n2-20020a027142000000b003585ff0233asm4799183jaf.150.2022.11.28.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:57:29 -0800 (PST)
Date:   Mon, 28 Nov 2022 23:57:26 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: lpass-sc7180: Return 0 instead of 'ret'
 at the end of _resume()
Message-ID: <Y4VK5ijXW7Kqnfjn@google.com>
References: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
 <20221128221152.2.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
 <CAD=FV=Uf3JiNf=339ktULYSUjreRU2k_tR2Q=LSNb+u-U4hQ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Uf3JiNf=339ktULYSUjreRU2k_tR2Q=LSNb+u-U4hQ6A@mail.gmail.com>
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:48:28PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 28, 2022 at 2:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > sc7180_lpass_dev_resume() returns 'ret' at the end of the function,
> > where 'ret' is always 0. Just return 0 to make it plain obvious that
> > this is always the success path.
> >
> > Also add an empty line between the error handling path and the
> > return.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> >  sound/soc/qcom/lpass-sc7180.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> > index 7a81e609727c..30a28e3152cb 100644
> > --- a/sound/soc/qcom/lpass-sc7180.c
> > +++ b/sound/soc/qcom/lpass-sc7180.c
> > @@ -173,7 +173,8 @@ static int sc7180_lpass_dev_resume(struct device *dev)
> >                 dev_err(dev, "sc7180 clk prepare and enable failed\n");
> >                 return ret;
> >         }
> > -       return ret;
> > +
> > +       return 0;
> 
> Yeah, I noticed this too when I was approving your pick. FWIW, I
> probably would have written this way, but it's 6 of one and half dozen
> of the other:
> 
> if (ret)
>   dev_err(dev, ...);
> return ret;

Yeah, I was considering this too, either is fine IMO :)

> ...but I just dug a tiny bit deeper and actually, there's no need for
> the error print here and it's just wasteful. clk_bulk_prepare_enable()
> already prints errors for you. So really this whole function could
> just be:
> 
> struct lpass_data *drvdata = dev_get_drvdata(dev);
> return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);

Right, the log isn't really needed if clk_bulk_prepare_enable() already
logs errors. I'll adjust the patch accordingly, and drop the first one
since 'ret' is going away.

> I guess theoretically one could even go further and look at pm_clk,
> but perhaps that's overboard.

Maybe let's leave that for another iteration :)

Thanks for the review!

m.
