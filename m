Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5363DF80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiK3Srs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiK3Srp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:47:45 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D3657D;
        Wed, 30 Nov 2022 10:47:44 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso2109974wmp.5;
        Wed, 30 Nov 2022 10:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY6t4MKpUcKU1pHAOXdVXL54lRiEp804yvwvE85yjss=;
        b=BJw0Plv0nn92aUgO/Ic+KimdkNPG91umt2wKb5b3/IytBI90rQz2hCUxS4p98dE8lm
         Uv5AxoaU0vHeXmU2kQLAB46blnGnl2zTZz0fPoNdIS8g2BdonaFKFQ2jAvBtF8+dldr5
         HE0An2ZdBbf+XoPRuqYm7Zkge8qBquWJGtEyEVTzRYqverh+Cj4EQaq8+f181MprK8rD
         GvmPbkBxx4WJs80pD1JkuRj7qX/q/AY+U6NGDlRdDUJ4oLvrv/XCEcTFVAzZ+CvF8oUt
         vxj2DfPSXKL2gFMkS77CtluvtOz+zUixMlIT8/i0lxla7LlRgpUsH1J/z7hgw3aOZGwt
         Jk/Q==
X-Gm-Message-State: ANoB5plQDMz0lEG6KvkFV9xNuaVsb4RM+zm38aGqucdZL7Hejlrlx0fP
        hCVFUJbLq3hXKu3Tq3OvdNRAf4bxQNoKMPxF9oA=
X-Google-Smtp-Source: AA0mqf65PtPlMRhlQsYy8OJFRrHgR5ElnxUhBum5EFHY/d+ex0MlBLrzoDD5PAvg5IqTOrLkwTUR2G9vRf4UwL0U2yY=
X-Received: by 2002:a05:600c:5012:b0:3cf:486f:2700 with SMTP id
 n18-20020a05600c501200b003cf486f2700mr37479334wmr.83.1669834063396; Wed, 30
 Nov 2022 10:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-2-irogers@google.com>
In-Reply-To: <20221130062935.2219247-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 10:47:31 -0800
Message-ID: <CAM9d7cjdRWhx2J4CpO88u5sSRYPBeyenGb3EViAhOdhhQSW3nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf util: Make header guard consistent with tool
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:29 PM Ian Rogers <irogers@google.com> wrote:
>
> Remove git reference by changing GIT_COMPAT_UTIL_H to __PERF_UTIL_H.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/util.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index c1f2d423a9ec..63cdab0e5314 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef GIT_COMPAT_UTIL_H
> -#define GIT_COMPAT_UTIL_H
> +#ifndef __PERF_UTIL_H
> +#define __PERF_UTIL_H
>
>  #define _BSD_SOURCE 1
>  /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
> @@ -94,4 +94,4 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
>                 0;                                              \
>         })
>
> -#endif /* GIT_COMPAT_UTIL_H */
> +#endif /* __PERF_UTIL_H */
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
