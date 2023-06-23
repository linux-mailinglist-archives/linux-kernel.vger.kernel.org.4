Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0973BA93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjFWOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjFWOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD81269F;
        Fri, 23 Jun 2023 07:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7028461A5A;
        Fri, 23 Jun 2023 14:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23405C433C0;
        Fri, 23 Jun 2023 14:46:58 +0000 (UTC)
Date:   Fri, 23 Jun 2023 10:46:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] tracing: fix warnings when building htmldocs
Message-ID: <20230623104656.7039aa05@gandalf.local.home>
In-Reply-To: <20230623071728.25688-1-pengdonglin@sangfor.com.cn>
References: <20230623071728.25688-1-pengdonglin@sangfor.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Remember to also Cc linux-trace-kernel@vger.kernel.org

(I pulled it in regardless)

And I also updated the subject to be:

  tracing: Fix warnings when building htmldocs for function graph retval

As it should start with a capital letter, and be more specific than just
general htmldoc fix.

-- Steve


On Fri, 23 Jun 2023 15:17:28 +0800
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> When building htmldocs, the following warnings appear:
> 
> Documentation/trace/ftrace.rst:2797: WARNING: Literal block expected; none found.
> Documentation/trace/ftrace.rst:2816: WARNING: Literal block expected; none found.
> 
> So fix it.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
>  Documentation/trace/ftrace.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index df2d3e57a83f..172f35c7308f 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -2786,7 +2786,7 @@ option, and these limitations will be eliminated in the future:
>    especially when larger types are truncated, whether explicitly or implicitly.
>    Here are some specific cases to illustrate this point:
>  
> -  **Case One**::
> +  **Case One**:
>  
>    The function narrow_to_u8 is defined as follows::
>  
> @@ -2805,7 +2805,7 @@ option, and these limitations will be eliminated in the future:
>    If you pass 0x123456789abcdef to this function and want to narrow it,
>    it may be recorded as 0x123456789abcdef instead of 0xef.
>  
> -  **Case Two**::
> +  **Case Two**:
>  
>    The function error_if_not_4g_aligned is defined as follows::
>  

