Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6216AA6AD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCDAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCDAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:53:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146534F6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:53:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p6so4634972plf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677891210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGkibq11R0+cziQFgAfpVxyjHtQQejqAPnK5ogtO+E4=;
        b=Soxx/UVvTT780yvRV/mK4If7cnARd+X5KgqxLQpQUX4GF3AITOg7a3EHlkYWTEqA16
         F56/HQF3qYwI86Jqe7cgGJUiFV+PLE6mnfQJu2CkEEaY74tKeqbQYceoGCM2q2ruNZZB
         QT/QcZ5oObsOEvTBj3T8r6tFMawHVlk+nQDE2MeXuTds2UeWMJ8JOcssbJ8X2EtE6MYk
         vL2foikSutbenRe/aMcg1xtS5yZVBBk2gRln7zZnBJpKT+LUKJvSpA1S2MLhaFpOR2Ee
         CAw7vVDR0lqk+j+7ug3ZuwsllmLgj+wj66TRDhuc2WQNt57NZ0CoM9RTrerc7ws5WLp4
         Jz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677891210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkibq11R0+cziQFgAfpVxyjHtQQejqAPnK5ogtO+E4=;
        b=FhRVDH0GTfeQn8ui6NTgFmsWTBjaqv/q7jpLsAlbwzJGmuYsvcf4vN/t+nWfmrMLYo
         1MyJQzvvbP/fsi0QW+uQE5qvlLLCr8oD5Ero4y0qlivzE+zKemnhbuhLTG58kgGHx8Lp
         8A6k8exIp1YXfAJWCkk/UdnKF0Nn0M9+O28uUleq29XUZy9br2BWE4Q4Y7EJfxI2wmRM
         O33z+7KPxnayQuQjDy65S2aee1lV2x/zLH8RUyC/NMJttCKtNwAhq21B13eD7q9pDGZE
         06yiQ6YnADYZ2Wi+P6it+P/uVpqu2vxxfpDcIK4TzFWBOFj9Q/+4+1JkoKEpzqg8KtX6
         wSJw==
X-Gm-Message-State: AO0yUKWNJ94L2aPSYJW/sXhnk1+01xtf5CfpS2PdFi2O3k8YeP/fNwff
        4nUeFiLXHgdegUHJ+1+b+L8/9c3YhR35M9QcX7GedA==
X-Google-Smtp-Source: AK7set+WOVGy3L0fQe6aqtZPNa4Qp1bsgpEMax4K+7E8khR2nWhEnP18dml0HifVFOcHHeU1zHVZvSy1ErI3ZrxR0Y0=
X-Received: by 2002:a17:902:64d0:b0:19c:a7a7:7072 with SMTP id
 y16-20020a17090264d000b0019ca7a77072mr1376422pli.10.1677891209788; Fri, 03
 Mar 2023 16:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com>
 <20230224070506.4157738-3-saravanak@google.com> <CAD=FV=WaWmHDX0FVH1KO7b_QDM9xxt86q60MGOtPVVvGZJ+t7A@mail.gmail.com>
In-Reply-To: <CAD=FV=WaWmHDX0FVH1KO7b_QDM9xxt86q60MGOtPVVvGZJ+t7A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Mar 2023 16:52:53 -0800
Message-ID: <CAGETcx_2f4atf-bpvj3o5FVcWrsbJRuY_Kwu5_NU6ESbNM8MFQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: Make state_synced device attribute writeable
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 2:33=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Feb 23, 2023 at 11:05=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > If the file is written to and sync_state() hasn't been called for the
> > device yet, then call sync_state() for the device independent of the
> > state of its consumers.
> >
> > This is useful for supplier devices that have one or more consumers tha=
t
> > don't have a driver but the consumers are in a state that don't use the
> > resources supplied by the supplier device.
> >
> > This gives finer grained control than using the
> > fw_devlink.sync_state=3Dtimeout kernel commandline parameter.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../ABI/testing/sysfs-devices-state_synced     |  5 +++++
> >  drivers/base/base.h                            |  8 ++++++++
> >  drivers/base/core.c                            |  5 +----
> >  drivers/base/dd.c                              | 18 +++++++++++++++++-
> >  4 files changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Doc=
umentation/ABI/testing/sysfs-devices-state_synced
> > index 0c922d7d02fc..cc4090c9df75 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-state_synced
> > +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> > @@ -21,4 +21,9 @@ Description:
> >                 at the time the kernel starts are not affected or limit=
ed in
> >                 any way by sync_state() callbacks.
> >
> > +               Writing anything to this file will force a call to the =
device's
> > +               sync_state() function if it hasn't been called already.=
 The
> > +               sync_state() call happens is independent of the state o=
f the
> > +               consumer devices.
>
> Please don't just accept anything written. It doesn't take much to
> check that the user wrote some known value here and then if we ever
> have a reason to allow something else we don't have to break old ABIs.
> Maybe "-1"?

Fine. I'll make it "1" to be consistent with the read behavior.

>
>
> > +
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 6fcd71803d35..b055eba1ec30 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -164,6 +164,14 @@ static inline int driver_match_device(struct devic=
e_driver *drv,
> >         return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> >  }
> >
> > +static inline void dev_sync_state(struct device *dev)
>
> IMO don't force inline. The compiler is probably smarter than you. I
> could even believe that it might be more optimal for this rarely
> called function to be _not_ inline if it kept the kernel smaller. I
> guess that means moving it out of the header...

I'm following the style of every other function in the .h file.

>
> > +{
> > +       if (dev->bus->sync_state)
> > +               dev->bus->sync_state(dev);
> > +       else if (dev->driver && dev->driver->sync_state)
> > +               dev->driver->sync_state(dev);
> > +}
> > +
> >  extern int driver_add_groups(struct device_driver *drv,
> >                              const struct attribute_group **groups);
> >  extern void driver_remove_groups(struct device_driver *drv,
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 929ec218f180..60bb3551977b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1215,10 +1215,7 @@ static void device_links_flush_sync_list(struct =
list_head *list,
> >                 if (dev !=3D dont_lock_dev)
> >                         device_lock(dev);
> >
> > -               if (dev->bus->sync_state)
> > -                       dev->bus->sync_state(dev);
> > -               else if (dev->driver && dev->driver->sync_state)
> > -                       dev->driver->sync_state(dev);
> > +               dev_sync_state(dev);
> >
> >                 if (dev !=3D dont_lock_dev)
> >                         device_unlock(dev);
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 84f07e0050dd..17b51573f794 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -510,6 +510,22 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
> >  static atomic_t probe_count =3D ATOMIC_INIT(0);
> >  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
> >
> > +static ssize_t state_synced_store(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 const char *buf, size_t count)
> > +{
> > +       device_lock(dev);
> > +       if (!dev->state_synced) {
> > +               dev->state_synced =3D true;
> > +               dev_sync_state(dev);
> > +       } else {
> > +               count =3D -EINVAL;
>
> count is of type "size_t", not "ssize_t". -EINVAL is signed.

Heh... I took the time to make sure it was signed... but looks like I
accidentally followed the other typdefs. Also the -EINVAL actually
worked when I tried writing
to a file that already had "1". I guess since the return value is
signed, it worked out. But, I'll fix it.



-Saravana
