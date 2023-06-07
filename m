Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614AB7261A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjFGNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjFGNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5E1FC8;
        Wed,  7 Jun 2023 06:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FE263F9C;
        Wed,  7 Jun 2023 13:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9B8C4339E;
        Wed,  7 Jun 2023 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686145691;
        bh=wf2XVFNUEgH+dPenf4U/GenfgafdyccvlWF1Dp+rFHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7XHq6YO7SuvCp5ZPMGFBBhOT0+DObP+Fft8vLFS/PJgrWhszhHbDuTgj+RpS3hNs
         s7m2gCGV4CAr4/2/dCtlj6ui4oURAdLGa+8o+NrzWywqX+Z3DZN9ZK1nWcyTS7NjzT
         CgkoaxXb3W1DQVvRwVbTbrAkkBgFZXAILcax2fazhBrgWdBZ2q8B4CGRt7qdRll2gM
         NvNtUyUYQ0KNWe4V5IsMJsJhoJGvNp2W/Tc0u5CveuYK7nP7D5F1/95reK+evbTRwM
         HrBMBpWzh/A9xSeXcXpuNNDijir1m2yTwU8LKaR9pXu/srfpYNxbmkvoqzuUCFi6Ta
         Eneaq0snhGMJg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1392D40692; Wed,  7 Jun 2023 10:48:09 -0300 (-03)
Date:   Wed, 7 Jun 2023 10:48:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
Message-ID: <ZICKmA1kcDa2nG53@kernel.org>
References: <20230525082902.25332-1-adrian.hunter@intel.com>
 <afe1c05a-2b77-c3d8-aacf-b4c7bebb8bf8@intel.com>
 <ZH933yJMYTr0cC+N@kernel.org>
 <ZH+Havh+xRIfwa4n@kernel.org>
 <9a3776f9-9c9e-b23f-9f18-91b4b5b8364d@intel.com>
 <f7228dc9-fe18-a8e3-7d3f-52922e0e1113@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7228dc9-fe18-a8e3-7d3f-52922e0e1113@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 07, 2023 at 08:33:07AM +0300, Adrian Hunter escreveu:
> Maybe this is cleaner:

It is, I folded it into your original patch, thanks!

- Arnaldo
 
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Wed, 7 Jun 2023 08:12:29 +0300
> Subject: [PATCH] perf tools: Suppress bison unused value warnings
> 
> Patch "perf tools: Allow config terms with breakpoints" introduced
> parse tokens for colons and slashes within breakpoint parsing to
> prevent mix up with colons and slashes related to config terms.
> 
> The token values are not needed but introduce bison "unused value"
> warnings.
> 
> Suppress those warnings.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/parse-events.h | 4 ++++
>  tools/perf/util/parse-events.y | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index b0eb95f93e9c..5fdc1f33f57e 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -228,6 +228,10 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
>  void parse_events_error__print(struct parse_events_error *err,
>  			       const char *event);
>  
> +static inline void parse_events_unused_value(const void *x __maybe_unused)
> +{
> +}
> +
>  #ifdef HAVE_LIBELF_SUPPORT
>  /*
>   * If the probe point starts with '%',
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index bbfb8110947c..0c3d086cc22a 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -510,6 +510,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
>  	struct list_head *list;
>  	int err;
>  
> +	parse_events_unused_value(&$3);
> +	parse_events_unused_value(&$5);
> +
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> @@ -528,6 +531,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>  	struct list_head *list;
>  	int err;
>  
> +	parse_events_unused_value(&$3);
> +
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> @@ -545,6 +550,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>  	struct list_head *list;
>  	int err;
>  
> +	parse_events_unused_value(&$3);
> +
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> -- 
> 2.34.1
> 
> 

-- 

- Arnaldo
