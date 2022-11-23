Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7042636E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKWXeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKWXeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:34:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C82409A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:34:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so2368184wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ta2Zb663w+hTcqdpNUGC4OtuQUTQUUplhbDEWR91618=;
        b=PW7/IdvYDe1fY2xW3B2vR7IAaprWV+VDcV7m3onc30QaWM4mA03Ao5zi6rbnN3Hy8a
         vYpUO+ZAymzFIWgb7cIdyNJFRPtYmXEfo85KrduP4ht2IyYUqJlXaghtXaLB8vrrZdSO
         c9YAFg722ximDKZfRYYAPYTAqNai8T6ozKH9z/+HeownU8g+0d7GJj81AMreLm86T6Lg
         RiqErMUyxMCYWbbVAwRwCRC4/UE9QzqQtB/nSLkcqOdPe3B8af96OxrYogYknJnZtpxG
         QPuzy1Dhoy8uRjWN+3JvVjaw4MA4p05fXimeZFfMuDxNTVit00X9CDV6eDhYAaGC5eJx
         lEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta2Zb663w+hTcqdpNUGC4OtuQUTQUUplhbDEWR91618=;
        b=F53vsBJQ+7wUbv5BRrbwx+VEPaHCqVxZ7uZ4CSGTf08Bv/ZVt/i6ngChIx2vQPa3xJ
         unccfN/8O6QpZUYPQqQTdhElDhpBuY4pLM1WJ/s8ZecR7ERZXTlzVZKbwbFq54GrnXJv
         qeSANMnLoEH6RnWjTNjRIvck00JikGHOMmWI1CtZheYHmG6RG4Tsi/nTNQMqHQnTURV+
         v8f6+/X0VoiKMJgNc6VpJC/VCgPq5Ktl7ib0LmRIem1LB68ap1t27K4Nt6GK3K7mPAES
         HvOfF6emgAHrhKU8+k8eL8RDZgboG/Fdv7Osgo/ei8YkKfGDu3Zc4qqtxCtbWHCwpsxA
         G2Dg==
X-Gm-Message-State: ANoB5pmdizs5A+u7wbahyV5qD2gFphmTf+E/yVtwvcqdGT7ut0QI42++
        h6w4UreCOUjHcQwoPqneYrEKRHf/nJ4inLADbhyTfg==
X-Google-Smtp-Source: AA0mqf6Z+6eCByVZTjXKSfoOhCjTGv9s0e/HVVpnT3VDCjYn81vKxcchedie8IM/xoUzwIaGOwVaM2XSKqwFspjr+8Y=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr14549932wmp.174.1669246448065; Wed, 23
 Nov 2022 15:34:08 -0800 (PST)
MIME-Version: 1.0
References: <202211231700506267036@zte.com.cn>
In-Reply-To: <202211231700506267036@zte.com.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:33:55 -0800
Message-ID: <CAP-5=fWB8AZYBQ-6CWbkPSsS7qr-T=cczCekXs-qY6yuH55_dg@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf stat: remove redundant variable in arch_get_topdown_pmu_name
To:     zhang.songyi@zte.com.cn
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 1:01 AM <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> Return value from arch_get_topdown_pmu_name directly instead of taking
> this in another redundant variable.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/topdown.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 54810f9acd6f..5a5cdd6efe4d 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -84,8 +84,6 @@ bool arch_topdown_sample_read(struct evsel *leader)
>
>  const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
>  {
> -       const char *pmu_name;
> -
>         if (!perf_pmu__has_hybrid())
>                 return "cpu";
>
> @@ -95,9 +93,7 @@ const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
>                 evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
>         }
>
> -       pmu_name = evlist->hybrid_pmu_name;
> -
> -       return pmu_name;
> +       return evlist->hybrid_pmu_name;
>  }
>
>  int topdown_parse_events(struct evlist *evlist)
> --
> 2.15.2
