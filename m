Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6E6F5B20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjECP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjECP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:28:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0259F0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:28:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so300015ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683127715; x=1685719715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qowq5eaooF5EfPDAG5Prg8rQoyyfy/TivcsC5fJA/c=;
        b=GYG7QQSW5O90ohyO56EoNemZ7golNZP54UQ7SwhViEZwYjPVlpDLUDtVHomYEcYPGF
         CeImdwOT7GlNrGqL9YWnk7GMt/uiDzc3vqMWuAByGYVYq72yG19hcVom4JAmVlIG0Cz9
         Ar171qPLcGSUpXcBJy5cav2bTRHixBsdpvWg/yYRPLOotuBhoZGb8NL8Lgro/ZKQlOzr
         N2O9NXpQs9YOXvQaHcamZXREvV5NVzktBCNTHmn09pJEJAGnylsk7e9LHk0SUn4OGa6H
         3MGJzWH4D9ugjyyr3h5Fx5Uq0vfa3dX55RI11YQiitESGO5xp28yXLc76rWEBHhxNev4
         5Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127715; x=1685719715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qowq5eaooF5EfPDAG5Prg8rQoyyfy/TivcsC5fJA/c=;
        b=cWY8v7p8pKGrIzLdQIWBFXC8r7qgGrQ+6w1/ppJHwlpAkm1jp+XniuCtCyCKItWzuZ
         Pj/FHpeYoKIvluH4xYflWN07HXnA+p+2SRXPTseNS0rv4ymxTefBG0YEAbMgokvgJRLo
         cCeVFdwU6HgOY1pRGauNcULYwlom7ashGGFIpGuEdWAkcYH8L7+ihB7gtkSL4q9C8w/B
         1psciIuXAiC7ett2r1iu1xt9zwP9J7QHVhxlVGlrRO8HIR89D2gywTe9l6fvahkn7omZ
         v/U28Zlzv2rXY7Ycr0vLCZ2H2S6UVtWeYYkY58uHezd2mTG4oW9FGtkETQCOneIyi3Zs
         ulhg==
X-Gm-Message-State: AC+VfDxcswkexmqAWP2SElUFIdv7zSOjyVb7dbYKemuUR0wJi7a8/dK+
        84TRD16hTZ6mi5ExZvSKcxNgkUOCRci2MomXA16DZQ==
X-Google-Smtp-Source: ACHHUZ6/tku7n9gduYI3Ggu24QNVh8G7eHSwi8IiNVBHgEwrkq2UCalGSwj6EMkEVCO6RNIRFOwS7PSpCZVlhcePiFE=
X-Received: by 2002:a05:6e02:1cad:b0:325:d0d8:2ddb with SMTP id
 x13-20020a056e021cad00b00325d0d82ddbmr251489ill.15.1683127715219; Wed, 03 May
 2023 08:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com> <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
 <ZEx0IQAtBatrRDCR@kernel.org> <ZEx0xAamEl66qk2w@kernel.org>
 <874jot69ks.fsf@oldenburg.str.redhat.com> <87zg6l4utl.fsf@oldenburg.str.redhat.com>
 <ZFJ39HKzBUg64QPO@kernel.org>
In-Reply-To: <ZFJ39HKzBUg64QPO@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 May 2023 08:28:22 -0700
Message-ID: <CAP-5=fUukHuVsPS_Am6VTGvpuiEVo=2X=BuN2feh+ibhnSFAUg@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
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

On Wed, May 3, 2023 at 8:04=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, May 03, 2023 at 11:40:06AM +0200, Florian Weimer escreveu:
> > * Florian Weimer:
> > > * Arnaldo Carvalho de Melo:
>
> > >>> Thanks, applied. BTW b4 coulnd't find this message (nor the origina=
l):
>
> > > Yes, vger drops the message after accepting it for some reason, proba=
bly
> > > something in the patch contents.  I tried to resubmit from a complete=
ly
> > > separate account, no luck.
> > >
> > >> Not so fast, removed it for now:
> > >>
> > >>   CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
> > >> In file included from util/pmu.y:14:
> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown typ=
e name =E2=80=98YYSTYPE=E2=80=99
> > >>   496 |
> > >>       | ^
> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown ty=
pe name =E2=80=98YYSTYPE=E2=80=99
> > >>   498 |
> > >>       |                   ^
> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown ty=
pe name =E2=80=98YYSTYPE=E2=80=99
> > >>   546 | extern int yylex \
> > >>       |                 ^~
> > >> util/pmu-bison.c: In function =E2=80=98perf_pmu_parse=E2=80=99:
> > >> /tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit d=
eclaration of function =E2=80=98perf_pmu_lex=E2=80=99; did you mean =E2=80=
=98perf_pmu_free=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > >>    69 | #define yylex           perf_pmu_lex
> > >>       |                         ^~~~~~~~~~~~
> > >> util/pmu-bison.c:1007:16: note: in expansion of macro =E2=80=98yylex=
=E2=80=99
> > >
> > > This appears to be related to some BPF filter stuff that is only in
> > > perf-next, not mainline.
> > >
> > > Is this the right tree on which to base the patch?
> > >
> > >   <https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/>
> > >
> > > Branch perf-tools-next?
> >
> > Sorry, it doesn't build even without my patch:
> >
> > make[4]: *** No rule to make target 'zip.h', needed by '/tmp/build/libb=
pf/staticobjs/libbpf.o'.  Stop.
>
> I'm noticing this, but then I haven't merged with upstream yet, I bet
> this is something upstream after merging the bpf branch... Nope, I just
> did a test merge of what is in
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools
> with upstream and it builds without problems on:
>
> [acme@quaco perf-tools]$ head -2 /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"37 (Workstation Edition)"
> [acme@quaco perf-tools]$
>
> I'll check on f38 and rawhide.
>
> - Arnaldo

The zip.c and zip.h in libbpf are new, perhaps it is a fixdeps issue?
Perhaps doing a clean build and retrying will address the problem.

Thanks,
Ian
