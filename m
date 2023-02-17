Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AEC69A3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBQCbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQCbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:31:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9774FCA1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:31:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B8E9612C9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8139BC433D2;
        Fri, 17 Feb 2023 02:31:15 +0000 (UTC)
Date:   Thu, 16 Feb 2023 21:31:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [Patch] [samples/trace_events] Remove unnecessary version.h
 include pointed out by 'make versioncheck'
Message-ID: <20230216213113.6c4f59af@rorschach.local.home>
In-Reply-To: <86718c8a-4a55-7254-f489-9c071588bc25@gmail.com>
References: <86718c8a-4a55-7254-f489-9c071588bc25@gmail.com>
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

On Thu, 16 Feb 2023 02:03:29 +0100 (CET)
Jesper Juhl <jesperjuhl76@gmail.com> wrote:

> >From 8917ba4246c3fa7344523a0c46b793c5dbb0400b Mon Sep 17 00:00:00 2001  
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Mon, 13 Feb 2023 02:53:37 +0100
> Subject: [PATCH 07/12] [samples/trace_events] Remove unneeded version.h
>   include pointed out by 'make versioncheck'
> 

The subject is not formatted correctly. There's no body to the commit.
And the Signed-off-by tag is incorrect. Not to mention that the patch
itself is corrupted.

Please fix all of these.

-- Steve


> Signed-ogg-by: Jesper Juhl <jesperjuhl76@gmail.com>
> ---
>   samples/trace_events/trace_custom_sched.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
> index b99d9ab7db85..dd409b704b35 100644
> --- a/samples/trace_events/trace_custom_sched.c
> +++ b/samples/trace_events/trace_custom_sched.c
> @@ -8,7 +8,6 @@
>   #define pr_fmt(fmt) fmt
> 
>   #include <linux/trace_events.h>
> -#include <linux/version.h>
>   #include <linux/module.h>
>   #include <linux/sched.h>
> 

