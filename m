Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF069562B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBNBx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBNBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:53:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73446B473;
        Mon, 13 Feb 2023 17:53:55 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cr22so16060591qtb.10;
        Mon, 13 Feb 2023 17:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTwthzEuN1THCOBEyCBtHJDGzrvYVM+c57oDXwGKXKs=;
        b=mmmhTXtB2tugw6h/F4YGTs4i1gE8X2h2BNyXY1OkBD+JyRvTOE16QrBsyqk76CXQqA
         rfWa45yckF/IN5brlQOOeVTqan3jGESf/rtgIvo/JRoi4G9mlQUXA5uZs3uvDhQktiht
         wk08QVZSgwltWUKshsq+KbFSJyslGdizp6xe9zmMP9xSEQAqN1vbYZVHASlAZV36SFJe
         m8PRsyFibz1AS/+Ojw84t3YDQ14d7wU9gBwmqbku1AWZlvalH7BZs3yRGCXWWS1G5QvU
         XRS3LnptNAJty5tafxjyPRN2+c525ecQQWSn+qhdfdrM0zjWc1KlS80XBu/lYX0/pxmM
         KvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTwthzEuN1THCOBEyCBtHJDGzrvYVM+c57oDXwGKXKs=;
        b=ajpi5Pz2ufgE4ci81Xz3R/cadzq+gozLOSWN5yusFRHVdUaPiOliHMvSv4sL2JBL8g
         bxqDboKh5dRkjaQdfbnlBGcLGhdvK0QJC4TEXQoUPXEauLH0rj7Br3DjbP1sPS5bt7U6
         DT3BfFNJfVaxyZ+MT3d0IRpFAZzYySsJRVRjbB/6N0q5Z1LR8yYW7ivBXqtdwPUM9PzG
         kynjJu3VlLirJLdcd7FCnNc/RViExtlwyVAAdDhngU6ujANyCHAId6GUUnkTyi5fwUwr
         nvHPmFn6bDRBKVSGaNz/UugcBbkG/sih3WrLwFkHj+ueh8KOGXzLoe2fLSe7TbuV9sZm
         lgOg==
X-Gm-Message-State: AO0yUKXYMe9asUaoDRJWFkkrkOo0dBvdEZ/hYi0AwBLWEK0hsWp80xWj
        gArhNEBB6hgDjG/5c2nj6dM=
X-Google-Smtp-Source: AK7set9rSz7NGOq22JX6V+peY5Dl5Uxgj42bdXqKRHXdFM3mPK6GHA3ioULppxq1X702kEjrGDnWDg==
X-Received: by 2002:ac8:5b92:0:b0:3ba:2722:e8d7 with SMTP id a18-20020ac85b92000000b003ba2722e8d7mr1030145qta.7.1676339634636;
        Mon, 13 Feb 2023 17:53:54 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h19-20020ac87453000000b003b9a6d54b6csm10288939qtr.59.2023.02.13.17.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 17:53:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 965DD27C0054;
        Mon, 13 Feb 2023 20:53:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 Feb 2023 20:53:53 -0500
X-ME-Sender: <xms:senqY9_vgotYnV_ooyJBQMwd0YwwFvJH6Sg-METUa_TDXm8YkwcTQQ>
    <xme:senqYxuYzNXGObEqzT8lc99MdnfMQ9qU6Klo4DFD2k09A1uncZA0QPEhj4pNPwoVq
    aoy8hihIcNl0BOqPQ>
X-ME-Received: <xmr:senqY7BdCXOI57l8o7_AtLHnCk0FrhoYcXDA0vKpfu8gtNNCQd2e4K3ymF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:senqYxdwTKglzyK0bvOZoejDnoym2T8yp_6hNDWzrqjlPuoPhcfL5A>
    <xmx:senqYyMouNgyUGhOBoy5GWKt6T0MUG4VhcxVlL-C455HNnuotXucmw>
    <xmx:senqYzklo5UOXcbYvQMgBg49ShUCEjCJizLbQekXVFB0NNFGcUsd-A>
    <xmx:senqY5lurZDyHTSw_mH5JZckER_uXygY3hYrsofDaNwwFbJPUai6DA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 20:53:52 -0500 (EST)
Date:   Mon, 13 Feb 2023 17:53:17 -0800
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
Message-ID: <Y+rpjQ/QrhSSM0BZ@boqun-archlinux>
References: <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:51:11PM -0800, Boqun Feng wrote:
> On Mon, Feb 13, 2023 at 05:29:49PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 13, 2023 at 10:25:59AM -0500, Alan Stern wrote:
> > > On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> > > > On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > > > > Provided it acquires the parent device's lock first, this is 
> > > > > utterly safe no matter what order the children are locked in.  Try 
> > > > > telling that to lockdep! 
> > > > 
> > > > mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> > > > exact pattern, it allows taking multiple child->lock class locks (in any
> > > > order) provided parent->lock is held.
> > > 
> > > Ah, this is news to me.  Is this sort of thing documented somewhere?
> 
> Basically if you have two lock instances A and B with the same class,
> and you know that locking ordering is always A -> B, then you can do
> 
> 	mutex_lock(A);
> 	mutex_lock_nest_lock(B, A); // lock B.
> 
> to tell the lockdep this is not deadlock, plus lockdep will treat the
> acquisition of A and the precondition of acquisition B, so the following

^^^
acquisition of A *as* the precondition of acquisition B

Regards,
Boqun

> is not a deadlock as well:
> 
> T1:
> 	mutex_lock(A);
> 	mutex_lock(C);
> 	mutex_lock_nest_lock(B, A);
> 
> T2:
> 	mutex_lock(A);
> 	mutex_lock_nest_lock(B, A);
> 	mutex_lock(C);
> 
> Regards,
> Boqun
> 
> > 
> > Probably not :/
> 
