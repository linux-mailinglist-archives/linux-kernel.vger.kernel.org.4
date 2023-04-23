Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE096EBFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDWNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:50:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E181AB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:50:32 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef31924c64so1381271cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682257832; x=1684849832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyRqlqH+VocvSLvf8Cs9BeqUc8anbkSQ/JobZuPLOz4=;
        b=doVqfcmnfTMcU1JUXPOhHBk0gMNw0dWSGOCV8Q++v9Vdz+TD5EyR5UrsLJGo6DvA6L
         jvSTRmQ2DN7KOXidgD11FbOxfv0LA8voZH8hOVmgvuFV8ntAqUqKKByy+XqghEooxD2G
         QEE+IcqGY8EqG+atlmfXAP+SVVehKRASBpAlpyqRg5JbsgGdVhIRHmSNBiT6rHeJprbr
         e5zBUYKlGmJvqqtn/LSoIxDCGD4xN6YtPiIyrU1y+EfxtbjNDCQk9OMeJiIKxmle6qif
         pyjz+POsEWg/dlPmWYNFSBx9nAJQaN27B9ma61NP8ck9kK4kMWaUePjUTnhAnkS+7K49
         ZHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682257832; x=1684849832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyRqlqH+VocvSLvf8Cs9BeqUc8anbkSQ/JobZuPLOz4=;
        b=bj7+y+jRHgfjTHcipLhuvaCi/zYymlc+UV+rnzcOkAx78C0ADm1w+D+eVKM/DHmCUX
         wxdpZbyHyrLWGdpUw0mchpD8FLttlLU6e4S2BfxXTXW+N37LsPO6UNLuO5f3OSFXZEjI
         l+qXl0Fr8mZbEweaAixNww4zy6GnG7acZwvPXNIMIYku/uBnZgl/4UGjJN6GFviyEtJD
         /qwixIeQK8vw8gPVmc6Hgw2OvCObK+ch9hUtvt9HCsLId7V3AewqfkUCLjPwMDMkMq61
         lap6VjNwJ4IenTgInj6x48xKo2vtWBJOlDvHr8XaHCtAmL7Q1BUji779/5oKf5hzHhJQ
         crAQ==
X-Gm-Message-State: AAQBX9cgL+Jnxg32mzFO12WvKD4XkPOTKqJavnDOZ918Q3ky99V3DYSO
        HNKDPhEeJ8C8iR+0vlchfVUodY0e+yATQ9pdIsqO3w==
X-Google-Smtp-Source: AKy350bfTV91nZ12wkSAkeXAw+Los8BXD/na0U/L8j8pEBCCdq1RXFfNO9TYJ1MIhCk1JUAmbOLs69XFGr5PQTtOYo4=
X-Received: by 2002:a05:622a:351:b0:3ef:62f2:52df with SMTP id
 r17-20020a05622a035100b003ef62f252dfmr320539qtw.9.1682257831737; Sun, 23 Apr
 2023 06:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <202304231436.60a4979b-oliver.sang@intel.com>
In-Reply-To: <202304231436.60a4979b-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 23 Apr 2023 06:50:19 -0700
Message-ID: <CAP-5=fV1u3LUP2S=LB8+w2Bwy1MEWme9Py_B6ZfDpYQ4aW3XdQ@mail.gmail.com>
Subject: Re: [linux-next:master] [perf vendor events intel] 9d9675bb41: perf-sanity-tests.perf_all_metricgroups_test.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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

On Sat, Apr 22, 2023 at 11:54=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.perf_all_metricgroups_test.f=
ail" on:
>
> commit: 9d9675bb411b08bc6c5bb2f399ee497f5880b551 ("perf vendor events int=
el: Refresh skylake events")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 44bf136283e567b2b62653be7630e7511da41da=
2]
>
> (we reported [ammarfaizi2-block:acme/linux/perf-tools-next] [perf vendor =
events intel]  9d9675bb41: perf-sanity-tests.perf_all_metricgroups_test.fai=
l
> on https://lore.kernel.org/all/202303080946.e5743bf5-oliver.sang@intel.co=
m/
> when this commit is on https://github.com/ammarfaizi2/linux-block acme/li=
nux/perf-tools-next
> since now it's on linux-next/master and we still observed same issue, rep=
ort
> again FYI)
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-00c7b5f4ddc5-1_20230402
> with following parameters:
>
>         perf_compiler: gcc
>
>
>
> compiler: gcc-11
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz=
 (Kaby Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202304231436.60a4979b-oliver.sang@=
intel.com
>
>
>
> 2023-04-21 05:44:17 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-9d9=
675bb411b08bc6c5bb2f399ee497f5880b551/tools/perf/perf test 101
> 101: perf all metricgroups test                                      : FA=
ILED!
>

I wasn't able to reproduce this in perf-tools-next with -fsanitize=3Daddres=
s:

102: perf all metricgroups test                                      : Ok

The blame on this also looks questionable as Skylake events aren't
applicable on Kabylake.

Thanks,
Ian

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
> https://github.com/intel/lkp-tests
>
>
