Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10673EF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFZXf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:35:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE2F198C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:35:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8161f564dso40905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687822550; x=1690414550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye+pBTYKS/u7tJpkg9sU71HIoSqwxT9g6K7TeSqe2NE=;
        b=XHhN2vaIC3SRLWpqzVYPqF9VikkQ8loPIGRxWK7NbapgSfMqLJ9lvJlzhmzwo3NH73
         M1EhVHHbpig+jziC4TgjgXEtyd+KvWmqsyPsY3kgV2xFuZc3FEcN1hlp6Z9n+JjPzQp8
         6LtWW/zQSL2XTXBmggszHNdKEefPb1qmg+QDKM4UyFXd6vAkLeb5bI2ipUzCoV3Jm50A
         RhcsxNF6GOIwtP+numVCzxqRpGdKI8Dd+TYAhNcqayZFU/AbkzIFNp8trXjwXYDKcKeb
         qQeemQ1VDnQFRQq7VkG5xMOSoZWlycNK3M8GaZqSjERoxMdA9vizuoE5gpJu0tdEnrt4
         3tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822550; x=1690414550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye+pBTYKS/u7tJpkg9sU71HIoSqwxT9g6K7TeSqe2NE=;
        b=Eq/iKxpVBoi/SyTy8slMrPc/qyfxtLBlgD0BcUfCwp7WlYiS5eYCpKb78pS7jsZ3zz
         PhSmlu5zXV7gWxxBCVaXMS04YIvaOqKwvhc8ejVPHiLRQ9S/klOOZH4vhlk1XiJaYKDh
         AeviMgZTOVA9OC7dy5TFESRi+FK/R9GLGsZ6G5mjHdttoIOI6tjAC3OYqQ+pgyou4D6p
         n917rbli4JncYGGsdcgt4mVRqaUWzlnRvnjudHOH/JNCaC8pPjbVdCORgkWGmniCewI7
         ufmaowWVyHTK5Z/LCNpUdHYf7QRY95O43A84InBpS0oiTczsVqLBz4K/gwnOxB50dQej
         y8zg==
X-Gm-Message-State: AC+VfDxeXyPo5LuRRXRyfCqvWLdL3DkStpPbqWN9tRrLUyOY3oCzJQYA
        +dg0jNWOsY099cJh4KuVq4XVsXtLIscLw0d3mbzqpA==
X-Google-Smtp-Source: ACHHUZ5+bYI/A80L2F4cJcbHWGeJR+t4TIW7r4Dwje1T3e53QR8qyg82z8W5jDDZSKxlPQievEX4IB1XmHHTAWBbB0w=
X-Received: by 2002:a17:903:453:b0:1b5:8a8:b587 with SMTP id
 iw19-20020a170903045300b001b508a8b587mr2216796plb.2.1687822550071; Mon, 26
 Jun 2023 16:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <YO2S+C7Cw7AS7bsg@google.com> <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com> <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com> <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com> <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
In-Reply-To: <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
From:   Anil Altinay <aaltinay@google.com>
Date:   Mon, 26 Jun 2023 16:35:37 -0700
Message-ID: <CACCxZWNx7=+BvrGgPYTGwARKdJp4DhKvGXAPdzuKu+ebmHr7Xw@mail.gmail.com>
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
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

Hi John,

I was wondering if you get a chance to work on patch v4. Please let me
know if you need help with testing.

Best,
Anil


On Tue, Feb 21, 2023 at 1:27=E2=80=AFPM Anil Altinay <aaltinay@google.com> =
wrote:
>
> I can test the patch with 5.10 and 5.15 kernels in different machines.
> Just let me know which machine types you would like me to test.
>
> On Mon, Feb 20, 2023 at 12:42 AM John Johansen
> <john.johansen@canonical.com> wrote:
> >
> > On 2/17/23 02:44, Sebastian Andrzej Siewior wrote:
> > > On 2023-02-16 16:08:10 [-0800], John Johansen wrote:
> > >> --- a/security/apparmor/lsm.c
> > >> +++ b/security/apparmor/lsm.c
> > >> @@ -49,12 +49,19 @@ union aa_buffer {
> > >>      char buffer[1];
> > >>   };
> > >> +struct aa_local_cache {
> > >> +    unsigned int contention;
> > >> +    unsigned int hold;
> > >> +    struct list_head head;
> > >> +};
> > >
> > > if you stick a local_lock_t into that struct, then you could replace
> > >       cache =3D get_cpu_ptr(&aa_local_buffers);
> > > with
> > >       local_lock(&aa_local_buffers.lock);
> > >       cache =3D this_cpu_ptr(&aa_local_buffers);
> > >
> > > You would get the preempt_disable() based locking for the per-CPU
> > > variable (as with get_cpu_ptr()) and additionally some lockdep
> > > validation which would warn if it is used outside of task context (IR=
Q).
> > >
> > I did look at local_locks and there was a reason I didn't use them. I
> > can't recall as the original iteration of this is over a year old now.
> > I will have to dig into it again.
> >
> > > I didn't parse completely the hold/contention logic but it seems to w=
ork
> > > ;)
> > > You check "cache->count >=3D  2" twice but I don't see an inc/ dec of=
 it
> > > nor is it part of aa_local_cache.
> > >
> > sadly I messed up the reordering of this and the debug patch. This will=
 be
> > fixed in v4.
> >
> > > I can't parse how many items can end up on the local list if the glob=
al
> > > list is locked. My guess would be more than 2 due the ->hold paramete=
r.
> > >
> > So this iteration, forces pushing back to global list if there are alre=
ady
> > two on the local list. The hold parameter just affects how long the
> > buffers remain on the local list, before trying to place them back on
> > the global list.
> >
> > Originally before the count was added more than 2 buffers could end up
> > on the local list, and having too many local buffers is a waste of
> > memory. The count got added to address this. The value of 2 (which shou=
ld
> > be switched to a define) was chosen because no mediation routine curren=
tly
> > uses more than 2 buffers.
> >
> > Note that this doesn't mean that more than two buffers can be allocated
> > to a tasks on a cpu. Its possible in some cases to have a task have
> > allocated buffers and to still have buffers on the local cache list.
> >
> > > Do you have any numbers on the machine and performance it improved? I=
t
> > > sure will be a good selling point.
> > >
> >
> > I can include some supporting info, for a 16 core machine. But it will
> > take some time to for me to get access to a bigger machine, where this
> > is much more important. Hence the call for some of the other people
> > on this thread to test.
> >
> > thanks for the feedback
> >
