Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69F6DF3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDLLb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjDLLbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37324AF11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323786333E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327BC4339B;
        Wed, 12 Apr 2023 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681298961;
        bh=FGxNZi2e5GtH62R/Rx2ubxYGZevs5OjnrYxPK1AfTpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxP8WLBPtDwcT0vRd1UAg7cn6LTRU/bBVBQKnrEMcfFHd8amzUb/xY7cguZb24MCu
         F241VgIAz4hQwcwtOQ1FUpEcsmMi7YCtxvdUMOu5+SRZoH00cymiFPxmOTftJ/q07s
         FJLBx7kGj2ArK3bQg38zbgKhtKxqYiSRO2rejfjj8tchkFUjHP5Zubw9nXpF69hDYI
         H061P4ujsG8xilgwwY4CYxm0z/YUvd/kNkMXt0Ez+dAlYu4ps6eSekfUhW/niclzpq
         dana4pF+JEJuftCfUTTbIsUmxSQh52HAWoa5fZNz4dnxmwX3QqmVo8++UOF+nya47N
         3/KhuGh5k2yog==
Date:   Wed, 12 Apr 2023 13:29:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 02/18] timer: Add comment to
 get_next_timer_interrupt() description
Message-ID: <ZDaWDX7ByztGLQQk@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-3-anna-maria@linutronix.de>
 <ZDUqGCU3O7pIzn0O@lothringen>
 <4972b725-d6af-8f93-e534-52ee57dbc9f9@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4972b725-d6af-8f93-e534-52ee57dbc9f9@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Apr 11, 2023 at 06:10:25PM +0200, Anna-Maria Behnsen a écrit :
> On Tue, 11 Apr 2023, Frederic Weisbecker wrote:
> 
> > On Wed, Mar 01, 2023 at 03:17:28PM +0100, Anna-Maria Behnsen wrote:
> > > get_next_timer_interrupt() does more than simply getting the next timer
> > > interrupt. The timer bases are forwarded and also marked as idle whenever
> > > possible.
> > > 
> > > To get not confused, add a comment to function description.
> > > 
> > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > ---
> > > v5: New patch, which adds only a comment to get_next_timer_interrupt()
> > > instead of changing the function name
> > > ---
> > >  kernel/time/timer.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > > index 63a8ce7177dd..ffb94bc3852f 100644
> > > --- a/kernel/time/timer.c
> > > +++ b/kernel/time/timer.c
> > > @@ -1915,6 +1915,10 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
> > >   * @basej:	base time jiffies
> > >   * @basem:	base time clock monotonic
> > >   *
> > > + * If required, base->clk is forwarded and base is also marked as
> > > + * idle. Idle handling of timer bases is allowed only to be done by CPU
> > > + * itself.
> > 
> > Idle marking you mean? Because idle handling can be done remotely after
> > this patchset.
> > 
> 
> Jupp, will change idle handling to "idle marking".

Thanks and then please add:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

(Trying to mark patches I don't need to review again on the next take :-)
