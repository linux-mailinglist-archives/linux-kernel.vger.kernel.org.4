Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F04606370
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJTOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJTOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:44:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53313EA5;
        Thu, 20 Oct 2022 07:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97415B82789;
        Thu, 20 Oct 2022 14:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18BAC433D6;
        Thu, 20 Oct 2022 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666277067;
        bh=lvzfXj7heYL9GnC2K0vygmpYPaS3/sCj45Ffqb48qKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2A5CJiZAqk4HXpNH4KtDT7KrowXZT9NG3/t5r6YXuC/pkYxlV/fkMh/cJkkIL5ej
         1yNspMcfSnAnkSKPCTF6U2AQOcUzNeAHlp8ZQTzr9ZwDQYHsirGnm6FD3CPabUryB+
         B936duNEFXowp49NG3UNEi+Pa0df09k47fKFIUStwJkEPEHBBZUrY7EfvFh1LCzWTx
         HFGy7/Y6ZOMCLRJRl2MH9eFsmr3KqRz1taF/Y25PjNztu0sGcByS9KjWq94dfyI0jm
         VoJ8Ykr4Y501Q0yiZ6OjKAG2lTC8+RIhjj+FRVZsrSsAJYodYzBALpGUxZtqIQJAzB
         fd4EbUw+rQz4w==
Date:   Thu, 20 Oct 2022 23:44:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hist: add in missing * in comment blocks
Message-Id: <20221020234423.42816821e2d09aba61db5e69@kernel.org>
In-Reply-To: <20221020133019.1547587-1-colin.i.king@gmail.com>
References: <20221020133019.1547587-1-colin.i.king@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Oct 2022 14:30:19 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There are a couple of missing * in comment blocks. Fix these.
> Cleans up two clang warnings:
> 
> kernel/trace/trace_events_hist.c:986: warning: bad line:
> kernel/trace/trace_events_hist.c:3229: warning: bad line:
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for the patch. 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, what version of clang are you using?
I couldn't see this warning with clang 15.0.0. Maybe I need a kconfig option?

Thank you,

> ---
>  kernel/trace/trace_events_hist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 48465f7e97b4..087c19548049 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
>   * A trigger can define one or more variables.  If any one of them is
>   * currently referenced by any other trigger, this function will
>   * determine that.
> -
> + *
>   * Typically used to determine whether or not a trigger can be removed
>   * - if there are any references to a trigger's variables, it cannot.
>   *
> @@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
>   * events.  However, for convenience, users are allowed to directly
>   * specify an event field in an action, which will be automatically
>   * converted into a variable on their behalf.
> -
> + *
>   * This function creates a field variable with the name var_name on
>   * the hist trigger currently being defined on the target event.  If
>   * subsys_name and event_name are specified, this function simply
> -- 
> 2.37.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
