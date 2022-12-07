Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5471C645F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLGRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLGRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:00:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF468C6C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:00:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m19so14146078wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXesToSWwwnCKV+g1AwRtRU3qfEBkcVEBg6QS+SjDxU=;
        b=KPDXYZ3duUZaAEdvvywMI9z5Q7Ah5nmdDmWoMbtDIcnjhdbFOj2001pt6dx2i9HBiI
         WIsFHDZF0EdUsKqoKTZmIXT9iahUvqWD65BZfbKTUXH73lJY+4MGRPSgJGb5ByJzVEK0
         iXGZ4gWRH/OV56kGeneKC6DzoKTwdwRdhJKeTXZn3H0S2+XQONlr21k27tQ533O1+Yj7
         MeSPWUXxsF4FnXNm9htMujyhue+JWos9/2r8PgnFHGUl/7zfCuEzfQh7oCcZgVZL5U3g
         1IgHzPewSxwcR9wCH2Khb50u7jgqj+Z4huhBLnlL31H2Om9m5RYaIlL866IJDKXjq5wz
         lUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXesToSWwwnCKV+g1AwRtRU3qfEBkcVEBg6QS+SjDxU=;
        b=IcTEQzHr5rFDpxjOgZduZHPZAgYqmmME9I6NeOcqKi71XVM13PNG0Ocr7JlYfaaJyw
         4XbJcOC1myRl8mR/S2X2ArTUXE/iBEhG9QC+XIUxlWzFwlHLMJ90RL9vmfjwlDYIu+XY
         dAuaSDAKuMW0/GH1c3NqoM0pjIDhZHFiKyvcCQ7yfwLD+jmWnCX0CI0pQ7FzHUuHX7rM
         kW5hDWR/V8BmQADhspRf/JBFwePLDQyRFeGnoaealSgd4jblkS9hUsrFQhp8lcTqkuSp
         59DSab+7+UvREWfQLzX4ngMKF1wGCcmIsKUHVQz64ubjQHy3kk5htfp36URuiU+nd6wc
         BeQA==
X-Gm-Message-State: ANoB5pk9bSCS3gCmi9aiuCbMiqloXTI9NWSXP7saiE3fnmil+kkGGc67
        peR1nvmrGmwxYdEmNOAh+RWnpo03q5VpM/h9Di5mtA==
X-Google-Smtp-Source: AA0mqf7EL9SVPdzmspMbX3uo2aj+Ffe0HMOfPSEBf1yBBX6KBSWuzkXm7BPUhNMirUVS0NsphHZk0Oyhelhb25tR8jw=
X-Received: by 2002:a05:600c:3d8f:b0:3cf:6a4c:af8b with SMTP id
 bi15-20020a05600c3d8f00b003cf6a4caf8bmr55219737wmb.115.1670432439791; Wed, 07
 Dec 2022 09:00:39 -0800 (PST)
MIME-Version: 1.0
References: <Y49vx0v6Z7EiR8jr@kernel.org> <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
 <Y5ChXjt0uv/yDNwV@kernel.org> <Y5Cjylv9dJh796dw@kernel.org>
 <20221207093958.09ae35c2@gandalf.local.home> <Y5C5AZ1YfthY0tx2@kernel.org>
In-Reply-To: <Y5C5AZ1YfthY0tx2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Dec 2022 09:00:27 -0800
Message-ID: <CAP-5=fWBzNP=uDLdyODC8gvT3KT5Kz9rRNouyLn=22_ouD8wEg@mail.gmail.com>
Subject: Re: [ALMOST ready] Re: [PATCH 2/3] perf build: Use libtraceevent from
 the system
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
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

On Wed, Dec 7, 2022 at 8:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Dec 07, 2022 at 09:39:58AM -0500, Steven Rostedt escreveu:
> > On Wed, 7 Dec 2022 11:31:38 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > > No distro I tested so far has a package for libtracevent in is default
> > > repositories:
> >
> > Not sure what you mean by "default repository".
> >
> > At least on Debian testing, I have libtraceevent-dev available.
>
> Right, I'm talking about non-bleeding edge, distros that are still
> supported. I'm still checking, fedora is ok all the way back to 33, wrt
> having libtraceevent available.
>
> - Arnaldo

I think this is both similar to the python2 issue and different. With
python we now have a build time dependency on having at least Python
3.6 if you want json events. With this change you need the system to
have libtraceevent if you want to have various commands like perf
sched, perf trace, etc. Losing entire commands with this change is
more than happened with the Python 3.6 dependency. With the python
issue, you can fix the build issue by installing Python 3.6 and with
this issue you can fix it by installing libtraceevent-devel. In both
cases you can install via a package manager, but given you are likely
building the perf tool from source, you can also build both python and
libtraceevent from source. Saying that an old distro is broken by this
change, or the Python 3.6 change, I think is too strong and we're in
danger of holding things back for a very small (possibly 0) set of
people. They'd have to be upset about building from source on an old
distro, then losing the less commonly used commands of perf sched,
perf trace, etc. and be unwilling to build libtraceevent from source.
Given they are building the perf tool from source I just can't imagine
they'd be too upset about building libtraceevent from source.

I think a problem with both changes is that the build time warning
given isn't loud enough. Perhaps we can make it that at build time we
$(error for these recommended dependencies, unless NO_JEVENTS=1 or
NO_LIBTRACEEVENT=1 are added. Losing functionality and just having a
small $(warning seems error prone and likely to cause functionality to
be accidentally lost.

Thanks,
Ian
