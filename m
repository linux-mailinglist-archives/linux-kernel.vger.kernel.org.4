Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731C669036B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBIJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBIJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:21:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328F677A0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:20:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ay1so902848pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NlaRWpA7tL71Df6i/q0sFCfUUbbYhsY1iDx/MO4gzLY=;
        b=TFuGzkmfgtQiVx340LL54zjOakAXM3YsZJT8IYUXZ4AxfzSnje1Joq13S4J68tnmgJ
         rat/LDFvFIYyXL9H5AV4J9ZCty7RHcfelJbGDRt7O0/dj0otCEBEVo1Emmrr+ff8eYdf
         PoMDW0+1KcAb+ML2/andm4TaLatf3HgtXGh8jfIPO95VwP4cr4QSN7ZAIEwU3Aqrc5qC
         E78Ko+LkqxfTadFSHh0Yg9iXoiZYyoSTs7wyE1L898WqmgfttxiQzdh00JdvAZ/kzN3V
         erXpIJRCtACl7OEph3e94rSnb/trH4Ru6XH2tjUt0NGzLK1AsAxU2nvWzcGgP10iHvjJ
         j0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlaRWpA7tL71Df6i/q0sFCfUUbbYhsY1iDx/MO4gzLY=;
        b=y93KMMYvV6Uj611MRBSO3a6DSB9UJGuppSfTdGCEeEYJ6L2DOw8qibTOm9/qmL9Sgh
         bwMfIQQN1FHWp7Zm9xPEcyH/LmIoQHXGPB8uZ9907RZvPcFTQ6DDBDKBwEd4p4YLVX5e
         qsq0GkYWVR7ThvZIg8oDQ965PxXcF/vWOtBxAcWdkzq1sWRAw6z0Et+uQaJvpfS2zy4P
         hQW8VDO1PKpbXPZmwkgKNv7SPRWMMKkjrl3edvrmlUksZq5t8m6D0JZqs+Uh5wtPE6b7
         6vFvXJDLtnZFpfRPodtnZj1ugJ0/MqA9Dhc8pABgpKwnWlDe6UO0elxytsGG4Yiil8uG
         lzMw==
X-Gm-Message-State: AO0yUKX40tl1us3VhTNDg9ORKcb8VC4TsAg/6V9THUKsirbsmRMQpXEs
        QCeOEHribKNHZLY6/WiVOJFz0NPdkr2sXMsE14w85g==
X-Google-Smtp-Source: AK7set+2f9vXIotOMaKv8GeSca304NiFCBOvh/ziF3kJSv0qMNrCGabOh/sgDJDRbTW5Ep2lLylsZsIrFX/llJTS47o=
X-Received: by 2002:a63:9206:0:b0:4d9:66d4:d05 with SMTP id
 o6-20020a639206000000b004d966d40d05mr2149570pgd.44.1675934441322; Thu, 09 Feb
 2023 01:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20230209071400.31476-1-rdunlap@infradead.org> <20230209071400.31476-17-rdunlap@infradead.org>
In-Reply-To: <20230209071400.31476-17-rdunlap@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Feb 2023 10:20:30 +0100
Message-ID: <CAKfTPtC5gV3VF7S_BEJ9ndYnGwGuCRvYrKJTABSLHneYZVZvmQ@mail.gmail.com>
Subject: Re: [PATCH 16/24] Documentation: scheduler: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 08:14, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct spelling problems for Documentation/scheduler/ as reported
> by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  Documentation/scheduler/sched-bwc.rst    |    2 +-
>  Documentation/scheduler/sched-energy.rst |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
> --- a/Documentation/scheduler/sched-bwc.rst
> +++ b/Documentation/scheduler/sched-bwc.rst
> @@ -186,7 +186,7 @@ average usage, albeit over a longer time
>  also limits the burst ability to no more than 1ms per cpu.  This provides
>  better more predictable user experience for highly threaded applications with
>  small quota limits on high core count machines. It also eliminates the
> -propensity to throttle these applications while simultanously using less than
> +propensity to throttle these applications while simultaneously using less than
>  quota amounts of cpu. Another way to say this, is that by allowing the unused
>  portion of a slice to remain valid across periods we have decreased the
>  possibility of wastefully expiring quota on cpu-local silos that don't need a
> diff -- a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -82,7 +82,7 @@ through the arch_scale_cpu_capacity() ca
>  The rest of platform knowledge used by EAS is directly read from the Energy
>  Model (EM) framework. The EM of a platform is composed of a power cost table
>  per 'performance domain' in the system (see Documentation/power/energy-model.rst
> -for futher details about performance domains).
> +for further details about performance domains).
>
>  The scheduler manages references to the EM objects in the topology code when the
>  scheduling domains are built, or re-built. For each root domain (rd), the
> @@ -281,7 +281,7 @@ mechanism called 'over-utilization'.
>  From a general standpoint, the use-cases where EAS can help the most are those
>  involving a light/medium CPU utilization. Whenever long CPU-bound tasks are
>  being run, they will require all of the available CPU capacity, and there isn't
> -much that can be done by the scheduler to save energy without severly harming
> +much that can be done by the scheduler to save energy without severely harming
>  throughput. In order to avoid hurting performance with EAS, CPUs are flagged as
>  'over-utilized' as soon as they are used at more than 80% of their compute
>  capacity. As long as no CPUs are over-utilized in a root domain, load balancing
