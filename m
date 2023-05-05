Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC66F856F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjEEPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B71815F;
        Fri,  5 May 2023 08:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA264615B9;
        Fri,  5 May 2023 15:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE85C4339B;
        Fri,  5 May 2023 15:20:27 +0000 (UTC)
Date:   Fri, 5 May 2023 11:20:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-ID: <20230505112026.6a46bcec@gandalf.local.home>
In-Reply-To: <168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 May 2023 11:18:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> + # cat events/fprobes/myprobe/format
> + name: myprobe
> + ID: 1313
> + format:
> + 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> + 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> + 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> + 	field:int common_pid;	offset:4;	size:4;	signed:1;
> +
> + 	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
> + 	field:u64 count;	offset:16;	size:8;	signed:0;
> + 	field:u64 pos;	offset:24;	size:8;	signed:0;

git complained when I pulled this in because there above lines is:

<space><tab>field...

Where, the space should be removed.

-- Steve

> +
> + print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos
