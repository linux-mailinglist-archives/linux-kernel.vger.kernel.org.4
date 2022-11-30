Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635763D58E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiK3MZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiK3MZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:25:24 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C4673BBE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:25:22 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 136so2272029ybl.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDUZsQ4ebsI3B74ltAql+qgtgRR7G69xLxugWM4TCSc=;
        b=Zz8W2z9vEL93OLfsHNnUXDZS/TbxmIuKGQr91bg/GIfUoCS/uDdK8dJyqeDTgQImIp
         dn1mS7laR7RUdKdoshyPXeDyeq4h3fM4OQNpBh27IG8d6QZ7+jdzcWG11Ryznwx8X0mP
         CgHxAGEorZEBnpaWLsjLjQr9+gfeVWcJ1Ewg13Rsbzdd1jyw0wp23kupb5lvpN17zxqL
         9uB5SRZdyDnLBoGSGffrXXi8DQZYaGdGE0nJQZlAjJy7pYw9/C9EOu2TH8fZTzYKsgqv
         b9nB6PETo6wi8y0WJY+TbFEQHUfl/f3D1bu5+8eptsmcMwNKqV/tf90YtX3HwDI1ikgZ
         UMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDUZsQ4ebsI3B74ltAql+qgtgRR7G69xLxugWM4TCSc=;
        b=o3v3j1VgacjXPTukW3VK0G7mlVWaTlhG0DSe62Wxv/SpxQgoeUbnHJqM1dCcn4ccih
         gB2zzYv0k65eY7kiG0EmFJR0TVJ7pVMFRofIwqxXJCtPZji7Hmj3dCmAz7attx6lnd0F
         fEOiIBVWrj+aPuMfKwj1E3Lt5kNh62VHDAFnZIxDaxTiviotV2BUWiq/pQr2oaNPYUHx
         +lDcy8hxCXynyW/dpG291IvKvbaNjk7sxz7EQnb3YxRhQnDhpRGbQSFwU227Y4FhDfjk
         oKV7ujM6ROoCtt+7+Y9WLIoPwboEIH0VU7KFLklHJF5hCB7i3tFwaItTyJImppokuFT6
         eAMg==
X-Gm-Message-State: ANoB5plvEySbzkSmWFwQmxmgLnSMNd+ftTSxsWHBaMElfF1fBO8+pGvT
        3/0lf6PdmhdcqEiggxlk3yndE479PoU8BRs+3RReow==
X-Google-Smtp-Source: AA0mqf71AmTAlt/1T7vTfWrjGkl6POAPk/AIdjczxzTs5xx2OOEwTB7XD9veH6gpmTkJZ7Ox1kbJ5H7WNEnnOwK1hNY=
X-Received: by 2002:a05:6902:4d3:b0:6ca:10da:acb7 with SMTP id
 v19-20020a05690204d300b006ca10daacb7mr43561380ybs.475.1669811121633; Wed, 30
 Nov 2022 04:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
 <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
 <CAH76GKMw2rAnQOSFqReG1sEC=sdncWOJHNXn-Rp2Gx1oUZR3ZQ@mail.gmail.com> <CAH76GKMtMi-Bp9h_49t5TBwF1cT0AQE=4H+4E+a4SK+cJ4JJ6A@mail.gmail.com>
In-Reply-To: <CAH76GKMtMi-Bp9h_49t5TBwF1cT0AQE=4H+4E+a4SK+cJ4JJ6A@mail.gmail.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Wed, 30 Nov 2022 13:25:10 +0100
Message-ID: <CAH76GKMpnCmrbUfo8oQ1C4ej_iNmSw=xBHb8UZYy5Z8vQwcCzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Kindly reminder about this topic.

BTW I've noticed that in the meantime v. similar patch was merged but
aimed for debugging purposes [1] (it uses s/notify/check and invokes
the callback a bit earlier just before s2idle_entry).
Perhaps combining Mario's [1] with aligned to it patch #2 of this
series [2] could be used and accepted as s2idle notifications method?

[1] https://patchwork.kernel.org/project/linux-pm/patch/20220829162953.5947=
-2-mario.limonciello@amd.com
[2] https://patchwork.kernel.org/project/linux-pm/patch/20220707125329.3782=
77-3-jaz@semihalf.com/

Best regards,
Grzegorz




pon., 12 wrz 2022 o 16:44 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=82=
(a):
>
> Hi Rafael,
>
> Gentle ping
>
> Best regards,
> Grzegorz
>
> pon., 22 sie 2022 o 11:26 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=
=82(a):
> >
> > Hi Rafael,
> >
> > Could you please kindly comment on the above?
> >
> > Thank you in advance,
> > Grzegorz
> >
> > =C5=9Br., 20 lip 2022 o 15:15 Grzegorz Jaszczyk <jaz@semihalf.com> napi=
sa=C5=82(a):
> > >
> > > wt., 19 lip 2022 o 20:09 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
> > > >
> > > > On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com>=
 wrote:
> > > > >
> > > > > Currently the LPS0 prepare_late callback is aimed to run as the v=
ery
> > > > > last thing before entering the S2Idle state from LPS0 perspective=
,
> > > > > nevertheless between this call and the system actually entering t=
he
> > > > > S2Idle state there are several places where the suspension proces=
s could
> > > > > be canceled.
> > > >
> > > > And why is this a problem?
> > > >
> > > > The cancellation will occur only if there is a wakeup signal that
> > > > would otherwise cause one of the CPUs to exit the idle state.  Such=
 a
> > > > wakeup signal can appear after calling the new notifier as well, so
> > > > why does it make a difference?
> > >
> > > It could also occur due to suspend_test. Additionally with new
> > > notifier we could get notification when the system wakes up from
> > > s2idle_loop and immediately goes to sleep again (due to e.g.
> > > acpi_s2idle_wake condition not being met) - in this case relying on
> > > prepare_late callback is not possible since it is not called in this
> > > path.
> > >
> > > >
> > > > > In order to notify VMM about guest entering suspend, extend the S=
2Idle
> > > > > ops by new notify callback, which will be really invoked as a ver=
y last
> > > > > thing before guest actually enters S2Idle state.
> > > >
> > > > It is not guaranteed that "suspend" (defined as all CPUs entering i=
dle
> > > > states) will be actually entered even after this "last step".
> > >
> > > Since this whole patchset is aimed at notifying the host about a gues=
t
> > > entering s2idle state, reaching this step can be considered as a
> > > suspend "entry point" for VM IMO. It is because we are talking about
> > > the vCPU not the real CPU. Therefore it seems to me, that even if som=
e
> > > other vCPUs could still get some wakeup signal they will not be able
> > > to kick (through s2idle_wake->swake_up_one(&s2idle_wait_head);) the
> > > original vCPU which entered s2idle_loop, triggered the new notifier
> > > and is halted due to handling vCPU exit (and was about to trigger
> > > swait_event_exclusive). So it will prevent the VM's resume process
> > > from being started.
> > >
> > > >
> > > > > Additionally extend the acpi_s2idle_dev_ops by notify() callback =
so
> > > > > any driver can hook into it and allow to implement its own notifi=
cation.
> > > > >
> > > > > Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/r=
estore
> > > > > hooks is not an option since it will not allow to prevent race
> > > > > conditions:
> > > > > - VM0 enters s2idle
> > > > > - host notes about VM0 is in s2idle
> > > > > - host continues with system suspension but in the meantime VM0 e=
xits
> > > > > s2idle and sends notification but it is already too late (VM coul=
d not
> > > > > even send notification on time).
> > > >
> > > > Too late for what?
> > >
> > > Too late to cancel the host suspend process, which thinks that the VM
> > > is in s2idle state while it isn't.
> > >
> > > >
> > > > > Introducing notify() as a very last step before the system enters=
 S2Idle
> > > > > together with an assumption that the VMM has control over guest
> > > > > resumption allows preventing mentioned races.
> > > >
> > > > How does it do that?
> > >
> > > At the moment when VM triggers this new notifier we trap on MMIO
> > > access and the VMM handles vCPU exit (so the vCPU is "halted").
> > > Therefore the VMM could control when it finishes such handling and
> > > releases the vCPU again.
> > >
> > > Maybe adding some more context will be helpful. This patchset was
> > > aimed for two different scenarios actually:
> > > 1) Host is about to enter the suspend state and needs first to suspen=
d
> > > VM with all pass-through devices. In this case the host waits for
> > > s2idle notification from the guest and when it receives it, it
> > > continues with its own suspend process.
> > > 2) Guest could be a "privileged" one (in terms of VMM) and when the
> > > guest enters s2idle state it notifies the host, which in turn trigger=
s
> > > the suspend process of the host.
> > >
> > > >
> > > > It looks like you want suspend-to-idle to behave like S3 and it won=
't.
> > >
> > > In a way, yes, we compensate for the lack of something like PM1_CNT t=
o
> > > trap on for detecting that the guest is suspending.
> > > We could instead force the guest to use S3 but IMO it is undesirable,
> > > since it generally does make a difference which suspend mode is used
> > > in the guest, s2idle or S3, e.g some drivers check which suspend type
> > > is used and based on that behaves differently during suspend. One of
> > > the example is:
> > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c#L2323
> > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/=
amdgpu/amdgpu_acpi.c#L1069
> > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c#L583
> > >
> > > Thank you,
> > > Grzegorz
