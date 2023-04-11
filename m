Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1C6DE0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDKQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjDKQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:12:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8174965AE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:10:30 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681229427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ccJ9V/z+ZvQmu8XlUH812Aah5FhB9IY70ps95GksDiU=;
        b=KJYLkGDYSwzeFnvaijbFeIwmVteo9ZntZePENCwkIh7JDdJ1R+Zv04SS6TH9bUMTSmTeGI
        i/Ud+QaKYE/wcq31uDHCEh7/5Cwea9RoJIB+vbZ51/nEAUKsHU7YcqJAwNz4elZEz7Iylp
        pF65jwCW/5XFuQUcoB2eoxWNre8ql9cjjrRCKvw3/HK1XsnL7IBWWUe8QnC2WYQtFFQBCx
        hWh6n8VeIKpJ0ThvE2vatu1S3xVFaWbBVCliRW2ZcMF+44J38CEt8cIZuvkXbHGef9KhgN
        QM4oiLRMl62L3q/HmBxthx8L+ZGhbILH498p44TfF8XdXuEFB3RIYcnckMGHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681229427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ccJ9V/z+ZvQmu8XlUH812Aah5FhB9IY70ps95GksDiU=;
        b=gOJZI63whU8cynzAb9c1LtnePkZc/50HtyXH6rwXAZ3HI7reY2SWAlytaKdzjnEEwXP9YH
        Aewv2SrxQJLdyMDQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 02/18] timer: Add comment to get_next_timer_interrupt()
 description
In-Reply-To: <ZDUqGCU3O7pIzn0O@lothringen>
Message-ID: <4972b725-d6af-8f93-e534-52ee57dbc9f9@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230301141744.16063-3-anna-maria@linutronix.de> <ZDUqGCU3O7pIzn0O@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023, Frederic Weisbecker wrote:

> On Wed, Mar 01, 2023 at 03:17:28PM +0100, Anna-Maria Behnsen wrote:
> > get_next_timer_interrupt() does more than simply getting the next timer
> > interrupt. The timer bases are forwarded and also marked as idle whenever
> > possible.
> > 
> > To get not confused, add a comment to function description.
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> > v5: New patch, which adds only a comment to get_next_timer_interrupt()
> > instead of changing the function name
> > ---
> >  kernel/time/timer.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 63a8ce7177dd..ffb94bc3852f 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -1915,6 +1915,10 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
> >   * @basej:	base time jiffies
> >   * @basem:	base time clock monotonic
> >   *
> > + * If required, base->clk is forwarded and base is also marked as
> > + * idle. Idle handling of timer bases is allowed only to be done by CPU
> > + * itself.
> 
> Idle marking you mean? Because idle handling can be done remotely after
> this patchset.
> 

Jupp, will change idle handling to "idle marking".

Thanks,

	Anna-Maria

