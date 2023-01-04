Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90565DCCC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbjADTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbjADTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:33:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A03C386
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:33:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 141so4619179pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhNuTXjWu/P/rdy7WLoVk70gjnClYIr8c3qZ/AxyUh8=;
        b=TT13YhOLFTeC/rkM3WpWltn6ub8CCNGWPD3HLItQpVtzPFS7zNlX5v7pZJOsmwJF35
         rirXKL1c/2WHcJmQr3hcMaAkgxs8jTVudUmVR/e4oJhDjuVRnH8zHS/oGxRfiyoOhzfU
         VIOU+J1YEAZcO1rlKuH3zkW8ySX2XLW9WOL0kzRbRRs5oifLAvIjVR+UFeQZauoQyB3F
         xg1u0b9TimgphNbSzwtkzWM7yooJ9xJZkyqlLxcmJxD23rJw+aNsrBwKBWb6UsI6mEsl
         pMVPMeMMtgwk/xT3NSAegHGRPYjKjPnpqL29a7HaNss9H9ltAR0qHlenHCuDBEAy5Uah
         c29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhNuTXjWu/P/rdy7WLoVk70gjnClYIr8c3qZ/AxyUh8=;
        b=Dk140eJsEaBcrVtFFV3emrmgyQfjGR2aRdWxCzXapkS0ae1UDk6hUJe+cgH7oImw6m
         LQS5LyN91JrtYyQybzXyYuZF+I4s8oDJGgGGM6g81Ed3A+3rKV6uCfcLRXEKwTnwqkHy
         xgAmT0WIVurJej0t/pCUloqHpyyRO6k9iopkfLHiMalTFAUtFSRUvwlyDzvpshny5ZU8
         4NS+PgdzHkwFzPDeaYEtEib9NPwPQAN0SsG/lkgnqYQzYWdkQAC4k9ZhWvPnNMrJOqCj
         v0VltLOehGOVjTpfvQwPL3Spl86c3KGC3cSuKl3EhsecxAbXn9oDwOscjUNlUCHgEstP
         INXg==
X-Gm-Message-State: AFqh2koynVTWeOzFTHi06kHvVkeQfYT9jOzx91ZekmAvQVrt1F24lzaa
        9oPidS7kNNiGhrhxQhIV1R8GYnycLWJi6EyW9yKS/Q==
X-Google-Smtp-Source: AMrXdXtB3UqDlg4fywThZ9oEcUJmkAbLk6z8tYBOfw7AenAVgHXmA24tL1e0zkLeqXOZuJxqdj9Lg8jgkS/Ktjb4wME=
X-Received: by 2002:a63:de12:0:b0:478:9367:1f27 with SMTP id
 f18-20020a63de12000000b0047893671f27mr3466595pgg.525.1672860820917; Wed, 04
 Jan 2023 11:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20230104182313.3164736-1-jesussanp@google.com> <Y7XP66TlOpkVlwyp@kernel.org>
In-Reply-To: <Y7XP66TlOpkVlwyp@kernel.org>
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
Date:   Wed, 4 Jan 2023 11:33:30 -0800
Message-ID: <CAK4Nh0izFWa107JVvDs9bHt+SpWMMkCSK+5p4grQ3SZFvDX86w@mail.gmail.com>
Subject: Re: [PATCH] perf: Add missing sys/types.h include
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 11:13 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jan 04, 2023 at 10:23:13AM -0800, Jesus Sanchez-Palencia escreveu:
> > Not all libc implementations define ssize_t as part of stdio.h like
> > glibc does since the standard only requires this type to be defined by
> > unistd.h and sys/types.h. For this reason the perf build is currently
> > broken for toolchains based on uClibc, for instance.
> >
> > Include sys/types.h explicitly to fix that. This is a follow up to
> > commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").
>
> Do you mean this problem started with the 378ef0f5d9d7 commit? If so
> then this is the fase for adding:
>
> Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
>
> To this patch, ok?

Fixed in v2.

Thanks,
Jesus


>
> - Arnaldo
>
> > Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
> > ---
> >  tools/perf/util/trace-event.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> > index add6c5d9531c..9b3cd79cca12 100644
> > --- a/tools/perf/util/trace-event.h
> > +++ b/tools/perf/util/trace-event.h
> > @@ -4,6 +4,7 @@
> >
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > +#include <sys/types.h>
> >  #include <linux/types.h>
> >
> >  struct evlist;
> > --
> > 2.39.0.314.g84b9a713c41-goog
>
> --
>
> - Arnaldo
