Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71426F0E45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbjD0WSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjD0WSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:18:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4554C12;
        Thu, 27 Apr 2023 15:18:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8eb8db083so91580561fa.3;
        Thu, 27 Apr 2023 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633903; x=1685225903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q32YBQfTAhgnMCbw6n/TgMYS+FbQgKW4a6+pzBzORvc=;
        b=gWt8g46D7hMHQU3nioTUXLpPHOuYkKmyktsFhjFCl9XyVfOaWfulLzCImRSYLoqOfD
         gkdWaIeGFYqy/db4xN+VS9FJArQyf5mfLUurQTcJ2OafOYRbTE5yWD9OEFVIxgYMWOTC
         7X9gxxyQLBGPEZvUPu1hxzxaz2tBRv3+zu0UiRByGL1SJTj0mbKF7OaCqg8piqmS3pYx
         jgpQnroR2Na7tvIq2fOyd/k5H7yY6+hl2fln/NSZDRqQlUMrG80jLMSR24IVvRhrSfLM
         r2Nlbis3Gf3Q2RPOm0sg+7R5NrjJUoF9mEUKZKUwnVkQvJgOj1sb7rGNuLdK50SE1YKr
         erVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633903; x=1685225903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q32YBQfTAhgnMCbw6n/TgMYS+FbQgKW4a6+pzBzORvc=;
        b=S7cI8keZpX6Ouy+WcRukQpcDSiJgG4s2/ixQt9mVv+iQAPglmHBrZt1IDQ2rDsOdrt
         V3WodBu7Y21uPSOJe89o8hHdRKjljDx2ISdbaxl6eew+ggKTKzqYoNmIQmYo9fdjsr++
         38bdf/6IYI1cmFRpolv6Il0BiOu8HNvPmI8oobU1tS2ggS2u55/o7h4RWE1MAfDBAe0B
         ko5JkXLTbpBNHcMegTAPNVG/DI6ghP14zZDpbe0887cldl3E49PC9CoF0mtJEbavOAbH
         CvygRy55Y2/tsi6N9e9NfstwDi/ujGfXr00Om/QgzHdpZ+kE1cKgrpARaOExbXDwlBzP
         lsug==
X-Gm-Message-State: AC+VfDxW6Nkr099TCGzfITFpN+T6283Sgylrf71WJNJnL4O2k3IzKMKB
        44da3NbvFMHo9Pr1aOsmzTjMb8XFLaC2S/YLjZiFPYZ9I8o=
X-Google-Smtp-Source: ACHHUZ4mqTV4sfNMk4mzre/a6s61v/DzX7uU5UzEht1AJCv/7pgivLZ4Jqfdoy2vrtF/yothJI5/Qeon4df4+zHOZaY=
X-Received: by 2002:a2e:9a83:0:b0:2a8:ae90:83d6 with SMTP id
 p3-20020a2e9a83000000b002a8ae9083d6mr1113261lji.48.1682633903109; Thu, 27 Apr
 2023 15:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-13-jorge.lopez2@hp.com>
 <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de>
In-Reply-To: <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 27 Apr 2023 17:17:57 -0500
Message-ID: <CAOOmCE8rpA=XvWBxcyRVu_gOHie3qN0E15Rs9bLfhb6tPZ7tyg@mail.gmail.com>
Subject: Re: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Apr 23, 2023 at 7:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
> >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attrib=
utes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c =
b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > new file mode 100644
> > index 000000000000..72952758ffe3
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to sure start object type attributes under
> > + * BIOS for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +#include <asm-generic/posix_types.h>
>
> Is the asm include needed?
> If yes, why not use linux/types.h?
>

Will change in Version 12

> > +
> > +#define LOG_MAX_ENTRIES              254
>
> A comment on how this values came to be would be good.
>

Done!

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
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
> > +                       LOG_MAX_ENTRIES);
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
> > +
> > +     // Get the number of event logs
> > +     ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > +                                HPWMI_SURESTART,
> > +                                &count, 1, sizeof(count));
> > +
> > +     /*
> > +      * The show() api will not work if the audit logs ever go
> > +      *  beyond 4KB
> > +      */
> > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > +             return -EFAULT;
>
> The error code seems not to match.
>

Changing error to -EINVAL

> Instead of not returning any data, why not show as many results as
> possible?
>

if count * LOG_ENTRY_SIZE > PAGE_SIZE then I prefer to return an error.
if the count is correct but a failure occurs while reading individual
audit logs then we will return a partial list of all audit logs
This changes will be included in Version 12

> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * We are guaranteed the buffer is 4KB so today all the event
> > +      * logs will fit
> > +      */
> > +
> > +     for (i =3D 0; ((i < count) & (ret >=3D 0)); i++) {
>
> &&
>
> Better yet, pull the condition ret >=3D 0 into the body, as an else-branc=
h
> for the existing check.
>

Done!

> > +             *buf =3D (i + 1);
>
> Isn't this directly overwritten by the query below?

buf input value indicates the audit log to be read hence the reason
why it is overwritten.
This is an expected behavior.
>
> > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > +                                        HPWMI_SURESTART,
> > +                                        buf, 1, 128);
> > +             if (ret >=3D 0)
> > +                     buf +=3D LOG_ENTRY_SIZE;
>
> So 128 bytes are read but only the first 16 bytes are preserved?
>
> The documentation says that each entry has 128 bytes in the file.
> And that they are separated by ";", which is not implemented.

The statement will be removed from documentation  (separated by ";")
audit log size is 16 bytes.
>
> Can the audit-log not contain all-zero bytes?
> If it does this would need to be a bin_attribute.

Bytes 16-127 are ignored and not used at this time.  If the audit log
changes, then the driver will need to change to accommodate the new
audit log size.
The audit log file cannot contain all zero bytes.
>
> > +     }
> > +
> > +     return (count * LOG_ENTRY_SIZE);
>
> No need for braces.

Done!
>
<snip>
