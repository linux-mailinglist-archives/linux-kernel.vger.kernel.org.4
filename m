Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E665D5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbjADOb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbjADObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:31:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F6CC7;
        Wed,  4 Jan 2023 06:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72185B8166B;
        Wed,  4 Jan 2023 14:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAE3C433EF;
        Wed,  4 Jan 2023 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842707;
        bh=L0RwDKuXpOOyyMNL0eeLGSwWB00sesQTyY24XYKNySQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+lxNxGYtydzA4AjYKS3FfMHOsfx8741vRfbVKOBj1rOb9k7djXxuQwcuUPoveLoQ
         ly7npujZpcOuD8VjiscDZzlSayVApVJF5Zh/5V8jL0lkAdeGQAHcNt0s1DlO/8a+GS
         hNjHEAO1hd1q1cCkKtGzICKkd2zUo0DnJiHcuc6B/z9w1EMUVA2Z4RwPE+VvFh2zEs
         /7kZliIPhUSJnjst1ApH264vLJ6+5A2mzdHRz5WT9cVddnmessLj7XMRU2NtzuU3xo
         aqFaZMIZ9BvjLKyduoMBeDRKXD3bpfaFcO3Vnk5pQ2Bk7rzlB4Dm9ITl817Fxm8ep5
         O8e4xWKtG1Y1Q==
Date:   Wed, 4 Jan 2023 23:31:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ftrace: Maintain samples/ftrace
Message-Id: <20230104233143.0ddebd4551b28216d4212bd1@kernel.org>
In-Reply-To: <20230103124912.2948963-2-mark.rutland@arm.com>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
        <20230103124912.2948963-2-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jan 2023 12:49:10 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> There's no entry in MAINTAINERS for samples/ftrace. Add one so that the
> FTRACE maintainers are kept in the loop.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427a..739006e245fbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8571,6 +8571,7 @@ F:	kernel/trace/fgraph.c
>  F:	arch/*/*/*/*ftrace*
>  F:	arch/*/*/*ftrace*
>  F:	include/*/ftrace.h
> +F:	samples/ftrace
>  
>  FUNGIBLE ETHERNET DRIVERS
>  M:	Dimitris Michailidis <dmichail@fungible.com>
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
