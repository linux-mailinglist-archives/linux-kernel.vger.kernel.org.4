Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38F73258B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbjFPDBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbjFPDBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:01:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4962D4D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:01:18 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D2B33F266
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686884476;
        bh=7ZYEzNSLdKSltgga6/IkaUhroC8RDaOM51oFnDh3NIk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=d1bf+lA29hHYOtVLrzOdd4p9GtPQ8bbvb3cf6gT8I84VaT+jXGJajvFHl8cmkWfvb
         2WXJNpxRv6MCAilaGhBNco0uVi1FR1PwMxxBePOfx6ojYdj7toC6jtHZ5HM8MzfdEL
         uEntzp65SdYu8FI2b7NK9kVI1XEoVCYKcwxz6eMJHQOrVGAc4rKmjbw3pRRUdoLxt7
         w6h4LKl5xV2QHOqzTxyqVDMMGfQIRvUnM7/sgCin3nMpPB+CFJv7TEB89gAQn2y40x
         abJ+k2b2srUynLSeAHeQYWhEcwJNz2zK0NBVt3XyWPQ2P2xF8O6vdA5A6HgL226TKS
         w1nYnkxu6tHyQ==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-558ae609dedso168577eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686884475; x=1689476475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZYEzNSLdKSltgga6/IkaUhroC8RDaOM51oFnDh3NIk=;
        b=cy+/xY9XoEcUMLfnbVm3S8GslofNdn3eO9leAiPyWr1WpJAs9uMe8LD8xWP2VtIELs
         yHFSQFTjgt8SBcIlVRM3MAXGvg/zL9YVnOkOorpZQL9gVKffqZzQ0ahHND+6NOgn8WM6
         DqgoT+Wixzya1JjFLBy6S3m1tUZzb+Le7kTkEiPJwRyMOa1yXUwmRFl04MtUwNdElzB0
         ohASjf5cVJBBTypbybkrAyiWCGGQ6416MFh8RnwhfhmpcEm7aEnwCgLntxu9yyYi6FS5
         SMz50fhpfOh3vwgF8bEbUeofYtHOYxW1bKuP/cWhFHm6bfw/Yc2Sjdfzi0KQQxGQUnYJ
         NhYw==
X-Gm-Message-State: AC+VfDwhYJ66bG2d5usCN2ggjjh0y2DaCSuDKmoCR63eosFn5ltYXEhO
        c5h0KE69lWvs3JwcLE/Wcc66II9RU+UrufxWHo4ZoMfudNgii/OnucLTDEAJTNa/Ta7B5uEuyHd
        4Gjq+iXyYd671juZS4tTI0PHVwly2yzXbZX9M/4FBoe88Aknrbkx/kpOYSA==
X-Received: by 2002:a05:6808:2110:b0:397:ee94:ab5f with SMTP id r16-20020a056808211000b00397ee94ab5fmr1246046oiw.14.1686884475146;
        Thu, 15 Jun 2023 20:01:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bd3LX9Rd0LwrYxKpDLtGRtKRLp4TTMxZczpmLqMQjzYQTKHQkXo7l1m+FoKaHvqELZEM5sAUatUEfl8C8jlU=
X-Received: by 2002:a05:6808:2110:b0:397:ee94:ab5f with SMTP id
 r16-20020a056808211000b00397ee94ab5fmr1246027oiw.14.1686884474904; Thu, 15
 Jun 2023 20:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com> <20230615171229.GA1478685@bhelgaas>
In-Reply-To: <20230615171229.GA1478685@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 16 Jun 2023 11:01:03 +0800
Message-ID: <CAAd53p7o496+WRgYggMcCOAGmA=tV0-M7HnURXGysFjCHxSuKg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:12=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> > When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> > enabled for that device. However, when the device is plugged preboot,
> > ASPM is enabled by default.
> >
> > The disparity happens because BIOS doesn't have the ability to program
> > ASPM on hotplugged devices.
> >
> > So enable ASPM by default for external connected PCIe devices so ASPM
> > settings are consitent between preboot and hotplugged.
> >
> > On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> > pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> > pcieport 0000:07:04.0: PCIe Bus Error: severity=3DCorrected, type=3DDat=
a Link Layer, (Receiver ID)
> > pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:07:04.0:    [ 7] BadDLLP
> >
> > The root cause is still unclear, but quite likely because the I225 on
> > the dock supports PTM, where ASPM timing is precalculated for the PTM.
> >
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217557
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 66d7514ca111..613b0754c9bb 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_st=
ate *link)
> >               /* Enable Everything */
> >               return ASPM_STATE_ALL;
> >       case POLICY_DEFAULT:
> > -             return link->aspm_default;
> > +             return dev_is_removable(&link->downstream->dev) ?
> > +                     link->aspm_capable :
> > +                     link->aspm_default;
>
> I'm a little hesitant because dev_is_removable() is a convenient test
> that covers the current issue, but it doesn't seem tightly connected
> from a PCIe architecture perspective.
>
> I think the current model of compile-time ASPM policy selection:
>
>   CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
>   CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
>   CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
>   CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */
>
> is flawed.  As far as I know, there's no technical reason we have to
> select this at kernel build-time.  I suspect the original reason was
> risk avoidance, i.e., we were worried that we might expose hardware
> defects if we enabled ASPM states that BIOS hadn't already enabled.
>
> How do we get out of that model?  We do have sysfs knobs that should
> cover all the functionality (set overall policy as above via
> /sys/module/pcie_aspm/parameters/policy; set device-level exceptions
> via /sys/bus/pci/devices/.../link/*_aspm).

Agree. Build-time policy can be obsoleted by boot-time argument.

>
> In my opinion, the cleanest solution would be to enable all ASPM
> functionality whenever possible and let users disable it if they need
> to for performance.  If there are device defects when something is
> enabled, deal with it via quirks, as we do for other PCI features.
>
> That feels a little risky, but let's have a conversation about where
> we want to go in the long term.  It's good to avoid risk, but too much
> avoidance leads to its own complexity and an inability to change
> things.

I think we should separate the situation into two cases:
- When BIOS/system firmware has the ability to program ASPM, honor it.
This applies to most "internal" PCI devices.
- When BIOS/system can't program ASPM, enable ASPM for whatever it's
capable of. Most notable case is Intel VMD controller, and this patch
for devices connected through TBT.

Enabling all ASPM functionality regardless of what's being
pre-programmed by BIOS is way too risky.
Disabling ASPM to workaround issues and defects are still quite common
among hardware manufacturers.

Kai-Heng

>
> Bjorn
