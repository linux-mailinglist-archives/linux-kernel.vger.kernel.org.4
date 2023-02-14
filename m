Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40801696941
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBNQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBNQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:11 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845817CD7;
        Tue, 14 Feb 2023 08:23:10 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h24so18154382qtr.0;
        Tue, 14 Feb 2023 08:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hnAkgZ2IxOZvRal3LVcrFQf5peXSWgVRjceSuVbVnA=;
        b=YWfk0yYBuyNo5BNqtAwoYS3qD4nOlJeEM7Q1daXTH6/12FhowxDiZkuEgFsDoeg7n8
         q7YTEBhH5G8HZK3q1sr5ImnsmskBaPc+g0Fd5Pm3S45g831bIy2P/ARiL4xLc8fHbbAV
         i5DZkyQ8rZxvQHSCrsfT8N4j13Gh3dXMYGmoGv0myM2Ur90/tci+CXsVvgezQFY9EdpP
         WWRgaN143B52jgorHY58tlagcyyv/7Qf1I0kFA1IHT9Q+BuyCNSIe1HCh+eHQ+mt87na
         yQqmiNS2Dzutb98H1nkrCdsJssKsQPHZmbZT1wAzBy7olYwKNxTLvJyHiU20LX13ELpW
         mzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hnAkgZ2IxOZvRal3LVcrFQf5peXSWgVRjceSuVbVnA=;
        b=zDuu2Jta7ZfFlp1I4eNcY9Bued/6P+cWkDegyOtqgJ6eYprGDLDT/PHMaX61pGp9TV
         ENRCZiIzySFQhh9np70qvBBAbmgSiUqV2nEdAyQ1OHDmNGVhB70CqSpji+2jr5uRt3dQ
         cmwiWBk9wqCGDOXi1QXXnmmqkxsG701d27Ic0Ld/inmpY2hXlgz5HCwz7TGbxriHkpBS
         Qgg+KarnAXED2mjqoXXhSaDNyhkT3HuJi8KJp/pjLrbtTzHBnK+4H0zRhzOY6ZAQ0cTR
         J5fTFeyBIyPk5AGfJBPpvgc2fgyu9q8a2Ewbmv0VaqGpfp8cqT2mZc7Slt8KHiSBkI8T
         Z7Zg==
X-Gm-Message-State: AO0yUKWJR9j70c7dH1ThoIpQFHOJruAPUmbt/dITSqV7BnYZGZr72tbn
        xPtnbLu2drUG1NcTVonyKmbLKnLik/4=
X-Google-Smtp-Source: AK7set8PtoBKYDLTw6SfcPIqj393orllwV0CS7JnqBqcaMxN7Vfsv797u7qWd6hRxwkrVoaShLgbcg==
X-Received: by 2002:a05:622a:19a4:b0:3b9:ba79:80d7 with SMTP id u36-20020a05622a19a400b003b9ba7980d7mr5058645qtc.12.1676391789545;
        Tue, 14 Feb 2023 08:23:09 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l26-20020ac8459a000000b0039cc0fbdb61sm11608963qtn.53.2023.02.14.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F0F727C0054;
        Tue, 14 Feb 2023 11:23:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Feb 2023 11:23:08 -0500
X-ME-Sender: <xms:arXrYyWIfIBCHjP_3B8Cm0Yp-vvzu8lUtyHrOLk_VEW8NCcxL35Jdw>
    <xme:arXrY-lRaXfRWGn--c4CQ_Ey9CEMA17giHyHXr7dNY_0dlWILS9pvyhy1sj-8tKP9
    0WhBQwK5OGJ4rWsrQ>
X-ME-Received: <xmr:arXrY2aOm_8jyqxVxzg5QuOgExJLn6C5qcZoREAlcqRo49wU9akTvqGS1gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:arXrY5WxFpaR1KUq4um45FDFjTIfJgUVZ4UMCaCf6KpN0w_t3z-qwA>
    <xmx:arXrY8k-1XIKnDPrhObLgc5sX7jfZWXP7XokRpeiuy_e6Mk20bqdZw>
    <xmx:arXrY-ftZiuhsNvgcOvelDviXXiiuLS5Td_N4xApCayAzAqa2oqgbA>
    <xmx:bLXrYx9XAFkJcfd81HZ4iPeJdV-B5ejOyyVmgVnwhq8ELkvhytfdFA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 11:23:06 -0500 (EST)
Date:   Tue, 14 Feb 2023 08:22:28 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+u1RBMMcCkvKISZ@boqun-archlinux>
References: <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
 <Y+tm59SmBEY1Ywq7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tm59SmBEY1Ywq7@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:48:07AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 13, 2023 at 05:51:11PM -0800, Boqun Feng wrote:
> > On Mon, Feb 13, 2023 at 05:29:49PM +0100, Peter Zijlstra wrote:
> > > On Mon, Feb 13, 2023 at 10:25:59AM -0500, Alan Stern wrote:
> > > > On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> > > > > On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > > > > > Provided it acquires the parent device's lock first, this is 
> > > > > > utterly safe no matter what order the children are locked in.  Try 
> > > > > > telling that to lockdep! 
> > > > > 
> > > > > mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> > > > > exact pattern, it allows taking multiple child->lock class locks (in any
> > > > > order) provided parent->lock is held.
> > > > 
> > > > Ah, this is news to me.  Is this sort of thing documented somewhere?
> > 
> > Basically if you have two lock instances A and B with the same class,
> > and you know that locking ordering is always A -> B, then you can do
> > 
> > 	mutex_lock(A);
> > 	mutex_lock_nest_lock(B, A); // lock B.
> > 
> 
> No, this isn't quite right, You need at least 3 locks and 2 classes.
> 
> P, C1, C2
> 
> Then:
> 
> 	mutex_lock(P)
> 	mutex_lock_next_lock(C1, P)
> 	mutex_lock_next_lock(C2, P)
> 
> And it will accept any order of Cn -- since it assumes that any
> multi-lock of Cn will always hold P, therefore the ordering fully given
> by P.

Ah, right, I was missing the fact that it works with 2 classes...

But I think with only one class, the nest_lock() still works, right?
In other words, if P and Cn are the same lock class in your example.

Also seems I gave a wrong answer to Alan, just to clarify, the following
is not a deadlock to lockdep:

T1:
	mutex_lock(P)
	mutex_lock_next_lock(C1, P)
	mutex_lock_next_lock(C2, P)
	mutex_lock(B)

T2:
	mutex_lock(P)
	mutex_lock(B)
	mutex_lock_next_lock(C1, P)
	mutex_lock_next_lock(C2, P)

Because of any pair of

	mutex_lock(L);
	... // other locks maybe
	mutex_lock_nest_lock(M, L);

lockdep will not add M into the dependency graph, since it's nested and
should be serialized by L.

Regards,
Boqun
