Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E1664C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbjAJTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjAJTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:09:10 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE710CD;
        Tue, 10 Jan 2023 11:09:09 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id 3so6548470iou.12;
        Tue, 10 Jan 2023 11:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m0o8gK2yZq30Jsm83JbSXnacP4P7Zm5m6HyGFlXqoA=;
        b=GbIwcWtqwM5Os3LqwcO+RJn5z6G3zxT2KshwF9RIqbuigGXXxRAFvUqCnCq6p32pGi
         WimPEefyGSyMJu18J8hvRwagVIqgHZV9GczkJErnagR7vT9TRRrWTwNDdDZTVUL2VNuf
         b4vocT1U8Yc2iMajvarEn1B8uFtqgKBsEiGGSb80XoXAhNUWUwPYLzM64N/PuDmbDCrA
         wtY7wvrFQhK7L327/cLqRauWNEFs1af3KwAI5g/G2QS0htQ0dX6gYqy6sVfavNNGVbQx
         vRH4UZxL7KXdfcA2ruseDb00jcgZ9zSVbji3FVPjZEB61053F3+xfT6neGl3ylPt7ANL
         KUDA==
X-Gm-Message-State: AFqh2krXFLoHZrE3MdcLtSNTRXbrCjSrpksq2vESd9LNxwtdvP9cE+f8
        xPihenIUVi9DaQ9vE9DwAj467B7n8gyffmOvdfs=
X-Google-Smtp-Source: AMrXdXuYsOyiDGutknMl1DcSOlA0HW9h91IYk6ptlwofXqJ5GoWoPHpif/AfJsVRLgKnT5MVfY7lxUVGfZUuB9nA0e8=
X-Received: by 2002:a02:ccb7:0:b0:38a:cbda:14b7 with SMTP id
 t23-20020a02ccb7000000b0038acbda14b7mr6467761jap.202.1673377748867; Tue, 10
 Jan 2023 11:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1201541-1-irogers@google.com> <CAM9d7cgGq=+MC+qwRNxO=0Bn_ZMOucEzh_WWH95Lq8fsYHMb4A@mail.gmail.com>
 <CAP-5=fXniy80Jpc2Hu=-GF7yDNUNHjs0=B2iqkUkMb6zArPukg@mail.gmail.com>
In-Reply-To: <CAP-5=fXniy80Jpc2Hu=-GF7yDNUNHjs0=B2iqkUkMb6zArPukg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Jan 2023 11:08:57 -0800
Message-ID: <CAM9d7chS+91Nep8FtsJsOdTvMJ0HhkSD1_Fn70=hWPi7a1JpfQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 3:38 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 2:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Mon, Jan 9, 2023 at 2:31 PM Ian Rogers <irogers@google.com> wrote:
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index e188f74698dd..cfcc253239f0 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -28,6 +28,7 @@
> > >  #include "time-utils.h"
> > >  #include "cgroup.h"
> > >  #include "machine.h"
> > > +#include "trace-event.h"
> > >  #include <linux/kernel.h>
> > >  #include <linux/string.h>
> > >
> > > @@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
> > >                 tep_read_number_field(field, a->raw_data, &dyn);
> > >                 offset = dyn & 0xffff;
> > >                 size = (dyn >> 16) & 0xffff;
> > > -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> > > +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> > >                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> > >                         offset += field->offset + field->size;
> >
> > Maybe I missed the previous discussion.
> >
> > As it's only used in the bit test, can we have something like this
> > in the header file?
> >
> > #if LIBTRACE_EVENT_VERSION < ...(1, 5, 0)
> > # define TEP_FIELD_IS_RELATIVE  0
> > #endif
> >
> > Thanks,
> > Namhyung
>
> We could but I think we lose some of the intention revealing-ness that
> TEP_FIELD_IS_RELATIVE is only present with libtraceevent 1.5.0 or
> newer.

I'm not sure how important it is to reveal the intention.
I think we wanted to minimize #ifdef-ery in the .c file and
moved the conditionals to the header.  Maybe we can add
a wrapper like this.

#if LIBTRACEEVENT_VERSION >= ...(1, 5, 0)
static inline bool is_relative_field(field)
{
    return field->flags & TEP_FIELD_IS_RELATIVE;
}
#else
static inline bool is_relative_field(field)
{
    return false;
}
#endif

Thanks,
Namhyung
