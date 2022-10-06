Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735885F5EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJFC1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJFC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CC84E7E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 19:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9FB6181B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD191C433C1;
        Thu,  6 Oct 2022 02:27:40 +0000 (UTC)
Date:   Wed, 5 Oct 2022 22:27:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/2] tracing: Last two fixes before pushing to
 6.1
Message-ID: <20221005222745.6613eab5@gandalf.local.home>
In-Reply-To: <20221006022126.894976366@goodmis.org>
References: <20221006022126.894976366@goodmis.org>
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

On Wed, 05 Oct 2022 22:21:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

After sending this (and noticing the link) I updated my scripts where the
above is now going to be:

    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

-- Steve

> for-next
> 
> Head SHA1: a541a9559bb0a8ecc434de01d3e4826c32e8bb53
> 
> 
> Steven Rostedt (Google) (2):
>       ftrace: Still disable enabled records marked as disabled
>       tracing: Do not free snapshot if tracer is on cmdline
> 
> ----
>  kernel/trace/ftrace.c | 20 ++++++++++++++++----
>  kernel/trace/trace.c  | 10 ++++++----
>  2 files changed, 22 insertions(+), 8 deletions(-)

