Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190B728634
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjFHRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjFHRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:20:44 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C834A269A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:20:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62b68ce199bso7410306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686244831; x=1688836831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiUMOSXxnadMdfH5BZI/Bps6B5NzwsmxH9J17vehVTE=;
        b=1+GMzsnKpHf0vQ3fPKZx4WPB+4os+5xcHmhLWVm3v8FuxxZu8czvUh4SY3vOHtL5a6
         0XZVmDN79H2aYBmz82g5qFPNYWEmcFjTtAeY9G5iRHnMk2mZQgfc5kh4mnd2QC+O5T5o
         B0IFu6b3CLpTL1u1FaCRxoP00WLXDOJPVf6HTOfdsfzWTRwjxU/ZXojqlOPjVk/UPdOR
         8bnnRgQLFj67Z2mKKJRT2No5NoL64BTz9CclusyWSfmx/HWMqax9OHwOfGWg8lSUqTLo
         u3pdiRvJB1p2AluXcOVfy36pncX+UOCMK1MO/JHyFQ2h27huT37Y/rq3ceLKa65G9yTt
         9wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244831; x=1688836831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiUMOSXxnadMdfH5BZI/Bps6B5NzwsmxH9J17vehVTE=;
        b=iuRG4IIkUgTafGaOOueYg8CPCnaFQIpmyxBE1KkwQ+PHb0ht2ZxtY/IJ6l1jx+1o0y
         lqs3IpA+4avZMIRpXrycw4Ga6GiLU+s00yZgNlbmp9C1bodo6zmwoB9Er3vEvzKB8+oo
         ocKxzuX5iYY+xc63/k73/ehAJiumGPfA7sd4XUnosXwHbozIf5yolw6NBlKOs4+s3gwd
         ieGTkHn28/I9SjeWSlkEtFKN1/Q2+r+UbX6/mYI8gXaeA4tVJWIUT4lLI3onqy3GNdrA
         6dziGEVNeCkcI35FTO2mQOMWy1fakSYxcz3EbcMH1QSb/yOjO6bYtPC3a3blwiWlfOAV
         tKyw==
X-Gm-Message-State: AC+VfDxqxCPsqWmFNHEidz21cBUi0D7dViOrzXzr+h6LhKJAo3t8TjTj
        0onOaJ5pW5nzj+ravjmrkFzD9e/ofl/KUgcvpBDWsg==
X-Google-Smtp-Source: ACHHUZ6+Lp1zf/e8qFWABC1i2ng1ZtM859BZQ6J4wwXv/nJtY5AAZd/D8FRLE4wwdXOJ2DbpJqa3rt9txtqR14Cw+lM=
X-Received: by 2002:ad4:5c6a:0:b0:626:2bd8:b67a with SMTP id
 i10-20020ad45c6a000000b006262bd8b67amr2965328qvh.21.1686244830829; Thu, 08
 Jun 2023 10:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <202306080917.C0B16C8@keescook>
In-Reply-To: <202306080917.C0B16C8@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Jun 2023 10:20:19 -0700
Message-ID: <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:47=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Thu, Jun 08, 2023 at 08:45:53AM -0700, Linus Torvalds wrote:
> > So for convenient automatic pointer freeing, you want an interface
> > much more akin to
> >
> >         struct whatever *ptr __automatic_kfree =3D kmalloc(...);
> >
> > which is much more legible, doesn't have any type mis-use issues, and
> > is also just trivially dealt with by a
> >
> >   static inline void automatic_kfree_wrapper(void *pp)
> >   { void *p =3D *(void **)pp; if (p) kfree(p); }
> >   #define __automatic_kfree \
> >         __attribute__((__cleanup__(automatic_kfree_wrapper)))
> >   #define no_free_ptr(p) \
> >         ({ __auto_type __ptr =3D (p); (p) =3D NULL; __ptr; })
> >
> > which I just tested generates the sane code even for the "set the ptr
> > to NULL and return success" case.
> >
> > The above allows you to trivially do things like
> >
> >         struct whatever *p __automatic_kfree =3D kmalloc(..);
> >
> >         if (!do_something(p))
> >                 return -ENOENT;
> >
> >         return no_free_ptr(p);
>
> I am a little worried about how (any version so far of) this API could go
> wrong, e.g. if someone uses this and does "return p" instead of "return
> no_free_ptr(p)", it'll return a freed pointer.

Presumably, one could simply just not use RAII(/SBRM someone else
corrected me about this recently coincidentally; I taught them my fun
C++ acronym IDGAF) when working with a value that conditionally
"escapes" the local scope.

--=20
Thanks,
~Nick Desaulniers
