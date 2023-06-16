Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16F4733AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjFPUhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:37:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D33AA3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:37:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9d619103dso15791cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686947869; x=1689539869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaWZAOYq9Kz+9I2rgSdZyzJkt4bwO6CIJObyuxXrsHk=;
        b=i84PUsAizzUSJ+I0fhdEyeE7PIh8vQ+ME3lGoIHMXeMSSTH15j1W+NTeAk60gbjrpo
         FthamMcN45HSyYjMwK60VazmXAaaEnB2+j/JzbSunlJmUrn3PVyaZe7YhNOzzmA5cwmr
         loDQbdhRGT80iDR/qBUhdLRR09AIrwYTzPQtRGw7iqk46WlhcqntOrfL7A185IrKsevd
         odgV5jvc90k8/8gkOK6R1jk9W4O8HEEvtG7q3+GkTMapY6J8114iJ+zFsLP/1watHsHN
         37CRKJ2A6CliCez4wi8nL8/CMlOQqQ+3qdctFAcxitxVkLuch+vUNtaiR9qqKlUEexvY
         WD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947869; x=1689539869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaWZAOYq9Kz+9I2rgSdZyzJkt4bwO6CIJObyuxXrsHk=;
        b=Up6ZHoRHYiCKDDXSAjIUNyfp3S+ukJgMRy/sR48/sg443oN9x8JpO9FRyuRAbqYHJd
         rO02lXhoMd2Fb7DOiqkhSoOHiFsrq5EF7mh1UFbWpaLtGoQM8ljW2FX/pVgekQrjeqXn
         4C61IFkw3CkFHKUqW9w9KgcZvyuYp2gHYT13rxhg4hGe2ig0qTK4NG4mGNNjQx8RaW9Y
         hf/ci9O9SCPH6IbVt7fgeAq3ezDwRxx23HxVnGTJejyxa7q+1xrrLGMN81obBw2BQeWb
         IgVx+8lrhZy5WRT3EE/uI3+FYhpj0GspW+YeHhfEvoh4Q7lYuxDDTS6ub5slrog9pAQk
         MLuw==
X-Gm-Message-State: AC+VfDwEbAjbNyMTGv3b/JPq+7vEf0LBq+xWrY56UkSEQXUDKU0GnDUl
        ug+1CNh8H/OcBKQg/ssyhXKlYrawM/74/D+vkXj6+A==
X-Google-Smtp-Source: ACHHUZ40HrYcnoK4CGXFjzBr80ourtV091ZlZtRSVYrio5xnaZTqaHSFo3Z6gsW0TercQW+GgffUlmuKxKsPKQj+x1w=
X-Received: by 2002:a05:622a:44:b0:3f9:f877:1129 with SMTP id
 y4-20020a05622a004400b003f9f8771129mr569817qtw.29.1686947868680; Fri, 16 Jun
 2023 13:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <202306161546.17ace7b9-oliver.sang@intel.com>
In-Reply-To: <202306161546.17ace7b9-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 16 Jun 2023 13:37:36 -0700
Message-ID: <CAP-5=fWxEjvK+ed-FFLuKT=AThhS_nH1ejOw=of7Shnu8oH-dw@mail.gmail.com>
Subject: Re: [linux-next:master] [perf parse] 70c90e4a6b: perf-test.perf_hw_event_sample_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX_NO_NMI_R1.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Samantha Alt <samantha.alt@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Weilin Wang <weilin.wang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 16, 2023 at 1:15=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-test.perf_hw_event_sample_group.group_sam=
pe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX=
_NO_NMI_R1.fail" on:

Failure is a memory leak that I believe was fixed in:
https://lore.kernel.org/r/20230608232823.4027869-20-irogers@google.com

Thanks,
Ian

> commit: 70c90e4a6b2fbe775b662eafefae51f64d627790 ("perf parse-events: Avo=
id scanning PMUs before parsing")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 925294c9aa184801cc0a451b69a18dd0fe7d847=
d]
>
> in testcase: perf-test
> version: perf-test-x86_64-git-1_20220520
> with following parameters:
>
>         type: lkp
>         group: group-00
>
> test-description: The internal Perf Test suite.
>
>
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306161546.17ace7b9-oliver.san=
g@intel.com
>
>
>
> Test Case group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses=
_instructions_NO_FIX_HAS_NMI_R1 FAILED!
>
>
> besides, we also observed below difference between this commit and its pa=
rent
>
> 442eeb77044705f2 70c90e4a6b2fbe775b662eafefa
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_NO_FIX_HAS_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_NO_FIX_HAS_NMI_R1.fail
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
