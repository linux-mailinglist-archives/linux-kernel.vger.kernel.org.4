Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF73B2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFWIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108B0E6E;
        Fri, 23 Jun 2023 01:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B97C6199F;
        Fri, 23 Jun 2023 08:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD2C433C0;
        Fri, 23 Jun 2023 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687509477;
        bh=vKyNB9XCmvnVAC+Zld9VuDInRjVAii58xA1Uoye9BmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tEOtl79Gg4tFbUt8p1nm6vuMS4G/R75ixw5Sl184xe2J/uuSPd+HaTJbpc9A7VpjG
         MUEvClQr4vtAIeJDAPKB2r3/Qa/Zgr+lQlWFwSDcR0G2eWsbbxc2ELUxj6Hjdfkv1a
         ZJuwAEluLcGaYQdm8oAtyx2VFDvwtreHXEtYdCpO3xclWi2t1rWC06I2pUFoGbhUYY
         qHQqZJTPZeCAhMXXcUsShcrBLV0uH39yUrj3ur/XTI2zTMENqFs88nXBXLX9gNr6+g
         ShVjz4diccKTbROzSm7d4yhxHA3lEr0jFvgbof9W8Jo0awPzviZhIRFfL5cF3r8M5E
         p1A/M28P/KNog==
Date:   Fri, 23 Jun 2023 17:37:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     rostedt@goodmis.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] tracing: fix warnings when building htmldocs
Message-Id: <20230623173753.83e69284d2752f57c91abf4e@kernel.org>
In-Reply-To: <20230623071728.25688-1-pengdonglin@sangfor.com.cn>
References: <20230623071728.25688-1-pengdonglin@sangfor.com.cn>
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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Also,

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20230623143517.19ffc6c0@canb.auug.org.au/
Fixes: 21c094d3f8a6 ("tracing: Add documentation for funcgraph-retval and funcgraph-retval-hex")

Thank you,

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
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
