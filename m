Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69459705DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjEQDKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjEQDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:10:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6695;
        Tue, 16 May 2023 20:10:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso5463763a12.1;
        Tue, 16 May 2023 20:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684293033; x=1686885033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pTSSDCaJ7lg+mm+c1srKGW468miK1XyKNdzeJHhyA4=;
        b=I+9fckyUF5DFOB6kouKDdUAmllDqQc/QcYTLG04b1K0QXMyqFH5nnQjIM6IaV5FrfE
         9o1FW9Kv5QKwd/b/XosujS90FzOmEGOxbLfFzpgDNB7shG1AI9AkMYhlRzjXqarJ557x
         zXm/VNz50OcuKrIWifJNvjToTwj6BUCVsMXU174tk3lL5idWChdZQuqOZgZf/Y0gg6ZG
         JTmWJ1ruoTgN/IGHBby+zPT5PJiduLY+v84V7kWaWiBXjcFM/VB52HWOqHLi0J0yxxXK
         MaqzP6Ja9YE2dfeF6AKzQTN/Bgfa3WOPzdrHWHqY0FKWJyCvbMDUA0cDg+9Sjo/KeM/q
         wLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684293033; x=1686885033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pTSSDCaJ7lg+mm+c1srKGW468miK1XyKNdzeJHhyA4=;
        b=J34l9UaRTUAw2UjiN8Ah8NttWLUry5ptAmAv2Gg16AO3PRvcYisRwqGjr1iVYYvrnR
         EsXG9ZutzCuiMiKajEbxma1tj2FZp6g//p/8dN3N3BljjrFLeHWYwv1KV2VJ/qw79xwd
         hD0o6qMamnjUAyhSKVD2Y2uWd29fyyZq56rr0ngEWJub4/cz2c7msfPyCHT4QygJsURz
         EzDmbfB0s6Eq6/DQR+w+Ht4Jve5IRginXvsws3z++hK57Qo96NYp/pGBbQ/B8L/jmQgQ
         O+K211hAgXNcGhAC7skq9kfBzKqzyx0Pf75YZHfjn7DMclFOAjPRnRedRaFiM3rjlqH8
         U5Cg==
X-Gm-Message-State: AC+VfDwmztlWX9/sDIGR4ym9yhkekvsFfag0kA21U6ijsw6hBCf6QzRG
        ATNJk1PxebEqsjGL8o8GZgEq+wQztqaDKsEevBY=
X-Google-Smtp-Source: ACHHUZ5Y5JiuuaffuRZQsJfvcnMH3GABSYBQ500yWJBzQa8Yn/drbPzcBo6ii1dLFh7aQZEdgHIVR3eI2pIheciedjI=
X-Received: by 2002:a05:6402:2807:b0:506:b94f:3d8f with SMTP id
 h7-20020a056402280700b00506b94f3d8fmr721226ede.5.1684293033169; Tue, 16 May
 2023 20:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
 <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
 <20230517010311.f46db3f78b11cf9d92193527@kernel.org> <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
 <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
In-Reply-To: <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 17 May 2023 11:10:21 +0800
Message-ID: <CAD8CoPC0BXB2ER_Oaixm5XgMk8TTqKVVF7Po0t4gBPOLhw_xwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it! :)

I will improve the commit message and send v3 ASAP.

BTW, which tree should I rebase those patches onto? Is that the
for-next branch of
git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git. I saw
Jiri had troubles
applying those since these works are based on v6.4.0.

THX,
Ze

On Wed, May 17, 2023 at 10:54=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Wed, 17 May 2023 09:54:53 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Oops, I misunderstood your comments before.
> >
> > Yes, it's not necessary to do this reordering as regards to kprobe.
>
> Let me confirm, I meant that your current patch is correct. I just mentio=
ned
> that kprobe_busy_{begin,end} will continue use standard version because
> kprobe itself handles that. Please update only the patch description and
> add my ack.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> If you add Steve's call graph for the explanation, it will help us to
> understand what will be fixed.
>
> Thank you,
>
> >
> > Thanks for your review.
> >
> > I'll rebase onto the latest tree and send v3 ASAP.
> >
> > Regards,
> > Ze
> >
> > On Wed, May 17, 2023 at 12:03=E2=80=AFAM Masami Hiramatsu <mhiramat@ker=
nel.org> wrote:
> > >
> > > On Tue, 16 May 2023 17:47:52 +0800
> > > Ze Gao <zegao2021@gmail.com> wrote:
> > >
> > > > Precisely, these that are called within kprobe_busy_{begin, end},
> > > > which the previous patch does not resolve.
> > >
> > > Note that kprobe_busy_{begin,end} don't need to use notrace version
> > > because kprobe itself prohibits probing on preempt_count_{add,sub}.
> > >
> > > Thank you,
> > >
> > > > I will refine the commit message to make it clear.
> > > >
> > > > FYI, details can checked out here:
> > > >     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516=
.c902edcf21028874a74fb868@kernel.org/
> > > >
> > > > Regards,
> > > > Ze
> > > >
> > > > On Tue, May 16, 2023 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > > > > Current implementation calls kprobe related functions before do=
ing
> > > > > > ftrace recursion check in fprobe_kprobe_handler, which opens do=
or
> > > > > > to kernel crash due to stack recursion if preempt_count_{add, s=
ub}
> > > > > > is traceable.
> > > > >
> > > > > Which preempt_count*() are you referring to? The ones you just ma=
de
> > > > > _notrace in the previous patch?
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
