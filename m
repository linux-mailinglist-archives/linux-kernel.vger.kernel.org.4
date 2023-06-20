Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C943737617
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFTUco convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:32:42 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45CF1;
        Tue, 20 Jun 2023 13:32:42 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77e357f8faeso135969639f.3;
        Tue, 20 Jun 2023 13:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293161; x=1689885161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wClhCQSLHlxJ7x+g/i0PKTHL3zUR+fkbCyijRsJiFko=;
        b=NoojAPysl/2kNz37HmtNkdcRJerSffJsUYJUDrB9DlG5Ir9ESDyLr/3T+JSCEwAom7
         WdZgjJFhdIKtcuQO9xkLt+afqUo6JISJ8AcK61lCz3ybPQg3bkQMR/+bgXSRTBRhYtHD
         S+lO6Fc/6nVKtDhRTWBL6byqn+OFjkD+JIzLAwL+lf3c/d6MZZRnelZNiHgP0GsAJ4P6
         scce7TahZHTWiXkuo4JAJ0sz+kOdkHJ1wfJm0vyngdJje0VYN1JrARYknBzZg9LbSYSk
         WFIEowZfUR2sMRzbxAHcBlFPrgGFZg2ARZz8tLy0sQPdSaP/H1Dr/vx63IRMJ760yaSN
         eeTA==
X-Gm-Message-State: AC+VfDyNM0cPD+g1WvxoVswm3Wpp/sqqfpig20dvfz8HRfWcyXn591kp
        hpYLJJYtyGorG+5Cuoc+1Dj8SggEy1dCeOrx0xM=
X-Google-Smtp-Source: ACHHUZ4jDamatlr+DCWZd9B2Mh8oDMdheAGX0lUtgp5PIy/+aKcbRPV1h0OwfT9MclKi/MH/cMeM6gALpIKP9YPSuzA=
X-Received: by 2002:a6b:5905:0:b0:77e:2883:13f3 with SMTP id
 n5-20020a6b5905000000b0077e288313f3mr11895581iob.14.1687293161237; Tue, 20
 Jun 2023 13:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230616024515.80814-1-yangjihong1@huawei.com>
In-Reply-To: <20230616024515.80814-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 13:32:29 -0700
Message-ID: <CAM9d7chJtidBnLYd27Us6aW5tJKbi_n_kHj=6SRUTbTiowwi5w@mail.gmail.com>
Subject: Re: [PATCH] perf parse: Add missing newline to pr_debug message in evsel__compute_group_pmu_name()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 15, 2023 at 7:47 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> The newline is missing for pr_debug message in
> evsel__compute_group_pmu_name(), fix it.
>
> Before:
>
>   # perf --debug verbose=2 record -e cpu-clock true
>   <SNIP>
>   No PMU found for 'cycles:u'No PMU found for 'instructions:u'------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   <SNIP>
>
> After:
>
>   # perf --debug verbose=2 record -e cpu-clock true
>   <SNIP>
>   No PMU found for 'cycles:u'
>   No PMU found for 'instructions:u'
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 2d36cadf35ec..bc7274641f34 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2036,7 +2036,7 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>                 pmu = perf_pmus__scan_core(NULL);
>         }
>         if (!pmu) {
> -               pr_debug("No PMU found for '%s'", evsel__name(evsel));
> +               pr_debug("No PMU found for '%s'\n", evsel__name(evsel));
>                 return -EINVAL;
>         }
>         group_pmu_name = pmu->name;
> --
> 2.30.GIT
>
