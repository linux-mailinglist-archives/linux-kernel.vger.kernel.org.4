Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146925FC3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJLKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJLKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:40:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD86B40E8;
        Wed, 12 Oct 2022 03:40:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so25587953wrj.11;
        Wed, 12 Oct 2022 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xks9Ju/Gqs2qILsDH8R7zXIlfdNsOo5MzHjZe4EAHJ4=;
        b=c7YYbdCX1be24wciYn0JCwaVrVYXYPveQGJEEeZrfzGwMnraNTZwExZczJRe41igsr
         4gUrmDGJZelM0LnNfQoi/UcYqbXDqAuacnneaP9jSYPY7ITn9x2Te4IV3je9F2ufCL+Z
         tmz2cIhOajKfVtKkjmS+lR9DWZ2pGZD4r+vZb2wJxD9vIxpFwvfLRTavsKMu1Gd0MMyZ
         wyYHulrepH8rUkjpRxU3tYd5W0yHXZwy/uCizhgelxq9TQidGnvWsYp7/OEhi5dlB/xv
         jjxblOxee3tDnbqRGfp3GAJGi15cS/c7W0W8u8O+IO3nMUEV/yy46LWcoEJII1fcCTRG
         naAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xks9Ju/Gqs2qILsDH8R7zXIlfdNsOo5MzHjZe4EAHJ4=;
        b=Q5o7jLhR1GHLL5M9dbdol+6f1HXpmcW0VTJN1xiqoTT1bczVcxEAb2W61O1PcSVZdC
         p+75Y33ROfgv+McwKj67a3prqY4onR3BnO/s59n4yLJPXp8bsLoBYCj8hhGDuqx/OTeI
         1WNq8t7ta7Vt2R0dUrJCUex3AYNaoBlJR7Dg7/ziusA4gcKkZhD1v7SbeXvelVlwShhK
         ZmsigWwXW8dlQjKC9u1d2sqaXqUwDprEhkoU+W48+P30BVDmPCw4GapDt9P61SQvrvp1
         d1cFp7ehJXEVBkSX+WlFzV0AaBNe4Z5KSFV0JR82WPxYP/dPNnyQdml/smlQQxaC9UEA
         5P5g==
X-Gm-Message-State: ACrzQf0kfZAjvFHh9SpTtASROZHzdJZBJrdqwHi1KLwREUqPSy8zE8i1
        BWp+BiuKbxwdiK0POUc++5Y=
X-Google-Smtp-Source: AMsMyM77/wM2dx/8gPL+qYta2rsTtdIMWrhWG834G7+X5XIIwULCyJrgdAec2TjO3DOXxeY9y/kfWA==
X-Received: by 2002:a05:6000:178c:b0:231:ce45:7e00 with SMTP id e12-20020a056000178c00b00231ce457e00mr2928558wrg.598.1665571227105;
        Wed, 12 Oct 2022 03:40:27 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003c6c4639ac6sm1360251wmr.34.2022.10.12.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:40:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 12 Oct 2022 12:40:24 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH 05/19] perf stat: Add cpu aggr id for no aggregation mode
Message-ID: <Y0aZmHecB7Ahiuuh@krava>
References: <20221010053600.272854-1-namhyung@kernel.org>
 <20221010053600.272854-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010053600.272854-6-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:35:46PM -0700, Namhyung Kim wrote:
> Likewise, add an aggr_id for cpu for none aggregation mode.  This is not
> used actually yet but later code will use to unify the aggregation code.
> 
> No functional change intended.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 144bb3a657f2..b00ef20aef5b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1339,6 +1339,12 @@ static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config
>  	return id;
>  }
>  
> +static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __maybe_unused,
> +					     struct perf_cpu cpu)
> +{
> +	return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
>  					      aggr_get_id_t get_id, struct perf_cpu cpu)
>  {
> @@ -1381,6 +1387,12 @@ static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *
>  	return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
>  }
>  
> +static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *config,
> +						    struct perf_cpu cpu)
> +{
> +	return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
> +}
> +
>  static bool term_percore_set(void)
>  {
>  	struct evsel *counter;
> @@ -1407,8 +1419,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>  	case AGGR_NONE:
>  		if (term_percore_set())
>  			return aggr_cpu_id__core;
> -
> -		return NULL;
> +		return aggr_cpu_id__cpu;;

nit, double ;; ;-)

jirka
