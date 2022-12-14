Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C664CD99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiLNQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiLNQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:00:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3E28E29
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:59:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so196944wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l/uy268DIouOlaUX1pmogcq5YSUEqfw9Ux2GHr22Fcw=;
        b=fNyjwLMZXubjgeSgHKjUe6T/UOZYLqSUc7aFegiHxu9AdAE6aO8SxLz8JaPnXUAWvc
         lTwvPjzpnpHjWLz+1DgQl8/iA7YSvRsMWHZS6n1nlE4mB3/KROPxX7p47q970h26G5OE
         KFAtcgt8BH0XaqScv2+J+esfdUdg8P/DWfDJdGhYrZ4niSIXmckAKLdJeBkZGRzd1ZqG
         ACiroJY7RbtJBeWJ/FpWdvjKvfTSb5lLIcWzADUzlfiP87STCY/Xeui3cY6Rjsa/pi64
         5vfzbE0QW+89V8YprvkwM0Nv22o4cATewq6dbm58IeOB8EonoBliK+AS235YjuP89lAV
         SRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/uy268DIouOlaUX1pmogcq5YSUEqfw9Ux2GHr22Fcw=;
        b=kV++bOj1RYJaXDgaS0PfhalFKK/yLuNnp3aLxU6fbJwy4e6A8HL7YufBG+dXZT7hHu
         ZeUwAc+UIUTW7ST+V12HRO7dPZlpB5R2rQoBENXO04oD03jXF0d+ZgnVFx288jj1WOTr
         Bfljxd2sJdPGDre7FuN2NK/m5UnW49naiMAYFtSlYBK2CY5d0EVORuf9soUyJCMGuIMq
         PSPL7XRqA6eXXyfUjzMbqeo9uonB74A3FE/RtwA1Qw7fW0ZXBB3JKMgMDw0O7N1bptsl
         4jwD+57mt0TyYmTpukahLFIJ5CWIoO7QfpD3L1bl+djxhI67TUlfZ0LHeAa+O/kTnqPn
         FVeg==
X-Gm-Message-State: ANoB5pl29jJ5AC3gh/VNMwKLypQvMkIkQgzYY23yA6YCryjwYN2PaspS
        rTIcgiW8BGWaY6U+LsJl7khyDLCQu/3j5OFsLZKV+4OfUehdNg==
X-Google-Smtp-Source: AA0mqf5SbNc2kGGi/MGIcrhYYti0hAMTqIqgvSk/bgyaHMPsKSew2BOLWDL6zByhzOo1QDXjsoHulglB2tjxjFDV8kY=
X-Received: by 2002:a5d:4acb:0:b0:242:78b7:6bf3 with SMTP id
 y11-20020a5d4acb000000b0024278b76bf3mr6621718wrs.375.1671033554398; Wed, 14
 Dec 2022 07:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20221214082652.419965-1-sandipan.das@amd.com>
In-Reply-To: <20221214082652.419965-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 07:59:01 -0800
Message-ID: <CAP-5=fWm55y6LdZozX=LuLZhk+SWm_yi5tLcKgT_UJt9FETNPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf vendor events amd: Add Zen 4 events and metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
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

On Wed, Dec 14, 2022 at 12:27 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Add events and metrics taken from the Processor Programming Reference
> (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
> found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip
>
> Previous versions can be found at:
> v1: https://lore.kernel.org/all/20221207053007.336806-1-sandipan.das@amd.com/
>
> Changes in v2:
> - Remove "bytes" from the names of data fabric bandwidth metrics which
>   use a scale unit.
> - Use better group names for pipeline utilization metrics.
> - Move patch that adds family-model mapping to the end of the series for
>   avoiding potential build issues.
>
> Sandipan Das (4):
>   perf vendor events amd: Add Zen 4 core events
>   perf vendor events amd: Add Zen 4 uncore events
>   perf vendor events amd: Add Zen 4 metrics
>   perf vendor events amd: Add Zen 4 mapping

Series: Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  .../pmu-events/arch/x86/amdzen4/branch.json   |   82 ++
>  .../pmu-events/arch/x86/amdzen4/cache.json    |  772 ++++++++++++
>  .../pmu-events/arch/x86/amdzen4/core.json     |  122 ++
>  .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
>  .../arch/x86/amdzen4/floating-point.json      |  818 +++++++++++++
>  .../pmu-events/arch/x86/amdzen4/memory.json   |  174 +++
>  .../pmu-events/arch/x86/amdzen4/other.json    |  138 +++
>  .../pmu-events/arch/x86/amdzen4/pipeline.json |   98 ++
>  .../arch/x86/amdzen4/recommended.json         |  334 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
>  10 files changed, 3630 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
>
> --
> 2.34.1
>
