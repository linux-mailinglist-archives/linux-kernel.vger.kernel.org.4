Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4C693585
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 02:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBLBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 20:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBLBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 20:53:04 -0500
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9F13D6B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 17:53:02 -0800 (PST)
Date:   Sat, 11 Feb 2023 20:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676166780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttlqVZ7iwJGSmKHruGiTu0Mo8sYJ1t8OLqF8t7RZ7hA=;
        b=c/DFT7qB7slON5RpqyNMbnFvWC3YtLR/wiL7vFHuWnMophXZjLOVzQsgt7JixfHQnRHOkR
        5uCKGh81Nxogm5fG31sw1s1Q2D+zQls8naL6gnmh/eMMTtoMREWXmdQMH2b3OvzyK+ccS7
        GXMDzHPSNQnYiM1Fixw1tChYrzynftQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+hGc73ZgY7ezQgt@moria.home.lan>
References: <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <20230212013220.2678-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212013220.2678-1-hdanton@sina.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 09:32:20AM +0800, Hillf Danton wrote:
> On Sat, 11 Feb 2023 18:08:05 -0500 Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > Subject: [PATCH] locking/lockdep: lockdep_set_no_check_recursion()
> > 
> > This adds a method to tell lockdep not to check lock ordering within a
> > lock class - but to still check lock ordering w.r.t. other lock types.
> 
> Given what is cut off in the rfc, better not add this to lockdep again if
> anything like checking lock_owner in reiserfs_write_lock() works for you.
> 
> Why is lockdep the dump bin for what you add?

You have zero commits to the code in question, and you're coming in here
with a total non sequitar and an insult.

Fuck off, you don't belong here.
