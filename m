Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098776C349C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCUOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjCUOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA143A84F;
        Tue, 21 Mar 2023 07:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C4D61BC5;
        Tue, 21 Mar 2023 14:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28B9C4339C;
        Tue, 21 Mar 2023 14:44:14 +0000 (UTC)
Date:   Tue, 21 Mar 2023 10:44:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florian Kauer <florian.kauer@linutronix.de>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230321104413.43a81ffb@gandalf.local.home>
In-Reply-To: <2eeef5a3-cbe7-7a01-489a-87c5ac00adf7@linutronix.de>
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
        <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
        <2eeef5a3-cbe7-7a01-489a-87c5ac00adf7@linutronix.de>
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

On Tue, 21 Mar 2023 15:09:40 +0100
Florian Kauer <florian.kauer@linutronix.de> wrote:

> On 20.03.23 14:16, Donglin Peng wrote:
> > When using the function_graph tracer to analyze system call failures,
> > it can be time-consuming to analyze the trace logs and locate the kernel
> > function that first returns an error. This change aims to simplify the
> > process by recording the function return value to the 'retval' member of
> > 'ftrace_graph_ent' and printing it when outputing the trace log.  
> 
> I just came across your patch by pure luck and it helped me a lot
> to trace down a problem I had, thanks!
> 
> So you can have my
> Tested-by: Florian Kauer <florian.kauer@linutronix.de>
>  
> > New trace options are introduced: funcgraph-retval and graph_retval_hex.  
> 
> I would personally prefer to have the second option scoped better, so for example
> "funcgraph-retval-hex".

That could be an ftrace option.

Anyway, could you tell us your use case, and that could go into the change
log of this patch as "one use case that this helped with".

Thanks,

-- Steve

