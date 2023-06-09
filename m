Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2C728F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjFIFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjFIFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:35:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561CB30C3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:35:15 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so192555ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686288914; x=1688880914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huyUVDMxg1GoV5FZOI51i6E2H+gZK3CmXk2ot5DT6WQ=;
        b=BdohcS2YKN7Y6Nkt6DZ1VywZoCmYITtcN0a0If/FoAj6Ca00HhKdBOvYMCFAPTJFE9
         ZXe0wg0abGqrYA67IzsORf6MrZ3cUeqyb8sgqTuPSLLXkFgj9QHy4q+n6OLxQfl3q34K
         zAN556ZGW4ZLUutgPBI6WJE43B3ZRoNxfuuar51Vbqr/0FeS4BJyp5T/jR6oLqce7QHv
         3l5mBkR0rIaHvQR+CPWc9aLjpaynabibj18oOjo3Ku6IC88Yc5A2XcJpFdM9MYlVw9Va
         ilpxSvG3FYZI5R4SlzKf5OXUEjtliD0w/PMFRm4ieRcosSubNm/lHmyfVtfokZnp9Tuv
         B6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686288914; x=1688880914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huyUVDMxg1GoV5FZOI51i6E2H+gZK3CmXk2ot5DT6WQ=;
        b=H0KgBLXB2Rtz7tEMXPzRyOxzSTP/6yaT+LJVVGvOsLlVc9+RIJ7HYDWGb4r8JRbqei
         eQjfqnYLAh0ylC6al4ZsRmpwTzf3p7d9zQOpr/VfBsZfAv68d0fxHffW2i6CqK8wdQdD
         ecmcutm8EKx7MU1TBxAGP5e9NR2C+o7zG63mlvHlzYPlEusjtrJJS/brLuXHPAvWBvR9
         h/jAhwrNPwWiwb4GnSdxkD7Gvu3mecO6RCUkChiBTahdjqB0HkkoEFQkx9sOPDraObIP
         IjulVRA5nU+C5RMqTNFL+qSRSyNo57ja9XAYOUm8lwqD7Hn0jbLg23660WTmpGCBpygc
         qnNQ==
X-Gm-Message-State: AC+VfDx1npcHlk1IXp6L4ne1xcxXHtfj7qsISQVe/PbWzzcY3jtlVi1r
        /LUzgiblUrXJAIKv+A1J6IW/b+8dzCPvYXPBRxlfsw==
X-Google-Smtp-Source: ACHHUZ5psJw9BDdZbfXijPEdUpcfiOHjAVdmZBWWPWl8hK3hG+0My4xzhKcTlIpvGgqXwpewGpXMW4Gm/AKn3l1OgFY=
X-Received: by 2002:a05:6e02:156a:b0:335:e50d:9b11 with SMTP id
 k10-20020a056e02156a00b00335e50d9b11mr292583ilu.7.1686288914588; Thu, 08 Jun
 2023 22:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com> <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com> <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
 <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com>
In-Reply-To: <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Jun 2023 22:35:02 -0700
Message-ID: <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 10:30=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> On 09-Jun-23 10:10 AM, Ian Rogers wrote:
> > On Thu, Jun 8, 2023 at 9:01=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd=
.com> wrote:
> >>
> >> Hi Ian,
> >
> > Hi Ravi,
> >
> >> On 27-May-23 12:52 PM, Ian Rogers wrote:
> >>> Split the pmus list into core and other. This will later allow for
> >>> the core and other pmus to be populated separately.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >>> ---
> >>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++----------=
--
> >>>  1 file changed, 38 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>> index 58ff7937e9b7..4ef4fecd335f 100644
> >>> --- a/tools/perf/util/pmus.c
> >>> +++ b/tools/perf/util/pmus.c
> >>> @@ -12,13 +12,19 @@
> >>>  #include "pmu.h"
> >>>  #include "print-events.h"
> >>>
> >>> -static LIST_HEAD(pmus);
> >>> +static LIST_HEAD(core_pmus);
> >>> +static LIST_HEAD(other_pmus);
> >>
> >> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independe=
nt of
> >> core hw pmu. I wonder where does IBS fit. Currently it's part of other=
_pmus.
> >> So, is it safe to assume that other_pmus are not just uncore pmus? In =
that
> >> case shall we add a comment here?
> >
> > I'm a fan of comments. The code has landed in perf-tools-next:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/util/pmus.c?h=3Dperf-tools-next
> > Do you have any suggestions on wording? I've had limited success
> > adding glossary terms, for example, offcore vs uncore:
> > https://perf.wiki.kernel.org/index.php/Glossary#Offcore
> > I think offcore is a more interconnect related term, but I'd prefer
> > not to be inventing the definitions. I'd like it if we could be less
> > ambiguous in the code and provide useful information on the wiki, so
> > help appreciated :-)
>
> Does this look good?
>
> /*
>  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's s=
ysfs
>  *             directory contains "cpus" file. All PMUs belonging to core=
_pmus
>  *             must have pmu->is_core=3D1. If there are more than one PMU=
s in
>  *             this list, perf interprets it as a heterogeneous platform.


Looks good but a nit here. It is heterogeneous from point-of-view of
PMUs, there are ARM systems where they are heterogenous with big and
little cores but they have a single homogeneous PMU driver. The perf
tool will treat them as homogeneous.

Thanks,
Ian

>  * other_pmus: All other PMUs which are not part of core_pmus list. Does =
not
>  *             matter whether it is a per SMT-thread or outside of the co=
re in
>  *             hw. i.e. PMUs belonging to other_pmus must have pmu->is_co=
re=3D0
>  *             but pmu->is_uncore could be 0 or 1.
>  */
> static LIST_HEAD(core_pmus);
> static LIST_HEAD(other_pmus);
>
> Thanks,
> Ravi
