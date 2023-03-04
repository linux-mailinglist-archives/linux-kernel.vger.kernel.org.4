Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290FC6AAC65
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCDUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:21:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883991ACFB;
        Sat,  4 Mar 2023 12:21:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j11so3940278edq.4;
        Sat, 04 Mar 2023 12:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677961298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INgV11plml1IBlee7DL8xge7m1ARbHsCq54faWydJTc=;
        b=nUU5S+Po/pMhW9DpAzhK52bV2vJxlOw3ZQCPHOyTjXDfbo5Q3WZKBK4Uta0DeAuRpU
         gcgQCwyiNb+avyHJwZaMSy+8HNTmnYGu/Lo9c2PuUcZrbDcQhRbXEzp8avs4hsbpR3+Y
         kVn+C5lxbhmjUBvcNyela/KvSQX7yVXtMykr69g43Rn2J1zanTeo8+Lnk3r8h0Pm88GK
         knrZ/L8WoC8kU09DK9TA7kJ7+uKCdUpMz4zTi6U/aSQN6iN0UjBCTTBt/Ia1CUS1r+S1
         AyL9LQjcxNwT4/HXqMV8CDXRXH8MA/kiI1o7sVjReEKyD0I1aI/H0kTV/Kvu7BI4TvUK
         aV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677961298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INgV11plml1IBlee7DL8xge7m1ARbHsCq54faWydJTc=;
        b=3v7ihDCDfxz758H9x6W+5mQYi4G2c4abndxCxrOc8eQgNiigntkLaw36OcqJqliGXM
         bg1oIMjyvKJylhbk8Hvohw35UtMPzNK1ErBIoOL1L6oLDBIX8IBP77Tc0DkZKZlnWmV/
         ePvg8RcaU084ymPi2BYSDhNAZJ/iAep/f89euVHLDo4RwudQIeDnq/GtpPr5RSM/PI/X
         isP0T2fAx650idmilvwQI/Zzbb18GbwzLDANz8sZO+pZ2B6vgg8BE+5WNTHcW7yGztcP
         tBMoQ3bVjnlAw4j97Cpa/h1bs1sF+ggIei3UxA6Oom4YF6OCNPjH750C4VCKXsjYfR33
         n1mw==
X-Gm-Message-State: AO0yUKUhfX8HStD7VK9qK3PGsp5z3EDlMg8793zsNlMz6CHTBLolz5Gn
        Xj8haZjByBzH2ZGCs1+6JIxH6aRHZQ0=
X-Google-Smtp-Source: AK7set+IA5I3dXRFwEY3Bo42AQxrAs3VEvUeUKBFvHfWTz4/rKjELqY0bjkOQNNeUi0gB4yAaiyAYw==
X-Received: by 2002:a17:906:f84c:b0:8b1:3a8d:6fc5 with SMTP id ks12-20020a170906f84c00b008b13a8d6fc5mr5126150ejb.25.1677961297946;
        Sat, 04 Mar 2023 12:21:37 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm2396208ejb.39.2023.03.04.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:21:37 -0800 (PST)
Date:   Sat, 4 Mar 2023 21:21:35 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <ZAOoT9IkzNT3BpZW@carbian>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
 <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
 <20230304164601.3888bbd4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304164601.3888bbd4@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 04:46:01PM +0000, Jonathan Cameron wrote:
> On Thu,  2 Mar 2023 14:04:35 +0100
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Move the kernel-doc of the function to industrialio-trigger.c
> > Add a note on the context where the function is expected to be called.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v2:
> > - Changed the expected context of from interrupt to hard IRQ context
> > 
> >  drivers/iio/industrialio-trigger.c | 7 +++++++
> >  include/linux/iio/trigger.h        | 6 ------
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index a2f3cc2f65ef..bb0a44df8740 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -192,6 +192,13 @@ static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
> >  		schedule_work(&trig->reenable_work);
> >  }
> >  
> > +/**
> > + * iio_trigger_poll() - Call the IRQ trigger handler of the consumers
> > + * @trig: trigger which occurred
> > + *
> > + * This function needs to be called from a hard IRQ context.
> I tweaked this to drop the line below and to say
> This function should only be called from a hard IRQ context.
> 
> Fun subtlety of English that reminds me of the sign on the London underground
> escalators that said "Guide dogs must be carried" thus apparently limiting
> their use to people who could find a guide dog to carry.
> 
> Here we don't want to oblige all code to call the function :)

I was even going for "must be called from hard IRQ context" first :) but
then decided that I need more accepted patches before instructing others on 
what must be done in the kernel :)

--
Kind Regards
Mehdi Djait
