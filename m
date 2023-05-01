Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3446F317D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjEANVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:21:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61025128
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vx+9WK5LI/CPRu44/mS2FTBTxR72Xm7dMoLNRvC9zQs=; b=S5/l3BBm0R7lGFrZH/4T66PmL5
        0J4UwCWGKfjYvaPJoAgCgyTpOHuMUvxQnm5ekQaGmz8e/dAi+ZGXBUANLRZyoBTic5a7kaAGKTbl9
        PuHbto64DsgXl3d8aPSRFUpQ10A1rdc1910Apo+ZxgnJtbpS8R19c/W2E/SAwZ/fc6G633Xq+lsVD
        9/mU7Fn0x9zODpZNEvJU54rbS9vrT5vKGXvDKDQ7LbRRfmoU/cYwbb63q3gDONwFf8kjecnCWInXI
        jcRdkKnCfwSgZ80hdpcc1Hw8P8+eS8zbTCcVLgahEEqfdqcBh6gwrXopGoTei0P9RCA6B6t8ZMCVC
        gu1BnaWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptTSe-00EtLt-0K;
        Mon, 01 May 2023 13:21:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11393300237;
        Mon,  1 May 2023 15:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0410623262B93; Mon,  1 May 2023 15:20:59 +0200 (CEST)
Date:   Mon, 1 May 2023 15:20:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH -next] sched: fix cid_lock kernel-doc warnings
Message-ID: <20230501132058.GA1597602@hirez.programming.kicks-ass.net>
References: <20230428031111.322-1-rdunlap@infradead.org>
 <20230501132020.GA1597538@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501132020.GA1597538@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 03:20:20PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 27, 2023 at 08:11:11PM -0700, Randy Dunlap wrote:
> > Fix kernel-doc warnings for cid_lock and use_cid_lock.
> > These comments are not in kernel-doc format.
> > 
> > kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
> >  on line 11496 - I thought it was a doc line
> > kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
> >  on line 11505 - I thought it was a doc line
> > 
> > Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Blergh, so mostly I avoid kerneldoc like the plague; because then you
> get random people doing 'fixups' that end up making the actual comment
> unreadable garbage.
> 
> Mostly my answer to any such patch is to simply remove the extra * and
> call it fixed.
> 
> But now the thing presumes to know better? :-(

Bah, I should go sleep more.. this removes them. All good.
