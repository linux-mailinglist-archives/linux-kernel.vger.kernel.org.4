Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFC5EEBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiI2CX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2CXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:23:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F5123DB5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:23:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay36so44818wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=885bZoAF9cATz3vxtOjRWDKiMOgQWtWGS/sIyDsnGvc=;
        b=j5blAkgzNbivA6YVD15PkyBQU0hoYVrqId7OzizI0uth5eAYft6AsJiHya90NxrNiN
         Ea3EnkUZJmr6iLkBBGK3NHfXWapei/cwLSfCOTd2Dak6NmlEPu3tYgLuqhhv1t9vHXCb
         NqlcLGknKQ+17inzmKVOEaAPQvDjz6/G/gCDZ/InxqHT4vHb4cs5hSzNrpAZ+2zJVXmQ
         3PGzWAXGuOy8dLDsPwwqSakykRIpbRNDAVyqJS8ObwKoq500CsjONv53rM6ILvRC6bdF
         rGCr52NFeSTphWjXB4+seKyq4ZXy91Gra5n+RmWCUqYm2lOMbr/d618Bbau0OI3NxsoZ
         4AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=885bZoAF9cATz3vxtOjRWDKiMOgQWtWGS/sIyDsnGvc=;
        b=JozeoSHuEHtagm2Z0SyBYPhntVkVR9k10YhB1UtlF4jtyM1SHShzK3G0n28RF7rVuM
         QiUtaK/Eug+pIeLzydavudN02mI81Ru+wuUCW5YKbhpQC/4nELsnIz+Ab6jq6biNOADo
         oUurMQ3JxeFo7pUsNSdWOMF3BCadmzpn/PxnjfZ+EzRVJDv5INwyaPFna4imv0vqFasx
         hjpmTiXpXJ8H72pmMtFo2VUg01x6dAciOqXmABUe2ihgQVKjzYWcQEewy65VJW9QMcih
         hp/XVxH0RCpvAgGTQGRdwAtA44zkw40mDQoe8pGbPWjH5LSFBti5yd/ch0kgOhEdQRZ0
         gH8w==
X-Gm-Message-State: ACrzQf2TkQ2hpZwOcrToXFv2OqnFyydUdMhP/uxnbSrs0pJu1vJT5IEI
        XP8vyevOFnXdr5O5Wuw572FHlvTwPAqoTLG4MXs0xg==
X-Google-Smtp-Source: AMsMyM4EW3WEL/8g7SzWKMrlQzFsAoKaRVucZZV7DfGGh8BFJ5SKG/B3CTiIV24PnStGZFrapbXl5A5jPXKfM0jO3tk=
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id
 e1-20020a05600c218100b003b474e416f8mr516955wme.174.1664418230461; Wed, 28 Sep
 2022 19:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com> <20220928072204.1613330-6-irogers@google.com>
 <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com> <YzRVOD4u2SI0K29Y@kernel.org>
In-Reply-To: <YzRVOD4u2SI0K29Y@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:23:37 -0700
Message-ID: <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/22] perf vendor events: Update Intel alderlake
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 7:08 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Sep 28, 2022 at 04:22:53PM +0800, Xing Zhengjun escreveu:
> > On 9/28/2022 3:21 PM, Ian Rogers wrote:
> > > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > index 7f2d777fd97f..594c6e96f0ce 100644
> > > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > @@ -1,5 +1,5 @@
> > >   Family-model,Version,Filename,EventType
> > > -GenuineIntel-6-9[7A],v1.13,alderlake,core
> > > +GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
> >
> > The commit description should mention this change "Add more CPUID support
> > for ADL"
>
> I added this note, with that can I have your Reviewed-by or Acked-by?
>
> - Arnaldo

I think I should send a v2. I can add this then. Other things for v2 are:
- this week there will likely be an update to [1] which is implicitly
integrated here.
- the topdown metrics are all percentages but are currently values
zero to 1. It is straightforward to add a ScaleUnit of 100% to them
all.
- eyeballing topdown event metrics like:

    {
       "BriefDescription": "This category represents fraction of slots
utilized by useful work i.e. issued uops that eventually get retired",
       "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
       "MetricGroup": "TopdownL1;tma_L1_group",
       "MetricName": "tma_retiring",
...
it looks like the group will fail due to the missing slots event. This
can be fixed with:
       "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
* TOPDOWN.SLOTS",

Thanks,
Ian

[1] https://github.com/intel/perfmon-metrics

> > >   GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> > >   GenuineIntel-6-(3D|47),v26,broadwell,core
> > >   GenuineIntel-6-56,v23,broadwellde,core
> >
> > --
> > Zhengjun Xing
>
> --
>
> - Arnaldo
