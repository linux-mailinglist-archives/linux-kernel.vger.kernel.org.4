Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02A648D23
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 05:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLJEmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 23:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLJEmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 23:42:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A98C7B559;
        Fri,  9 Dec 2022 20:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011E860DF5;
        Sat, 10 Dec 2022 04:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01EC433EF;
        Sat, 10 Dec 2022 04:42:09 +0000 (UTC)
Date:   Fri, 9 Dec 2022 23:42:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Fix print_ip_ins() to print only two digits per
 byte
Message-ID: <20221209234204.1674118a@gandalf.local.home>
In-Reply-To: <d585e629-92ea-3ba4-876f-4fda11c5c055@huawei.com>
References: <20221209105640.6d5eda0e@gandalf.local.home>
        <d585e629-92ea-3ba4-876f-4fda11c5c055@huawei.com>
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

On Sat, 10 Dec 2022 12:12:23 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Hi, Steve,
> 
> commit 30f7d1cac2aa ("ftrace: Fix char print issue in print_ip_ins()")
> has solved this issue.
> 
> Link: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30f7d1cac2aab8fec560a388ad31ca5e5d04a822

Ah, that's probably why I never applied it, and it was sitting in my
staging branch. I just noticed it with a couple of other commits, that were
not applied.

OK, I'll revert it. Thanks for letting me know.

-- Steve
