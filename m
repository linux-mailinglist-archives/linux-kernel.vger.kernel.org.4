Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B029749DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGFNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF08F;
        Thu,  6 Jul 2023 06:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18AE61927;
        Thu,  6 Jul 2023 13:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B445C433C7;
        Thu,  6 Jul 2023 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688650635;
        bh=5xsDFMqKiKcb2GYFWhTiN6rPXWfblS1mUzchy+w1xDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RHrvdu5Uj7cAqAyDgp0i5NO1d8iIZP9KrKs2nGX87TOW7L5pO4fpt1/GpPgyTV6aI
         GuNNMZZ5QP/NFhmWGJz9vC2vQnwH/aE5etRMn2rz+k29zxN7Jmrv/1n5JabfAimgwE
         CblqGpIpi3ygL9ulgfcLzFP0fdwmUjQxIYkC7TLk5mhj86sm7GbDB6+xlYBglN7VXm
         X/6qrbSTTZm+YBaRihpPMhj0wF2duhBvSLXqDcolrZoSOR2h2kKJXh1G7rPHXWgVOm
         9jS6KILvLkbUyqkH2xqejWrAdh0ikBNpPl/5Z0DFxgXEUMHp/vDNO0XVe8BYjLweyY
         xC91EDHU0UTDA==
Date:   Thu, 6 Jul 2023 22:37:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove unnecessary =?UTF-8?B?4oCYMOKAmQ==?=
 values from ret
Message-Id: <20230706223710.58284736311727766cee345a@kernel.org>
In-Reply-To: <20230704192107.2944-1-zeming@nfschina.com>
References: <20230704192107.2944-1-zeming@nfschina.com>
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

On Wed,  5 Jul 2023 03:21:07 +0800
Li zeming <zeming@nfschina.com> wrote:

> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 00e177de91cc..db8a3aa53cf6 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1072,7 +1072,7 @@ static int kprobe_ftrace_enabled;
>  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  			       int *cnt)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	lockdep_assert_held(&kprobe_mutex);
>  
> @@ -1110,7 +1110,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  				  int *cnt)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	lockdep_assert_held(&kprobe_mutex);
>  
> -- 
> 2.18.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
