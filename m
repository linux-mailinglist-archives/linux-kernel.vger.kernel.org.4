Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BC5F874E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJHUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJHUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:18:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385032058
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 13:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8DEB80BED
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 20:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC6C433C1;
        Sat,  8 Oct 2022 20:18:10 +0000 (UTC)
Date:   Sat, 8 Oct 2022 16:18:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ring-buffer: Fix kernel-doc
Message-ID: <20221008161806.62d8dec9@rorschach.local.home>
In-Reply-To: <20221008065624.40998-1-jiapeng.chong@linux.alibaba.com>
References: <20221008065624.40998-1-jiapeng.chong@linux.alibaba.com>
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

On Sat,  8 Oct 2022 14:56:24 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> kernel/trace/ring_buffer.c:895: warning: expecting prototype for ring_buffer_nr_pages_dirty(). Prototype was for ring_buffer_nr_dirty_pages() instead.
> kernel/trace/ring_buffer.c:5313: warning: expecting prototype for ring_buffer_reset_cpu(). Prototype was for ring_buffer_reset_online_cpus() instead.
> kernel/trace/ring_buffer.c:5382: warning: expecting prototype for rind_buffer_empty(). Prototype was for ring_buffer_empty() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2340
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/trace/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c3f354cfc5ba..89fb203b04b3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -885,7 +885,7 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
>  }
>  
>  /**
> - * ring_buffer_nr_pages_dirty - get the number of used pages in the ring buffer
> + * ring_buffer_nr_dirty_pages() - get the number of use_ pages in the ring buffer

Get rid of the parenthesis, that's not how kernel doc works.

-- Steve


>   * @buffer: The ring_buffer to get the number of pages from
>   * @cpu: The cpu of the ring_buffer to get the number of pages from
>   *
> @@ -5305,7 +5305,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
>  
>  /**
> - * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
> + * ring_buffer_reset_online_cpus() - reset a ring buffer per CPU buffer
>   * @buffer: The ring buffer to reset a per cpu buffer of
>   * @cpu: The CPU buffer to be reset
>   */
> @@ -5375,7 +5375,7 @@ void ring_buffer_reset(struct trace_buffer *buffer)
>  EXPORT_SYMBOL_GPL(ring_buffer_reset);
>  
>  /**
> - * rind_buffer_empty - is the ring buffer empty?
> + * ring_buffer_empty() - is the ring buffer empty?
>   * @buffer: The ring buffer to test
>   */
>  bool ring_buffer_empty(struct trace_buffer *buffer)

