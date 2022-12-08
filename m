Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D22647A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLHXme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiLHXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4502DF3;
        Thu,  8 Dec 2022 15:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72781B8262B;
        Thu,  8 Dec 2022 23:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3800C433D2;
        Thu,  8 Dec 2022 23:39:46 +0000 (UTC)
Date:   Thu, 8 Dec 2022 18:39:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add trace_trigger kernel command line
 option
Message-ID: <20221208183945.1de18843@gandalf.local.home>
In-Reply-To: <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
References: <20221020210056.0d8d0a5b@gandalf.local.home>
        <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
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

On Thu, 8 Dec 2022 15:27:07 -0700
Ross Zwisler <zwisler@google.com> wrote:

> > +#ifdef CONFIG_HIST_TRIGGERS  
> 
> Can you help me understand why this is only available if
> CONFIG_HIST_TRIGGERS is selected in the kernel config?  AFAICT this
> code doesn't depend on the histogram code, and the run-time selection
> of triggers is usable without CONFIG_HIST_TRIGGERS.

Good catch!

I got confused, and only saw that as "CONFIG_TRIGGERS" and wasn't thinking
that config was just for histogram triggers :-p

Care to send a patch to fix it?

Thanks Ross,

-- Steve
