Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404A16D914B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjDFIPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjDFIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:15:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA645276;
        Thu,  6 Apr 2023 01:15:05 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:15:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680768902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmksDzLXdOctZW9XPkY/c3iq+kJAl0CSoWbiwwGb8Pk=;
        b=QvaPIpxUaBNeZbw/K3/HgY/TKdMt0k2xxuBYTqOsVlYsPFB6Tit28SNe+LQFpmK5PTHQpk
        +nyM2g3QZbQMdaQfewO6DqH0a7sX9dYu+BUlCFgezptafB4FsyGj9QF0/epcNiyjcyKO4d
        fzxu2Tg3M4O+/TG8oOMpB95j/AE6cRCHcOUE42wgApDfNtKT3jRJSK9X11N0traCQg2tXl
        rx6Y7nFVBjMWCBWEdCtAFmSLhhyzFse/6y11cu58rqEINMKtPkk0mhMwPqC+srq+WgE81Q
        R6LNt/S0ls3DoxpWHBC/ABJ5BSSEx4tjJVBXuqd8EuwKdRfuunERjYt7GyWnhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680768902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmksDzLXdOctZW9XPkY/c3iq+kJAl0CSoWbiwwGb8Pk=;
        b=lUDN+cLyXE5ZZS58//iARXgnIIwGqAbc4obCSNLQ2cMpQJJp4AkIf3IGWpHSencV8vhnNM
        EbC5werHpNTXuuAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230406081501.pS4ZnWaK@linutronix.de>
References: <20230406075718.68672-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406075718.68672-1-leobras@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 04:57:18 [-0300], Leonardo Bras wrote:
> When running RT workloads in isolated CPUs, many cases of deadline misses
> are caused by remote CPU requests such as smp_call_function*().
> 
> For those cases, having the names of those functions running around the
> deadline miss moment could help finding a target for the next improvements.
> 
> Add tracepoints for acquiring the funtion name & argument before entry and
> after exitting the called function.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Check
	https://lore.kernel.org/20230307143558.294354-1-vschneid@redhat.com

Sebastian
