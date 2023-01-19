Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE76737D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjASMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjASMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:03:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91375739
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:03:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so334959pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WOLLU2M/7ghBnIu5O679rBzqMlY9Ph9xGx8HlVfUxZ0=;
        b=nysKV9OjD8770ltPmWSxrldVp3jHnexV+YWy/vDcSWeNyLxEyHpFfJlQ19wMEFckFy
         ajaQ8GKgxZ5+RCVgxNDgBNBrJecBvRg5HQYZKHt1ENvARgY1ELn3Mr+W6MjYAsum6Ctr
         4NMWi3b58bIB3CdXW52fmhg0VuEDzvDmnXtxSlFa9igRKUdDfLltJ+GF6misp2k5VQsJ
         e154ndyAO1zbOs+QQ0bPwbslMtfMRi1/CUhLiIBy9QsATE/6Y8QNVWP4cGK1kLU4OX6n
         yS+wcoqaM0/YucowrIL/Dqx3D0Uc+/u0eUH/rs9sLo1bdW4W7oabmczajmQwrCDW8Mtj
         05rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOLLU2M/7ghBnIu5O679rBzqMlY9Ph9xGx8HlVfUxZ0=;
        b=4rjGPay7qvx8K5ms9GaoaIyL7BNEvjRixttHN4NiptYhdXMRdU1ATYOd+WWSiOJmU/
         is3TAZTB81l1K0Ajvg2JBDOBmbXjzBUFs4k7eI5WwvK1ZJpiPa8SpVjxdjvJe5gwgvHk
         lje6sNzlIqe33v8Ugtqw+r56NCag40g3R/4QbmNvvV4G4GK79E3B5uOJdHkO35XOEVEA
         3LxwiywhWHjSlF9DifcVhsauVHJe9pcHeV6nWMHLsi+P3L57FFtLpgiPidTLyyTpfC+j
         iTAYxJU/Tx+bfPCiG3hWx+bY8Gb81HPYQ3w+v4jSDQ4knZVZNKQRhYDvnlscBA371DuQ
         65ZQ==
X-Gm-Message-State: AFqh2koYNgYFzfogdCAy7cikG1eNcmPI7bjfXAXPIAx/xwLEbgGwpJzB
        754Q1ljA+HxUXNHjSMNLUWFr9zIBm2jsl1/IMIkhjw==
X-Google-Smtp-Source: AMrXdXsiRWVwQc8CBMyT2RUu38VIhY5bzgs7N1l1NGDYntY7397ex1OKCPUEleQAWSM7ga7a1/l50WMieA3xUxGaapw=
X-Received: by 2002:a17:90b:1901:b0:226:c03e:23fc with SMTP id
 mp1-20020a17090b190100b00226c03e23fcmr1172874pjb.6.1674129785808; Thu, 19 Jan
 2023 04:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20230116124928.5440-1-mike.leach@linaro.org> <20230116124928.5440-14-mike.leach@linaro.org>
 <b14b7507-e20a-2223-b772-fc865e5c9558@arm.com>
In-Reply-To: <b14b7507-e20a-2223-b772-fc865e5c9558@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 19 Jan 2023 12:02:54 +0000
Message-ID: <CAJ9a7Vj8Xx6fpaivoqe1LQWKrc4bG=jv+PmjUc+6r9FCsCKL1Q@mail.gmail.com>
Subject: Re: [PATCH v7 13/15] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID
 used for Trace ID
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On Thu, 19 Jan 2023 at 11:02, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 16/01/2023 12:49, Mike Leach wrote:
> > Use the perf_report_aux_output_id() call to output the CoreSight trace ID
> > and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
> > perf.data file.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
> >   include/linux/coresight-pmu.h                    | 14 ++++++++++++++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index bdb9ab86173a..12fff661456e 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -4,6 +4,7 @@
> >    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >    */
> >
> > +#include <linux/bitfield.h>
> >   #include <linux/coresight.h>
> >   #include <linux/coresight-pmu.h>
> >   #include <linux/cpumask.h>
> > @@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
> >       struct perf_output_handle *handle = &ctxt->handle;
> >       struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> >       struct list_head *path;
> > +     u64 hw_id;
> >
> >       if (!csdev)
> >               goto fail;
> > @@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
> >       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> >               goto fail_disable_path;
> >
> > +     /* output cpu / trace ID in perf record */
> > +     hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
> > +     hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
> > +     perf_report_aux_output_id(event, hw_id);
> > +
>
> One minor nit:
>
> This ends up putting the HWID packet for every single time the event is
> scheduled on the CPU and thus we have :
>
> $ perf report -D | grep OUTPUT_HW_ID
> ...
> AUX_OUTPUT_HW_ID events:         55  (18.3%)
>
> We could do the above step only once per CPU for the lifetime of the
> event by book keeping the info in event_data. With that we get, one
> record per CPU and:
>
> $ perf report -D | grep OUTPUT_HW_ID
> ...
> AUX_OUTPUT_HW_ID events:          5  ( 1.9%)
>
> Here is a quick patch. We can queue this separately if you all are Ok
> with this. Thoughts ?
>

Seems reasonable given we guarantee the ID <=> CPU association for the
lifetime of the perf session.

Regards

Mike

> ---8>---
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
> b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 12fff661456e..5335f3a2b010 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -495,10 +495,16 @@ static void etm_event_start(struct perf_event
> *event, int flags)
>          if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>                  goto fail_disable_path;
>
> -       /* output cpu / trace ID in perf record */
> -       hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
> CS_AUX_HW_ID_CURR_VERSION);
> -       hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> coresight_trace_id_read_cpu_id(cpu));
> -       perf_report_aux_output_id(event, hw_id);
> +       /*
> +        * output cpu / trace ID in perf record, once for the lifetime
> +        * of the event.
> +        */
> +       if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
> +               cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
> +               hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
> CS_AUX_HW_ID_CURR_VERSION);
> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> coresight_trace_id_read_cpu_id(cpu));
> +               perf_report_aux_output_id(event, hw_id);
> +       }
>
>   out:
>          /* Tell the perf core the event is alive */
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h
> b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 468f7799ab4f..9b11bb3d96d9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -55,6 +55,7 @@ struct etm_filters {
>   struct etm_event_data {
>          struct work_struct work;
>          cpumask_t mask;
> +       cpumask_t aux_hwid_done;
>          void *snk_config;
>          u32 cfg_hash;
>          struct list_head * __percpu *path;
>
>
>
> >   out:
> >       /* Tell the perf core the event is alive */
> >       event->hw.state = 0;
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index 624f4843453e..51ac441a37c3 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -7,6 +7,8 @@
> >   #ifndef _LINUX_CORESIGHT_PMU_H
> >   #define _LINUX_CORESIGHT_PMU_H
> >
> > +#include <linux/bits.h>
> > +
> >   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> >
> >   /*
> > @@ -43,4 +45,16 @@
> >   #define ETM4_CFG_BIT_RETSTK 12
> >   #define ETM4_CFG_BIT_VMID_OPT       15
> >
> > +/*
> > + * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> > + * Used to associate a CPU with the CoreSight Trace ID.
> > + * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
> > + * [59:08] - Unused (SBZ)
> > + * [63:60] - Version
> > + */
> > +#define CS_AUX_HW_ID_TRACE_ID_MASK   GENMASK_ULL(7, 0)
> > +#define CS_AUX_HW_ID_VERSION_MASK    GENMASK_ULL(63, 60)
> > +
> > +#define CS_AUX_HW_ID_CURR_VERSION 0
> > +
> >   #endif
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
