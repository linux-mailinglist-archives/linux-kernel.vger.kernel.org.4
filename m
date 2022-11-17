Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BB62E8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiKQWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiKQWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:53:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2378C7C011
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C0D6228C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3DFC433D6;
        Thu, 17 Nov 2022 22:53:21 +0000 (UTC)
Date:   Thu, 17 Nov 2022 17:53:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     <mhiramat@kernel.org>, <zanussi@kernel.org>,
        <fengguang.wu@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] tracing: Fix some bug about synth
Message-ID: <20221117175319.76816b32@gandalf.local.home>
In-Reply-To: <20221117012346.22647-1-shangxiaojing@huawei.com>
References: <20221117012346.22647-1-shangxiaojing@huawei.com>
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

On Thu, 17 Nov 2022 09:23:44 +0800
Shang XiaoJing <shangxiaojing@huawei.com> wrote:

> Some bugs are found when insert synth_event_gen_test, and fixed by this
> patch set. 
> 
> Shang XiaoJing (2):
>   tracing: Fix memory leak in test_gen_synth_cmd() and
>     test_empty_synth_event()
>   tracing: Fix wild-memory-access in register_synth_event()
> ---
> changes in v2:
> - some clean up.
> - remove redundant code.
> changes in v3:
> - remove redundant code.
> ---
>  kernel/trace/synth_event_gen_test.c | 16 ++++++----------
>  kernel/trace/trace_events_synth.c   |  5 ++---
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 

Queued. Thanks Shang!

-- Steve
