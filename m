Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7790D74D249
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjGJJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGJJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C5E71;
        Mon, 10 Jul 2023 02:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB8560F7A;
        Mon, 10 Jul 2023 09:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD1C433C8;
        Mon, 10 Jul 2023 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688982523;
        bh=smMst04IepMxRJUPoOQzmJ/MhSVOSpAQTL9lqbIyrAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSXtss5+su/HP1ycJhTCUrcQYIlsIkn6IQ2AqTnNU4wEgpM2hnyEPWHalP3XhLcOP
         qEkfikeyTjovMXVzDSlutxgdOBA/EdKgepbEQADDJWXcrGMlBgC7bMpVR9K+3cyaO5
         b7RKYSYnotEf/RXLgcJgPNPG+ctwmVZFq5kkvuhICTzFhqmckQfzOFlTmL1eiwcdO6
         1bysVRISQNCKiU90rV4d9Igk8l1wsS415IkPlICYm6Tga1ZoZtk7QocyF+8+WI10Xa
         sN9YwQZXGFqPwEakt1DZtyzog9y+BlayCOlTgd+cqEoWOdetdpFlYCue7dhZySWrDh
         f9wS7DrOiRC4w==
Date:   Mon, 10 Jul 2023 18:48:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: kprobes: Remove unnecessary =?UTF-8?B?4oCY?=
 =?UTF-8?B?MOKAmQ==?= values
Message-Id: <20230710184839.4680f3e7983470c650cc24ad@kernel.org>
In-Reply-To: <20230711185353.3218-1-zeming@nfschina.com>
References: <20230711185353.3218-1-zeming@nfschina.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 02:53:53 +0800
Li zeming <zeming@nfschina.com> wrote:

> it is assigned first, so it does not need to initialize the assignment.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/kprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 00e177de91cc..83e6f76fca04 100644
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
> @@ -2692,7 +2692,7 @@ void kprobe_free_init_mem(void)
>  
>  static int __init init_kprobes(void)
>  {
> -	int i, err = 0;
> +	int i, err;
>  
>  	/* FIXME allocate the probe table, currently defined statically */
>  	/* initialize all list heads */
> -- 
> 2.18.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
