Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E55F6EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiJFUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiJFUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:25:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486465FAD0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:25:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so7106152eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDkZXpYkthhr4s+SBp7MVCA2CeZehoIdF0YnVoTrB+4=;
        b=HMVwYNvHNUq5jcc1xBChJuBtT7Yqm8A3BfCP3cyzFhc7t+uHO5yrYNuaEnDgFXcb2S
         SqGrDmZD3j2pa9EpjNiN0o6XNjkZeEqsDiXVG3SWzpIKAlPlULNJqpIl5UQ1e0odEmGd
         dyqkExVgC58BaLg6bwzCC9F5vwB8iD9xEG4DPnr9nJJ+lzqQO4QIhH3QdNf7CElF75im
         /DQugQKMhlivopypTBExSFCOvbLeyvr7NA0t1Jv3TuaSQPg1MN48kveS+5UggVrUg1oD
         Mfzj7hnffAkdGDNcixGvjSsk5XrTQEMWGPqm9XHheiZN/nbzYZ9u0xQrg749Nbcd1wXt
         KxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDkZXpYkthhr4s+SBp7MVCA2CeZehoIdF0YnVoTrB+4=;
        b=qg8IBzVamPWUYFuNJtbdQwqjaqB1NxIoTDej+D51abnLS0qsONE/QIcF66U5XU17ru
         HBYGE8WT8ANCvB2d3CCPj3tHPBk/wKuYD7E8VAkntar9aPPI7NNCr9VDuf1ODe89qW0+
         SdGyZEGOeckrul9csDsO74+fztOth/slMwFx7QOYvxRNv1QVM4K3LVjOB4g9V5SuW/A2
         /HNix+Sj5q8+wrtnjB1xfHIX8Y9eGktVXJtsSw7ffBQlgKvFhE6C7Ph930f6hvO4q0E/
         vLvooUKMg7NLedTni2Y7PglxYLj3kyDMGgIol2S1G6u4fYTl5Oc9wQjOGLp1n3QIOrBL
         i8Lw==
X-Gm-Message-State: ACrzQf3Ugq9BQDKjgryVYZ8JEzHLP8rJGbsvfB2dj/xqv3RL7nM5GIr4
        Kqq3N74UGGjwUEFaBRukYvcWeu5Gjgv3WIPvn0I=
X-Google-Smtp-Source: AMsMyM6yO2fc6iqYaCkfMWdElsWOqIkBh03X3fUJPDWgd9ZHfrdMIYFxdoBMaUMB0a/bpmSex5GqIZ1PecxxWtff4d8=
X-Received: by 2002:a17:907:16a8:b0:78d:4da3:eedd with SMTP id
 hc40-20020a17090716a800b0078d4da3eeddmr1159649ejc.476.1665087901399; Thu, 06
 Oct 2022 13:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com> <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
In-Reply-To: <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Oct 2022 06:24:49 +1000
Message-ID: <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Fri, 7 Oct 2022 at 06:14, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Oct 6, 2022 at 3:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Oct 6, 2022 at 12:28 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > Maybe you are seeing this which is an issue with GPU TLB flushes which
> > > is kind of sporadic:
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/2113
> >
> > Well, that seems to be 5.19, and while timing changes (or whatever
> > other software updates) could have made it start trigger, this machine
> > has been pretty solid otgerwise.
> >
> > > Are you seeing any GPU page faults in your kernel log?
> >
> > Nothing even remotely like that "no-retry page fault" in that issue
> > report. Of course, if it happens just before the whole thing locks
> > up...
>
> Your chip is too old to support retry faults so it's likely you could
> be just seeing a GPU page fault followed by a hang.  Your chip also
> lacks a paging queue, so you would be affected by the TLB issue.


Okay I got my FIJI running Linus tree and netconsole to blow up like
this, running fedora 36 desktop, steam, firefox, and then I ran
poweroff over ssh.

[ 1234.778760] BUG: kernel NULL pointer dereference, address: 0000000000000088
[ 1234.778782] #PF: supervisor read access in kernel mode
[ 1234.778787] #PF: error_code(0x0000) - not-present page
[ 1234.778791] PGD 0 P4D 0
[ 1234.778798] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1234.778803] CPU: 7 PID: 805 Comm: systemd-journal Not tainted 6.0.0+ #2
[ 1234.778809] Hardware name: System manufacturer System Product
Name/PRIME X370-PRO, BIOS 5603 07/28/2020
[ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_sched]
[ 1234.778828] Code: aa 0f 1d ce e9 57 ff ff ff 48 89 d7 e8 9d 8f 3f
ce e9 4a ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 55 53
48 89 fb <48> 8b af 88 00 00 00 f0 ff 8d f0 00 00 00 48 8b 85 80 01 00
00 f0
[ 1234.778834] RSP: 0000:ffffabe680380de0 EFLAGS: 00010087
[ 1234.778839] RAX: ffffffffc04e9230 RBX: 0000000000000000 RCX: 0000000000000018
[ 1234.778897] RDX: 00000ba278e8977a RSI: ffff953fb288b460 RDI: 0000000000000000
[ 1234.778901] RBP: ffff953fb288b598 R08: 00000000000000e0 R09: ffff953fbd98b808
[ 1234.778905] R10: 0000000000000000 R11: ffffabe680380ff8 R12: ffffabe680380e00
[ 1234.778908] R13: 0000000000000001 R14: 00000000ffffffff R15: ffff953fbd9ec458
[ 1234.778912] FS:  00007f35e7008580(0000) GS:ffff95428ebc0000(0000)
knlGS:0000000000000000
[ 1234.778916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1234.778919] CR2: 0000000000000088 CR3: 000000010147c000 CR4: 00000000003506e0
[ 1234.778924] Call Trace:
[ 1234.778981]  <IRQ>
[ 1234.778989]  dma_fence_signal_timestamp_locked+0x6a/0xe0
[ 1234.778999]  dma_fence_signal+0x2c/0x50
[ 1234.779005]  amdgpu_fence_process+0xc8/0x140 [amdgpu]
[ 1234.779234]  sdma_v3_0_process_trap_irq+0x70/0x80 [amdgpu]
[ 1234.779395]  amdgpu_irq_dispatch+0xa9/0x1d0 [amdgpu]
[ 1234.779609]  amdgpu_ih_process+0x80/0x100 [amdgpu]
[ 1234.779783]  amdgpu_irq_handler+0x1f/0x60 [amdgpu]
[ 1234.779940]  __handle_irq_event_percpu+0x46/0x190
[ 1234.779946]  handle_irq_event+0x34/0x70
[ 1234.779949]  handle_edge_irq+0x9f/0x240
[ 1234.779954]  __common_interrupt+0x66/0x100
[ 1234.779960]  common_interrupt+0xa0/0xc0
[ 1234.779965]  </IRQ>
[ 1234.779968]  <TASK>
[ 1234.779971]  asm_common_interrupt+0x22/0x40
[ 1234.779976] RIP: 0010:finish_mkwrite_fault+0x22/0x110
[ 1234.779981] Code: 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 41 55 41
54 55 48 89 fd 53 48 8b 07 f6 40 50 08 0f 84 eb 00 00 00 48 8b 45 30
48 8b 18 <48> 89 df e8 66 bd ff ff 48 85 c0 74 0d 48 89 c2 83 e2 01 48
83 ea
[ 1234.779985] RSP: 0000:ffffabe680bcfd78 EFLAGS: 00000202

I'll see if I can dig any.
Dave.
