Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD448691D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBJK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjBJK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:56:20 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EFE212A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:56:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id x10so3462160pgx.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cdWQCDPvzRd237MkvtKB/bKfpfl+JQl03fgba3InAU=;
        b=MwQtNUNuKekmuKpkfeEbL04nByMWNHCHzBtNG5obtBP/x28MY8nurkdQ9kvu6r31qv
         ULB5P8v5Ij9muRFTwO7C1zbCP1bFi2+Y6DElDg0DNyKNBc8kZwq+vSHJH+FcdjPxaq9v
         CcpFxywBK2Jj3bXCrqZd/22KUZ24UjaRRvVkup39D4j+I3HbejHUj3HUPQmfBEdbejDL
         BUV3xT360CZfTczDbbEEFJ460CT0ELcrZWRm8TncWF50MD2zyAWZ7Cos6ffFcu+QKvNY
         2FOMsSuFBCwppyG+EuhVuz+kI1ywXJNEJgxPLF16yMkACK7WM3haGYGpzeSKZxI1ppw7
         vCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cdWQCDPvzRd237MkvtKB/bKfpfl+JQl03fgba3InAU=;
        b=4fSkgWopcW8GfQPO3kmEz1HgMeCVMsf3FwvAOsSGSnai+03utTIjcq9AdRz7tQKlcw
         szIWz6aNfOXz7kO5aS7ySKwFpjwPWJU65T8grXHUZZ4jlUuXUPeysLdWS2Ixpx9I++6Y
         WMLwXfSKkjZS0JGOnU6J8MXAyLSBWtm+/0cfJCJQlnK4Vl6caVFM+aFcepYUuWiggoVB
         d9tXtz4yCKF9TsAAxhf0Ia+XSqs2khfN2k+mg845KUV+2AhbDDn7Ch8qXn+MLnm8aP7k
         oP6S+E40BQDSj+ojyqlTGa7Th5kYT4cYwNsz0C8VHmhn389rUvnvNZHHDoqHz2d8N8QS
         iWOQ==
X-Gm-Message-State: AO0yUKWjv35fF2MIhYUis8MfYiGtWMMNg0KhZ5jqPQ2LLaO7w6lqFQ+M
        1RYB1jcVCtTbezAE2kGOQ2yAlSGfxOT+n/rdb2X7bA==
X-Google-Smtp-Source: AK7set9QsQrPNoQraqN4UdZF5um53qpwlXsOfo7iWPeSEHb5V/1abqp33RWaIqiGacwY0OJUvIblia89cXIk4hLMknM=
X-Received: by 2002:aa7:95b8:0:b0:593:9029:fcf6 with SMTP id
 a24-20020aa795b8000000b005939029fcf6mr3015553pfk.52.1676026577812; Fri, 10
 Feb 2023 02:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20230209152123.3186930-1-jaz@semihalf.com> <20230209152123.3186930-2-jaz@semihalf.com>
 <MN0PR12MB61010A5D6EA7526F88E85AEFE2D99@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61010A5D6EA7526F88E85AEFE2D99@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 10 Feb 2023 11:56:06 +0100
Message-ID: <CAH76GKORnd-6rfvtWHwGqeaHOO2G-HzFhYRqebp_1=XgLLDz9A@mail.gmail.com>
Subject: Re: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for S2Idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "dmy@semihalf.com" <dmy@semihalf.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "dbehr@google.com" <dbehr@google.com>,
        "zide.chen@intel.corp-partner.google.com" 
        <zide.chen@intel.corp-partner.google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "dtor@google.com" <dtor@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
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

czw., 9 lut 2023 o 19:25 Limonciello, Mario
<Mario.Limonciello@amd.com> napisa=C5=82(a):
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Grzegorz Jaszczyk <jaz@semihalf.com>
> > Sent: Thursday, February 9, 2023 09:21
> > To: linux-kernel@vger.kernel.org; rafael@kernel.org
> > Cc: dmy@semihalf.com; tn@semihalf.com; dbehr@google.com;
> > zide.chen@intel.corp-partner.google.com; seanjc@google.com;
> > upstream@semihalf.com; hdegoede@redhat.com; markgross@kernel.org;
> > dtor@google.com; Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> > pm@vger.kernel.org; x86@kernel.org; platform-driver-x86@vger.kernel.org=
;
> > Grzegorz Jaszczyk <jaz@semihalf.com>
> > Subject: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used f=
or
> > S2Idle
> >
> > Virtual PMC driver is meant for the guest VMs for the S2Idle
> > notification. Its purpose is to register S2Idle dev ops check handler,
> > which will evaluate ACPI _DSM just before the guest enters S2Idle power
> > state.
> >
> > This allows to trap on MMIO access done as a consequence of _DSM
> > evaluation and therefore notify the VMM about the guest entering S2Idle
> > state.
> >
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> > Changelog v1..v2:
> > - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
> > ---
> >  drivers/platform/x86/Kconfig    |  7 ++++
> >  drivers/platform/x86/Makefile   |  3 ++
> >  drivers/platform/x86/virt_pmc.c | 73
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+)
> >  create mode 100644 drivers/platform/x86/virt_pmc.c
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 5692385e2d26..b7c3f98031d7 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
> >         buttons below the display. This module adds an input device
> >         that delivers key events when these buttons are pressed.
> >
> > +config VIRT_PMC
> > +     tristate "Virt PMC"
> > +     depends on ACPI && SUSPEND
> > +     help
> > +       The Virtual PMC driver is meant for the guest VMs and its main
> > +       purpose is to notify about guest entering s2idle state.
> > +
> >  endif # X86_PLATFORM_DEVICES
> >
> >  config P2SB
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index 1d3d1b02541b..c4d3056cf4ea 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)               +=3D
> > intel_scu_wdt.o
> >  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)     +=3D intel_scu_ipcutil.o
> >  obj-$(CONFIG_X86_INTEL_LPSS)         +=3D pmc_atom.o
> >
> > +# Virtual PMC
> > +obj-$(CONFIG_VIRT_PMC)                       +=3D virt_pmc.o
> > +
> >  # Siemens Simatic Industrial PCs
> >  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)    +=3D simatic-ipc.o
> >
> > diff --git a/drivers/platform/x86/virt_pmc.c
> > b/drivers/platform/x86/virt_pmc.c
> > new file mode 100644
> > index 000000000000..daf9c9ed86e5
> > --- /dev/null
> > +++ b/drivers/platform/x86/virt_pmc.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Virtual Power Management Controller Driver
> > + *
> > + * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define ACPI_VIRT_PMC_DSM_UUID       "9ea49ba3-434a-49a6-be30-
> > 37cc55c4d397"
> > +#define ACPI_VIRT_PMC_NOTIFY 1
> > +
> > +static acpi_handle virt_pmc_handle;
> > +
> > +static void virt_pmc_s2idle_notify(void)
> > +{
> > +     union acpi_object *out_obj;
> > +     static guid_t dsm_guid;
> > +
> > +     guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> > +
> > +     out_obj =3D acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
> > +                                     0, ACPI_VIRT_PMC_NOTIFY, NULL);
> > +
> > +     acpi_handle_debug(virt_pmc_handle, "_DSM function %u
> > evaluation %s\n",
> > +                       ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" :
> > "failed");
> > +
> > +     ACPI_FREE(out_obj);
> > +}
> > +
> > +static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops =3D {
> > +     .check =3D virt_pmc_s2idle_notify,
> > +};
> > +
> > +static int virt_pmc_probe(struct platform_device *pdev)
> > +{
> > +     int err =3D 0;
> > +
> > +     virt_pmc_handle =3D ACPI_HANDLE(&pdev->dev);
> > +
> > +     err =3D acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
> > +     if (err)
> > +             dev_warn(&pdev->dev, "failed to register LPS0 sleep
> > handler\n");
> > +
>
> Besides registering, I would think you also want to have a query to the
> _DSM to determine what functions are available.  It could allow this to
> scale better if you're going to need to introduce a new function again
> later for a different reason.
>

Ok, I will add such a query. Thanks
