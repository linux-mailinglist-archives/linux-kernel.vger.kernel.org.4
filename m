Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355A744358
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjF3Ulc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjF3UlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:41:24 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23A3AA4;
        Fri, 30 Jun 2023 13:41:23 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bacf685150cso2240639276.3;
        Fri, 30 Jun 2023 13:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688157682; x=1690749682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYo6xwqgj8zLkrevSTQkiJtfEFqIVZl3iHwHCD3Vcos=;
        b=GWAS/yOEknb7yhlnmVOXOxnkp8z3Mf/D6+wI7FgojSE/LtoMKvfdHlqsOCRZFjlRAr
         nkpo9Nv6NZfYnPrXyKQXq9pntI0kfssb2KR86rkGYr5TWlTEYjvE5hQ3YyxxJpLr8Rwm
         ZTWyivtXNqmL1Y7KiP6iz/tkK5atFPNsK1kExIM6nvQMxmf7HdGgwx455obPFVFzh4QH
         KECjqRtb3srh0Q6yU9iWQeE+LZoYepYj7iXb71+uJQBOa6UhSw+gyJ6TGvpUA7mj/bwC
         qWGGOljZAfvx0SbGNe53QmMWHsx++OmxC3XyD4ry5DvC9zX+25xvDKDZCx11hAQzNSZJ
         SfTg==
X-Gm-Message-State: ABy/qLbHbskNTWrw25BMhX2atG502RMi1pURlwMAYTTGX2XaFljj15pB
        iRrhksnFNwo/GTguuH6qCpeQEYEViU6rNQP62WM=
X-Google-Smtp-Source: APBJJlEqVAfrRJFE3aEHuiEdW7YLrymc6shDJInOjyjRUpwfSj+e96oScfQ0D3gvA5SF46wzO3Yk+hvA4mOmZnLUzbU=
X-Received: by 2002:a25:d87:0:b0:c41:d9da:213c with SMTP id
 129-20020a250d87000000b00c41d9da213cmr2563067ybn.40.1688157682386; Fri, 30
 Jun 2023 13:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230628215954.1230048-1-namhyung@kernel.org> <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
In-Reply-To: <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Jun 2023 13:41:11 -0700
Message-ID: <CAM9d7cgN8fOGwyUReec9mdfrts_y3qkNFo1931iW43D+3R2aRw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Linus,

On Fri, Jun 30, 2023 at 11:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 28 Jun 2023 at 15:00, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Please consider pulling perf tool changes.  I'm doing this on behalf of
> > Arnaldo as he's on vacation.  This is my first pull request and hope I
> > didn't break anything. :)
>
> Things look normal, although I find your pgp key situation confusing.
>
> I looked up your gpg key from the kernel.org pgp key repo, but that's
> apparently not the one you used for signing this.
>
> So I have two keys for you, and neither of them are then signed by
> others (although that part is probably just the usual pgp mess with
> signatures being dropped due to flooded bogus signatures, which has
> made the whole pgp infrastructure be essentially close to useless).
>
> Anyway, I wish the pgp key situation would be better, but it's not an
> actual problem.

Sorry about that.  Unfortunately I lost my old key due to a problem
in my backups.  So I had to create a new one and asked signing
by others including Arnaldo and Jiri.  Probably it's a problem in
the pgp system as you mentioned, I don't know enough about
that though.


>
> HOWEVER.
>
> What _is_ a problem is that the end result doesn't build cleanly.
>
> The
>
>         if (list_empty(&pmus))
>                 perf_pmu__scan(NULL);
>
>         ibs_pmu = perf_pmu__find("ibs_op");
>
> in the amd-ibs-via-core no longer works, and it seems that it should just be
>
>         ibs_pmu = perf_pmus__find("ibs_op");
>
> That's fine - I can do (and did) that merge resolution - and it's part
> of my normal "merge and test build", but I'm slightly unhappy that I
> wasn't told about this part.
>
> The actual data conflicts were trivial. But this was a semantic
> conflict that was invisible to git, but showed up in build testing.
>
> And I *think* you should have known about it, because the conflict you
> do talk about shows that
>
>  +perf-y += amd-ibs-via-core-pmu.o
>
> as part of the actual data conflicts.
>
> Anyway, I've resolved this, and it wasn't a *problem*, and I'm just a
> bit unhappy that it took me by surprise.

Sorry about the inconvenience.  I'll check this kind of
problem more seriously next time and let you know.

Thanks,
Namhyung
