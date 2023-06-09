Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD872A4B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjFIUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjFIUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE7249C8;
        Fri,  9 Jun 2023 13:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F8165BEA;
        Fri,  9 Jun 2023 20:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9818AC433A4;
        Fri,  9 Jun 2023 20:20:49 +0000 (UTC)
Date:   Fri, 9 Jun 2023 16:20:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, kpsingh@kernel.org, xukuohai@huaweicloud.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/2] Ftrace direct call samples improvements
Message-ID: <20230609162046.13d19398@gandalf.local.home>
In-Reply-To: <20230427140700.625241-1-revest@chromium.org>
References: <20230427140700.625241-1-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 16:06:58 +0200
Florent Revest <revest@chromium.org> wrote:

> This series is a subset of [1] that didn't go through the arm64 tree.
> 
> - The first patch fixes a small bug when a direct call sample is loaded on x86
> - The second patch adds arm64 support to all direct calls samples
> 
> They are sent together because the second one depends on the first one.
> 
> This series applies cleanly on Linus's master branch. It needs the first two
> patches of [1] which, at the time of writing, don't seem to have made it to the
> trace/linux-trace tree but I suppose they could be pulled from Linus's master
> 
> 1: https://lore.kernel.org/bpf/20230405180250.2046566-1-revest@chromium.org/
> 
> Florent Revest (2):
>   samples: ftrace: Save required argument registers in sample
>     trampolines
>   arm64: ftrace: Add direct call trampoline samples support

Is this going through the arm64 tree, or should it go through mine?

-- Steve


> 
>  arch/arm64/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 40 +++++++++++++++++----
>  samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
>  6 files changed, 158 insertions(+), 6 deletions(-)
> 

