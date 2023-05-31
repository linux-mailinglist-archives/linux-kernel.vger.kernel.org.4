Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BC718550
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEaOtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjEaOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:49:11 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCC126;
        Wed, 31 May 2023 07:49:09 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-510f866ce78so1351044a12.1;
        Wed, 31 May 2023 07:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685544548; x=1688136548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q4/5yqfFJf4oODef+cqz5GsfK24kBHLnVyeg/jPlLU=;
        b=WdPrvGqg5CfrMQ6Ku5SLYUxyL8crtOgRmdOXjhrUC1UgpCQQWEYzeJHZBbCLxX+SJT
         a8if7id5KYlHEbS/iQLNLLzHFu/ympfKerY75Q3cC5fYRhQucqPHkgvK0F3nPl2Lk+eS
         lL6xvzTa5Bk6T90tTfJ7xcvhTIgXF2qs6NtPOD0Mp6CrDY1mWzvtpWbpW+v0Xdlxgl5w
         fjrujI25icE8VzhzlkzxN70J6h2zj2rHRTDCVG2DNhLcQCriq0DBq9WFZAXRFSE9o5zB
         wcj53VtphVA9V3eYCd537c3nY8DBZAAHDpQsVtby+Ml4Ox2ivwtoim3js1rlXgXK/PGL
         MaUw==
X-Gm-Message-State: AC+VfDywhEkyd4l+8Opr3e5umt2ChiI7bl+TMgPVN1e6TeBXPBDBAVA+
        1BklMoXxS1TU+sitC6YbuCGLaHn+YT4hPFd00sbeonfo
X-Google-Smtp-Source: ACHHUZ74xucedoUtS/KZZnbp/Y7yQ5NjbhZFomTy8vAp954OUjIvkLfc/skN7Yna+tLw+jo7pAgK6MR4IgGPVBm72XM=
X-Received: by 2002:a17:906:519d:b0:96f:56ab:c6a5 with SMTP id
 y29-20020a170906519d00b0096f56abc6a5mr4439128ejk.3.1685544547910; Wed, 31 May
 2023 07:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <5675481.DvuYhMxLoT@kreacher> <8222291.T7Z3S40VBb@kreacher> <d93db4e9-16b4-d20e-0769-d6f9b8826b64@intel.com>
In-Reply-To: <d93db4e9-16b4-d20e-0769-d6f9b8826b64@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 May 2023 16:48:55 +0200
Message-ID: <CAJZ5v0jQW345Ad=sY+T2Pwp22xvmSG6iNK+EOKtiaGYnC4CaMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ACPI: thermal: Drop redundant ACPI_TRIPS_REFRESH_DEVICES
 symbol
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 9:50 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 5/30/2023 5:44 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Drop the ACPI_TRIPS_REFRESH_DEVICES symbol which is redundant, because
> > ACPI_TRIPS_DEVICES can be used directly instead of it without any
> > drawbacks and rename the ACPI_TRIPS_REFRESH_THRESHOLDS to
> > ACPI_TRIPS_THRESHOLDS to make the code a bit more consistent.
> >
> > While at it, fix up some formatting white space used in the symbol
> > definitions.
> >
> > No functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/thermal.c |   13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/thermal.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/thermal.c
> > +++ linux-pm/drivers/acpi/thermal.c
> > @@ -238,12 +238,11 @@ static int acpi_thermal_set_cooling_mode
> >  #define ACPI_TRIPS_ACTIVE    BIT(3)
> >  #define ACPI_TRIPS_DEVICES   BIT(4)
> >
> > -#define ACPI_TRIPS_REFRESH_THRESHOLDS        (ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> > -#define ACPI_TRIPS_REFRESH_DEVICES   ACPI_TRIPS_DEVICES
> > +#define ACPI_TRIPS_THRESHOLDS        (ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> >
> > -#define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> > -                           ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE |  \
> > -                           ACPI_TRIPS_DEVICES)
> > +#define ACPI_TRIPS_INIT              (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> > +                              ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
> > +                              ACPI_TRIPS_DEVICES)
> >
> >  /*
> >   * This exception is thrown out in two cases:
> > @@ -906,13 +905,13 @@ static void acpi_thermal_notify(struct a
> >               acpi_queue_thermal_check(tz);
> >               break;
> >       case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> > -             acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
> > +             acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
> >               acpi_queue_thermal_check(tz);
> >               acpi_bus_generate_netlink_event(device->pnp.device_class,
> >                                               dev_name(&device->dev), event, 0);
> >               break;
> >       case ACPI_THERMAL_NOTIFY_DEVICES:
> > -             acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
> > +             acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
> >               acpi_queue_thermal_check(tz);
> >               acpi_bus_generate_netlink_event(device->pnp.device_class,
> >                                               dev_name(&device->dev), event, 0);
> >
>
> Looks good to me,
>
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>
> Also I wonder, whether I should wait with another revision of my patchset 'Remove .notify', since it will
> obviously need to be rebased on top of that changes.

No need to wait, I can deal with merge conflicts just fine.
