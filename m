Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9264C461
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiLNH3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiLNH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A613EB9;
        Tue, 13 Dec 2022 23:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EC3CB816A6;
        Wed, 14 Dec 2022 07:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7632C433EF;
        Wed, 14 Dec 2022 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671002943;
        bh=dno/KTeTyb5v+fsRxXhmOmKiQ+bTbNy80KwqOVca13Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BF70I1EajtTttQQUzy7JPGJ9X21P4TccwQtVzOuu4myVDEz7s4gx0DIIMCqNGZmM3
         3n4Md2fh57piwijK9JqWsusaqdpwcqUWqix5HPiEwVcfGplvF2mnLzTvRGiLZLwkg7
         w4PahQOE0wIkjpx+Y7q/PI3vwiWLI7znAfH7l5rrCRTbA/IwWDYSAJP7lafvwYua4H
         9UwmhIUVIZ0Eya6ptqjxg5m4nvyjOHfjrGuivUWriocr0UM9j5EiX7PCoxTPkM1/Tt
         WLBGkici458ebZjEfl+wl3PQI7JfvEQAO2cBCSakvCmVN5N0BujVpmcfUzWPq1nrno
         22vOS/JbHtE2Q==
Date:   Wed, 14 Dec 2022 16:29:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix cpumask() example typo
Message-Id: <20221214162901.d0b51cea193aacc3148350b2@kernel.org>
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
