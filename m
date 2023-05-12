Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2064F7006D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjELLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjELLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:30:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD24205
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:30:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3330afe3d2fso662145ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683891030; x=1686483030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQOquoFV+QTNwyBDL+luWud+9DaJCTtLWpWTFwVtp80=;
        b=IIS9/jL1CyQbCpwihNHu/letLRsBghwudGOMRWI4sU+LwgrHxUx626locCf96Kh2By
         mOKoSF/vnaez26l2dql0HjfAEz6wKBsUwV5AH8e62DMoGK5WAoFWuGutXC8PDpCjCATL
         o14Qi+RpSTdLTnmA/7XFtBjsoakGlco4FCw5cFBet+blSInkDdUJ4RTkaLWsneU8DJLT
         UTfPNHDUdgnTPh2ZllI3C4eMjB+Z0Kn8je5fgFwNNXowKn/k36A9/UP937T1kfWGZ0iF
         p/a1/hXGmvFA52pf0m8AYkzkKjOc+3ke8841vqhTcmebVEXBfqOtzn/BII8NX04DNQ5u
         F0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683891030; x=1686483030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQOquoFV+QTNwyBDL+luWud+9DaJCTtLWpWTFwVtp80=;
        b=Mmzl0fQ03WKd/RArH1v6lBn2YenBAploPjsZnVGk6EOoJcsqQcDjnkRcA/KOutgYev
         BKPr4C8wrAjW5pRBwgGUxOv3UazooFmSHTjfvDGlKTKlvgIGMplIITUh3PitJU3nQs4o
         ZYSLEkmmBGVJGNb8Dnltq5PPxJc1zJfwNHbHfMhyVpUsX1dNJzpdcPLEzRivFVRo/B55
         9tjXtLmX3pv6iSr2OYhMC3UIiAbWs/SorlV65MLGJcHu2+6k4ce9B5cQd3N5CCULKIe4
         paUU6CHjlGrcPo3pVCGmO82lHe3eaJgMZVDbskwnnmfV4mOgMSvWK1mPPZxNiOLf4H7b
         XVew==
X-Gm-Message-State: AC+VfDx03mxW351Rs/k+rC+z79IsE4iXfuOTLg5vrfGxLSWvoc+Ba2H7
        vtrWHJi6L5RuTvFRHLL/XAAneBxQ2I7JM6YINgOnjw==
X-Google-Smtp-Source: ACHHUZ4u5m9VmRjZUs3O0nL3CTE66D+Vzp9JHG06ZWaysEeSZaeBUaUvCzqTJnrj9GJgi6D3tPRosC3x2p22IPcAw2E=
X-Received: by 2002:a05:6e02:174c:b0:330:eb79:91ad with SMTP id
 y12-20020a056e02174c00b00330eb7991admr194792ill.9.1683891029900; Fri, 12 May
 2023 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da2a8505fb71d81b@google.com> <CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx=YwOnrZ6qeOyBWE8=tKQw@mail.gmail.com>
In-Reply-To: <CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx=YwOnrZ6qeOyBWE8=tKQw@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 12 May 2023 13:30:18 +0200
Message-ID: <CANp29Y44p1GCe+NC_KhGGGNB+N2v0MHB+onHZ2rzP52AfZahDQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in gic_eoi_irq
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     syzbot <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        magnus.damm@gmail.com, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 9:59=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On Thu, May 11, 2023 at 11:41=E2=80=AFPM syzbot
> <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com> wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    ac9a78681b92 Linux 6.4-rc1
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D102a3f6a280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcc86fee6719=
9911d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dafc1d968649e7=
e851562
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/c35b5b2731d2/non_bootable_disk-ac9a7868.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c04bec59d77d/vmli=
nux-ac9a7868.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/070113b307f3=
/zImage-ac9a7868.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com
> >
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
005f4 when read
> > [000005f4] *pgd=3D80000080004003, *pmd=3D00000000
> > Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at gic_eoi_irq+0x64/0x70 drivers/irqchip/irq-gic.c:228
>
> Why is this sent to the renesas-soc maintainers?

The report was attributed to `drivers/irqchip/irq-gic.c` and
`./scripts/get_maintainer.pl -f drivers/irqchip/irq-gic.c` gives
linux-renesas-soc@vger.kernel.org (open list:ARM/RISC-V/RENESAS ARCHITECTUR=
E)
as one of the output results.

>
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
>
> While I see the list of subsystems there, how do I find out the (wrong?)
> current bug's subsystem?

In this particular case, syzbot was not able to determine any
subsystems (I've sent a fix) and just picked the output of the
get_maintainer.pl script.

[1] https://github.com/google/syzkaller/pull/3893

Otherwise, the bug is a yet another manifestation of
https://lore.kernel.org/all/CANp29Y4Q-VWEWeHmZu0f9tLLik1Va8oDF-s8hAeVkBZbX4=
K0gg@mail.gmail.com/

#syz invalid

>
> Thanks for fixing!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx%3DYwOnrZ6qeOyBWE8%3DtKQw%40=
mail.gmail.com.
