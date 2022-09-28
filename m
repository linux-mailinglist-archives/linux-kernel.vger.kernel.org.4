Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867965EE935
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiI1WM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiI1WMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:12:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CE8051C;
        Wed, 28 Sep 2022 15:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33E27B8220D;
        Wed, 28 Sep 2022 22:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CEDC433C1;
        Wed, 28 Sep 2022 22:12:21 +0000 (UTC)
Date:   Wed, 28 Sep 2022 18:13:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix spelling mistake "preapre" -> "prepare"
Message-ID: <20220928181332.5819a8cc@gandalf.local.home>
In-Reply-To: <20220928215828.66325-1-colin.i.king@gmail.com>
References: <20220928215828.66325-1-colin.i.king@gmail.com>
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

On Wed, 28 Sep 2022 22:58:28 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in the trace text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d..623c5691ab21 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10091,7 +10091,7 @@ __init static int tracer_alloc_buffers(void)
>  	 * buffer. The memory will be removed once the "instance" is removed.
>  	 */
>  	ret = cpuhp_setup_state_multi(CPUHP_TRACE_RB_PREPARE,
> -				      "trace/RB:preapre", trace_rb_cpu_prepare,
> +				      "trace/RB:prepare", trace_rb_cpu_prepare,

This is exposed to user space. Hopefully nobody is depending on it ;-)

>  				      NULL);
>  	if (ret < 0)
>  		goto out_free_cpumask;


I'll risk the breakage. Thanks.

-- Steve
