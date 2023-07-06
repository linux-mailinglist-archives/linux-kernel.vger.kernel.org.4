Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A0749DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGFNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGFNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0083131;
        Thu,  6 Jul 2023 06:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4676192C;
        Thu,  6 Jul 2023 13:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0614C433C7;
        Thu,  6 Jul 2023 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688650830;
        bh=++e4KEfyGa8uNa5HRMomjPJxKC/zgtp/avpeQHuft60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nqP5sEaHUeJpJeFtAh65LAPbnt5cYSBKQpW1QuuKQIVWJuUqxDtdCxSlflCpY5VTF
         9f/wvg2Jv6x7idkLzly83vrRNXsg74Yi5k49rzF4OmKdGpzLpvVaGA4xoxEKBD+LPj
         LdGrcIjaNDiXwyqKh0dv7TBD+fRmU5CoV6dWiSr1/zE4NIXPvBxEhmCwJd5zI6UboF
         4jQ9oCCKmCo5nxQw5Hi3rxLPyPa8FxpbHRC4+iWCJD3Khc/QBaCuD0K15/TJ61mENL
         2ffEMVlwtnjGfAqQ2YpvXxewDTZOj4cy4Du01w1hbHVYHVXd00A4crm7rPl9TYN6wJ
         +obaiAJbw+XYA==
Date:   Thu, 6 Jul 2023 22:40:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: kprobes: Remove unnecessary =?UTF-8?B?4oCY?=
 =?UTF-8?B?MOKAmQ==?= values from ret
Message-Id: <20230706224026.9a29f4f4deb9da74a83bb848@kernel.org>
In-Reply-To: <20230704201056.3352-1-zeming@nfschina.com>
References: <20230704201056.3352-1-zeming@nfschina.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jul 2023 04:10:56 +0800
Li zeming <zeming@nfschina.com> wrote:

> ret is assigned first, so it does not need to initialize the assignment.
> 

OK, but can you merge this to the first one?
https://lore.kernel.org/all/20230704192107.2944-1-zeming@nfschina.com/

Thank you,

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ec50f9f380c1..a009c8ccd8ea 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
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
