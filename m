Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0D62E6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiKQVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbiKQVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:11 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0485ECF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:16:22 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so4411351ljl.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtl/lclYTlJtGwSEA1jWl+9ZkQmRhJ5jq1xun1UIxNw=;
        b=lfDyFFIavZIS27mwn6jmlPpyj/NRIjFYRu40Zmy/O4CYQg98ecyo+qN/AdF7F0btJD
         8XJdgtjsFRG+gmTVb4nsY1iOz+HukSzrbJzU2Zce5v7rHhmYxsG4auVofB4kGWysPpKZ
         3FYZSj4EX7p4/S1gWWNfiZwcgA75WfyEH+znSeVW0btTSYyMoWkApjtK1y9XbKdB0DkT
         3H0fpuR6L9t4SS+awuav2kxcO+sEvbl1oZHyzdQ7kqeYJRTmchTsE+jrtAcnVNoUpaaj
         wPWwc++sC5f+3KTB4XsmKJA0VZVgkwAU5fvi9OnT3y0OX7A5cQu1vG+D/9H2q8FAi3Qe
         Bpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtl/lclYTlJtGwSEA1jWl+9ZkQmRhJ5jq1xun1UIxNw=;
        b=1tx59x1zQ+OzH0CUBoK2EsTWwCs5x45BkXxPCshxj5SW2XZdFXEu72XZ0pdFwV//Bb
         rYg7mG9dSvzuXuKoQhji0J0ZL3glStYV0k+R5ka6FCsavyLvvhpCpljDP8yhrrtOmmi9
         1urOWyqShr9gimNXo/hAYwmPGsSb1U13B6zneN4RDYaZUMNPcBoE39iAaVqCziKwXRoW
         gE9Wa5A5ZhdqBl/Gi/MAw3KAiHoLEmo2olainFApKzpzEVHSKa3SNP/CfQ1n0+KYJvVH
         1hI+5gBEnzmBSN0geZAUUBgRO+41Tb9OdYP3FA5cUV88ZpGJFI4FIUhuQUVvH33tFZTW
         A+Tg==
X-Gm-Message-State: ANoB5pl/ri3z8WHwW3fxonwXjR/9IyDHz1+krF5AVVFqYxWuTAnthwYO
        f5D0lWcOyN2nh7E2XksfQ1/gwj7Cq7xFWCI91B8=
X-Google-Smtp-Source: AA0mqf6SbQJelZeOfvUkDWPOk5lgA4rCz2ocpQfgf4ENPUpIifneRv9ps2AYoqaIzOTuq18sURGG4bH/sGBGA3LtdIA=
X-Received: by 2002:a2e:a4c7:0:b0:277:81ff:b8c4 with SMTP id
 p7-20020a2ea4c7000000b0027781ffb8c4mr1537399ljm.260.1668719780237; Thu, 17
 Nov 2022 13:16:20 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009d5daa05ed9815fa@google.com> <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com> <87wn7tlg4n.ffs@tglx> <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
In-Reply-To: <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Nov 2022 13:16:08 -0800
Message-ID: <CABBYNZJYbzX9xoqU8_KEArTJ2=5eMTiDTjMbNjEYNVmi1rkp+A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Thu, Nov 17, 2022 at 1:04 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Thomas,
>
> On Thu, Nov 17, 2022 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Nov 17 2022 at 20:55, Hillf Danton wrote:
> > > On 17 Nov 2022 12:54:28 +0100 Thomas Gleixner <tglx@linutronix.de>
> > >>
> > >> The work has been canceled already before in the same function and there
> > >> are some more delayed works which can trigger this.
> > >>
> > >> So no, this whole close_sync() function is prone to teardown races and
> > >> just slapping a single cancel here without deeper analysis does not cut
> > >> it.
> > >
> > > Agree.
> > >
> > > A set of sync cancelations can do the job, given what is defined in struct
> > > hci_dev wrt workqueue.
> >
> > It's only part of the solution because you also have to prevent that
> > work is queued from other parts of the code....
>
> I thought we would have something similar to shutdown_timer (e.g.
> shutdown_delayed_work) so we can safely free its object/struct, at
> least that was the impression I got when discussing with Steven.

Wasn't the following patch suppose to address such problem:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=deee93d13d385103205879a8a0915036ecd83261

It was merged in the last pull request to net-next:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=a507ea32b9c2c407012bf89109ac0cf89fae313c

-- 
Luiz Augusto von Dentz
