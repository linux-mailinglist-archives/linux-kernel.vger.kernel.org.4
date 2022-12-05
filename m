Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B405642BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiLEPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiLEPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:36:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F162D2;
        Mon,  5 Dec 2022 07:36:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o12so11550312pjo.4;
        Mon, 05 Dec 2022 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1vH1dvrgSyDnedzoMQstWazi20nrn3iOOtx2zZamBg=;
        b=gXYdttr/hZGmqCeq49R45h++zeLTuzTtdy5viSA5VeqJIUlCP4fCq4hGlPTuXAeWSB
         O85YPq35CJQsSpSf70AJyL8tYDKuSdAcQbswkkGD9FFUnYwUqISjZP1QYQVBBifGHp/+
         qsfkDKv4Li/ZFV9U6Nf5AtKHblX8swFcifPv/fmqtJ13I+Y+56bm67T7Lw7YwHbPbWEX
         m1OBU2jafVf49PlIKOKMgN9+g9Sixh1NVRppGTIKQL5e30YZ3d/YKiw954tq2+A74Gyr
         emZ6e6zrZaVXPbZLgthM1zGLncjLx9F3IIVchi0q8A3cCM52w8EjbETOjw2TvBxYrltA
         qgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1vH1dvrgSyDnedzoMQstWazi20nrn3iOOtx2zZamBg=;
        b=EilNxQhnVc4WEeuK4ohahOvQJNtooKLAIgxSzNLu2nGtOPEoXv3OLQ/TGddmhhRN45
         ajFlEykyrGpCpkr79tnki4Lmux51sqmpIRZuZVQvwzJU1FqFYMnbZ9bLtn36biYXD18j
         cfzJIZKKbhzUrYf9pk7pGmgMg2ECjQ7Eeemr5R/N280k9M2ETkDQVX7k2BN8ZZj2aLTF
         9yagjihs9Jkd7RDUjd56gjUAIccipNvrXhsoj+hXEBb0uX7YvwWyk6XvLMRZb3y40Q/4
         D+0bSrPUf2MztO0nIuxf/55e29MttPy7Zjwcr9E3pPo2RL4nCkld3ade60P944WmebGT
         VNjg==
X-Gm-Message-State: ANoB5pkCVlAHaMGStx5a8d7GQAl5XFGaiA1bQCqjnO+AtnOxdkXffpeG
        Qb7zf3SBKMU15stoZT16C8A=
X-Google-Smtp-Source: AA0mqf5c4Cau2Vpe+MTJhXmVTeWAFvXgR1+7eJNPK0+/QMr+kP4KI5MC3I3jE/FLZwxuUJisPRQDhQ==
X-Received: by 2002:a17:903:3306:b0:189:7d4d:b9a3 with SMTP id jk6-20020a170903330600b001897d4db9a3mr43284505plb.156.1670254566271;
        Mon, 05 Dec 2022 07:36:06 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adb0200b0020ad53b5883sm9440899pjv.14.2022.12.05.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:36:05 -0800 (PST)
Date:   Mon, 5 Dec 2022 23:35:59 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y44P3811P1KB5pEl@sol>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
 <Y41MxPthLjitvzEl@sol>
 <Y43fQFBcPgKtuKRZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43fQFBcPgKtuKRZ@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:08:32PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 05, 2022 at 09:43:32AM +0800, Kent Gibson wrote:
> > On Sat, Dec 03, 2022 at 10:38:45AM +0100, Linus Walleij wrote:
> > > On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > +The below table gathered the most used cases.
> > > > +
> > > > +==========  ==========  ===============  =======================
> > > > +  Input       Output         State        What value to return?
> > > > +==========  ==========  ===============  =======================
> > > > + Disabled    Disabled    Hi-Z             input buffer
> > > > + Disabled    OS/OD/etc   Single ended     [cached] output buffer
> > > > +    x        Push-Pull   Out              [cached] output buffer
> > > > + Enabled     Disabled    In               input buffer
> > > > + Enabled     OS/OD/etc   Bidirectional    input buffer
> > > > +==========  ==========  ===============  =======================
> > > 
> > > This looks about right to me, but we need more input, Kent?
> > > 
> > 
> > Firstly, I'm all for tightening up the driver contract, and hope that
> > whatever is decided will also be updated in driver.h itself.
> > 
> > I can also understand Andy wanting to add support for Bidirectional
> > using the existing API.
> > 
> > But, and please correct me if I'm wrong, the user has no control over
> > whether an open drain output is single ended or bidirectional, and
> > no visibility as to which the driver supports or chooses.
> > So the contract is still vague.
> > 
> > My preference would be for the driver API to be extended with a new
> > callback for the output buffer, say get_output(), and have the existing
> > get() always return the input buffer.  Both would return an error if the
> > buffer is unavailable or disconnected, e.g. in the Hi-Z case.
> > As per Hans' suggestions, this would keep the drivers simple.
> 
> That's not about keeping driver simple, it's about how from hardware
> (electrical) point of view we should recognize the GPIO signal value.
> And I disagree on the input buffer to be always involved (in particular,
> not all hardware may support that anyway). That said, I will send an answer
> to all you guys, but just to make sure that we are on the different pages
> here I state yet another time that this is not about solely software p.o.v.
> And yes, there is no simple answer to the question.
> 

To be clear, my suggestion is focussed on providing visibility to allow
the user to determine if their hardware supports their use case - without
them having to get out a scope to check.
And it doesn't care what those use cases are.

The fact that it also keeps the driver logic simple is a happy
coincidence, but I agree with Hans that that is a huge benefit and so
reiterated it above.  My bad if that gave the impression that was my
primary focus.

> > Then cdev could determine the approriate buffer to return, depending
> > on the mode.  Or, better yet, we extend that through the uAPI and
> > handball that decision to the user.
> 
> TL;DR: I don't like this idea.
> 

And yours paints us into a corner.

Cheers,
Kent.

