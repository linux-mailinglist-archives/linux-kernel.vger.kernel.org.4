Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B86FE719
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjEJWOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEJWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:14:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE972B7;
        Wed, 10 May 2023 15:14:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f00d41df22so43668088e87.1;
        Wed, 10 May 2023 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683756849; x=1686348849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F12xtUUbHfnnIPOcV6kMlGj3VIf41Mi5l3K4OiMlRYE=;
        b=adGfu62pua9jfHtulZjBTNr37OcBgkpkp9PpMc0Uw8KhqvMS5dQiaE0ufS4ObFfZx6
         vZav3Vexft6IWm7qXaulrJFyZKDoH0c0SQ9wSo3UDia90JKJ13NogFQyJncoz49YKvSn
         ha3eTzoe0ttL4En5CZbBIDKnvPBsRiSb8c/V8eIwXthhtKhb2vPT12X6aNHr8VggNYBe
         pL/cvCXv+epo+m6IH9irobcG9yslbnNBhzqKsCYK8ON6r5eFIx9PT2jYy1Oo5W7ry/gn
         bz55J79U8gWrojppaO0u577h6lHllFvIxULq2iJ53X7UyhurSkgx4yaVEbQ8VcGZRJFx
         Z5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756849; x=1686348849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F12xtUUbHfnnIPOcV6kMlGj3VIf41Mi5l3K4OiMlRYE=;
        b=kOy/e8ooJhR9bOxV5hzk3u1PkiRtse02le0Plg/jQwJJQen8PH2vQFBltYUYmLZDRz
         fFLbM8qDRz/cznVUM2DBMXd80/R8/GMLWeriySV1sTDDgQPs9kBWxnHG8DkFmT7jlfGJ
         J6bmjhL298haJM74Y+rUp5bSXHIpLNfN6n6uvWgxnSt45eCH5kNcgcFGBtW8ZKknwuNh
         o9p/c6V1WgYVLr6j5+NOAHFjGcX/vuNyMVbDFu5N6iP+LQPOT4h9oNDhj7he0K+HJjBZ
         LhoAhrg2N1CyDgW9IgBabQ5z3gplrylGpswV0RA498wfX9nVKd7k13/hvr1WrHqQXFtI
         RrkQ==
X-Gm-Message-State: AC+VfDyWR44Y3StflJPerfWkL9Ov4UWIOjThn9JptY7Jqbe/+Ltx0UDk
        WOmk+NiJijr0AIPZm2vab0h7Tb7ydyo5Jaep6RWc1jgA
X-Google-Smtp-Source: ACHHUZ6yap2uHAjTn0ge4LVO4wQlRyrseuOWr4icmdg/eT2743XxvrxZt2KzjZbuhO4+HSBB0GQoz9HBok78VplGW5s=
X-Received: by 2002:a05:6512:3990:b0:4ef:ef1d:a987 with SMTP id
 j16-20020a056512399000b004efef1da987mr2211186lfu.25.1683756849396; Wed, 10
 May 2023 15:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-12-jorge.lopez2@hp.com>
 <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com>
In-Reply-To: <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 17:13:40 -0500
Message-ID: <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com>
Subject: Re: [PATCH v12 11/13] HP BIOSCFG driver - surestart-attributes
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 8:57=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 5 May 2023, Jorge Lopez wrote:
>
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
> >
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> >
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new
> > documentation cover HP-specific firmware sysfs attributes such Secure
> > Platform Management and Sure Start. Each section provides security
> > feature description and identifies sysfs directories and files exposed
> > by the driver.
> >
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> >
> > HP Commercial notebooks have several BIOS settings that control its
> > behaviour and capabilities, many of which are related to security.
> > To prevent unauthorized changes to these settings, the system can
> > be configured to use a cryptographic signature-based authorization
> > string that the BIOS will use to verify authorization to modify the
> > setting.
> >
> > Linux Security components are under development and not published yet.
> > The only linux component is the driver (hp bioscfg) at this time.
> > Other published security components are under Windows.
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 ++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attrib=
utes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c =
b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > new file mode 100644
> > index 000000000000..b627c324f6a6
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to sure start object type attributes under
> > + * BIOS for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +#include <linux/types.h>
> > +
> > +/* Maximum number of log entries supported when log entry size is 16
> > + * bytes.  This value is calculated by dividing 4096 (page size) by
> > + * log entry size.
> > + */
> > +#define LOG_MAX_ENTRIES              254
> > +
> > +/*
> > + * Current Log entry size.  This value size will change in the
> > + * future. The driver reads a total of 128 bytes for each log entry
> > + * provided by BIOS but only the first 16 bytes are used/read.
> > + */
> > +#define LOG_ENTRY_SIZE               16
> > +
> > +/*
> > + * audit_log_entry_count_show - Reports the number of
> > + *                           existing audit log entries available
> > + *                           to be read
> > + */
> > +static ssize_t audit_log_entry_count_show(struct kobject *kobj,
> > +                                       struct kobj_attribute *attr, ch=
ar *buf)
> > +{
> > +     int ret;
> > +     u32 count =3D 0;
> > +
> > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > +                                HPWMI_SURESTART,
> > +                                &count, 1, sizeof(count));
> > +
>
> Extra newline.
Done!
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
> > +                       LOG_MAX_ENTRIES);
>
> Why 3 values instead of 1?
This version of BIOS only returns the number of audit log events available.
The other two values are the current log entry size which today is
hardcoded.  This will change in future when BIOS returns the log entry
size.
>
> > +}
> > +
> > +/*
> > + * audit_log_entries_show() - Return all entries found in log file
> > + */
> > +static ssize_t audit_log_entries_show(struct kobject *kobj,
> > +                                   struct kobj_attribute *attr, char *=
buf)
> > +{
> > +     int ret;
> > +     int i;
> > +     u32 count =3D 0;
> > +     u8 audit_log_buffer[128];
> > +
> > +     // Get the number of event logs
> > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > +                                HPWMI_SURESTART,
> > +                                &count, 1, sizeof(count));
> > +
>
> Extra newline.
Done!
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * The show() api will not work if the audit logs ever go
> > +      *  beyond 4KB
>
> Extra space.
Done!
>
> > +      */
> > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > +             return -EIO;
> > +
> > +     /*
> > +      * We are guaranteed the buffer is 4KB so today all the event
> > +      * logs will fit
> > +      */
> > +     for (i =3D 0; i < count; i++) {
> > +             audit_log_buffer[0] =3D (i + 1);
>
> Extra parenthesis.
Done!
>
> > +
> > +             /*
> > +              * read audit log entry at a time. 'buf' input value
> > +              * provides  the audit log entry to be read.  On
>
> Extra spaces.
Done!
>
> > +              * input, Byte 0 =3D Audit Log entry number from
> > +              * beginning (1..254)
> > +              * Entry number 1 is the newest entry whereas the
> > +              * highest entry number (number of entries) is the
> > +              * oldest entry.
> > +              */
> > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > +                                        HPWMI_SURESTART,
> > +                                        audit_log_buffer, 1, 128);
> > +
> > +             if (ret >=3D 0 && (LOG_ENTRY_SIZE * i) < PAGE_SIZE) {
>
> Can the second condition ever fail?
>
Only in the event BIOS data is corrupted.

> > +                     memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> > +                     buf +=3D LOG_ENTRY_SIZE;
> > +             } else {
> > +                     /*
> > +                      * Encountered a failure while reading
> > +                      * individual logs. Only a partial list of
> > +                      * audit log will be returned.
> > +                      */
> > +                     count =3D i + 1;
> > +                     break;
> > +             }
>
> Reverse order, do error handling with break first.
Done!
>
> Why not return i * LOG_ENTRY_SIZE directly (or at the end), no need to
> tweak count?

Done!
>
> > +     }
> > +
> > +     return count * LOG_ENTRY_SIZE;
> > +}
> > +
> > +static struct kobj_attribute sure_start_audit_log_entry_count =3D __AT=
TR_RO(audit_log_entry_count);
> > +static struct kobj_attribute sure_start_audit_log_entries =3D __ATTR_R=
O(audit_log_entries);
> > +
> > +static struct attribute *sure_start_attrs[] =3D {
> > +     &sure_start_audit_log_entry_count.attr,
> > +     &sure_start_audit_log_entries.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group sure_start_attr_group =3D {
> > +     .attrs =3D sure_start_attrs,
> > +};
> > +
> > +void exit_sure_start_attributes(void)
> > +{
> > +     sysfs_remove_group(bioscfg_drv.sure_start_attr_kobj,
> > +                        &sure_start_attr_group);
> > +}
> > +
> > +int populate_sure_start_data(struct kobject *attr_name_kobj)
> > +{
> > +     bioscfg_drv.sure_start_attr_kobj =3D attr_name_kobj;
> > +     return sysfs_create_group(attr_name_kobj, &sure_start_attr_group)=
;
> > +}
> >
>
> --
>  i.
