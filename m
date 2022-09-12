Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397535B5C92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiILOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiILOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:44:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBDA37F91
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:44:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so8511613pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=sukhJYoCgew7uoZYP/s1sBJhXsmmbRwwbMiHWcpxCak=;
        b=hq7HUPwF2uqkoez9+BCSmqUdhwINWlBe4+cCDRS8h8xUs38ncizG1c+KxCaOJplpbQ
         Rp4RxQhvwkZ0GzFcSQrVkj7Pz61BMy0jFgvLV+8Pag5VDLbXYFGY/yBOIOZv56sWbifI
         Hm8zxbxX0Iy3aEkx+X49AoosQlokWYultOhdLAwxeK1U26Iq2P4vWOIHbBZ8TTskTvwt
         QYfykZ2jvz1Exmz8gA+IStgOD4sAIHjPdCXVfG4hkzciCTa0s1OKTr5v8SLTiApu75HV
         sYlauglGjpmwBXQx9IBOyzPuZrQjifJlE3u7Lc+6dkwzIUko6mCs+ep6QEcJHhuGiFAN
         N5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sukhJYoCgew7uoZYP/s1sBJhXsmmbRwwbMiHWcpxCak=;
        b=Owu5l5JAWpmJY4nc13wuBbwmzrRiUeIeJNTSqo5YbXXH38Qw9dQsZEOYsY3UTJcFVg
         lLfJVX2vKywxBpO9Iq78x2hBRmVneO5NgEf6T1pKofBSl7/067GSoEITJgw2PAzvqa63
         86PoygWY+g8sysYDksjMa5GIzlOkwpyZFVjphSJA9Ns+alUIKYcB+QnMkdm7uHut6YIM
         CF1+Kqpvhwj1ypwXacbDR3T2aFkvaAnYNLc4ioJFmkM76YHxQINVlAtKCLFY9RcSmP1V
         iOp7TLjJo8O9KmKZqU+TYWVCS5KDw+L1c6eUQ2TM+UKTHIa+qE8SdLSQaYhj7AzOfrry
         uP7A==
X-Gm-Message-State: ACgBeo2C0Zvsh5W1sU0sRYExjdx9zbwzy6YGIDFi8H70MSp8A5PganVA
        I0+VmTAoxBBLpWwvyFLmAwc9KYipVacpK0hIetmWkQ==
X-Google-Smtp-Source: AA6agR7O6vDovGN26sVycLXUycIV5F7LTGHgOYYaxmyct5XRK9tv/Z6ndqSmcU2nA+P8JaEQXq6wd8nolTZXNjmGx40=
X-Received: by 2002:a63:201c:0:b0:434:8bd6:87e1 with SMTP id
 g28-20020a63201c000000b004348bd687e1mr24208310pgg.394.1662993851476; Mon, 12
 Sep 2022 07:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
 <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com> <CAH76GKMw2rAnQOSFqReG1sEC=sdncWOJHNXn-Rp2Gx1oUZR3ZQ@mail.gmail.com>
In-Reply-To: <CAH76GKMw2rAnQOSFqReG1sEC=sdncWOJHNXn-Rp2Gx1oUZR3ZQ@mail.gmail.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Mon, 12 Sep 2022 16:44:00 +0200
Message-ID: <CAH76GKMtMi-Bp9h_49t5TBwF1cT0AQE=4H+4E+a4SK+cJ4JJ6A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Gentle ping

Best regards,
Grzegorz

pon., 22 sie 2022 o 11:26 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=82=
(a):
>
> Hi Rafael,
>
> Could you please kindly comment on the above?
>
> Thank you in advance,
> Grzegorz
>
> =C5=9Br., 20 lip 2022 o 15:15 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=
=C5=82(a):
> >
> > wt., 19 lip 2022 o 20:09 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
> > >
> > > On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com> w=
rote:
> > > >
> > > > Currently the LPS0 prepare_late callback is aimed to run as the ver=
y
> > > > last thing before entering the S2Idle state from LPS0 perspective,
> > > > nevertheless between this call and the system actually entering the
> > > > S2Idle state there are several places where the suspension process =
could
> > > > be canceled.
> > >
> > > And why is this a problem?
> > >
> > > The cancellation will occur only if there is a wakeup signal that
> > > would otherwise cause one of the CPUs to exit the idle state.  Such a
> > > wakeup signal can appear after calling the new notifier as well, so
> > > why does it make a difference?
> >
> > It could also occur due to suspend_test. Additionally with new
> > notifier we could get notification when the system wakes up from
> > s2idle_loop and immediately goes to sleep again (due to e.g.
> > acpi_s2idle_wake condition not being met) - in this case relying on
> > prepare_late callback is not possible since it is not called in this
> > path.
> >
> > >
> > > > In order to notify VMM about guest entering suspend, extend the S2I=
dle
> > > > ops by new notify callback, which will be really invoked as a very =
last
> > > > thing before guest actually enters S2Idle state.
> > >
> > > It is not guaranteed that "suspend" (defined as all CPUs entering idl=
e
> > > states) will be actually entered even after this "last step".
> >
> > Since this whole patchset is aimed at notifying the host about a guest
> > entering s2idle state, reaching this step can be considered as a
> > suspend "entry point" for VM IMO. It is because we are talking about
> > the vCPU not the real CPU. Therefore it seems to me, that even if some
> > other vCPUs could still get some wakeup signal they will not be able
> > to kick (through s2idle_wake->swake_up_one(&s2idle_wait_head);) the
> > original vCPU which entered s2idle_loop, triggered the new notifier
> > and is halted due to handling vCPU exit (and was about to trigger
> > swait_event_exclusive). So it will prevent the VM's resume process
> > from being started.
> >
> > >
> > > > Additionally extend the acpi_s2idle_dev_ops by notify() callback so
> > > > any driver can hook into it and allow to implement its own notifica=
tion.
> > > >
> > > > Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/res=
tore
> > > > hooks is not an option since it will not allow to prevent race
> > > > conditions:
> > > > - VM0 enters s2idle
> > > > - host notes about VM0 is in s2idle
> > > > - host continues with system suspension but in the meantime VM0 exi=
ts
> > > > s2idle and sends notification but it is already too late (VM could =
not
> > > > even send notification on time).
> > >
> > > Too late for what?
> >
> > Too late to cancel the host suspend process, which thinks that the VM
> > is in s2idle state while it isn't.
> >
> > >
> > > > Introducing notify() as a very last step before the system enters S=
2Idle
> > > > together with an assumption that the VMM has control over guest
> > > > resumption allows preventing mentioned races.
> > >
> > > How does it do that?
> >
> > At the moment when VM triggers this new notifier we trap on MMIO
> > access and the VMM handles vCPU exit (so the vCPU is "halted").
> > Therefore the VMM could control when it finishes such handling and
> > releases the vCPU again.
> >
> > Maybe adding some more context will be helpful. This patchset was
> > aimed for two different scenarios actually:
> > 1) Host is about to enter the suspend state and needs first to suspend
> > VM with all pass-through devices. In this case the host waits for
> > s2idle notification from the guest and when it receives it, it
> > continues with its own suspend process.
> > 2) Guest could be a "privileged" one (in terms of VMM) and when the
> > guest enters s2idle state it notifies the host, which in turn triggers
> > the suspend process of the host.
> >
> > >
> > > It looks like you want suspend-to-idle to behave like S3 and it won't=
.
> >
> > In a way, yes, we compensate for the lack of something like PM1_CNT to
> > trap on for detecting that the guest is suspending.
> > We could instead force the guest to use S3 but IMO it is undesirable,
> > since it generally does make a difference which suspend mode is used
> > in the guest, s2idle or S3, e.g some drivers check which suspend type
> > is used and based on that behaves differently during suspend. One of
> > the example is:
> > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/am=
dgpu/amdgpu_drv.c#L2323
> > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/am=
dgpu/amdgpu_acpi.c#L1069
> > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/am=
dgpu/amdgpu_gfx.c#L583
> >
> > Thank you,
> > Grzegorz
