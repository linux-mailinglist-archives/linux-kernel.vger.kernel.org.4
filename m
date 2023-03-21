Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AA6C2D94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCUJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUJIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:08:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C128136D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3+el0Lt5RIYhAy+cSKuCZJQcOhxPhFhxuLx5YHOEDfk=; b=EO0OzhaYZI1crVViEM85zW4GbW
        kkF/Z9Oz0TUlc2YYtKD5gPlsvA9voAy0F+qO623TB+AwDAPgzYIp9/xHe2S0Ysq3Xh605fkJyU6xu
        VoS3i0VChGyEkxdbM3dZS2L1x5B+yD5oeHMzS8rYZkId8j7FUVj6YmAiquETSC93MvsBTAXUBNqI4
        ggiCg4cDEdhCqgDRlMDImbkUkU/gxCivEw8+oTAXcwaLrTBGosYIMgNuhGo1l+sfil8n705wnfD1Y
        kquac4DUX2oF7R3RrTwVJXz5HDwmGYcBIvbFEpfFFGsB2ErCgyVlsbR1dtDNmQzZalFJRsjDev3CF
        p2f8Br6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peXy9-004DY4-0U;
        Tue, 21 Mar 2023 09:07:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 391CE3001D6;
        Tue, 21 Mar 2023 10:07:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 106FA205414ED; Tue, 21 Mar 2023 10:07:47 +0100 (CET)
Date:   Tue, 21 Mar 2023 10:07:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [External] Re: [PATCH] sched/core: Avoid selecting the task that
 is throttled to run when core-sched enable
Message-ID: <20230321090746.GC2234901@hirez.programming.kicks-ass.net>
References: <20230316081806.69544-1-jiahao.os@bytedance.com>
 <20230320124701.GL2194297@hirez.programming.kicks-ass.net>
 <18404dfb-c727-1b33-a5f9-0e7b65e74f66@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18404dfb-c727-1b33-a5f9-0e7b65e74f66@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:16:54PM +0800, Hao Jia wrote:

> Thanks for your review. Do I need to modify to send V2 patch?

Nah, I've got it. I'll push it into sched/core later today..
