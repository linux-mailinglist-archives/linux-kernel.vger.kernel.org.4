Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B064D39E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLNXpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLNXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:45:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27502B274;
        Wed, 14 Dec 2022 15:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E01261C5B;
        Wed, 14 Dec 2022 23:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFF3C433D2;
        Wed, 14 Dec 2022 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671061495;
        bh=dno/KTeTyb5v+fsRxXhmOmKiQ+bTbNy80KwqOVca13Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cxAXhixOxGX7A99DGgtMoWzff3/+EXOa8iyHEfLn22srI5A6FpMpu6ZnnFH5/zMT/
         2KcCYkYvyQTHJ0n3LzjiJQqml6WlegRTkecmSAf140l+EQEzWVtz8Yk5bfAIpH5Tax
         3qC9pMU+9d8PlTPafFLB9yW874cSf4IgQ77AxYs8OsWSAUvZHXadS39ZO2YAH3Got9
         yBD+hmEh2Ntrw1Gv6kNDswrgizgcSo/OiAYSF6u0d8ZGD7dJNrc0FhMEgbAuwzRHu7
         ex1zP4bQUFZdzttinOCIL3UbIDxa1AfoVPg8eUSY7paDAJo9D4N5M5mOgjlfZeBoki
         OkeE8L3KQLX3w==
Date:   Thu, 15 Dec 2022 08:44:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix cpumask() example typo
Message-Id: <20221215084453.0de77bfacc9e739e3accaae2@kernel.org>
In-Reply-To: <20221213221227.56560374@gandalf.local.home>
References: <20221213221227.56560374@gandalf.local.home>
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

On Tue, 13 Dec 2022 22:12:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The sample code for using cpumask used the wrong field for the
> __get_cpumask() helper. It used "cpus" which is the bitmask (but would
> still give a proper example) instead of the "cpum" that was there to be
> used.
> 
> Although it produces the same output, fix it, because it's an example and
> is confusing in how to properly use the cpumask() macro.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  samples/trace_events/trace-events-sample.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index fb4548a44153..1c6b843b8c4e 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -359,7 +359,7 @@ TRACE_EVENT(foo_bar,
>  		  __print_array(__get_dynamic_array(list),
>  				__get_dynamic_array_len(list) / sizeof(int),
>  				sizeof(int)),
> -		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpus),
> +		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpum),
>  		  __get_str(vstr))
>  );
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
