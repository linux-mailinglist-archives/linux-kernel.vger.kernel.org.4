Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59271A362
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjFAPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFAPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:55:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82A19D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:55:37 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E02E3F554
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685634936;
        bh=0jAabHqdSvSI81GcjIi2ShyL+hAnr5Nv9d2pTfh5lts=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aqB5WeaqfzZByzeT6mHsWKeIF55yloO8OKRRd8eJxEtLm9aYtrZjUO1kELWZayOuM
         p7xgqxLT05I+YKlweMNJ0zoVCASzgQeiBOqiMFlhuS7gSDQNV6Mw1ir3bXsWxs3WdK
         t9A+KwTGpfcDV4aZF2z+RJX36y9srYeUu4fVNrYeoRaeSD4rHx+28EY+YOKI5otXF1
         wLuTLMndTZd/dwzNWeZ2oYwznwkE6uxN5SZq+HxNxIfnau3o2JpHMD6P5JM1fGRy0k
         w0I/4uNNOe/nWKbvArjtxmRn5ng6bbX9CEmXsMZyMP7mnZ8MbJ+QUAcJs6LhPbgi+j
         /9lQsOhKmKCkA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64d413b25caso1085599b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634933; x=1688226933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jAabHqdSvSI81GcjIi2ShyL+hAnr5Nv9d2pTfh5lts=;
        b=fL8Gu6nCxv8SfyRcM6VhP9UDywMbUXfLXkW5fTdJ4o7FSEV7TjQKoIfr9uKn/N+hqY
         7AK8SU8TeEzDM2SrSR03X0j3Z+Q34cqZJ5wGfKtC9dK31+EjPqmW+CQvqXTYRxKQ0Cz0
         p3cG5KYf/YlgbRvzUpJHZcT6ZePwfYK9xB5SQZedL/z724apFBTM9jcYnWjIgF44KqOT
         epvgfH4i2zHxClXzzZ6WdEpFLwwJe+TSGrolGH2CGWS7sIdCj9TJIzAqoFjnQhcVOXPL
         MaM2lasZFG2fADtEtRrfXgk9SETTO08BCA2nRRG23NVs+0YAVk96ulbb2x/UKJbU29Cx
         hVgQ==
X-Gm-Message-State: AC+VfDyhPtAaxCpSrKRuQ8M+i550VkIFTZlUIctjnDNh3MnxZxVQPEbT
        NCDfcacUqW5rU/ZGhivq7op9PCzWFZt52usYEDUWcsQpPfSxI5lD9WG/97cMCD3tPR8Wu0map/0
        7LOqXddCddU7a7rU62dvyKCKOb7WPJ4s6MC4AN1tGLw/9kQhsM067eUFFs43AqTv59Ekb
X-Received: by 2002:a05:6a20:8f04:b0:106:c9b7:c93d with SMTP id b4-20020a056a208f0400b00106c9b7c93dmr12612835pzk.19.1685634932906;
        Thu, 01 Jun 2023 08:55:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pvvJJKpMvAFbtIuz7/+acgXHck5G0WosfwFB94/V2cO+3iqB/cNFrT2JZeoiXuxJej081VjB1P5xpca6/ccI=
X-Received: by 2002:a05:6a20:8f04:b0:106:c9b7:c93d with SMTP id
 b4-20020a056a208f0400b00106c9b7c93dmr12612804pzk.19.1685634932503; Thu, 01
 Jun 2023 08:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230502150435.423770-1-kai.heng.feng@canonical.com>
 <20230502150435.423770-2-kai.heng.feng@canonical.com> <8eea2352-1d4f-aa3a-7c86-9306adb0aaae@kernel.org>
In-Reply-To: <8eea2352-1d4f-aa3a-7c86-9306adb0aaae@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 1 Jun 2023 23:55:21 +0800
Message-ID: <CAAd53p7H2C+LenmzynRHqnxd-qgc2+p9ZLKidVUOAtXMyU2rmQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ata: libata: Defer rescan on suspended device
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 5:23=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 2023/05/03 0:04, Kai-Heng Feng wrote:
> > During system resume, if an EH is schduled after ATA host is resumed
> > (i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
> > fully resumed, the device_lock hold by scsi_rescan_device() is never
> > released so the dpm_resume() of the disk is blocked forerver.
> >
> > That's because scsi_attach_vpd() is expecting the disk device is in
> > operational state, as it doesn't work on suspended device.
> >
> > To avoid such deadlock, defer rescan if the disk is still suspended so
> > the resume process of the disk device can proceed. At the end of the
> > resume process, use the complete() callback to schedule the rescan task=
.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v4:
> >  - No change.
> >
> > v3:
> >  - New patch to resolve undefined pm_suspend_target_state.
> >
> > v2:
> >  - Schedule rescan task at the end of system resume phase.
> >  - Wording.
> >
> >  drivers/ata/libata-core.c | 11 +++++++++++
> >  drivers/ata/libata-eh.c   | 11 +++++++++--
> >  include/linux/libata.h    |  1 +
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 8bf612bdd61a..bdd244bdb8a2 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -5093,6 +5093,16 @@ static int ata_port_pm_poweroff(struct device *d=
ev)
> >       return 0;
> >  }
> >
> > +static void ata_port_pm_complete(struct device *dev)
> > +{
> > +     struct ata_port *ap =3D to_ata_port(dev);
> > +
> > +     if (ap->pflags & ATA_PFLAG_DEFER_RESCAN)
> > +             schedule_work(&(ap->scsi_rescan_task));
> > +
> > +     ap->pflags &=3D ~ATA_PFLAG_DEFER_RESCAN;
>
> Is this called with the port lock held ? Otherwise, there is a race with
> ata_eh_revalidate_and_attach() and we may end up never actually revalidat=
ing the
> drive. At the very least, I think that ATA_PFLAG_DEFER_RESCAN needs to be
> cleared before calling schedule_work().

OK. Maybe all of these are unnecessary if the rescanning can wait for
disk device to be resumed.

>
> > +}
> > +
> >  static const unsigned int ata_port_resume_ehi =3D ATA_EHI_NO_AUTOPSY
> >                                               | ATA_EHI_QUIET;
> >
> > @@ -5158,6 +5168,7 @@ static const struct dev_pm_ops ata_port_pm_ops =
=3D {
> >       .thaw =3D ata_port_pm_resume,
> >       .poweroff =3D ata_port_pm_poweroff,
> >       .restore =3D ata_port_pm_resume,
> > +     .complete =3D ata_port_pm_complete,
> >
> >       .runtime_suspend =3D ata_port_runtime_suspend,
> >       .runtime_resume =3D ata_port_runtime_resume,
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index a6c901811802..0881b590fb7e 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/export.h>
> >  #include <linux/pci.h>
> > +#include <linux/suspend.h>
> >  #include <scsi/scsi.h>
> >  #include <scsi/scsi_host.h>
> >  #include <scsi/scsi_eh.h>
> > @@ -2983,8 +2984,14 @@ static int ata_eh_revalidate_and_attach(struct a=
ta_link *link,
> >                        */
> >                       ehc->i.flags |=3D ATA_EHI_SETMODE;
> >
> > -                     /* schedule the scsi_rescan_device() here */
> > -                     schedule_work(&(ap->scsi_rescan_task));
> > +                     /* Schedule the scsi_rescan_device() here.
>
> Code style: please start multi-line comment with a line starting with "/*=
"
> without text after it.

OK. Will do.

>
> > +                      * Defer the rescan if it's in process of
> > +                      * suspending or resuming.
> > +                      */
> > +                     if (pm_suspend_target_state !=3D PM_SUSPEND_ON)
>
> Why ? Shouldn't this be "pm_suspend_target_state =3D=3D PM_SUSPEND_ON" ? =
Because if
> the device is already resumed, why would we need to defer the rescan ?

"pm_suspend_target_state !=3D PM_SUSPEND_ON" means the system is not
"ON" state. For this particular issue, it means the system is still in
resume process.

>
> > +                             ap->pflags |=3D ATA_PFLAG_DEFER_RESCAN;
> > +                     else
> > +                             schedule_work(&(ap->scsi_rescan_task));
> >               } else if (dev->class =3D=3D ATA_DEV_UNKNOWN &&
> >                          ehc->tries[dev->devno] &&
> >                          ata_class_enabled(ehc->classes[dev->devno])) {
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index 311cd93377c7..1696c9ebd168 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -189,6 +189,7 @@ enum {
> >       ATA_PFLAG_UNLOADING     =3D (1 << 9), /* driver is being unloaded=
 */
> >       ATA_PFLAG_UNLOADED      =3D (1 << 10), /* driver is unloaded */
> >
> > +     ATA_PFLAG_DEFER_RESCAN  =3D (1 << 16), /* peform deferred rescan =
on system resume */
>
> Do we really need a new flag ? Can't we use ATA_PFLAG_PM_PENDING correctl=
y ?
> From the rather sparse commit message description, it sounds like this fl=
ag is
> being cleared too early. Not sure though. Need to dig further into this.

Defer clearing ATA_PFLAG_PM_PENDING doesn't seem to be trivial.
I'll send a new version which IMO is a lot simpler.

Kai-Heng

>
> >       ATA_PFLAG_SUSPENDED     =3D (1 << 17), /* port is suspended (powe=
r) */
> >       ATA_PFLAG_PM_PENDING    =3D (1 << 18), /* PM operation pending */
> >       ATA_PFLAG_INIT_GTM_VALID =3D (1 << 19), /* initial gtm data valid=
 */
>
> --
> Damien Le Moal
> Western Digital Research
>
