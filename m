Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1D66DE53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjAQNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjAQNCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:02:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD88E31E01
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:02:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so10584651pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmIfKKj7U8Bcy9yj2YgmEfLZDpCS32pWFxDGk4zOAmQ=;
        b=qASjWliaWCrKRQ9R7a3HdRD3wfjSMYeWigyGmwPIlQPT0evFxvqsL3mP4vjvxl0HXT
         Xfd9p7NjAA+SyYxihPlOXeX2/DPGibynkITo2FypiWhKjgFeOvj6oym18lwCv1uT6cUZ
         LRmlgXsoUGBbM39r6ME7ug1aSPsKzobn6azc7AXCppTSqSbFm+ITNXqZR3YWwz+0uFQ9
         bsKgGsZ8B2WQtxJ1qDZEzeuZztgdPLl8apVmzxtqEvVsIP70h25SLCd3gZaVSRCuYa9n
         OWmU9/YudYlAXzvGDv2cGUQE8j8ysK7Lk2seZ6V3a7BBzzdXFeMc/EPlwm3d8Faa9hIq
         oryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmIfKKj7U8Bcy9yj2YgmEfLZDpCS32pWFxDGk4zOAmQ=;
        b=FZS69RFveGroubKmjbSEHq8cayFu3hz0y2ouK2A3pRo7UfXPjLlBNNhhE4zc6Mz42i
         Rcv4qzfEnEbDM1vHHK0LXCxGQOrrwtMhBq5HTsq1JoZXNipSzoO5nGqACNti/j4wDjLq
         yxw9/agk4btf80tQOFoXnqkhmXzTCYnhCqU4jnqK2MdUroxaYIFGxLij7/wbY+z4MQJi
         iJ4XRvTKKDhTmZ6RSGNYYdkb+oG+FGAP8Q/GK+d4MlvK4mcZb+XUFTekDbbPm3AbPdp0
         vHQbfATFA1He9T06ZVq4ljt3FSc8ay5Lko13E1Q83rSoNLTtbuyHI+P0mbR3OP/cpjW0
         yv3g==
X-Gm-Message-State: AFqh2kpkMKyQ5n000gEVo7KZebA61UJE8qZz2UTf7//rm6dqtgeqp8Vd
        3PjZWClwBk+dCuBu7Hhb5SYMVCocjzKaDuMxUpPycg==
X-Google-Smtp-Source: AMrXdXv+i/hO3HrGWtPdleEamTrdv9t60Vx4JRXDr8oRauAlWP6HwqCLIuRipmrBsGIcaXtn+991HUpTrAVSyDKwif0=
X-Received: by 2002:a17:90a:9413:b0:229:81a7:c5a7 with SMTP id
 r19-20020a17090a941300b0022981a7c5a7mr309318pjo.76.1673960561097; Tue, 17 Jan
 2023 05:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20230116124928.5440-1-mike.leach@linaro.org> <20230116124928.5440-2-mike.leach@linaro.org>
 <1896a73b-eb7b-7ffb-272d-115a10adeb71@arm.com>
In-Reply-To: <1896a73b-eb7b-7ffb-272d-115a10adeb71@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 17 Jan 2023 13:02:29 +0000
Message-ID: <CAJ9a7VixL9f2Cm7A780V311KH2G2giryeH9dG0p2e4zWBwA3iQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
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

On Mon, 16 Jan 2023 at 14:16, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 16/01/2023 12:49, Mike Leach wrote:
> > The existing mechanism to assign Trace ID values to sources is limited
> > and does not scale for larger multicore / multi trace source systems.
> >
> > The API introduces functions that reserve IDs based on availabilty
> > represented by a coresight_trace_id_map structure. This records the
> > used and free IDs in a bitmap.
> >
> > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
> > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > the ID associated with the CPU. This ensures that the same ID will be
> > re-used while perf events are active on the CPU. The put_cpu_id function
> > will pend release of the ID until all perf cs_etm sessions are complete.
> >
> > For backward compatibility the functions will attempt to use the same
> > CPU IDs as the legacy system would have used if these are still available.
> >
> > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > coresight_trace_id_put_system_id.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   .../hwtracing/coresight/coresight-trace-id.c  | 265 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++++
> >   include/linux/coresight-pmu.h                 |  10 +
> >   4 files changed, 432 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..329a0c704b87 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > -             coresight-syscfg-configfs.o
> > +             coresight-syscfg-configfs.o coresight-trace-id.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..9b85c376cb12
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> ...
>
> > +int coresight_trace_id_read_cpu_id(int cpu)
> > +{
> > +     return _coresight_trace_id_read_cpu_id(cpu);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
> > +
> > +int coresight_trace_id_get_system_id(void)
> > +{
> > +     return coresight_trace_id_map_get_system_id(&id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > +
> > +void coresight_trace_id_put_system_id(int id)
> > +{
> > +     coresight_trace_id_map_put_system_id(&id_map_default, id);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> > +
> > +void coresight_trace_id_perf_start(void)
> > +{
> > +     atomic_inc(&perf_cs_etm_session_active);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> > +
> > +void coresight_trace_id_perf_stop(void)
> > +{
> > +     if (!atomic_dec_return(&perf_cs_etm_session_active))
> > +             coresight_trace_id_release_all_pending();
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> > +
>
> This blank new line at the end of the file generates a checkpatch
> warning for me. I have fixed it locally and applied it.
>
OK, thanks.

The only thing I get out of checkpatch.pl for this patch (and indeed
the entire set) is:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Mike

> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
>
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
