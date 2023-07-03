Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE27455A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCGxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGCGw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:52:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C38CC;
        Sun,  2 Jul 2023 23:52:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e00695e21so1243207a12.1;
        Sun, 02 Jul 2023 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688367176; x=1690959176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVnaXplbKPJXEZ2wiNEToKb7XEKkfgoYbR2y25X8PVI=;
        b=VzflzDnTLPNOQmXJxd99X35fT7q/HR/QamcP6SrxBexExHNgsbOZsyhUeanxMgkLLn
         L/VtZLktB53Ed8yppJ0fFYWScy0Aj/qCc2yCXUG2iBeuMm/QnoCNosqVx5hcRLaINXQ+
         HqW7Fzg6DQrl4EiDtWTntrDjQZQcsuJr+h4kkvHeTeRE8woq+Fz3dwlky3Yeetn+edKK
         ep+HzMFbyP5/k+xDm1DFAYmUNJ/FJswnOHPquMfKSha2av2jSgD6F/uo+GUw9Al2fiab
         BqJ2wR2Gegkgq5Mxrth7KKykU7Rkw0byB8PgzGCA0u4H4skY9up14uq+QiJdKaZgqyq1
         J+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688367176; x=1690959176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVnaXplbKPJXEZ2wiNEToKb7XEKkfgoYbR2y25X8PVI=;
        b=Q5OkeiMsDHq1be5KsaulRzsOnGw67YEr0a2HeN8nkYC1cRD4VSKmfH+Juhnwt0m7Xz
         Yry5YafvlRuF+Zh+TVpYFNeoJjJTg3fhpcrItTBvJ2r8JeK5p5y/59cjQyr4FyC5c3h0
         E0JdZ31sHYxGcJn0Ru9LhwFiW8PECcsXZJ3g2PiouSRAZCU1yM4pLldmVNXFvXgUHFuX
         cCkNvtfYHAvs6OrDRAC32QGy1HYebSBlutlnnBo8gvbSFUMY61Mko8ULwvpkPwp7UDAe
         pXp1uNk2MyetdaCZ7mUqOeuOPowKP5XjC51TFzaRDjBqcSAA3eID+ojDPhLNlZLldRbT
         NVBg==
X-Gm-Message-State: ABy/qLag2XWRaFhmycJWsKWRiIBxWK02WJ1OkMSbEcQBCEdY8P5cZgdQ
        dmRntyAeVby7obDMqbKH+/rsc7xt13gUF0vrPkw=
X-Google-Smtp-Source: APBJJlH9Rx8BE+Ibb788/1pjQjhi6zODsNw7L2myu5MLbnUXY/Hw8WaffqWQhv9tRYXmFSR4j3+5TFUixrmCMQNLOII=
X-Received: by 2002:a05:6402:1a41:b0:51b:df14:594e with SMTP id
 bf1-20020a0564021a4100b0051bdf14594emr5868433edb.39.1688367176421; Sun, 02
 Jul 2023 23:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230517034510.15639-1-zegao@tencent.com> <20230517034510.15639-3-zegao@tencent.com>
 <CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com>
In-Reply-To: <CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 3 Jul 2023 14:52:45 +0800
Message-ID: <CAD8CoPCSAK_BM3WhJoeu7FCWqpnWpPpYwAEdSaewrZByRN2TOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion free
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
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

Hi, yafang.

You're right, it should do the unlock before return for the sake of
sanity. (Please
ignore the last misleading reply :)

Will send a new patch to fix it.

Thanks
Ze

On Wed, Jun 28, 2023 at 3:17=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, May 17, 2023 at 11:45=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wro=
te:
> >
> > Current implementation calls kprobe related functions before doing
> > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > is traceable in kprobe_busy_{begin, end}.
> >
> > Things goes like this without this patch quoted from Steven:
> > "
> > fprobe_kprobe_handler() {
> >    kprobe_busy_begin() {
> >       preempt_disable() {
> >          preempt_count_add() {  <-- trace
> >             fprobe_kprobe_handler() {
> >                 [ wash, rinse, repeat, CRASH!!! ]
> > "
> >
> > By refactoring the common part out of fprobe_kprobe_handler and
> > fprobe_handler and call ftrace recursion detection at the very beginnin=
g,
> > the whole fprobe_kprobe_handler is free from recursion.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-=
zegao@tencent.com
> > ---
> >  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 44 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9abb3905bc8e..097c740799ba 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
> >         char data[];
> >  };
> >
> > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -                          struct ftrace_ops *ops, struct ftrace_regs *=
fregs)
> > +static inline void __fprobe_handler(unsigned long ip, unsigned long
> > +               parent_ip, struct ftrace_ops *ops, struct ftrace_regs *=
fregs)
> >  {
> >         struct fprobe_rethook_node *fpr;
> >         struct rethook_node *rh =3D NULL;
> >         struct fprobe *fp;
> >         void *entry_data =3D NULL;
> > -       int bit, ret;
> > +       int ret;
> >
> >         fp =3D container_of(ops, struct fprobe, ops);
> > -       if (fprobe_disabled(fp))
> > -               return;
> > -
> > -       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > -       if (bit < 0) {
> > -               fp->nmissed++;
> > -               return;
> > -       }
> >
> >         if (fp->exit_handler) {
> >                 rh =3D rethook_try_get(fp->rethook);
> >                 if (!rh) {
> >                         fp->nmissed++;
> > -                       goto out;
> > +                       return;
> >                 }
> >                 fpr =3D container_of(rh, struct fprobe_rethook_node, no=
de);
> >                 fpr->entry_ip =3D ip;
> > @@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsign=
ed long parent_ip,
> >                 else
> >                         rethook_hook(rh, ftrace_get_regs(fregs), true);
> >         }
> > -out:
> > +}
> > +
> > +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > +               struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +       struct fprobe *fp;
> > +       int bit;
> > +
> > +       fp =3D container_of(ops, struct fprobe, ops);
> > +       if (fprobe_disabled(fp))
> > +               return;
> > +
> > +       /* recursion detection has to go before any traceable function =
and
> > +        * all functions before this point should be marked as notrace
> > +        */
> > +       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +       if (bit < 0) {
> > +               fp->nmissed++;
> > +               return;
> > +       }
> > +       __fprobe_handler(ip, parent_ip, ops, fregs);
> >         ftrace_test_recursion_unlock(bit);
> > +
> >  }
> >  NOKPROBE_SYMBOL(fprobe_handler);
> >
> >  static void fprobe_kprobe_handler(unsigned long ip, unsigned long pare=
nt_ip,
> >                                   struct ftrace_ops *ops, struct ftrace=
_regs *fregs)
> >  {
> > -       struct fprobe *fp =3D container_of(ops, struct fprobe, ops);
> > +       struct fprobe *fp;
> > +       int bit;
> > +
> > +       fp =3D container_of(ops, struct fprobe, ops);
> > +       if (fprobe_disabled(fp))
> > +               return;
> > +
> > +       /* recursion detection has to go before any traceable function =
and
> > +        * all functions called before this point should be marked as n=
otrace
> > +        */
> > +       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +       if (bit < 0) {
> > +               fp->nmissed++;
> > +               return;
> > +       }
> >
> >         if (unlikely(kprobe_running())) {
> >                 fp->nmissed++;
>
> I have just looked through this patchset, just out of curiosity,
> shouldn't we call ftrace_test_recursion_unlock(bit) here ?
> We have already locked it successfully, so why should we not unlock it?
>
> >                 return;
> >         }
> > +
> >         kprobe_busy_begin();
> > -       fprobe_handler(ip, parent_ip, ops, fregs);
> > +       __fprobe_handler(ip, parent_ip, ops, fregs);
> >         kprobe_busy_end();
> > +       ftrace_test_recursion_unlock(bit);
> >  }
> >
> >  static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> > --
> > 2.40.1
> >
> >
>
>
> --
> Regards
> Yafang
