Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019162EAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKRBSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKRBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:18:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24902648
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB21621FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07FDC433C1;
        Fri, 18 Nov 2022 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668734293;
        bh=7mlgIKcSUmjUSaR35J/rGq3Vt83E9fI1dTuydiOPdGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/KLWp00xfNxX2+0jZBUAS1s/Y7Vm2c5hxrUmHwcgE2SE5zPerPmB+6stGTQJmZDp
         f7FwavEMMZnCkH45wGB/b4qIk6Tri7UmGGRXkmvh5AwWsF50oCiQjeoyqf2DWJT++q
         ms1kZ6SN+JodbRbG+5zwZpMhKgM8JlRgcuF+H5MKv8homUSn24GasJdxbyCeyWTB79
         s5Zj1w/CiAjXAioYBiZeN5K2lJGK++5pdiVp10F/YEsZ7wlUGzrRZsqIwFL4g3EbBb
         MadP2KZ+h/WcebHeNVqNKSI6IBQPMiv0HMbBegKQymqbA2+5yqTkly0X2M1Y/trERe
         6T3V4x3hsgQWw==
Date:   Fri, 18 Nov 2022 10:18:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: remove __bad_type_size() method
Message-Id: <20221118101811.7d120f813149f7da8ba907a2@kernel.org>
In-Reply-To: <D062EC2E-7DB7-4402-A67E-33C3577F551E@gmail.com>
References: <D062EC2E-7DB7-4402-A67E-33C3577F551E@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 00:44:35 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> 
> __bad_type_size() is unused after
> commit 04ae87a52074("ftrace: Rework event_create_dir()").
> So, remove it.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/trace/trace_syscalls.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index b69e207012c9..942ddbdace4a 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -201,8 +201,6 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
>  	return trace_handle_return(s);
>  }
>  
> -extern char *__bad_type_size(void);
> -
>  #define SYSCALL_FIELD(_type, _name) {					\
>  	.type = #_type, .name = #_name,					\
>  	.size = sizeof(_type), .align = __alignof__(_type),		\
> -- 
> 2.30.2

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
