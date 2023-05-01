Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D176F3A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEAWaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEAWax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:30:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656ED26BC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:30:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517bb01bac9so2014151a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682980251; x=1685572251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0vZEv/FmAjqR4OATKlbblWETdmbuJQmkbVqTAuStBc=;
        b=WKCw2ix+6dihGEpad4r0eJJquJbzoo5nOCEgYNWxUUgvKaWldmAbDrEooWLrv4sGrc
         bbwT4R5ad+zKhAmSVBsWmdHi7UocjItrB9hXDbZjunjUTj+USPCHEyOvk88S0hg/xy3l
         z6ktRPkV+XY1lcchAYB7O5M/0adGmD2EZi2887oEvtsiI5q1/IWXJNQe/6V4gJ3CMmuR
         77uDaZnsR+JTqwUlJNbuH1GqqspvBSVQnbZThyGMsA/OGdXOXB6VL3gk/U3023ElAC4B
         tYFjIC953WZT77XYoqzN+pGHgYTneqWQ33jA7XS8g5eaMGJx3orsHepBNokbNkU6YSwi
         WvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980251; x=1685572251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0vZEv/FmAjqR4OATKlbblWETdmbuJQmkbVqTAuStBc=;
        b=IoYy5TyRSXBaU0N674WvnWb3oIlEqFgbGQPKVya9lxRslVYBeUiqDoq1hWXTsbUAPN
         kwm7YfgAwrR7G5L8NUAWDG54T9k+HVMPYeu1otOI0aiHbz3rZkXDA/u8VHVqh+fHpggB
         W4Ofka9ucmV/LmNyJZyaC3zJDuCnrsmu4d8rfrLJcqVzOoKNeYNbYqMD5DWkMPaGKLRO
         0n4+yLXVeA5xT+kOUbZ6cDt9RAMVAm1mbPbFm6BRvqDshZ5kmD2rANBya2f0B4E57IQD
         OiBhEOFbwQaJ502dvZRfGamdg9HpDZ3BoodvLevIVj5mieesNV49JAf01bztFEStdzk0
         GwJQ==
X-Gm-Message-State: AC+VfDwkNjvWNY3OBT+Ix36rq4rsjANJHNQX9cvODyK5vVB8xJFrceCZ
        KVdk7EDS4Qz6uAxKmrG1CS2C3373fi9TJPYaBzZw7A==
X-Google-Smtp-Source: ACHHUZ7jIPANuM1sqTIbuiAlms9FW/dcjpUfPf8qR/hIGsTZHUlWNVU5LIbFTwoJV+QoEkulsThBRTy4qagbvX+vERw=
X-Received: by 2002:a17:902:e744:b0:1a6:b23c:3bf2 with SMTP id
 p4-20020a170902e74400b001a6b23c3bf2mr18550422plf.10.1682980250619; Mon, 01
 May 2023 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
In-Reply-To: <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 May 2023 15:30:38 -0700
Message-ID: <CAKwvOdkgwHcZKndei2NcMn+Z8y1HjKCUpMxnNCbcCGm9EB-o0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Peter Collingbourne <pcc@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
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

On Mon, May 1, 2023 at 3:02=E2=80=AFPM Peter Collingbourne <pcc@google.com>=
 wrote:
>
> On Thu, Feb 23, 2023 at 10:45=E2=80=AFPM Peter Collingbourne <pcc@google.=
com> wrote:
> >
> > On Wed, Feb 15, 2023 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> w=
rote:
> > >
> > > On Wed, 15 Feb 2023 09:57:40 +0100
> > > Marco Elver <elver@google.com> wrote:
> > >
> > > > Yes, you are right, and it's something I've wondered how to do bett=
er
> > > > as well. Let's try to consult tracing maintainers on what the right
> > > > approach is.
> > >
> > > I have to go and revisit the config options for CONFIG_FTRACE and
> > > CONFIG_TRACING, as they were added when this all started (back in
> > > 2008), and the naming was rather all misnomers back then.
> > >
> > > "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> > > really should just be for the function tracing infrastructure, and
> > > perhaps not even include trace events :-/ But at the time it was
> > > created, it was for all the "tracers" (this was added before trace
> > > events).
> >
> > It would be great to see this cleaned up. I found this aspect of how
> > tracing works rather confusing.
> >
> > So do you think it makes sense for the KASAN tests to "select TRACING"
> > for now if the code depends on the trace event infrastructure?
>
> Any thoughts? It looks like someone else got tripped up by this:
> https://reviews.llvm.org/D144057

https://reviews.llvm.org/D144057#4311029
Peter, please triple check.
--=20
Thanks,
~Nick Desaulniers
