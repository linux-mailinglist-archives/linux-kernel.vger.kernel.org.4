Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68147695663
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBNCJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBNCJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:09:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1912F17;
        Mon, 13 Feb 2023 18:09:55 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g18so16103921qtb.6;
        Mon, 13 Feb 2023 18:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0+HenZNoKThrL9wix0Mx2a4DCWq8ldMDRHK+a4MjSI=;
        b=FRtdaCSMOqUMFiLr5EA7VHivdDV8PBAwUlmYDWmHk3FjPPZBrA92/CpiUGnywDNrzW
         gvtm3forCiGREhmqQ6Zd1U2umPlavkVTRiptJEoGvwVxt6M9eqJnskl6HeCSh89WAlhg
         Or90PeVl9eQEke/PSOYR4Z/asaXrp0b1/L9w1ZYCZM5QYu5cdrBRiOodG8c3W7b0XL/x
         NVertr+7exT9RKsGVxVh1heTp+9Xe44WFfAk3Nml2OCdEStyIjjU11ppiVnSpcRzRZ+b
         hT79NGx51/gXTupeV3aTV134OJySPpJnECFUES/YgJEoiMiIpZu0e5ykjnPIBnrts/Ub
         sufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0+HenZNoKThrL9wix0Mx2a4DCWq8ldMDRHK+a4MjSI=;
        b=6rKEgB8g072s15ZNyXE5jI9LBpXbkAXpImoQCDwxX9wE5WlYGYOrPYL7k1vB2pphg/
         0l6Np9RyrqHHW/GIHaYgzLEnzSL+Nkv9qfcm6n9WSUU0FKilENX9lICKZ4G7iRbmqo7v
         6RqrSe3BzO0cUMWzwvIxjADvyy8mtyw8ZAvBXUx5bDyOe9UucYyPHAvLDMCfLPMxBnb4
         pmQPwfJl2C/HjLV7aDJ44DgSBw6L2lNZhxpLuyN5ThaEBI6H3NJAiKtoMPjX0dTYA+n/
         tOQpK2Hj6pUbJZbqLUwcX6UFSRjayGudu4LYJsDRQNVYH+G1RZ/bUt4iAEjSyJ7XWxDv
         D+qw==
X-Gm-Message-State: AO0yUKX3h8RH2MM++klIdfCqCz/ZGGiLAZCTGPSTgRFtWcREJob4OmM+
        gSvs2TO1uH+XisD2lhpLb4c=
X-Google-Smtp-Source: AK7set9WiiGg3n7cZ5WmiTdlMMMoWlmE0t6H59xFWsd9QmQmy7TFHt1NQayAxAmFc/EzNTzLgqIhvw==
X-Received: by 2002:ac8:59cc:0:b0:3b9:a4bb:e53d with SMTP id f12-20020ac859cc000000b003b9a4bbe53dmr806835qtf.34.1676340595032;
        Mon, 13 Feb 2023 18:09:55 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y129-20020a376487000000b00738e8e81dc9sm10921256qkb.75.2023.02.13.18.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 18:09:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id E592327C0054;
        Mon, 13 Feb 2023 21:09:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 Feb 2023 21:09:53 -0500
X-ME-Sender: <xms:ce3qYyECgyTa1VtlIFtW98AyS2dcXp5yyMyF5dHweyAJ4qdtChUAuw>
    <xme:ce3qYzWqExwK5M5YmXSLl5_kp5CqNchelXt_SPwZODLdMYssBN3YNx-ZXjONWCGd8
    4bSfzGhYV8Pfgaa7w>
X-ME-Received: <xmr:ce3qY8Juh3UHmjyi3rLwsrqnVFLhickgP_cCl3uueZwVR4LvZxkwRXmNDqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ce3qY8Hg51Njg0jT4uY687rjaT4ia5bOYgrpeQvKMdVe6jqk2FsUmA>
    <xmx:ce3qY4Xc19kJzrh_I0d_xee9YViTQ6mPQ_-5qec0zXo4J5SZ9IpPcQ>
    <xmx:ce3qY_P-itJLw-tonIJkMc00ccQ3z8xNejzbi18hOoND0Z1s-DPAcQ>
    <xmx:ce3qY5vr_xC6Ji3MJLkMD_yZduFr4wr4l72J5GMWXV-RB_-X_mKvfA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 21:09:52 -0500 (EST)
Date:   Mon, 13 Feb 2023 18:09:16 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Y+rtTLD9UtPI5uGM@boqun-archlinux>
References: <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
 <Y+rr4p6njVOTSYxs@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rr4p6njVOTSYxs@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:03:14PM -0500, Alan Stern wrote:
> On Mon, Feb 13, 2023 at 05:51:11PM -0800, Boqun Feng wrote:
> > Basically if you have two lock instances A and B with the same class,
> > and you know that locking ordering is always A -> B, then you can do
> > 
> > 	mutex_lock(A);
> > 	mutex_lock_nest_lock(B, A); // lock B.
> > 
> > to tell the lockdep this is not deadlock, plus lockdep will treat the
> > acquisition of A and the precondition of acquisition B, so the following
> > is not a deadlock as well:
> > 
> > T1:
> > 	mutex_lock(A);
> > 	mutex_lock(C);
> > 	mutex_lock_nest_lock(B, A);
> > 
> > T2:
> > 	mutex_lock(A);
> > 	mutex_lock_nest_lock(B, A);
> > 	mutex_lock(C);
> 
> Why isn't this treated as a deadlock?  It sure looks like a deadlock to 
> me.  Is this an example where lockdep just doesn't get the right answer?
> 

Because A serializes B and C, so that particular piece of code doesn't
cause deadlock. Note that you can still use you normal mutex_lock() for
B, so if there is more code:

T3:
	mutex_lock(C);
	mutex_lock(B);

lockdep will report deadlock.

Regards,
Boqun

> Alan Stern

