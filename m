Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF96DC3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDJG7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:59:52 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344671FD7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 23:59:48 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id z23so2807224uav.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 23:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681109987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nePYi444oFSBNCNb1sIZeCx0m02UrkHlr/iQVGosHSc=;
        b=VX0v1TPr9/I0ciSXfLyT0vVm2nE+3H/S8FiRu5eDBB/FckvIiF5WyWr23EmFe2+xoE
         7z0szfsccdHXC4RDFgHpRtqfhUSAjeS6Veu6UlFg7aqFXhU08mljKQSN+6u5bdD5Fves
         FyBZZP++BgFF7kaZxMfABcbEf2nQ24+bBLW6bdEFBR0Fjw2O8JkVBMR5Lp9/ubrqGsnH
         bmafk+pXt5TiZD39Y/cnDQN/bvZOc/CgLrL4i2zQ6w0Wec2OEUMx0R+XO83MERrpxEG4
         I/QcH5IF43GIyZRFMpX9HCeRDycRyVeucDcpWoqo78+UX0Az7TTgvNazhIgaIN/5K1Oc
         Oibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681109987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nePYi444oFSBNCNb1sIZeCx0m02UrkHlr/iQVGosHSc=;
        b=nQALRnY+X7MmGca2UmvuDnXZ+m/19T3MEzC6jEJSaQuTPm07X7n702sV6+ayhahHBq
         IgTR3Xu96VVi2iQtSh6NgoDtAhkXYdX+Yx2hurYVR4J/pzTa6phyypheyKp0rrg4Gim7
         5DFi8r2CY55wr7hT1+g7/fV7kU4X5L4aI+b6ttscFt3/LwQUzXu/IQk33scWqa/arvRN
         3Bbtm7Okf52akRJGMuzEbTP7vQcLJmOf1FFTqU7TZl0CFffiCVgarZCw82PloTT1g+/a
         pNMpuD5LnWuKnhPf/KitX0x3bx2cWcNypkjVBw46CXFwNObm7RUSyPzRF900nKyaTDEb
         5Z0A==
X-Gm-Message-State: AAQBX9fJSIRBP+zHf7nPvrm2PjCmWQCRzXfuinbJdKZ5jU57UjfewNZn
        cOpM0g46gvvtXsZZDse2P8hdn3xpjcAJcX+faec=
X-Google-Smtp-Source: AKy350Y4jVLSl3cXOcim9fYM3jYhSV4eANEPs8iX9qI40WGIhhVAk5GseRcArUHsS8Emq4KJswV9sffx2aAmOxqXPYw=
X-Received: by 2002:a05:6122:a26:b0:43f:c5d4:cddb with SMTP id
 38-20020a0561220a2600b0043fc5d4cddbmr1562278vkn.1.1681109987141; Sun, 09 Apr
 2023 23:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-5-avagin@google.com>
 <CALCETrUB_rCCBa9TPt+7x0MBfKP9L5e8JXva-rDzE3B-AGEzNA@mail.gmail.com>
In-Reply-To: <CALCETrUB_rCCBa9TPt+7x0MBfKP9L5e8JXva-rDzE3B-AGEzNA@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 9 Apr 2023 23:59:35 -0700
Message-ID: <CANaxB-wykCH+2fgrwBNe2BkTmEJpZjhsFBekiS_qaQHz4vYt8Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] seccomp: add the synchronous mode for seccomp_unotify
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrei Vagin <avagin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 8:42=E2=80=AFPM Andy Lutomirski <luto@kernel.org> wr=
ote:
>
> On Tue, Mar 7, 2023 at 11:32=E2=80=AFPM Andrei Vagin <avagin@google.com> =
wrote:
> >
> > seccomp_unotify allows more privileged processes to do actions on behal=
f
> > of less privileged processes.
> >
> > In many cases, the workflow is fully synchronous. It means a target
> > process triggers a system call and passes controls to a supervisor
> > process that handles the system call and returns controls to the target
> > process. In this context, "synchronous" means that only one process is
> > running and another one is waiting.
> >
> > There is the WF_CURRENT_CPU flag that is used to advise the scheduler t=
o
> > move the wakee to the current CPU. For such synchronous workflows, it
> > makes context switches a few times faster.
> >
> > Right now, each interaction takes 12=C2=B5s. With this patch, it takes =
about
> > 3=C2=B5s.
>
> This is great, but:
>
> >
> > This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> > it used to enable the sync mode.
>
> Other than being faster, what does this flag actually do in terms of
> user-visible semantics?

In short, the process handling an event wakes up on the same cpu where the
process that triggered the event has been running. Knowing this fact, the u=
ser
can understand when it is appropriate to use this flag.

Let's imagine that we have two processes where one calls syscalls (the
target) and another one handles these syscalls (the supervisor). In this ca=
se,
the user should see that both processes are running on the same cpu.

If we have one target process and one supervisor process, they synchronousl=
y
swap with each other and don't need to run on cpu concurrently.  But
it becomes more
complicated if one supervisor handles a group of target processes. In this
case, setting the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag depends on the
frequency of events. If the supervisor often has pending events (doesn't sl=
eep
between events), it is better to unset the flag or add more supervisor
processes.

Thanks,
Andrei
