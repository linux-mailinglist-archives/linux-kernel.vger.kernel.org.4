Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5287E62082C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKHEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiKHEPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:15:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5160731EF8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23E261422
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F233AC433C1;
        Tue,  8 Nov 2022 04:15:34 +0000 (UTC)
Date:   Mon, 7 Nov 2022 23:15:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [for-linus][PATCH 4/5] timers: Add timer_shutdown_sync() and
 timer_shutdown() to be called before freeing timers
Message-ID: <20221107231532.4bbfce5c@rorschach.local.home>
In-Reply-To: <87y1sm8h1o.ffs@tglx>
References: <20221106233037.815236769@goodmis.org>
        <20221106233434.425162916@goodmis.org>
        <87sfivvy91.ffs@tglx>
        <87mt93vwv4.ffs@tglx>
        <F93A06C1-6188-4787-9563-8F5676A5A098@goodmis.org>
        <87y1sm8h1o.ffs@tglx>
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

On Tue, 08 Nov 2022 00:45:55 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Sure, but I'm traveling this week and may not get to it until Friday.  
> 
> That's fine as I think this whole approach is wrong to begin with.
> 
> We are not doing a tree wide change at rc4 just to scratch an itch which
> is there for ages and has been debated for months.
> 
> Q: Did you try a merge of the result against -next?
> A: Definitely not.

OK, Yep, I was only working with Linus's tree, not next, something I
overlooked.

> 
> The proper approach is to provide all the infrastructure, i.e. the new
> interfaces and merge them during the next merge window. Right before rc1
> provide a script or a script converted tree to Linus which switches the
> tree over to the new world order.

Well, actually this was my original plan, but Linus asked for the
treewide script to be done in this -rc release, and that part was only
done on his request.

  https://lore.kernel.org/all/CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com/


> 
> How long have you been around doing kernel development and how much fuzz
> do you make about even trivial changes to ftrace?

This is my first "treewide" change I'm doing, so I'm going to make
mistakes. Hence why I started this all off with RFC.

I'll rebase this on next and break this patch up into more comprehensible bits.

-- Steve
