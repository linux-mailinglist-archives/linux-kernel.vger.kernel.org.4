Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84842711E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjEZCjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEZCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:39:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17869B2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:39:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso34385e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685068751; x=1687660751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohn1R/J/AfVb3I/VEMDslEkxtOuOHHHyZhBzkm1KS9A=;
        b=imnTHtCM9B41B34Y88WUIV9SySffeXBhGujLP09b8xEmkT8e1iCE0AQiCzbgEBX8Hh
         uuodaiLmZkkuOCFLrbXKan08UU5d8uUhW8H3eNpe6aO9wOXbgX53HB8EPL1L81Y8wp9h
         S6ZW4pTFmwL7EjwL7fIDcW6oyXD1dPy5NkeKgwmo3xvVkvnAp93fMRCFA8bcJC9c7moJ
         xsg0gIKiMl3ze2wnd5rLrsSWSb4lev5SL0W/EJmYhgWCeaIbcQ/HhlKF1YtEjvai8Yzl
         Qx6X0sfyvmIpX22LoHOZqnpDu4zvtDFIXPhLkOT1uAzHdv+PvYWILvYrOME8MNIoWLY0
         ogyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068751; x=1687660751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohn1R/J/AfVb3I/VEMDslEkxtOuOHHHyZhBzkm1KS9A=;
        b=FBb3mpMp4ndZYN7m0VA9qEQD/eppBs1MKSln65P96nt03sJnnEWstmMzAmUd49r2MD
         5tqgf/5VCs+6sc74L2cnlmLI+C7Bi2qj44BoJEkBjRhUeeeqrIKkgnjc2RawbIBP7AZN
         5XTBQEjbuOBCErTC2rcgj2ynwg6ycRgFfr3qXscRb3OlmDnqJf5JLFjVIl7W9QT37QKY
         r5tmeyD/sV2yIsc8muKh1fuUSFk2l4VkLYV6qke7x3AN3WIhsMLcOlqMaDPGWhvc40Q/
         4PuFa39xxdsSr+EiGWjvifBMrg1cXYqjD21G0xbrARKzjltd8Te6cXWOdr8BALPDicMM
         Ss0g==
X-Gm-Message-State: AC+VfDwUJnc6D0VKphLhpkRC2eNcjb77/IeimL/xzyq1G6VwnB+LyATD
        4whO/D2xtZ1TkfW9YhkgoWcjSqMQTN2K43ty0DfJlg==
X-Google-Smtp-Source: ACHHUZ6UoviObZrMDQ9owiCul166V1WvP9U/Z3lUioxOIPvrkfVoIPMVX0b5IORZYmUZpkxmx4Ypx7OyNnLu3Wk1PDo=
X-Received: by 2002:a05:600c:3c96:b0:3f4:1dce:3047 with SMTP id
 bg22-20020a05600c3c9600b003f41dce3047mr5863wmb.2.1685068751363; Thu, 25 May
 2023 19:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com> <20230525071133.2066610-2-irogers@google.com>
 <CAM9d7cgaSPbnjoA6bv8fwkpoyc6nCdXOOrbmBm_jGbZbm3a_4w@mail.gmail.com>
In-Reply-To: <CAM9d7cgaSPbnjoA6bv8fwkpoyc6nCdXOOrbmBm_jGbZbm3a_4w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 25 May 2023 19:38:57 -0700
Message-ID: <CAP-5=fX0BnzQacr1NRQfis42osk07BuKJ9BqNTf7pGBMoj4ORA@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] perf header: Make nodes dynamic in write_mem_topology
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, May 25, 2023 at 12:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, May 25, 2023 at 12:12=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Avoid a large static array, dynamically allocate the nodes avoiding a
> > hard coded limited as well.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/header.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 2dde3ca20de5..80593ed8c79b 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -24,6 +24,7 @@
> >  #include <bpf/libbpf.h>
> >  #endif
> >  #include <perf/cpumap.h>
> > +#include <tools/libc_compat.h> // reallocarray
> >
> >  #include "dso.h"
> >  #include "evlist.h"
> > @@ -1396,13 +1397,14 @@ static int memory_node__sort(const void *a, con=
st void *b)
> >         return na->node - nb->node;
> >  }
> >
> > -static int build_mem_topology(struct memory_node *nodes, u64 size, u64=
 *cntp)
> > +static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
> >  {
> >         char path[PATH_MAX];
> >         struct dirent *ent;
> >         DIR *dir;
> > -       u64 cnt =3D 0;
> >         int ret =3D 0;
> > +       size_t cnt =3D 0, size =3D 0;
> > +       struct memory_node *nodes =3D NULL;
> >
> >         scnprintf(path, PATH_MAX, "%s/devices/system/node/",
> >                   sysfs__mountpoint());
> > @@ -1426,16 +1428,24 @@ static int build_mem_topology(struct memory_nod=
e *nodes, u64 size, u64 *cntp)
> >                 if (r !=3D 1)
> >                         continue;
> >
> > -               if (WARN_ONCE(cnt >=3D size,
> > -                       "failed to write MEM_TOPOLOGY, way too many nod=
es\n")) {
> > -                       closedir(dir);
> > -                       return -1;
> > -               }
> > +               if (cnt >=3D size) {
> > +                       struct memory_node *new_nodes =3D
> > +                               reallocarray(nodes, cnt + 4, sizeof(*no=
des));
> >
> > +                       if (!new_nodes) {
> > +                               pr_err("Failed to write MEM_TOPOLOGY, s=
ize %zd nodes\n", size);
> > +                               free(nodes);
> > +                               closedir(dir);
> > +                               return -ENOMEM;
> > +                       }
> > +                       nodes =3D new_nodes;
> > +                       size +=3D 4;
> > +               }
> >                 ret =3D memory_node__read(&nodes[cnt++], idx);
>
> I think you need to handle error cases here.
>
> Thanks,
> Namhyung

Not sure I follow. The reallocarray tests for failure, frees nodes and
returns -ENOMEM on error.

Thanks,
Ian

>
> >         }
> >
> >         *cntp =3D cnt;
> > +       *nodesp =3D nodes;
> >         closedir(dir);
> >
> >         if (!ret)
> > @@ -1444,8 +1454,6 @@ static int build_mem_topology(struct memory_node =
*nodes, u64 size, u64 *cntp)
> >         return ret;
> >  }
> >
> > -#define MAX_MEMORY_NODES 2000
> > -
> >  /*
> >   * The MEM_TOPOLOGY holds physical memory map for every
> >   * node in system. The format of data is as follows:
> > @@ -1464,8 +1472,8 @@ static int build_mem_topology(struct memory_node =
*nodes, u64 size, u64 *cntp)
> >  static int write_mem_topology(struct feat_fd *ff __maybe_unused,
> >                               struct evlist *evlist __maybe_unused)
> >  {
> > -       static struct memory_node nodes[MAX_MEMORY_NODES];
> > -       u64 bsize, version =3D 1, i, nr;
> > +       struct memory_node *nodes =3D NULL;
> > +       u64 bsize, version =3D 1, i, nr =3D 0;
> >         int ret;
> >
> >         ret =3D sysfs__read_xll("devices/system/memory/block_size_bytes=
",
> > @@ -1473,7 +1481,7 @@ static int write_mem_topology(struct feat_fd *ff =
__maybe_unused,
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D build_mem_topology(&nodes[0], MAX_MEMORY_NODES, &nr);
> > +       ret =3D build_mem_topology(&nodes, &nr);
> >         if (ret)
> >                 return ret;
> >
> > @@ -1508,6 +1516,7 @@ static int write_mem_topology(struct feat_fd *ff =
__maybe_unused,
> >         }
> >
> >  out:
> > +       free(nodes);
> >         return ret;
> >  }
> >
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
