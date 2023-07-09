Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289374C098
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGIDXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Jul 2023 23:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGIDXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:23:40 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C681B9;
        Sat,  8 Jul 2023 20:23:38 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-765ae938b1bso314925685a.0;
        Sat, 08 Jul 2023 20:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688873017; x=1691465017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Os/T81jfV0h75zdTCYZv06KbERDIlm36ZHuHvLASs=;
        b=QOT1tpjq+QXaUtLoskPNFiaBsus5uAQQLsSNKhs4gLNLGNik8lRqDYt3yOkhU9U4yy
         0uIo/NXQQg8hO1HrQG96YHOuqmXmNzIgFdyG3MC5s1qVPiuTf30JR86TERiEJm6FDYQp
         bUyVaugFUNfJuwdmaYXgiqRZDi2+lbRzcXRuiuGaZQpP5Gpm0vzePbMZHcPRcv8+WHTo
         QBsixX2zsiidc/VD8SpKyAQaXQA0cGkuEgDXZTuUKpD0dZhaJsZwVRZGm2Vam+UIcceV
         N8huyQno7jvkBJYF9CJJoLCOowYd+IbXl3Gk08IPu9bmPcnVHi9TaFf2L9cHfcw1Bz+O
         POpA==
X-Gm-Message-State: ABy/qLZ8YMO7yq963uHVoA/yJRo6gKaQskl5pJ1cTL+llo2NC26IBUkr
        NqHRRskyu4xcu/YCZwhEDh0S3X207TLuotXTVw4=
X-Google-Smtp-Source: APBJJlFQPtFEVtWcYE7How2gb/CHze6oWc15Qum2gklJGQTijwLRDkYhYvN4zBclMao8WbTKeTv0Ji3K0JuVa3VbfC8=
X-Received: by 2002:a05:620a:28c5:b0:75d:4101:2c9a with SMTP id
 l5-20020a05620a28c500b0075d41012c9amr11401351qkp.34.1688873017559; Sat, 08
 Jul 2023 20:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230707042644.94061-1-namhyung@kernel.org> <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgRP0qeuTSWtHgDdvgUTfBD1mGwrenbOyJC7_ygsbWCEQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 8 Jul 2023 20:23:25 -0700
Message-ID: <CAM9d7cjvowtUcfew12k7oLs6g19FHZipcQ9UsX9pOKXENeGEYw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5: 2nd batch
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Jul 8, 2023 at 12:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 6 Jul 2023 at 21:26, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello Linus,
> >
> > Please consider pulling more perf tool changes.  These are remaining
> > changes and fixes for this cycle.  The last two fixes are relatively
> > new but other changes have been sitting on -next for a number of days.
>
> Hmm.
>
> I htink there's some dependency problem in the perf tools build that
> just caused a random build error for me:
>
>    util/expr-flex.c:214: error: unterminated #ifdef
>
> that error went away on a re-build, and it's clearly nonsensical when
> I look at that file, so it looks to me like somehow the parallel buld
> used that file while it 3as being generated.
>
> I don't see anything obviously wrong, and I've only seen this error
> once. I've done the pull - I doubt it was introduced by the recent
> changes - but I wanted to just mention that there seems to be some
> problem in this area..
>
> Am I the only one to have ever seen something like this?

I saw a similar problem before and it was ok after a re-build.
I also believe it's not related to this pull request.  But I will
take a deeper look at the problem.

Thanks,
Namhyung
