Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD75F48F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJDRyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJDRx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:53:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194A59255
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:53:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y20so389385qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5Vo8p/cM3obgtfs2skgCytAWp05nMFJ/Nn5TC15GrH0=;
        b=ac3xFb73L4PnwMtdIaThuvvAQcWUY2Dv379FdTurNx3wBZ1HfqE4DJXNR49NS2P7uZ
         +XiC1P3MjxL6lUacUwgsaXJEPy7zrm7NLtWgNtquaD2rMLeQbdItWAv5UoARVmtsTSpe
         HOShdLT2KMhwAliZjGDugL/+Qnrb4T0qT70Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5Vo8p/cM3obgtfs2skgCytAWp05nMFJ/Nn5TC15GrH0=;
        b=VjmXCSjYryyFYX6Jo9wAceJp1aPABaO7JH1OVGQ5CUFG3ZgKfpJM+TieTyvEwf1QXc
         EVF3tsYeuNfhZ8Tqku5DSfvYYqGmrC24/u0aMKBgk6O35tDyRI8qMtewQ46CJ0rqxKkj
         /Y9XyWwsN/QZsVz9uDxOhc823MCLF1kSopdze0XQ9pERUoH3uquznZ8t3OqzbBDZDXLN
         Z0uzoeZpr+X5GB0CrykojOFBelEJ94LNqOmT1GHh3pibDC9mWxkDRuHRs34AVJQ1f1Bi
         dXMTXdTTrY/gURm0rWe9+fkA72rMfzv3thXqPalTzP9XMuOV2Bp6NbOP6x6yeSS86eZb
         C5Fw==
X-Gm-Message-State: ACrzQf0n90ePaOMPLW6rupWJyIWXgfG1nu3he/7XYVDqHXGzXIoTuvGH
        5mUyjvPSmy7ZkB4DYZcClx70Sw==
X-Google-Smtp-Source: AMsMyM6rucTJ1CQBuNL9rJOQoDLHcHv38gQgU5eP8vFeKD58IMo0QpEfmLy9aTnmshF6GZNlOknXzw==
X-Received: by 2002:a05:622a:164d:b0:35c:c465:911b with SMTP id y13-20020a05622a164d00b0035cc465911bmr20054305qtj.250.1664906036554;
        Tue, 04 Oct 2022 10:53:56 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id l18-20020a05620a28d200b006ce813bb306sm15174832qkp.125.2022.10.04.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:53:55 -0700 (PDT)
Date:   Tue, 4 Oct 2022 13:53:54 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:19:24PM +0200, Thorsten Leemhuis wrote:
> Hi!
> 
> TLDR: Core Linux kernel developers are unhappy with the state of
> bugzilla.kernel.org; to improve things I plan to change a few important
> aspects of its configuration, unless somebody comes up with better ideas
> to tackle current problems: (1) Create a catch-all product making it
> totally obvious to submitters that likely nobody will look into the
> ticket. (2) Remove or hide all products & components where the subsystem
> didn't fully commit to look into newly submitted reports. (3) Change the
> text on the front page to make it clear that most kernel bug reports
> need to be sent by mail.

Here's my counter-plan, which builds on top of yours.

1. Create a Kernel/Kernel product that acts as a starting point for all bug
   submissions.
2. Create and maintain a mapping from MAINTAINER subsystem entries to
   Product/Component categories in Bugzilla (the scheme to be established).
3. Establish and maintain a team of designated triage people who are willing
   to look at incoming bugs to either:

   a. quick-close them as non-actionable (tainted kernel, distro kernel, spam)
   b. obtain missing information from the submitter as necessary
   c. figure out the correct component to assign, to the best of their ability
   d. set a "triaged" flag

4. a backend monitoring bot will track all bug changes and, when it sees a bug
   get the "triaged" state, it will:

   a. create a useful bug summary from all bug comments
   b. figure out who to notify based on the mapping (see #2 above)
   c. send out the email to everyone identified

5. the same backend monitoring bot will track responses and update the bug
   comments as needed; any comments added via the bugzilla site will be
   similarly sent out as follow-up messages.

6. the bot can also monitor commits and other discussions via lore.kernel.org
   and automatically add comments/links when it sees the bug mentioned
   elsewhere.

I'm happy to take care of everything bot-related (apparently, programming bots
is what I do now -- I just wish it was the cool and glamorous kind).

As I have stated multiple times, the hard part will be keeping a team of
people who are willing to do the bug triage work, but maybe we can start with
Greg KH using his intern funds to hire someone (assuming he's not already
using these funds for someone to help him with all the other tasks).

Does that sound like a plan for everyone?

-K
