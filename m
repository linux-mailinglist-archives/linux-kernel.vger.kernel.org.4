Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08CD5E6296
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIVMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiIVMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D10E7C1C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EF662D96
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B34C433C1;
        Thu, 22 Sep 2022 12:39:17 +0000 (UTC)
Date:   Thu, 22 Sep 2022 08:40:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Use proper do_arch_spin_lock() API
Message-ID: <20220922084019.4e2f2afc@gandalf.local.home>
In-Reply-To: <YywU8U7yD1nvvGlZ@hirez.programming.kicks-ass.net>
References: <20220921132152.1622616-1-longman@redhat.com>
        <20220921132152.1622616-3-longman@redhat.com>
        <20220921181721.3a51afe9@gandalf.local.home>
        <YywU8U7yD1nvvGlZ@hirez.programming.kicks-ass.net>
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

On Thu, 22 Sep 2022 09:55:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Nothing here is needed, as interrupts had better be disabled when this
> > function is called. And there's already a:
> > 
> > 	WARN_ON_ONCE(!irqs_disabled());  
> 
> You can write that as lockdep_assert_irqs_disabled();

Of course we can ;-)  But this was written before that existed.

-- Steve
