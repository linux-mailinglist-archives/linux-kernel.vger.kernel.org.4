Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60686B93C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCNMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjCNM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:29:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85309F231
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zq0B93sJFBGoEcjcEFD7N1oEhPmx7V6SgTS6OCLnRa8=; b=CEc7JknDGiwo1v5r6RcQH/21Ki
        C8t07xPkeFjX+8pGuvrFD+MlrBa1mY0N1+BQ4vwdf+KDC/JZJOZSJ/tGPlCzPltv491pdJdrN+qH9
        rvucdXiuFjq27Xtzeijb2U8MaW0Omgn0G7/Ebc8RPKRgRy3JYzl4c1K5qzx/TkS1kJFnGIuVJVrhm
        dJ3KqKQGWNZ5Adc/n2KKqPrXwVAoTGcHAYbEchP+/d5go1jArZdsQOA/kfw93Q8iJVlG+O4vOD8wE
        S2V1Q6VsJ0IL4QPZmaOISESXUPvZRul7kL1gF+y8dnZN5Es3ceJE3/JZ8GcQXDHU5GJjoX2eRMcu1
        iwJScXNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc3kT-001mTf-39;
        Tue, 14 Mar 2023 12:27:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78323300293;
        Tue, 14 Mar 2023 13:27:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F0C42008DE8B; Tue, 14 Mar 2023 13:27:25 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:27:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <20230314122725.GI1845660@hirez.programming.kicks-ass.net>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
 <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
 <ZBBYCSZUJOWBg1s8@localhost.localdomain>
 <20230314114018.GF1845660@hirez.programming.kicks-ass.net>
 <CAMj1kXHC+UCaWLRrujEJeqVaQ_4Wn3dQ+Mq+1ryQj6C=Qsb53w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHC+UCaWLRrujEJeqVaQ_4Wn3dQ+Mq+1ryQj6C=Qsb53w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:01:27PM +0100, Ard Biesheuvel wrote:
> On Tue, 14 Mar 2023 at 12:40, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Mar 14, 2023 at 12:18:33PM +0100, Frederic Weisbecker wrote:
> > > How does the following look like as a culprit?
> > >
> > > 62b95a7b44d1 (ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled)
> >
> > Ooh yeah, that asm implementation of local_bh_{dis,en}able completely
> > miss out on the lockdep state tracking. Also I think it breaks RCU, note
> > how __local_bh_disable_ip() explicitly does rcu_read_lock() for the
> > first bh-disable.
> >
> 
> Thanks a lot for the diagnosis, doctor :-)
> 
> I may need some hand holding getting this fixed - probably better to
> run the C implementations wherever feasible, right?

That is certainly the easiest and least risky approach yes.
