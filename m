Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD906F46D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjEBPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjEBPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:16:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D472114
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:16:41 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-330ec047d3bso103715ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683040601; x=1685632601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgQf3REMzYOuZ+1ZgyK5fke9Ps2GU4rRNicGysnK8q8=;
        b=w7GM7waiay/9nYQEzXai6Q33QVggtJKJtr/BmXdF7Xyn+io6TAGYRFbCi9L6RhHN61
         WnRiX9dkSAOKpLjRCpPMlzGjaCc57ikCX+Ba6i+HyBMhEmw2C9fWbeBNJ79/lzbp/tEZ
         pnWIOHKwt5sIWw0F9kHPATghH2gBX/P2mVQlB6olKQNDHtGtAh84zS6FP7skKNLWc9zD
         2XKEmbUChNIzuWxdo1aZiQW0XXpjT4HeDTEPCKDcwDPDQh5xmC8Zc4eXzIFZIhE7KIsp
         /45yRUnDzYPf6Mr5LZ627TGYh8r9s2tM4lQqWwlsKdBRBfvE/8O4QUktgPDVO/WEPklo
         hZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040601; x=1685632601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgQf3REMzYOuZ+1ZgyK5fke9Ps2GU4rRNicGysnK8q8=;
        b=lIHMuJQzFBUT1WGl/hIHZ732JfukGrWk1cCocqRtwg81vykeICgacvbGmJEX+0Q+Lw
         kM+SNCcP/cWNHT8X60bQiwJi3L+Bt1ceYPEuWS5dg7RIVTqFfWDwfh9kcN6580qMRtWi
         RNiiKVd3K5ffDD31oVddQAPmfQx3NWlrlD6li36t2zEs3tH6hBrueRtjKVN8T38brUIS
         WDsGeV8t0le06N+j8/6xdxnUBBnSr+mHheDeIkCqibLLHQNbOb+4haxLJlpYoSm78cii
         jFODiZlCrGp7BIiFFyE7tAf1fJTa4Utiaf06JGZSa1O+6f1rsUhmHi2l2u68V2osBGrU
         /07g==
X-Gm-Message-State: AC+VfDwLasdTlrUYJb93W3Q2Lu09bbT4cAluLQnVZZ2mkgXRAJifck41
        u3q5eyKhAnvd3cluELc8FhyQ+XlPdBHSIm2YY4HpSw==
X-Google-Smtp-Source: ACHHUZ46mgBYrXBlaTeoysijxAWvTxG1SGEBbaAaXuoLdNO5yxk1lOSH37DFUd5fFTDSabscRV9HchLEmLA5qtlQ304=
X-Received: by 2002:a05:6e02:1c21:b0:32a:f2a9:d1b7 with SMTP id
 m1-20020a056e021c2100b0032af2a9d1b7mr364329ilh.10.1683040600719; Tue, 02 May
 2023 08:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-13-irogers@google.com>
 <31dbae6c-4cbe-d7e2-bc78-beed959cbddc@amd.com>
In-Reply-To: <31dbae6c-4cbe-d7e2-bc78-beed959cbddc@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 08:16:29 -0700
Message-ID: <CAP-5=fW-_2OxYFTVuZgSPAPEH7DLGm1xS_Nijb0cTj3YKBQ7-A@mail.gmail.com>
Subject: Re: [PATCH v3 12/46] perf test: Test more sysfs events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
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

On Tue, May 2, 2023 at 3:27=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> > @@ -2225,74 +2226,82 @@ static int test_pmu(void)
> >
> >  static int test__pmu_events(struct test_suite *test __maybe_unused, in=
t subtest __maybe_unused)
> >  {
> > -     struct stat st;
> > -     char path[PATH_MAX];
> > -     struct dirent *ent;
> > -     DIR *dir;
> > -     int ret;
> > +     struct perf_pmu *pmu;
> > +     int ret =3D TEST_OK;
> >
> > -     if (!test_pmu())
> > -             return TEST_SKIP;
> > +     perf_pmus__for_each_pmu(pmu) {
>
> 'pmus' list might be empty and, if so, we need to fill it first with:
>
>         if (list_empty(&pmus))
>                 perf_pmu__scan(NULL);
>
> before iterating over it. Other option is to add this code to
> perf_pmus__for_each_pmu() macro itself.
>
> With that, the test fails for me:
>
> $ sudo ./perf test 6
>   6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            : Ok
>   6.2: Test parsing of "hybrid" CPU events                           : Sk=
ip (not hybrid)
>   6.3: Parsing of all PMU events from sysfs                          : FA=
ILED!
>
> > +             struct stat st;
> > +             char path[PATH_MAX];
> > +             struct dirent *ent;
> > +             DIR *dir;
> > +             int err;
> >
> > -     snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/=
",
> > -              sysfs__mountpoint());
> > +             snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/=
events/",
> > +                     sysfs__mountpoint(), pmu->name);
> >
> > -     ret =3D stat(path, &st);
> > -     if (ret) {
> > -             pr_debug("omitting PMU cpu events tests: %s\n", path);
> > -             return TEST_OK;
> > -     }
> > +             err =3D stat(path, &st);
> > +             if (err) {
> > +                     pr_debug("skipping PMU %s events tests: %s\n", pm=
u->name, path);
> > +                     ret =3D combine_test_results(ret, TEST_SKIP);
>
> combine_test_results(ret, TEST_OK); probably? Since many pmus don't expos=
e
> events via sysfs.

Thanks Ravi! The following looks to address the issues and I'll add it to v=
4.

'''
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-event=
s.c
index 35b35a5c795c..2ff61ee8f970 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -559,7 +559,8 @@ static int test__checkevent_pmu_events(struct
evlist *evlist)
       struct evsel *evsel =3D evlist__first(evlist);

       TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.nr_=
entries);
-       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.attr=
.type);
+       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.attr=
.type ||
+                                     strncmp(evsel->pmu_name, "cpu/", 4));
       TEST_ASSERT_VAL("wrong exclude_user",
                       !evsel->core.attr.exclude_user);
       TEST_ASSERT_VAL("wrong exclude_kernel",
@@ -2229,6 +2230,9 @@ static int test__pmu_events(struct test_suite
*test __maybe_unused, int subtes
t
       struct perf_pmu *pmu;
       int ret =3D TEST_OK;

+       if (list_empty(&pmus))
+                perf_pmu__scan(NULL);
+
       perf_pmus__for_each_pmu(pmu) {
               struct stat st;
               char path[PATH_MAX];
@@ -2242,7 +2246,6 @@ static int test__pmu_events(struct test_suite
*test __maybe_unused, int subtes
t
               err =3D stat(path, &st);
               if (err) {
                       pr_debug("skipping PMU %s events tests: %s\n",
pmu->name, path);
-                       ret =3D combine_test_results(ret, TEST_SKIP);
                       continue;
               }
'''
