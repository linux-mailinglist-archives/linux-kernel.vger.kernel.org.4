Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D16A46C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjB0QMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjB0QMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:12:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AB222E5;
        Mon, 27 Feb 2023 08:12:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h31so3856486pgl.6;
        Mon, 27 Feb 2023 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677514322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlYv36LriYWI6uETeQFHMIIq0RQX3z53GLoaGcDgeUo=;
        b=MiIulBqVarPKCoJSurFdShAUhXZMpRsFaIXXLeECgsNQq9HrHfZGJQ8KdmpF8S6yJB
         Pjdvaab/3DS3jaZ520KWW8cZGeNhkPY4w2bNAMntfZRkqzXze1fYANW25cnAg8bgYDfp
         VW6xmHFlTdQU+w1K0pnQJ45pk2BL882lW9xszcaOlszGXiquGELEcnhjuWK77kQiB8zM
         y/uTnKW1GVMKdhC9C0rILbXb3sJRSlGDazWR8ve1v9yg8kGjDeOdeUOHoMALW8mo1nLr
         ckg9Xh5F0C9lU3BLuBHxah7Iqq92JZxT5bBdjGovpP+4imp5bYAlGFt9XqsYeiRekFrI
         is2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677514322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlYv36LriYWI6uETeQFHMIIq0RQX3z53GLoaGcDgeUo=;
        b=Y1ADP/Y6roDDVk27V/iEizEyYw+EF1ZCr5Czn81+kkct2DmjkZOm/Eq5jXOnbwwAo2
         tNUNvfz68uG/JKFKb5heXc4PYrHrp160FNpdbcDx++Mi8FtvYZc/eBIMxRs8tw3VeCDD
         ttsuVRAosqvPTa1QKLvKMtxTnFdU+K9tL0hTntd+wnsMVLDUGxjnM4+9GmzYwwULQCZ5
         s1j/Ll0Uc3RGwKiNv6URcI0YtZf2FDZeLLP0vDvVM55VHKbm4kws1DqJT+8cnYZfUQC+
         3NczLV5zhy+I0IbczLLUrt84vX4C7YrOBMRtuR9317p0UrFtiooOyv1rL2fu87IxghcR
         bO1A==
X-Gm-Message-State: AO0yUKVL4LHRXokoPQpdtmRyOWeCIolB7bbMfF6T7CymVD2hhhMN6v8c
        /tFcpOW/cDZzhf8hcW5WVPCYpsRmarnfmbsyFY3RvAaaf1SjzUCg
X-Google-Smtp-Source: AK7set/aTcBWmGzBwvuWEJDuZpRXuDNH6tsDx63P3I7cdKiA8R3Idyyg1ANmf8ZYQdt23JsS2ZeoYHOjqFRv7j/qRRk=
X-Received: by 2002:a63:3c58:0:b0:4fb:933a:91d with SMTP id
 i24-20020a633c58000000b004fb933a091dmr6109997pgn.11.1677514322311; Mon, 27
 Feb 2023 08:12:02 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org> <20230227103257.4b99b6fb@gandalf.local.home>
 <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
In-Reply-To: <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 28 Feb 2023 00:11:51 +0800
Message-ID: <CAABZP2zZHQ22MPsWkPZ5kPW5SNDPt0mT37xw3f4VNLeBsxRPvw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:49=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hey Steve,
>
> On Mon, Feb 27, 2023 at 10:33 AM Steven Rostedt <rostedt@goodmis.org> wro=
te:
> >
> > On Mon, 27 Feb 2023 08:15:26 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > >> asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > > >> RIP: 0010:default_idle+0xf/0x20
> > > >> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 =
ff ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 6=
6 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> > > >> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> > > >> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> > > >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > > >> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> > > >> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> > > >> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
> > > >> default_idle_call+0x67/0xa0
> > > >> do_idle+0x361/0x440
> > > >> cpu_startup_entry+0x18/0x20
> > > >> start_secondary+0x256/0x300
> > > >> secondary_startup_64_no_verify+0xce/0xdb
> > > >> </TASK>
> > > >> Modules linked in:
> > > >> CR2: 0000000000000000
> > > >> ---[ end trace 0000000000000000 ]---
> > > >> RIP: 0010:0x0
> > > >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > >
> > > I have seen this exact signature when the processor tries to execute =
a function that has a NULL address. That causes IP to goto 0 and the except=
ion. Sounds like something corrupted rcu_head (Just a guess).
> >
> > [ Joel, you need to line wrap your emails ;-) ]
>
> Ok I will try. The thing is, I have not figured out yet how to
> plaintext-reply from my iPhone without having it wrap :-(
>
> > This looks like a call_rcu() was called on something that later got fre=
ed
> > or reused. That is, the bug is not with RCU but with something using RC=
U.
>
> Yes certainly, the rcu_head is allocated on the caller side so it
> could have been trampled while the callback was still in flight.
Thank you all for your guidance, I learned a lot during this process
>
> > OR it could be a bug with RCU if the synchronize_rcu() ended before the
> > grace periods have finished.
Thanks again.

By the way, the syzkaller on my local machine has been running for 8
hours, only three bugs reported[1][2][3], but they don't seem to be
related to Sanan's original report.
Maybe there are some configuration mismatches between us.The test
continues,  I will report to you once I have any new discovery.

[1] http://154.220.3.120:56700/
[2] https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux=
-next.git/snapshot/linux-next-next-20230221.tar.gz
[3] http://154.220.3.120/configs/linux-next-config-20230221.txt
Thanks
Zhouyi
>
> Good point..
>
> Thanks,
>
>  - Joel
