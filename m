Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85D63380F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiKVJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiKVJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:11:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B523347339
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:11:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y4so13051218plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoTx9C4uNq1hBG7+PyDvIRzpdUCEux+gorC7Y4BuSig=;
        b=pKItYzsHtblDg17Omt9eVUAvCwzac4oqmR4KDXabuznIoYuqj4kdQ1H/EV0hs8btaL
         YtAvLpE2pNn8QeruD8M9mXRW8H7CXBGfB9brX8g6jgdykL8H+Aoa4BudOeXQYih/TPKI
         JZVkJX6fmFTJiDDXRRqFhIK4FVO4F2zmxnWr+Ll4p35JaXFPBM5iQ280KIkTug3CmjCT
         Vd2q2TKfZaR19wVH9Wco+5Z5buPmdSkDuiUsi8qxUWUgRwJbgYyGODMGtF0TWZjlvA4g
         BN8r+U7qcfyIo6WvSoRXX02XJ7kO0FgV4BHHfNMloxCR0rsXQVBxTAO4JPm9VxNZVRog
         Msug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoTx9C4uNq1hBG7+PyDvIRzpdUCEux+gorC7Y4BuSig=;
        b=JfsSjd9KguIJGIZHpzTSo3nwzPPxS0qe7hHbJmwXmQ+mvpq1MafYzJLbNvdOEP3tpa
         9YQartO7bk8BOh7leElKHRsIpRS5PsiSzLfAymKt6qHpgqSNKH/V62DnMPrHAfYlg8Dl
         hnpkqef2sa/wgPDmvLL/nwI1XwN2qjDRBImg3r4qrJqHlI3vfXJ5GLbkHGEk2x7sUAiQ
         9N6cqqbAALpILedNsWinl8KTC6ZmUJ1F3vUkj0FjlZRMRD4YYXuf55Bu53M/dow9AdR7
         2TEBbKUcYr+KK+IRgFgLT66o183QI59z0kbieYRpqopgBXPKEzOmZvADu4u7rG3vpFGU
         hJEw==
X-Gm-Message-State: ANoB5plZaJB1PvdS57688icqUjC/qs+UuExpxLFrv8G3lcFNicw2o4Qm
        CylsVcI7nQa9vX264+lSOD921fyoXkcTPijlJSU=
X-Google-Smtp-Source: AA0mqf6VwG6QTTx5bieFy6M4a8Omoi5dC0LYHvGLNImoGL+M+vdrkKx82ONeT7MVjXNQSt3UyWfjJQscQQwM6arG93k=
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id
 i6-20020a17090adc0600b0021891961cd1mr17572330pjv.230.1669108307219; Tue, 22
 Nov 2022 01:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20221122075440.1165172-1-suagrfillet@gmail.com> <CAJF2gTQWuu2wUk-7WhFdov0PG5R1z_F_+OLqHM0nGnMiC1Yi_w@mail.gmail.com>
In-Reply-To: <CAJF2gTQWuu2wUk-7WhFdov0PG5R1z_F_+OLqHM0nGnMiC1Yi_w@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 09:11:34 +0000
Message-ID: <CAAYs2=iSTTuthLhwiyw08yG2q=yLrdKPmvbG2rS7uibzhe-wXQ@mail.gmail.com>
Subject: Re: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
To:     Guo Ren <guoren@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=BA=8C 08:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 22, 2022 at 3:54 PM Song Shuai <suagrfillet@gmail.com> wrote:
> >
> > With this commit (riscv: ftrace: Reduce the detour code size to half)
> > patched, ftrace bug occurred When hosting kprobe and function tracer
> > at the same function.
> >
> > Obviously, the variable caller in ftrace_modify_call was assigned by
> > rec->ip with 4 offset failing the code replacing at function entry.
> > And the caller should be assigned by rec->ip directly to indicate
> > the function entry.
> Thank you, it's my fault, but I think the problem is:
>
> Before (riscv: ftrace: Reduce the detour code size to half)
>      0: REG_S  ra, -SZREG(sp)
>      4: auipc  ra, ?          <- We need "rec->ip + 4" here
>      8: jalr   ?(ra)
>     12: REG_L  ra, -SZREG(sp)
>
> After (riscv: ftrace: Reduce the detour code size to half)
>      0: auipc  t0, ?  <- We needn't "rec->ip + 4" anymore
>      4: jalr   t0, ?(t0)
>
> I copied rec->ip + 4 blindly, then caused the bug. Right?
>
Yes, you're right.

Here's my simple test case for your convenience.
```
echo kernel_read > set_ftrace_filter
echo function > current_tracer
echo 'p:myp kernel_read' > kprobe_events
echo 1 > events/kprobes/myp/enable # ftrace bug
```
> >
> > The following is the ftrace bug log.
> >
> > ```
> > [  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but got (=
1a8282e7 f0227179)
> > [  419.633390] ------------[ ftrace bug ]------------
> > [  419.633553] ftrace failed to modify
> > [  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
> > [  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
> > [  419.634087] Updating ftrace call site to call a different ftrace fun=
ction
> > [  419.634279] ftrace record flags: e0000002
> > [  419.634487]  (2) R
> > [  419.634487]  expected tramp: ffffffff800093cc
> > [  419.634935] ------------[ cut here ]------------
> > ```
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/kernel/ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 8c77f236fc71..61b24d767e2e 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsi=
gned long old_addr,
> >                        unsigned long addr)
> >  {
> >         unsigned int call[2];
> > -       unsigned long caller =3D rec->ip + 4;
> > +       unsigned long caller =3D rec->ip;
> >         int ret;
> >
> >         make_call_t0(caller, old_addr, call);
> > --
> > 2.20.1
> >
>
>
> --
> Best Regards
>  Guo Ren
Thanks,
Song
