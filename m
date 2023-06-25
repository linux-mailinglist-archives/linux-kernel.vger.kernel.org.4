Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4673CEA2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFYGB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFYGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2360B5;
        Sat, 24 Jun 2023 23:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A963C60A20;
        Sun, 25 Jun 2023 06:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3310DC433C8;
        Sun, 25 Jun 2023 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687672911;
        bh=IBKoJp/+tM2p8hVcc5pJrPto183vA3oXy+x7gD5JnB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qbdds3jGrvTlkwchHHxQ3n/cPPokP5pRyds4YDxBWcenHMxjYKq2wjjcnm5PPLZm7
         N8vxlRtL3ApLDiZTycTdD3WW4ApTID0apqNGWmekexpNcebfON/RUS+XLzG0Dfh9jc
         NAKnjPg1PUNH3rBTfRXvMuR/HPMI9BhjxewDQd+SgR2p1lzWmYfJacBP4kux46rTt1
         06XjSUi43+BtLuTvHf4DzHVwxdEIJWSr3++YBAzdXW+gi1Jav123+kwcG0cck3AWhJ
         yMgJGbR7OCWx9u+pvFX+k4quO8343073UIA1QqzONuIvDQZpVJFdLz0O+m+SFeT1e/
         d0gjE1Y/hXyIQ==
Date:   Sun, 25 Jun 2023 15:01:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/ftrace: Remove unsued extern declaration
 ftrace_regs_caller_ret()
Message-Id: <20230625150145.8681fc80d19c3d7bc34f7abe@kernel.org>
In-Reply-To: <20230623091640.21952-1-yuehaibing@huawei.com>
References: <20230623091640.21952-1-yuehaibing@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 17:16:40 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> This is now unused, so can remove it.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/x86/kernel/ftrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 01e8f34daf22..12df54ff0e81 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -282,7 +282,6 @@ static inline void tramp_free(void *tramp) { }
>  
>  /* Defined as markers to the end of the ftrace default trampolines */
>  extern void ftrace_regs_caller_end(void);
> -extern void ftrace_regs_caller_ret(void);
>  extern void ftrace_caller_end(void);
>  extern void ftrace_caller_op_ptr(void);
>  extern void ftrace_regs_caller_op_ptr(void);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
