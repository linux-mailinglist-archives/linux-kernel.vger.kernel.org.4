Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001D672F64
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjASDGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:06:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EAC728C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:06:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 203so900103yby.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSVT8YMAjXFFuPOc52FToBAxdMmpNVmxrCRZs5o5VjI=;
        b=Y3pFPShzMo7m/C/Jbyf8twwR/ljuAb7pInc97aWWrCPc6JmUlDjeCObiYI61nbhC6c
         XDC3+gNU8ufbrG9efFIMnn3lk5g6TfpACZQZluk5wa+WHfNbal0TxzV9FHP71U8SfZGl
         zJ3XfQ4oA3eBQnWNLCL7/czQ2ga6mAo+WgrMgKdBaidMspmMI1kkfFKNTha1zKJSom8S
         WRHM2N8jEkYX/FccbMRwxEu0oDNfEwk84BYuIibSI86OhQhg/8l5nMIxe8ngCEQt7GPM
         5kZ4y3DznA986yj2Jba7c1HPZL6x1yPp1RSV9IXEgSPtlTmAPv2KDF7kuFK6eT1zoTcB
         dPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSVT8YMAjXFFuPOc52FToBAxdMmpNVmxrCRZs5o5VjI=;
        b=dLw6nImch1Ac6rIkf3fWHJ3j42bwrFKAwx7LzJNu1oXbczPK2HItpTHhHoaa1dzicj
         3mQxLWZniu7uitu4CH55496AVLd6y2sU7Gk+YkivzW8CUXPJUmSXQK35aeGUT+SP3MVm
         MzoK9xMwQeH/KzVWmzIFWn7yTQp1m2ySZkOeqdRy9ZwqLPQTz4ccioYSdcJejPbZqOOg
         Nmz1cJrRKRITweIo5PXl6R0LU1jXvMLlaqQQc6IEt1rHDfKQbHHTEg3Ek6lYUgPyQ9W6
         Y4Gh2cMxIfqY+KIwbV0IaJhpRGzN6uCSvYnlVkHzWEhVEbmZaEcyMqaISLDbe7lVLRmS
         IdFA==
X-Gm-Message-State: AFqh2kq5/BPfeBlm24MBafDxaB9NnJFas1yAwOuNGPFjIyu4LvIP6OV2
        PTmfmf/ZGFrnP831RvWlYvI8c2EFNyOioh9+tbAgVg==
X-Google-Smtp-Source: AMrXdXsAS+F/t+k+RLycofXHpm2MVkThS9HDzF+oG0yCkqMTTq9jCZYTPVYA3UVQC5g/ZQoWjF19SIwf+o09Ru1wZ6k=
X-Received: by 2002:a05:6902:11cd:b0:7d6:c4f6:b4ea with SMTP id
 n13-20020a05690211cd00b007d6c4f6b4eamr976386ybu.59.1674097582453; Wed, 18 Jan
 2023 19:06:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com> <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
In-Reply-To: <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 19:06:10 -0800
Message-ID: <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Munehisa Kamata <kamatam@amazon.com>
Cc:     ebiggers@kernel.org, hannes@cmpxchg.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 9:52 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Jan 12, 2023 at 6:26 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> >
> > On Thu, 2023-01-12 22:01:24 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, Jan 9, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > > >
> > > > > > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > > > > >
> > > > > > > That patch survived the repro in my original post, however, the waker
> > > > > > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > > > > > the pressure file got closed. So, if the following modified repro runs
> > > > > > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > > > > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > > > > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > > > > > the queue, but wake_up_pollfree() does.
> > > > > >
> > > > > > Thanks for your testing. And the debugging completes.
> > > > > >
> > > > > > Mind sending a patch with wake_up_pollfree() folded?
> > > > >
> > > > > I finally had some time to look into this issue. I don't think
> > > > > delaying destruction in psi_trigger_destroy() because there are still
> > > > > users of the trigger as Hillf suggested is a good way to go. Before
> > > > > [1] correct trigger destruction was handled using a
> > > > > psi_trigger.refcount. For some reason I thought it's not needed
> > > > > anymore when we placed one-trigger-per-file restriction in that patch,
> > > > > so I removed it. Obviously that was a wrong move, so I think the
> > > > > cleanest way would be to bring back the refcounting. That way the last
> > > > > user of the trigger (either psi_trigger_poll() or psi_fop_release())
> > > > > will free the trigger.
> > > > > I'll check once more to make sure I did not miss anything and if there
> > > > > are no objections, will post a fix.
> > > >
> > > > Uh, I recalled now why refcounting was not helpful here. I'm making
> > > > the same mistake of thinking that poll_wait() blocks until the call to
> > > > wake_up() which is not the case. Let me think if there is anything
> > > > better than wake_up_pollfree() for this case.
> > >
> > > Hi Munehisa,
> > > Sorry for the delay. I was trying to reproduce the issue but even
> > > after adding a delay before ep_remove_wait_queue() it did not happen.
> >
> > Hi Suren,
> >
> > Thank you for your help here.
> >
> > Just in case, do you have KASAN enabled in your config? If not, this may
> > just silently corrupt a certain memory location and not immediately
> > followed by obvious messages or noticeable event like oops.
>
> Yes, KASAN was enabled in my build.
>
> >
> > > One thing about wake_up_pollfree() solution that does not seem right
> > > to me is this comment at
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253:
> > >
> > > `In the very rare cases where a ->poll() implementation uses a
> > > waitqueue whose lifetime is tied to a task rather than to the 'struct
> > > file' being polled, this function must be called before the waitqueue
> > > is freed...`
> > >
> > > In our case we free the waitqueue from cgroup_pressure_release(),
> > > which is the handler for `release` operation on cgroup psi files. The
> > > other place calling psi_trigger_destroy() is psi_fop_release(), which
> > > is also tied to the lifetime to the psi files.  Therefore the lifetime
> > > of the trigger's waitqueue is tied to the lifetime of the files and
> > > IIUC, we should not be required to use wake_up_pollfree().
> > > Could you please post your .config file? I might be missing some
> > > configuration which prevents the issue from happening on my side.
> >
> > Sure, here is my config.
> >
> >  https://gist.github.com/kamatam9/a078bdd9f695e7a0767b061c60e48d50
> >
> > I confirmed that it's reliably reproducible with v6.2-rc3 as shown below.
> >
> >  https://gist.github.com/kamatam9/096a79cf59d8ed8785c4267e917b8675
>
> Thanks! I'll try to figure out the difference.

Sorry for the slow progress on this issue. I'm multiplexing between
several tasks ATM but I did not forget about this one.
Even though I still can't get the kasan UAF report, I clearly see the
wrong order when tracing these functions and forcing the delay before
ep_remove_wait_queue(). I don't think that should be happening, so
something in the release process I think needs fixing. Will update
once I figure out the root cause, hopefully sometime this week.


> Suren.
>
> >
> >
> > Regards,
> > Munehisa
> >
> >
> > > Thanks,
> > > Suren.
> > >
> > > >
> > > >
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
> > > > >
> > > > > Thanks,
> > > > > Suren.
> > > > >
> > > > > >
> > > > > > Hillf
> > >
> > >
