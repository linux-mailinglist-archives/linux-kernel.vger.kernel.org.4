Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CAC61015E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiJ0TQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0TQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B3971BF9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E6662486
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026A6C433C1;
        Thu, 27 Oct 2022 19:16:36 +0000 (UTC)
Date:   Thu, 27 Oct 2022 15:16:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027151650.77d7e4de@gandalf.local.home>
In-Reply-To: <CAHk-=wiXk3jrhzjkYgC=a7F1+oFY2wNmxeMDTza10maGU2-i4Q@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
        <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
        <20221027150237.4e69ba27@gandalf.local.home>
        <CAHk-=wiXk3jrhzjkYgC=a7F1+oFY2wNmxeMDTza10maGU2-i4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 12:11:43 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Oct 27, 2022 at 12:02 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > So it works on current stable and current mainline? Does that mean we need
> > to worry about this?  
> 
> No, I think Guenter is saying that current mainline *without* the
> patches works fine.
> 
> But v6.1-rc2 (which is quite close to that current mainline) *with*
> the patches blows up.
> 
> So it's almost certainly the patches that break. There are no
> appreciable timer changes in those 105 commits (there's some added
> irq_work_sync but that looks very unlikely to be related.
> 

Got it. I'll need to setup an arm64 VM to see if I can reproduce it.

-- Steve
