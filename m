Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3597D740404
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0TdR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjF0TdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:33:15 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9B1BC3;
        Tue, 27 Jun 2023 12:33:14 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c13b0941a38so338689276.0;
        Tue, 27 Jun 2023 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894393; x=1690486393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6I1qDNxrhaapOFb46VGvBuvtnmrp2kBctslbEeEODg=;
        b=aPZE4jt/XY6t6chgiKySDHn36EuvSmuYXXwHF9YKEIcBp7NS7JHmBI1WQfuwi3oKrL
         Dm3OrEPDigj2xXB37dcmlq4OTa+Uz0uSJkUAh59Kq7I7FNXGxxYnDV2jFcn9GUpRYIam
         WBo+13eYgvPtBMr9tmQStOtmsb1Iz76rvLAdVq7VoWzrEMODfEV7IU/aF46gAD7rJJH+
         JLpwTQRqj8BctBfzEvYQsImtp1KpkkQNxvQ/AaaJPqXXuIemkkkGLV2RJy1suiqSY057
         Yjrndn+CeocVHBb9xA8z3jAJSDHCG6H6tSjQKB6lPKBMhlJIRWiwTqhsdlbkwzbhMHoH
         rhuA==
X-Gm-Message-State: AC+VfDw9R/gMwcKbGcjxW57vRzOkUKC2JY8hBMMHLMcRX2NeoyH/W8UL
        f/4xd2goCbUuupd5d0ftFkVoBJX6N90/x90opQM=
X-Google-Smtp-Source: ACHHUZ5ARinfQ03+Wn7zCCdzOEc4NDbJs+cCh1o88sZhvU8Ng6O9KNQ+LB0QE+64kS3i1/NyFuQJY8+6toXVgGkQgKs=
X-Received: by 2002:a25:dc91:0:b0:bce:bed4:29f6 with SMTP id
 y139-20020a25dc91000000b00bcebed429f6mr138892ybe.17.1687894393221; Tue, 27
 Jun 2023 12:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201606.2514679-1-jolsa@kernel.org> <CAM9d7chMGzEJ3GKyxXD-RwUpjje7u3Cp810TRD+ZGgCT+mFrEQ@mail.gmail.com>
 <ZJqfUL1gnkTbUx5n@krava>
In-Reply-To: <ZJqfUL1gnkTbUx5n@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Jun 2023 12:33:02 -0700
Message-ID: <CAM9d7chRtGNG6KLkWQRBz0aNVwDJWm-StPbMuXN4bumpUsNG-g@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add missing else to cmd_daemon subcommand condition
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

On Tue, Jun 27, 2023 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jun 26, 2023 at 01:58:48PM -0700, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Mon, Jun 26, 2023 at 1:16 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Namhyung reported segfault in perf daemon start command.
> > >
> > > It's caused by extra check on argv[0] which is set to NULL by previous
> > > __cmd_start call. Adding missing else to skip the extra check.
> > >
> > > Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")
> > > Reported-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Thanks for the fix.  Now it runs ok.
> >
> > Before:
> >   $ sudo ./perf test -v daemon
> >    85: daemon operations                                               :
> >   --- start ---
> >   test child forked, pid 82420
> >   test daemon list
> >   ./tests/shell/daemon.sh: line 133: 82426 Segmentation fault
> > perf daemon start --config ${config}
> >   test daemon reconfig
> >   ./tests/shell/daemon.sh: line 133: 82520 Segmentation fault
> > perf daemon start --config ${config}
> >   test daemon stop
> >   ./tests/shell/daemon.sh: line 133: 82636 Segmentation fault
> > perf daemon start --config ${config}
> >   test daemon signal
> >   ./tests/shell/daemon.sh: line 133: 82674 Segmentation fault
> > perf daemon start --config ${config}
> >   signal 12 sent to session 'test [82676]'
> >   signal 12 sent to session 'test [82676]'
> >   test daemon ping
> >   ./tests/shell/daemon.sh: line 133: 82702 Segmentation fault
> > perf daemon start --config ${config}
> >   test daemon lock
> >   ./tests/shell/daemon.sh: line 133: 82734 Segmentation fault
> > perf daemon start --config ${config}
> >   test child finished with 0
> >   ---- end ----
> >   daemon operations: Ok
> >
> > Maybe we need to investigate more why it was ok..
> > But at least I don't see segfaults anymore
>
> yea, for some reason parse_options would put NULL into argv[0]
>
> I'll try to check what changed, in any case the fix makes the
> condition alligned with the other legs and fixes the segfault

Yep, thanks for checking.

In the meantime, Thomas Richter reported the same problem and
fix.  I'll take yours but leave it for the record.

  http://lore.kernel.org/r/20230627092633.2135105-1-tmricht@linux.ibm.com

Applied to perf-tools-next, thanks!
