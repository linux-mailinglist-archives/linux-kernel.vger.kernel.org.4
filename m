Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28E5640EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiLBTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiLBTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:45:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16CF4E92
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:45:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so9384180wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbzsLHN287NRmoIH0dYEVu2IEaMjMYmTN1PuYOM7BuY=;
        b=P0xsU1IaQIAlZ/k9ksfZJKi/poK1AM9cbxHTrW5Jdls9S08vVA7J6RBU29lS/jSXid
         PTSg6KsAT1b0xEjqI7fZv5PA5+bzTo0pbnkJU0iCP/Vhe+jA0tVqse99QjU5lB8oSEar
         VCY2rVFQ+n4emwu12CYcOyKyKbRXjfCxUSCigW3I8lh/wXIK6rlbYu/ZD3z5K7vKhZv9
         TE5o1xJjJoFeOyQUmmF4dh1LqLdxixA5asrDT8vV5qARsF+iT8p/z2wJnpnTX5KnVu9S
         odOFSf7EZ1xKWcvostLn9L9l5VUaNjcCnQAaV4FsLGHHRuqyIKQlW85ysM/W7U0SFWw0
         Jgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbzsLHN287NRmoIH0dYEVu2IEaMjMYmTN1PuYOM7BuY=;
        b=icxKKo9BPx2rf/QIX96XbPgUATdvqnKjOSO5Z+xVmR9DVc/0fFiw+9vxdm+o7eJBqH
         euzloIB7cY9V9Rfi+Wj/2gIAp9F4g/DqD0o9isQjdZlQ3fzZk/dzldjfCboWJ1rICqAP
         g+fBUxnMUFZ28e8glNRWs4QbMSagpMm+bs6QU14xf9nqsvUsanG7Q/FhPuvg0rK/nP73
         HhWqJwornoa9jgeEoea6lnbKs9uJuTc/+6JneIrYxRBGSrrEU/VSRzNa9+8DY8lN8Y9m
         1Bvhly+Jt1q/7CLzY/9Od0srcuQgn150l+ACxsFxTYdKDq8PihvfRSuww/lJepioT4Db
         0YJw==
X-Gm-Message-State: ANoB5pk5izqE/jje5oOb/XDNhiKzA6Rk1/kZUkgFk+k1OSYwFFE/SaWo
        xT7ENt16r3hEErMMuN7QXMMIwWjBl9LOARiLHrFlzw==
X-Google-Smtp-Source: AA0mqf5xdmtiVOODB6ewoUgH8vtcAtvaFCzCCZOnzUfuX1tmNCWT2nBVI+1TuXrlRdfbuEEX9SDRo7JCH6B9dSKzIr8=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr34644247wrj.40.1670010335669; Fri, 02
 Dec 2022 11:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-4-irogers@google.com>
 <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
 <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
 <CAM9d7chsymFFq1di15w+s7jtDenV=kFnk=EDrFO_rDWcSQSa6g@mail.gmail.com> <Y4pEHlmaT1i3j23J@kernel.org>
In-Reply-To: <Y4pEHlmaT1i3j23J@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 2 Dec 2022 11:45:22 -0800
Message-ID: <CAP-5=fUJ-X4vePcTN7DED4+R5NmqSuaO5Z=a5xLzV9mNbNwK-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Dec 2, 2022 at 10:29 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 02, 2022 at 10:08:04AM -0800, Namhyung Kim escreveu:
> > On Wed, Nov 30, 2022 at 12:13 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 11:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > > > > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > > > > build, don't compile in libtraceevent and libtracefs support. This
> > > > > also disables CONFIG_TRACE that controls "perf
> > > > > trace". CONFIG_TRACEEVENT is used to control enablement in
> > > > > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > > > > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > > > > kmem, kwork, lock, sched and timechart are removed. The majority of
> > > > > commands continue to work including "perf test".
> > > >
> > > > Maybe we can have a different approach.  I guess the trace data
> > > > access is isolated then we can make dummy interfaces when there's
> > > > no libtraceevent.  This way we don't need to touch every command
> > > > and let it fail when it's asked.
> > >
> > > Sounds like a worthwhile refactor that can land on top of this change.
> > >
> > > > The motivation is that we should be able to run the sub-commands
> > > > as much as possible.  In fact, we could run 'record' part only on the
> > > > target machine and pass the data to the host for analysis with a
> > > > full-fledged perf.  Also some commands like 'perf lock contention'
> > > > can run with or without libtraceevent (using BPF only).
> > >
> > > The issue here is that perf lock contention will use evsel__new_tp and
> > > internally that uses libtraceevent. As such it is removed without
> > > HAVE_LIBTRACEEVENT. Without the evsel there's not much perf lock
> > > contention can do, so rather than litter the code with
> > > HAVE_LIBTRACEEVENT and for it to be broken, I made the choice just to
> > > remove it from the no libtraceevent build for now.
> >
> > I don't think it needs evsel__new_tp() when BPF is used.
> > The BPF program is attached to the raw tracepoint without
> > perf_event and the result is written to the BPF map.
> >
> > >
> > > I think it is worth pursuing these patches in the shape they are in so
> > > that we can land the removal of tools/lib/traceevent and ensure the
> > > migration away from an out-of-date version of that library.
> >
> > Yeah, I agree that we should remove the stale libtraceevent but
> > I'd like to do it with minimal changes in the perf code base.
> > Let me take a look at this.
>
> Ok, was going to take a look at this patchkit, will wait for you now.
>
> - Arnaldo

So the problematic function is:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n482
struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)

on success it will always initialize:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n499
evsel->tp_format = trace_event__tp_format(sys, name);

tp_format is a libtraceevent type so this patch makes the variable
conditional on HAVE_LIBTRACEEVENT. I think this will remain true even
with a new evsel__newtp function that isn't dependent on
libtraceevent. I also think adding such things is best kept out of
this patch which is trying to do the minimal (only 312 lines of
addition) to have a build without libtraceevent.

Given we expect builds to use libtraceevent and we should build off of
this patch, I think we should look to land it for 6.2.

Thanks,
Ian
