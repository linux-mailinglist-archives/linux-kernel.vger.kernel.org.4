Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8B5FF9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJOLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJOLOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5EEBF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 121E160C09
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 11:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F648C433D6;
        Sat, 15 Oct 2022 11:14:20 +0000 (UTC)
Date:   Sat, 15 Oct 2022 07:14:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Add __cpumask to denote a trace event field
 that is a cpumask_t
Message-ID: <20221015071416.00369347@rorschach.local.home>
In-Reply-To: <xhsmh8rlixqvu.mognet@vschneid.remote.csb>
References: <20221014080456.1d32b989@rorschach.local.home>
        <xhsmh8rlixqvu.mognet@vschneid.remote.csb>
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

On Fri, 14 Oct 2022 18:21:41 +0100
Valentin Schneider <vschneid@redhat.com> wrote:
> 
> Thanks for spinning this out so quickly! I gave it a test against my IPI
> tracepoints, it's working OK with one (expected) change:

No problem. It was my "While traveling I pick what I want to work on" project ;-)

> 
>   [ipi:ipi_send_cpumask] function __get_cpumask not defined
>   CPU 0 is empty
>   CPU 1 is empty
>   CPU 3 is empty
>   cpus=4
>             echo-173   [002]    11.859745: ipi_send_cpumask:     [FAILED TO PARSE] cpumask=ARRAY[02, 00, 00, 00, 00, 00, 00, 00] callsite=0xffffffff81121013
> 
> so libtraceevent is going to need updating - I'm happy to do that (if you
> haven't done it already!)

I have not done that. I'm happy to take a patch from you.

> 
> Lastly, given all cpumasks have a (usable) size of nr_cpumask_bits, we can
> factor out the size argument, see below. Regardless:

Seems reasonable. I can fold that into my patch and if you reply back
with your signed-off-by tag, I'll include you as co-author.

Cheers,

-- Steve
