Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A849D72B8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjFLHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjFLHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:46:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696119B2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:46:01 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F216A3F375
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686555429;
        bh=SARDuX0ozM1dSrw1r+XdZ1aSpyhQuZmUUG6i83rAkzc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dv7qEN2/+WBE3GlPnw4MQ3232hxQg4S0dQyNzEJPE6PQFKPP7962beOG33up0ALs8
         /Ap/VIWHJUUla0gxKWN4OkiT2+R2OxiPkTu0v66NuNNXT+Mmbho+ARfL4/d7KiS8Ae
         34QqowCwT1HW35PR1fU8YhsOeqnjPmHUDgc0S5VlbJ9b44WQsO83EdOqBvbVK7BRdy
         Zf+E7KNmRlrgNuq46leC58Ix/uY0k/neBMAh2A29WQ5EfK//sxxDd5gbQiyMgNeGgm
         fSe18FZgPMDD7mwA4SwbzI178qhXt07DF6XncR2piZsfSCMjaNeUcHpRtI4dCwl6C7
         sVrjltHaT779A==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-543a25df980so1698946a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555427; x=1689147427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SARDuX0ozM1dSrw1r+XdZ1aSpyhQuZmUUG6i83rAkzc=;
        b=UtHQpXfBtE89LV8tISvhhSDCdqk8DvFonUb+h5OK/3NPMR/hTMOF2sNDdPJYyRulGS
         VNFXrteuBXIWt7j4U5Ca2aNhDrrS16/UyEN/fiaIZQBvRxF43VyyeGSMzrSHw28oDOXo
         vYEo8xnSNawBNhtzdbvjt0PmKv9uUkWsUYoEeWLwg8SzAaTx4G47kErtcSuwdvwHzeOb
         jtrJzdxTcPURhIU2OfqmH7Cv0ZYNuPiZxvIXXSKf3R/LkKhDxxxdqNTuuXo9fGtvA8S/
         XKIekUJjbBa+8MBq9zFLzrIbIwJSeq1a9aVlG6es7HQqebIDMCRsA4RX6cWZg37TDNij
         MpEg==
X-Gm-Message-State: AC+VfDzex2bzyXqQPWCgVeUlIEKUIpxiMLn8hUe/kBt0pH1TxK5hl2Dj
        tmLGkbXfDTAl4naSd7qD9hFyGG1a9bYdA5kXSyFXPb9pK28ch4MvvCPzWmzh5nCNEquQ8tv3zmT
        7HvWvCM6xAqmITVvSF+4bxabiXbPuqe6S3Txw/U1y1mXENV659eynECg55Q==
X-Received: by 2002:a17:90a:1a0a:b0:258:996c:a2e8 with SMTP id 10-20020a17090a1a0a00b00258996ca2e8mr7314701pjk.5.1686555427241;
        Mon, 12 Jun 2023 00:37:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Yj42CeU0uWY/ySQzUq50P4dnzJCgR3Qa5gLWoMOBy2SUVIWUXgk6mm5OGuSpj2WelHyVYhxK439rub4Zew/w=
X-Received: by 2002:a17:90a:1a0a:b0:258:996c:a2e8 with SMTP id
 10-20020a17090a1a0a00b00258996ca2e8mr7314672pjk.5.1686555426671; Mon, 12 Jun
 2023 00:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com> <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com> <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <4005a768-9e45-0707-509d-98ce0d2769bd@kernel.org> <0505654c-e487-6b91-57cf-fa7996f5c738@suse.de>
 <6957a93c-b933-9b08-2f9f-901c4782cd40@kernel.org>
In-Reply-To: <6957a93c-b933-9b08-2f9f-901c4782cd40@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Jun 2023 15:36:55 +0800
Message-ID: <CAAd53p5CsAAX5G1J2WH5N5JT5dZB_BD2AW8WL-S=pHZtGXr1sw@mail.gmail.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 3:22=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 6/12/23 15:09, Hannes Reinecke wrote:
> > On 6/12/23 05:09, Damien Le Moal wrote:
> >> On 6/11/23 00:03, Bart Van Assche wrote:
> >>> On 6/10/23 06:27, Bagas Sanjaya wrote:
> >>>> On 6/10/23 15:55, Pavel Machek wrote:
> >>>>>>> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/s=
how_bug.cgi?id=3D217530
> >>>>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD dri=
ve
> >>>>>>>
> >>>>>> The reporter had found the culprit (via bisection), so:
> >>>>>>
> >>>>>> #regzbot introduced: a19a93e4c6a98c
> >>>>> Maybe cc the authors of that commit?
> >>>>
> >>>> Ah! I forgot to do that! Thanks anyway.
> >>>
> >>> Hi Damien,
> >>>
> >>> Why does the ATA code call scsi_rescan_device() before system resume =
has
> >>> finished? Would ATA devices still work with the patch below applied?
> >>
> >> I do not know the PM code well at all, need to dig into it. But your p=
atch
> >> worries me as it seems it would prevent rescan of the device on a resu=
me, which
> >> can be an issue if the device has changed.
> >>
> >> I am not yet 100% clear on the root cause for this, but I think it com=
es from
> >> the fact that ata_port_pm_resume() runs before the sci device resume i=
s done, so
> >> with scsi_dev->power.is_suspended still true. And ata_port_pm_resume()=
 calls
> >> ata_port_resume_async() which triggers EH (which will do reset + resca=
n)
> >> asynchronously. So it looks like we have scsi device resume and libata=
 EH for
> >> rescan fighting each others for the scan mutex and device lock, leadin=
g to deadlock.
> >>
> >> Trying to recreate this issue now to confirm and debug further. But I =
suspect
> >> the solution to this may be best implemented in libata, not in scsi.
> >> This looks definitely related to this thread:
> >>
> >> https://lore.kernel.org/linux-scsi/7b553268-69d3-913a-f9de-28f8d45bdb1=
e@acm.org/
> >>
> >> Similaraly to your comment on that thread, having to look at
> >> dev->power.is_suspended is not ideal I think. What we need is to have =
ata and
> >> scsi pm resume be synchronized, but I am not yet 100% clear on the scs=
i layer side.
> >>
> > Which is my feeling, too.
> > libata runs rescan as part of the device discovery, so really it will
> > run after resume. And consequently resume really cannot wait for rescan
> > to finish.
> >
> > What I would be looking at is to decouple resume from libata device
> > rescan, and have resume to complete before libata EH runs.
>
> That is the case now, for the ata port at least, even though that is not =
super
> explicit, and not reliable. See ata_port_pm_resume(): I think that the ca=
ll to
> EH in ata_port_pm_resume() -> ata_port_resume_async() -> ata_port_request=
_pm()
> -> ata_port_schedule_eh() should instead use a sync resume, leading to a =
sync EH
> call.
>
> That EH execution essentially does ata_eh_handle_port_resume(), which cal=
ls into
> the adapter resume operation. That in itself does not do much beside some
> registers accesses to wakeup the port. There should be no issues doing th=
at
> synchronously.
>
> The problem is that after that is done, ata EH calls ata_std_error_handle=
r() ->
> ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() ->
> schedule_work(&(ap->scsi_rescan_task)). And the rescan work calls
> scsi_rescan_device() (yet in another context than EH) which causes the pr=
oblem
> when the scsi disk device has not been resumed yet (dev->power_is_suspend=
ed
> still true).
>
> So it really looks like the solution should be to have ata_scsi_dev_resca=
n()
> wait for the scsi device to resume first, but not sure how to do that wit=
h the
> pm API. Digging...

Probably use dpm_wait_for_children()? Right now it's an internal PM API.

Rafael,
What do you think?

Kai-Heng

>
> >
> > Cheers,
> >
> > Hannes
>
> --
> Damien Le Moal
> Western Digital Research
>
