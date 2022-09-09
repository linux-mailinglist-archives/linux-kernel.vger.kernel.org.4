Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6165B3DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiIIRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIIRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A3FE0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0661F6207D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC97CC433D6;
        Fri,  9 Sep 2022 17:25:30 +0000 (UTC)
Date:   Fri, 9 Sep 2022 13:26:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bing Huang <huangbing775@126.com>
Cc:     dietmar.eggemann@arm.com, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched/topology: Add __init for init_defrootdomain
Message-ID: <20220909132614.0bb4f87b@gandalf.local.home>
In-Reply-To: <20220909062406.99435-1-huangbing775@126.com>
References: <20220909062406.99435-1-huangbing775@126.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Sep 2022 14:24:06 +0800
Bing Huang <huangbing775@126.com> wrote:

> From: Bing Huang <huangbing@kylinos.cn>
> 
> init_defrootdomain is only used in initialization
> 
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Do not add a reviewed-by tag unless it is explicitly stated that you can.
Just because someone reviews your patch does not mean it allows you to add
that tag. I have not reviewed this version of the patch, and the last
version was not acceptable.

That said, this version is acceptable. But that still doesn't mean it was
right to add that tag before I gave the OK. That's because that tag carries
some weight of responsibility to those that give their review.

Now-Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  v1->v2:
>    Remove __init in function prototype
> 
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8739c2a5a54e..dea9fa39e7c0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -578,7 +578,7 @@ static int init_rootdomain(struct root_domain *rd)
>   */
>  struct root_domain def_root_domain;
>  
> -void init_defrootdomain(void)
> +void __init init_defrootdomain(void)
>  {
>  	init_rootdomain(&def_root_domain);
>  

