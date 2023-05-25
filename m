Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24F710A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjEYLC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjEYLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:01:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD77119
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:01:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2533d74895bso1027995a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685012516; x=1687604516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbjVWck/hWoFPnwCC+/uqQ8bifjydlPxrNA6Wzo7G0w=;
        b=YG23WwR4ZwaIZ7jMECdpEzffAUUzprTCGLkw5Ms+ryRqUEqthhCayg7o4n4ttM9Xex
         xNH392l8qwf+BR7xOR44na0/oFzCKuMctOo48860cPXDyLuy8FjlKO6o+8V4TIdRDxvY
         /C3TLJoFaTPzkMTafPrby8Z2Tfj9YAEosI4mJmPW3/VSrpjhw9g3ugjE9JKO3eHj8JLv
         d6YvKeKo9YlX16X0rMu5XWbn0Cv/aUrmrv8YTyDnDjaEXRXls0T+h/pzTADqL9ezOOPj
         bSbqYyKOHJUru6Ue+7bK4YULWXKo3SBn7ZDELVGunmH2lhUlC0Pnp6lmGa3YrxnUNVHJ
         Fdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685012516; x=1687604516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbjVWck/hWoFPnwCC+/uqQ8bifjydlPxrNA6Wzo7G0w=;
        b=MgUaFZHYw+eeA0nSTYAYg0IIGYSEfRi6PHdSSkWrXdoK6cOosqFVgL/otIu/wdOgcl
         NjL/izdzSlp1KJ3cKiBUrJiiMCyA5xI74bRXytib2KUAuOIQugHD+3BEZi/fpw3DvxNe
         /ELQrH9uJ0+3YkW3rqax8d5JDu/vJqnLWYUX+TrpQKG9JZhtwVjbeP5B2UoPXBa9oFgD
         VpQl5snCdU3QAhXM+y3NN3SfZjuPFlqdlfkaFUBaEdYws6lhbYW/g/O992kmKmCjxprB
         KJXhPU4QyKUpOFA7LlTThr6IXnR8j+qUdHqPsgWJ+uMVR+pDnjg+hJKAGGjazFiqLrsF
         cwwQ==
X-Gm-Message-State: AC+VfDy92kSi+onyBrWu68G23I2vqEKjRG90YQdWjJ8j+rR54nDwhbxm
        SlD6rL3YVs5BTje0jQmTv1OcCV26wKgaybi3jjvFdA==
X-Google-Smtp-Source: ACHHUZ6ZPsbfxxo120zv1/o0xjAaF0T6hYsGyl2SeHsDctCjLENIkmGY9RKV14apPqLIsC2M2QV5/UCAkpxrfROm43k=
X-Received: by 2002:a17:90a:8ce:b0:24b:7618:2d16 with SMTP id
 14-20020a17090a08ce00b0024b76182d16mr1432337pjn.31.1685012515861; Thu, 25 May
 2023 04:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230522102604.1081416-1-james.clark@arm.com>
In-Reply-To: <20230522102604.1081416-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 25 May 2023 12:01:44 +0100
Message-ID: <CAJ9a7VghEAKBE0OW-byyNN_9OXgYa_N__9c-3mGDRFVRHjiQrg@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Copy kernel coresight-pmu.h header
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        siyanteng@loongson.cn, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 11:26, James Clark <james.clark@arm.com> wrote:
>
> Copy the kernel version of the header to fix the header diff build
> warning. Some new definitions were only added to the tools side header,
> but these are only used in Perf so move them to a different header.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/include/linux/coresight-pmu.h | 13 -------------
>  tools/perf/util/cs-etm.h            | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index cef3b1c25335..51ac441a37c3 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -21,19 +21,6 @@
>   */
>  #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
>
> -/* CoreSight trace ID is currently the bottom 7 bits of the value */
> -#define CORESIGHT_TRACE_ID_VAL_MASK    GENMASK(6, 0)
> -
> -/*
> - * perf record will set the legacy meta data values as unused initially.
> - * This allows perf report to manage the decoders created when dynamic
> - * allocation in operation.
> - */
> -#define CORESIGHT_TRACE_ID_UNUSED_FLAG BIT(31)
> -
> -/* Value to set for unused trace ID values */
> -#define CORESIGHT_TRACE_ID_UNUSED_VAL  0x7F
> -
>  /*
>   * Below are the definition of bit offsets for perf option, and works as
>   * arbitrary values for all ETM versions.
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 70cac0375b34..ecca40787ac9 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -227,6 +227,19 @@ struct cs_etm_packet_queue {
>  #define INFO_HEADER_SIZE (sizeof(((struct perf_record_auxtrace_info *)0)->type) + \
>                           sizeof(((struct perf_record_auxtrace_info *)0)->reserved__))
>
> +/* CoreSight trace ID is currently the bottom 7 bits of the value */
> +#define CORESIGHT_TRACE_ID_VAL_MASK    GENMASK(6, 0)
> +
> +/*
> + * perf record will set the legacy meta data values as unused initially.
> + * This allows perf report to manage the decoders created when dynamic
> + * allocation in operation.
> + */
> +#define CORESIGHT_TRACE_ID_UNUSED_FLAG BIT(31)
> +
> +/* Value to set for unused trace ID values */
> +#define CORESIGHT_TRACE_ID_UNUSED_VAL  0x7F
> +
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>                                   struct perf_session *session);
>  struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
> --
> 2.34.1
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
