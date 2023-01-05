Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9712A65F58C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjAEVNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjAEVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:13:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CC631BD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:13:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2302997wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQS9qhBABKhqH+642bRHtx06DBbbx6rvDuXIghN6EuI=;
        b=nprqES6XDcZ9mIrZxT8SD3FLhunpqVW2LXbPPstn2xk1f1s88o12y+LWPDhKyfEHIN
         XNVx3UhG/t2glTTneUFVCQn6tjzALxgfnxHn0TQsUXhpaAVehczCWfK/IwKkU9GW7C4X
         QS5dBDraINfqAQi/pLtyZTezIYlDSDNV2XzYbbuMahUlBr/UxGeT0hPsq9xJDKZlyJfE
         icTzS2xrd8o/smGVFc/ftfYh/4MpvHqDqH1dcvIjupkwdhHFH7voCUBdm3YsRzcIdUqt
         YUhPcADzZwloTrzv8pt9y8avW2h+iWdSPItYZ8p9WiXFeVrEV5pHc6Gsp5IB9J3JCU7B
         yvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQS9qhBABKhqH+642bRHtx06DBbbx6rvDuXIghN6EuI=;
        b=mXKEN0qYfOuwHqZh3ZyMzszYG5EOX2nwhG7sW2VtayWmjcOpSDIf22c9QZRy2zfIE0
         Wy3S91hYGHGIhb2vIvgvr/+z/SifX27IVW2F44oZKbXtCs4RXSnLenoiVilXJEZe/Fxj
         2AMv+XDjI93oNyceuv9FrnJmMcuDf1bADrZ5qv025dWL1A2y/bJGSy4BEymxWQ26JXpd
         uCXaUITvrd9mMmgpjZgmWU9VakuTvzejzkvQA0F9WWi49xqAcaxsSl19FktS7wvFFT/t
         2p9wJU+5jvgI2gi7gM4TyKWJE+8D1EktyvBVTol9ikt2YBGl8G/yKLbfvY60qs0gCc5V
         Xxaw==
X-Gm-Message-State: AFqh2kpZRI74G7VniaXnLSLBCdfoQDPSafGZufzLWBN65taETEPtthcU
        IYKRdoAqVQzoIzBaCxEqWrdmYgKbfcvlTjT4One8Pw==
X-Google-Smtp-Source: AMrXdXsVhhB2xAqGw/PBRO+ucelnMKPgTTTv+0uFt3SNahyKC2MlULYNt3fDuSId9ZR/d0MFIKH2lNASMCYvzTJ5sOo=
X-Received: by 2002:a05:600c:3b04:b0:3d0:50c4:432c with SMTP id
 m4-20020a05600c3b0400b003d050c4432cmr2574532wms.67.1672953219795; Thu, 05 Jan
 2023 13:13:39 -0800 (PST)
MIME-Version: 1.0
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
 <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com> <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com> <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
 <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
In-Reply-To: <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Jan 2023 13:13:27 -0800
Message-ID: <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
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

On Thu, Jan 5, 2023 at 2:13 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 05/01/2023 10:05, Jing Zhang wrote:
> >> However, for this value of slot, isn't this discoverable from a system register per core? Quoting the sbsa: "The IMPLEMENTATION DEFINED constant SLOTS is discoverable from the system register PMMIR_EL1.SLOTS." Did you consider how this could be used?
> >>
> >
> > This may be a feasible idea. The value of slots comes from the register PMMIR_EL1, which I can read in
> > /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I replace the slots in MetricExpr with the
> > read slots values? Currently I understand that parameters in metricExpr only support events and constants.
> >
>
> Maybe during runtime we could create a pseudo metric/event for SLOT.

For Intel we do this by just having a different constant for each
architecture. It is fairly easy to add a new "literal", so you could
add a #slots in expr__get_literal:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.c?h=perf/core#n407
Populating it would be the challenge :-)

Thanks,
Ian

> This metric would be created during init, and it always just returns the
> value which was read from PMMIR_EL1.
>
> I'm not sure how well that would play will trying to resolve metrics
> when building generated pmu-events.c, but I don't think it's all too
> difficult to achieve.
>
> Have you actually read this value for the n2 core? Does look correct?
>
> Thanks,
> John
