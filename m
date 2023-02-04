Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0568AC93
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBDVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjBDVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:24:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907113DF1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:24:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso8295980wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PARsC8y1fPOLUn5xm+fwUpwavqaXYaKZQCUnLUBx/AY=;
        b=ROSh4d0FpqJs8EZAFBENi9nSEZsbr7+OYgUVCkyfoz70uvDwzo3wKCvO8P3dzrhkgg
         +MrRaxu4KnvTg1c/Lc9uA5/0kcOjZd7jES4QK6IRQkvTdQwSCEIWR3Y4HsxOLGUVQ/8y
         AymaF5hX5TUlHN4eiB3z1/aUP6/RA2P7o5VFGy1NZMGOc83eYY5podlRfX1R3copJfWf
         WfeO/jWPsJp2kqEvZPbLAwORIqf7YTB7DvhRngEMxZPJwA3tDk2EFIQtb+/YOGlH0SWB
         IzApacoZLLrLAHO/e1YfAhuYWGGhtKLjM/4Orb+TLWvt3jyQNX07qnkyvdmNXeB2h3re
         vD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PARsC8y1fPOLUn5xm+fwUpwavqaXYaKZQCUnLUBx/AY=;
        b=X0DMegcCJJYl7wGI/J+ItQWb6XTAWS4tIFtrUNmMmkrqNYRS9pJkzRJPTF+YOgVjWV
         0yqviEH9RX6+3YP8j1f5F3tnYklJzq94DY/44MEUPx3sP8ShU+aMJPQzg2mWce+OW7+E
         9U2G8iRAlE5SRE6RKoGq1xdIqoTnhlluvQMXZc9VMH14+2MWN9R80iB/IO6c4nVLFmOt
         g/g71XQoc9sxL26KP6m+hGzohoFtFA5IXJ4zZJQR2JA9tac7CTQmjMGhz+12R5Ajv6r4
         KLJJTSKrj4Uf1OtX5OVVwIzXvzRlaDdYW4CVeHN49Ao3RaLx0dm2wwlc922Nybh+rtd1
         99VQ==
X-Gm-Message-State: AO0yUKU6UuQNCWvRyyPF6AiYGNyLx0aQz7FrLcbogT67SRlChmz5J3k1
        kypfyUAdiejsly9KvTeKQhFWJv7kDycJO0fqGQ5uXA==
X-Google-Smtp-Source: AK7set8E/kwj+RPaRP0zrGj8rKXKAErZLLzjxXZGU2xDbLWNgjsyjgtnzFH2ioXJ1Fj05s2DC8Kfc/P/mIAw/Owkaq0=
X-Received: by 2002:a05:600c:1e0a:b0:3dc:599b:795e with SMTP id
 ay10-20020a05600c1e0a00b003dc599b795emr663412wmb.203.1675545847849; Sat, 04
 Feb 2023 13:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20230203014014.75720-1-irogers@google.com> <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
 <Y90XgtX9uv26UAQa@kernel.org> <Y90bsM4DGL+WV8m0@kernel.org>
 <Y90b7shHtOCQL3ma@kernel.org> <Y90di+N7TODkFvMV@kernel.org>
 <Y90rtA95mWW5Othk@kernel.org> <Y90v+jTe6z1dSFE0@kernel.org> <Y908vNzJp7cVM8gN@kernel.org>
In-Reply-To: <Y908vNzJp7cVM8gN@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 4 Feb 2023 13:23:53 -0800
Message-ID: <CAP-5=fVfNVSTqSp4qzqAHcCXqwOHXaq1eMuyf2y67vvsrwwO6g@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Fix aarch64 build
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 3, 2023 at 8:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Fri, Feb 03, 2023 at 01:02:02PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Feb 03, 2023 at 12:43:48PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > I tried bisecting, but at this cset:
> > >
> > > acme@roc-rk3399-pc:~/git/perf$ git log --oneline -1
> > > d22e569cd33d (HEAD) perf pmu-events: Separate the metrics from events=
 for no jevents
> > > acme@roc-rk3399-pc:~/git/perf$
> > >
> > > I'm getting this:
> > >
> > >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> > > pmu-events/pmu-events.c:3637:32: error: no previous prototype for =E2=
=80=98perf_pmu__find_table=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >  3637 | const struct pmu_events_table *perf_pmu__find_table(struct pe=
rf_pmu *pmu)
> > >       |                                ^~~~~~~~~~~~~~~~~~~~
> > >   CC      /tmp/build/perf/builtin-ftrace.o
> > >   CC      /tmp/build/perf/builtin-help.o
> > >   CC      /tmp/build/perf/builtin-buildid-list.o
> > > cc1: all warnings being treated as errors
> > > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp=
/build/perf/pmu-events/pmu-events.o] Error 1
> > > make[2]: *** [Makefile.perf:676: /tmp/build/perf/pmu-events/pmu-event=
s-in.o] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> > >   CC      /tmp/build/perf/builtin-buildid-cache.o
> > >
> > > <SNIP>
> > >
> > >   CC      /tmp/build/perf/tests/attr.o
> > > arch/arm64/util/pmu.c: In function =E2=80=98pmu_events_table__find=E2=
=80=99:
> > > arch/arm64/util/pmu.c:35:24: error: implicit declaration of function =
=E2=80=98perf_pmu__find_table=E2=80=99; did you mean =E2=80=98perf_pmu__fin=
d_by_type=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > >    35 |                 return perf_pmu__find_table(pmu);
> > >       |                        ^~~~~~~~~~~~~~~~~~~~
> > >       |                        perf_pmu__find_by_type
> > > arch/arm64/util/pmu.c:35:24: error: returning =E2=80=98int=E2=80=99 f=
rom a function with return type =E2=80=98const struct pmu_events_table *=E2=
=80=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
> > >    35 |                 return perf_pmu__find_table(pmu);
> > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp=
/build/perf/arch/arm64/util/pmu.o] Error 1
> > > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: uti=
l] Error 2
> > > make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arm=
64] Error 2
> > > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arc=
h] Error 2
> > > make[3]: *** Waiting for unfinished jobs....
> > >   CC      /tmp/build/perf/tests/vmlinux-kallsyms.o
> > >
> > > -----
> > >
> > > I'm building with:
> >
> > So:
> >
> > acme@roc-rk3399-pc:~/git/perf$ find tools/perf/ -name "*.[ch]" | xargs =
grep -w perf_pmu__find_table
> > tools/perf/arch/arm64/util/pmu.c:             return perf_pmu__find_tab=
le(pmu);
> > tools/perf/pmu-events/pmu-events.c:const struct pmu_events_table *perf_=
pmu__find_table(struct perf_pmu *pmu)
> > acme@roc-rk3399-pc:~/git/perf$
> > acme@roc-rk3399-pc:~/git/perf$ git log --oneline -1
> > d22e569cd33d (HEAD) perf pmu-events: Separate the metrics from events f=
or no jevents
> > acme@roc-rk3399-pc:~/git/perf$
> >
> > Tring to fix...
>
> tools/perf/pmu-events/pmu-events.c was a leftover from a previous build,
> strange as I build using O=3D, not to clutter the source dir, so perhaps
> handling that is missing, I'll check.
>
> Fixed aarch64 specific one with:
>
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/uti=
l/pmu.c
> index 801bf52e2ea6..b4eaf00ec5a8 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -32,7 +32,7 @@ const struct pmu_events_table *pmu_events_table__find(v=
oid)
>         struct perf_pmu *pmu =3D pmu__find_core_pmu();
>
>         if (pmu)
> -               return perf_pmu__find_table(pmu);
> +               return perf_pmu__find_events_table(pmu);
>
>         return NULL;
>  }
>
>
> ---
>
> Continuing...

Thanks! Sorry for missing this one. Ideally we'd have less code under
arch/ . The previous error messages made me think you may need to
build clean.

Ian
