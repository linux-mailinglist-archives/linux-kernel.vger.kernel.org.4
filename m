Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC95EAE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIZRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIZRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:21:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877F102512
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267FBB80B30
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F9AC433D6;
        Mon, 26 Sep 2022 16:35:41 +0000 (UTC)
Date:   Mon, 26 Sep 2022 12:36:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
Message-ID: <20220926123650.3b29d1a4@gandalf.local.home>
In-Reply-To: <YymMH7UnCyqruuch@hirez.programming.kicks-ass.net>
References: <20220913135213.720368-1-namit@vmware.com>
        <YymMH7UnCyqruuch@hirez.programming.kicks-ass.net>
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

On Tue, 20 Sep 2022 11:47:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

>   #3 I think Steve's concern is that the tracability of a function then
>   depends on the compiler's whim -- but yeah, who cares ;-)

As I mentioned in my other email. I was tired of the bug reports telling me
it was a bug that a function was no longer available for tracing because
the compiler decided to inline it. By having notrace on all inlines, it
made it consistent no matter what the compiler decided to do, and those bug
reports went away ;-)

-- Steve
