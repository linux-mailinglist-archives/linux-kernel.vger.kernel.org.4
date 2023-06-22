Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D473AC7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFVW2q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:28:44 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9B195;
        Thu, 22 Jun 2023 15:28:43 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bc476bf5239so7519434276.2;
        Thu, 22 Jun 2023 15:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472922; x=1690064922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cguTASJCALnnEHz7EV9F2VapKWryIEdNJ4Yyp61gRQ=;
        b=aa/aybTHtSDC94rPyiFQVVG4g63TieaKlAEqRK7mbTO7q7FjhxqERsB7Z7OSVaJiBE
         0RKWISZcUy4HogggUjxV1rMq1b3BRVyZVOhkXZBFRmb2NfOsB49Odlegd+iuhRl3x1Rb
         XEpsIFxvegZs7CsR+noOqnBJLwpL1dhwIVKyDSkWracjyxFg5zGaH0y/ioJJaazcKNSF
         Uk5YCTIjZ3v1gz0muTmk/jM/sIoyX2/8d8hfQ4KNKO8y7CV+u4zLqxHx019/AHEJPYNR
         dayjOWNSqHSCzPFhAykKBfLgic2/6Ajs5NY0oSqfRXhCTq/LnDTsRLlTHkhaKaLpvnTv
         cuCQ==
X-Gm-Message-State: AC+VfDwEhM+EHuRQellWmuxIkFiVD2EuTsCAtg8ufaBFyXI9S9rI5kes
        YW7R1Y/wBNDLmzx5Nq8tbVkmjbAZpRaEJkPYvJMQolyA
X-Google-Smtp-Source: ACHHUZ5GWW5lAJ4cmwZVv8aQHTph7SzHLlfBoxcM/6d6k0Odbz2CcQ6GCCdD6mBc4KxGmnuK5Hq5JKiR+SHZ19yHQI4=
X-Received: by 2002:a5b:906:0:b0:ba7:54ab:d676 with SMTP id
 a6-20020a5b0906000000b00ba754abd676mr15682550ybq.63.1687472922187; Thu, 22
 Jun 2023 15:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230525220927.3544192-1-namhyung@kernel.org> <CAP-5=fWOji8vCQfO-y4HnmFk2k+F70BtGHTjCg6XyORNfYNcww@mail.gmail.com>
In-Reply-To: <CAP-5=fWOji8vCQfO-y4HnmFk2k+F70BtGHTjCg6XyORNfYNcww@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 15:28:31 -0700
Message-ID: <CAM9d7cgnOzVV7ww-+4N_mccgn9r_xYX1LeExgxDOo0x5NG=Zqw@mail.gmail.com>
Subject: Re: [PATCH] tools lib subcmd: Show parent options in help
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:05 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, May 25, 2023 at 3:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I've just realized that help message in a subcommand didn't show one
> > in the parent command.  Since the option parser understands the parent,
> > display code should do the same.  For example, `perf ftrace latency -h`
> > should show options in the `perf ftrace` command too.
> >
> > Before:
> >
> >   $ perf ftrace latency -h
> >
> >    Usage: perf ftrace [<options>] [<command>]
> >       or: perf ftrace [<options>] -- [<command>] [<options>]
> >       or: perf ftrace {trace|latency} [<options>] [<command>]
> >       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]
> >
> >       -b, --use-bpf         Use BPF to measure function latency
> >       -n, --use-nsec        Use nano-second histogram
> >       -T, --trace-funcs <func>
> >                             Show latency of given function
> >
> > After:
> >
> >   $ perf ftrace latency -h
> >
> >    Usage: perf ftrace [<options>] [<command>]
> >       or: perf ftrace [<options>] -- [<command>] [<options>]
> >       or: perf ftrace {trace|latency} [<options>] [<command>]
> >       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]
> >
> >       -a, --all-cpus        System-wide collection from all CPUs
> >       -b, --use-bpf         Use BPF to measure function latency
> >       -C, --cpu <cpu>       List of cpus to monitor
> >       -n, --use-nsec        Use nano-second histogram
> >       -p, --pid <pid>       Trace on existing process id
> >       -T, --trace-funcs <func>
> >                             Show latency of given function
> >       -v, --verbose         Be more verbose
> >           --tid <tid>       Trace on existing thread id (exclusive to --pid)
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/subcmd/parse-options.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> > index 9fa75943f2ed..41de97671c72 100644
> > --- a/tools/lib/subcmd/parse-options.c
> > +++ b/tools/lib/subcmd/parse-options.c
> > @@ -806,18 +806,28 @@ static int option__cmp(const void *va, const void *vb)
> >
> >  static struct option *options__order(const struct option *opts)
> >  {
> > -       int nr_opts = 0, nr_group = 0, len;
> > -       const struct option *o = opts;
> > -       struct option *opt, *ordered, *group;
> > +       int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
> > +       const struct option *o, *p = opts;
> > +       struct option *opt, *ordered = NULL, *group;
> >
> > -       for (o = opts; o->type != OPTION_END; o++)
> > +retry:
>
> Why use "goto retry" and not compute the size with the parent upfront?

No specific reason, just followed the same pattern as in
parse_{short,long}_opt(). :)

>
> > +       for (o = p; o->type != OPTION_END; o++)
> >                 ++nr_opts;
> >
> > -       len = sizeof(*o) * (nr_opts + 1);
> > -       ordered = malloc(len);
> > -       if (!ordered)
> > +       len = sizeof(*o) * (nr_opts + !o->parent);
>
> It'd be nice to comment on why the "!o->parent" here.

What about this?

/* It needs a terminating NULL entry when there's no parent */

Thanks,
Namhyung


>
> Thanks,
> Ian
>
> > +       group = realloc(ordered, len);
> > +       if (!group)
> >                 goto out;
> > -       memcpy(ordered, opts, len);
> > +       ordered = group;
> > +       memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr_parent));
> > +
> > +       if (o->parent) {
> > +               p = o->parent;
> > +               nr_parent = nr_opts;
> > +               goto retry;
> > +       }
> > +       /* copy the last OPTION_END */
> > +       memcpy(&ordered[nr_opts], o, sizeof(*o));
> >
> >         /* sort each option group individually */
> >         for (opt = group = ordered; opt->type != OPTION_END; opt++) {
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
