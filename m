Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39F162E8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiKQWwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiKQWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:52:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E965E69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:52:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t4so2400089wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt8mo/vmbZwNG8GL/TKOQ4X0XW2Ob2p8e2KGFxJx1qo=;
        b=S81v9zXCrlVa1P7JdBW/JpWc4PV1I/azzGigr+dVNTPAvkNJSd66X2QQ4AsI0Jvesb
         BYu6xt9q+UIyPvvli2lQEImOd5npZYrtQzAA0tUzUTIPhuADa1svox4+UaWvWqvgx5+t
         ieDx11JNpPMr9OgXPQccUR8OazG0Qmhd13bzqwJuzTmwoeJiiGQ6BNnIH0qmn/R7IrGV
         OdQVhTNA5vTqoaTP1P7W+5EqyWsJ6k866/hxaCYaM09p9e8VTdIuhncN579tXoDGsqz2
         ujwMrksk8nxB+dAFINDJhS0onaCXT3E62y/QAlxGzFsube6XYTVtJScTjdKJrc3SXay6
         7i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt8mo/vmbZwNG8GL/TKOQ4X0XW2Ob2p8e2KGFxJx1qo=;
        b=scva9m7zUFcXJehJ8ne9Vb8TlN2IytXb3/qMclrSV/f84y4eT9Z/39xTTKlluK5moH
         bQq0OEzBEN7OPNlFpgh2ae9jMhfoq5mZaLbcK8gXfCzwwLvh+mmanHV3fTQQT5twopOi
         cgHwCXFSCBIAaIbqMXIk62LO5+AQW/7rtnGolXTTzUXl1GjOZuMl7NwmBXrLs2xlBt7T
         E3tM5ngLQ2M/x5xcicAtKph8T1a8Aixtbb/V8jwLkNP4tUAPG7nCISGbM8NTe6NvN0Nj
         wsugIG+cmJrzx3qSXkLat9GmHBAcL1rUhRdWQ+qmw+VxPi4BdMcz9eD9H7M51EaDpJ6Q
         8Xmg==
X-Gm-Message-State: ANoB5pkaz4rSQuN44eNwt2i43RCwuiSsLshRlXAh2qZFRcgvdP+V/L3k
        vCsmjhiH2rh+4fLnYizukbZ2PkyDnuLAPM5cSCQsYw==
X-Google-Smtp-Source: AA0mqf7I7gZKcrogPJVyhv0VubDrk/oH7agbpOC6L9wKsryHGMj4QrtQY59KLOsHOGRRapuVENIWQjQ01+0QCtrGqTA=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr2947166wmp.174.1668725538850; Thu, 17
 Nov 2022 14:52:18 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fWxAjEia-Qbm0RVzKOxyiod8rUOBieqaGK=DtQboDe3Qw@mail.gmail.com>
 <20221117134250.532a44c9@gandalf.local.home>
In-Reply-To: <20221117134250.532a44c9@gandalf.local.home>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 14:52:06 -0800
Message-ID: <CAP-5=fUmWPz8ZyfuXu929VZkRNXKmD0PCX9WwZNWu+17-ENKiw@mail.gmail.com>
Subject: Re: Remove traceevent from tools/lib
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
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

On Thu, Nov 17, 2022 at 10:42 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 17 Nov 2022 09:59:46 -0800
> Ian Rogers <irogers@google.com> wrote:
>
> > Means that perf is cleanly(ish) separated from libraries in tools/lib.
> > traceevent in tools/lib is out of date (~2years - version 1.1.0 whilst
> > the latest is 1.6.3 [1]) . Should we delete traceevent from tools/lib
>
> Yes please!
>
> Strongly-acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I sent v1 patches:
https://lore.kernel.org/lkml/20221117224952.358639-1-irogers@google.com/

Thanks,
Ian

> -- Steve
>
> > and just make LIBTRACEEVENT_DYNAMIC the only supported perf build
> > option? I guess this may break old distributions that may not have
> > libtraceevent, but even so I'm not sure that should motivate not
> > cleaning this up (if they are building perf they can build
> > libtraceevent).
>
