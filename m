Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DA710243
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjEYBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYBTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:19:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFFBE6;
        Wed, 24 May 2023 18:19:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so6779105ad.0;
        Wed, 24 May 2023 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684977548; x=1687569548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1o+V55E45CxNz+gKMdCFIHZHJ7htwLBTle0C7Zp+HO4=;
        b=OOzTp5ElA9ljZFVPtSPjbdW7BEP8KzxGh6zqkRrowYsqFOYrcT8/awzaaxImtkygOD
         xv1KQlb/ROeatc3tUaJaYSa6oLqv61owjdeDdEDE8B1INLmBXX0FNwWUTIEqqnG5DSPa
         +PTqfwcFJnt3yLA5ns0l206952qScxR6XRJOEqKJV16woOEkyhreNa8hPMYjsnwUyUOP
         pOGqa4jn4rjiuk9GaDnDtekj6kaMr/e2BShNo3bgJi0atTLkLME/rORUp6oSRlYXdOdi
         S94FVP5vIlKPN74eIS+4uFdjK0OlTY0WuQRsN9zlmXI2bFUNI3ATDty2gRjhLcDfztlV
         VoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977548; x=1687569548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1o+V55E45CxNz+gKMdCFIHZHJ7htwLBTle0C7Zp+HO4=;
        b=VmdEm+NkuvRM88UnJHy6cBk0SUKXzguFZPNsFKtA3x+Q1G8o42/We2LEIwVYwjFAWk
         mD2zXNeRaRWP6lNxCliKig0nhbnQtntGTN2EbYT2wlJQ21bj2Odoif/wxSOukNxfLCuQ
         +shwmVb9fepMcQHppc2QYgO7FcaVCS6z3EDou2LsyNosxMb6ihdvLdZ6jOVDRj8OaL5T
         6XWwJNQLdLGlLdInmT0IhCJ38lTXj72MTCjG659FQoHfiKkRC4V523qC59htnCLA5OcW
         luqdGktnOt6QENK1vmkyjIlzvPTUfcl0tQm/ngdrgsc9AubOcFJuDMtTZnGU3h7yLsAB
         ltUA==
X-Gm-Message-State: AC+VfDzmsKwmyp1tQERpQXe9CKPNbMAt4THPJHWOPWt8cHAE3WPa9x1q
        pn1kyNtPVQnGjXp5FD7PSqpaRwDkFa0=
X-Google-Smtp-Source: ACHHUZ7wPi1P4UA2XyHD1SE/2XBgtSY+M9ipfpcN49OIAlP/FU6BThZV6zlDz+YQNNLk6dU3jCUX2w==
X-Received: by 2002:a17:902:e80e:b0:1af:a049:45d with SMTP id u14-20020a170902e80e00b001afa049045dmr16673198plg.18.1684977548229;
        Wed, 24 May 2023 18:19:08 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001aaec7a2a62sm86042plk.188.2023.05.24.18.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 18:19:07 -0700 (PDT)
Date:   Thu, 25 May 2023 09:19:02 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: using libgpiod to replace sysfs ABI (was Re: [PATCH] gpiolib:
 Avoid side effects in gpio_is_visible())
Message-ID: <ZG63hiXloQl/YZDX@sol>
References: <ZGzsD_HMbMGhGwcr@surfacebook>
 <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol>
 <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:53:12PM +0000, Chris Packham wrote:
> (culled the Cc list but hopefully those that might want to chime in are 
> on linux-gpio)
> 
> On 24/05/23 17:41, Kent Gibson wrote:
> > On Tue, May 23, 2023 at 09:17:26PM +0000, Chris Packham wrote:
> >> On 24/05/23 04:38, andy.shevchenko@gmail.com wrote:
> >>> Wed, May 17, 2023 at 09:30:51PM +0000, Chris Packham kirjoitti:
> >>>> On 17/05/23 20:54, Andy Shevchenko wrote:
> >>>>> On Wed, May 17, 2023 at 2:50 AM Chris Packham
> >>>>> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>>>> On 17/05/23 10:47, Kent Gibson wrote:
> >>> ...
> >>>
> >>>> Again the problem boils down to the fact that we have a userspace switch
> >>>> driver (which uses a vendor supplied non-free SDK). So despite the
> >>>> kernel having quite good support for SFPs I can't use it without a
> >>>> netdev to attach it to.
> >>> That user space driver is using what from the kernel? GPIO sysfs?
> >> Yes GPIO sysfs and exported links with known names, which allows things
> >> to be done per-port but also wildcarded from shell scripts if necessary.
> >> I think the key point here is that it doesn't care about the GPIO chips
> >> just the individual GPIO lines. Anything involving libgpiod currently
> >> has to start caring about GPIO chips (or I'm misreading the docs).
> >>
> > As previously mentioned, the libgpiod tools now support identification of
> > lines by name.
> 
> The libgpiod tools do but not libgpiod itself. The tools are reasonable 
> replacements for things that are currently done in shell scripts but 
> there is also application code that needs to care about GPIO lines but 
> ideally it shouldn't need to care about GPIO chips.
> 
> > As long as your line names are unique at system scope you should be
> > good.  Otherwise you have no option but to identify by (chip,offset).
> >
> > Wrt the library itself, I was thinking about relocating the line name
> > resolution logic from the tools into the library itself, so it would be
> > more generally accessible, but haven't gotten there yet.
> 
> Yes I think that'd help my use-case. Even if there were APIs to iterate 
> over all possible GPIO lines and let the application worry about how to 
> match the names.
> 

Even that is a bit of a minefield, as there is no guarantee that line
names are unique across the system.  I'm not even sure they are unique
across a chip.

So what order do you iterate over all the lines?
In chip order?  Chip names/numbers aren't deterministic.
The latest tools go in chip name order - human sorted, which is probably
the best we can do - it at least makes sense to the casual user.

The big problem being, once we put in the library proper it is etched in
stone, so we want to get it right and not open any cans of worms.

> > I'm also of the opinion that libgpiod is too low level for common
> > tasks.  That is necessary to access all the features of the uAPI, but
> > for basic tasks it would be nice to have a higher level abstraction to
> > reduce the barrier to entry.
> >
> > e.g. in Rust I can do this:
> >
> >      let led0 = gpiocdev::find_named_line("LED0").unwrap();
> >      let req = Request::builder()
> >          .with_found_line(&led0)
> >          .as_output(Value::Active)
> >          .request()?;
> >
> >      // change value later
> >      req.set_value(led0.offset, Value::Inactive)
> >
> > which is the equivalent of the sysfs
> >
> > echo 1 > /some/sysfs/line
> > ...
> > echo 0 > /some/sysfs/line
> >
> > That is bad enough. It pains me to see how complex the equivalent is using
> > the libgpiod v2 API (or v1), and that is not putting any shade on Bart or
> > anyone else who worked on it - there are a lot of constraints on how it
> > is designed.  It just doesn't feel complete yet, particularly from a
> > casual user's perspective.
> >
> > One of the things I would like to see added to libgpiod is a set of working
> > examples of simple use cases.  Formerly the tools took double duty to
> > fill that role, but they've now grown too complex.
> > Those examples would highlight where we could provide simplified
> > higher level APIs.
> > Then rinse and repeat until the simple use cases are simple.
> 
> I was a little put-off when I noticed there was an looming API change 
> the last time I looked at libgpiod and unfortunately any time I had to 
> spend on updating the application code has now passed.
> 
> I think modulo the problem of line discovery the current API would do 
> what I need. As you've said having some examples in the docs would go a 
> long way.
> 

I don't mean examples in docs, I mean working code examples.
That beats docs every day in my book.

> It'd also be great if there was some way of ensuring that a line's state 
> is kept after the application has released the request (i.e. the txdis 
> case I mentioned). But that probably needs work on the kernel side to 
> make such guarantees.

To be clear, I am suggesting extensions to the API, not changes to it.
libgpiod v2 is fixed and the functions therein will remain as-is.
But v2.1 could get some additional functions to make common tasks easier.
At least, that is what I would like to see.

Cheers,
Kent.
