Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7006D1B49
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjCaJGG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjCaJFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:05:50 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA81E732;
        Fri, 31 Mar 2023 02:05:27 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id y4so87047623edo.2;
        Fri, 31 Mar 2023 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unlYLUwSWBLzgE39Yo6lUS/o31M4d0KORihs3ir0uOE=;
        b=HbPREgOpLTocOWykBLIt+Wm4YbAoFg2hnLUODqpke94Yj+YmKYSvEsCIL1aFlGUVXX
         C6v6Puw5seADrNSokNdaWxqF1zGfFUNou6E8LEc/R2iOCYCfvopr5C/q0Oe1uVBo+dG4
         UB6y7b5ckLNS96SETpFDbGlvSvi+3QFZEVCyPBmexg2zKZUHPBKLlQ9OIYX3DltQxSRD
         u8FUj+Pvi21qHqTXwg/QK3/qTISbMe26tmt6uwNOLhdtDkdaAxZxpflthgYbN0tDuZ2t
         d9hx/NFMCisJqKBr4LiqS6xJanc2uHETkUYwt5apm1PpgEYU0I/uqmbgtBwLsxU92KFz
         55QQ==
X-Gm-Message-State: AAQBX9efU9HS5Bj0YbQyigvuEgKj1FMMeE4dQlK9/sXtmsW1gXKDuAc/
        1mTvnGtRfcdN+TdSFI1Q3nxFME/dqdagU6BZnMc=
X-Google-Smtp-Source: AKy350ZORYGCLOKDgR/ZotHXAntK96d7KoFVUfFeHnSQpc2r8lbwdA0N0ipjLtyZn93kwiSERplHY0gS5v9piW4fqlg=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr14018675ejc.2.1680253525959; Fri, 31 Mar
 2023 02:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230330104526.3196-1-rui.zhang@intel.com> <751e20b9-34f6-ab1d-dd42-70239044f13d@linaro.org>
In-Reply-To: <751e20b9-34f6-ab1d-dd42-70239044f13d@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 11:05:14 +0200
Message-ID: <CAJZ5v0h--_OhUWLQArp1DJ3kLinbP7bN+HThoxanzkT1BWNqZg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Remove thermal_bind_params structure
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:49 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rui,
>
>
> On 30/03/2023 12:45, Zhang Rui wrote:
> > Remove struct thermal_bind_params because no one is using it for thermal
> > binding now.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>
> Thanks for the cleanup, always good to remove unused code.
>
> Rafael, is it fine if I pick it ?

Sure, no problem.

>
> > ---
> >   .../driver-api/thermal/sysfs-api.rst          |  40 ------
> >   drivers/thermal/thermal_core.c                | 129 ++----------------
> >   include/linux/thermal.h                       |  38 ------
> >   3 files changed, 11 insertions(+), 196 deletions(-)
> >
> > diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> > index 2e0f79a9e2ee..6c1175c6afba 100644
> > --- a/Documentation/driver-api/thermal/sysfs-api.rst
> > +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> > @@ -304,42 +304,6 @@ temperature) and throttle appropriate devices.
> >   1.4 Thermal Zone Parameters
> >   ---------------------------
> >
> > -    ::
> > -
> > -     struct thermal_bind_params
> > -
> > -    This structure defines the following parameters that are used to bind
> > -    a zone with a cooling device for a particular trip point.
> > -
> > -    .cdev:
> > -          The cooling device pointer
> > -    .weight:
> > -          The 'influence' of a particular cooling device on this
> > -          zone. This is relative to the rest of the cooling
> > -          devices. For example, if all cooling devices have a
> > -          weight of 1, then they all contribute the same. You can
> > -          use percentages if you want, but it's not mandatory. A
> > -          weight of 0 means that this cooling device doesn't
> > -          contribute to the cooling of this zone unless all cooling
> > -          devices have a weight of 0. If all weights are 0, then
> > -          they all contribute the same.
> > -    .trip_mask:
> > -            This is a bit mask that gives the binding relation between
> > -            this thermal zone and cdev, for a particular trip point.
> > -            If nth bit is set, then the cdev and thermal zone are bound
> > -            for trip point n.
> > -    .binding_limits:
> > -                  This is an array of cooling state limits. Must have
> > -                  exactly 2 * thermal_zone.number_of_trip_points. It is an
> > -                  array consisting of tuples <lower-state upper-state> of
> > -                  state limits. Each trip will be associated with one state
> > -                  limit tuple when binding. A NULL pointer means
> > -                  <THERMAL_NO_LIMITS THERMAL_NO_LIMITS> on all trips.
> > -                  These limits are used when binding a cdev to a trip point.
> > -    .match:
> > -         This call back returns success(0) if the 'tz and cdev' need to
> > -         be bound, as per platform data.
> > -
> >       ::
> >
> >       struct thermal_zone_params
> > @@ -357,10 +321,6 @@ temperature) and throttle appropriate devices.
> >              will be created. when no_hwmon == true, nothing will be done.
> >              In case the thermal_zone_params is NULL, the hwmon interface
> >              will be created (for backward compatibility).
> > -    .num_tbps:
> > -            Number of thermal_bind_params entries for this zone
> > -    .tbp:
> > -            thermal_bind_params entries
> >
> >   2. sysfs attributes structure
> >   =============================
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d51cacd66756..2e6a49dd527d 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -794,64 +794,18 @@ void print_bind_err_msg(struct thermal_zone_device *tz,
> >               tz->type, cdev->type, ret);
> >   }
> >
> > -static void __bind(struct thermal_zone_device *tz, int mask,
> > -                struct thermal_cooling_device *cdev,
> > -                unsigned long *limits,
> > -                unsigned int weight)
> > -{
> > -     int i, ret;
> > -
> > -     for (i = 0; i < tz->num_trips; i++) {
> > -             if (mask & (1 << i)) {
> > -                     unsigned long upper, lower;
> > -
> > -                     upper = THERMAL_NO_LIMIT;
> > -                     lower = THERMAL_NO_LIMIT;
> > -                     if (limits) {
> > -                             lower = limits[i * 2];
> > -                             upper = limits[i * 2 + 1];
> > -                     }
> > -                     ret = thermal_zone_bind_cooling_device(tz, i, cdev,
> > -                                                            upper, lower,
> > -                                                            weight);
> > -                     if (ret)
> > -                             print_bind_err_msg(tz, cdev, ret);
> > -             }
> > -     }
> > -}
> > -
> >   static void bind_cdev(struct thermal_cooling_device *cdev)
> >   {
> > -     int i, ret;
> > -     const struct thermal_zone_params *tzp;
> > +     int ret;
> >       struct thermal_zone_device *pos = NULL;
> >
> >       mutex_lock(&thermal_list_lock);
> >
> >       list_for_each_entry(pos, &thermal_tz_list, node) {
> > -             if (!pos->tzp && !pos->ops->bind)
> > -                     continue;
> > -
> >               if (pos->ops->bind) {
> >                       ret = pos->ops->bind(pos, cdev);
> >                       if (ret)
> >                               print_bind_err_msg(pos, cdev, ret);
> > -                     continue;
> > -             }
> > -
> > -             tzp = pos->tzp;
> > -             if (!tzp || !tzp->tbp)
> > -                     continue;
> > -
> > -             for (i = 0; i < tzp->num_tbps; i++) {
> > -                     if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> > -                             continue;
> > -                     if (tzp->tbp[i].match(pos, cdev))
> > -                             continue;
> > -                     tzp->tbp[i].cdev = cdev;
> > -                     __bind(pos, tzp->tbp[i].trip_mask, cdev,
> > -                            tzp->tbp[i].binding_limits,
> > -                            tzp->tbp[i].weight);
> >               }
> >       }
> >
> > @@ -1138,16 +1092,6 @@ void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
> >   }
> >   EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
> >
> > -static void __unbind(struct thermal_zone_device *tz, int mask,
> > -                  struct thermal_cooling_device *cdev)
> > -{
> > -     int i;
> > -
> > -     for (i = 0; i < tz->num_trips; i++)
> > -             if (mask & (1 << i))
> > -                     thermal_zone_unbind_cooling_device(tz, i, cdev);
> > -}
> > -
> >   /**
> >    * thermal_cooling_device_unregister - removes a thermal cooling device
> >    * @cdev:   the thermal cooling device to remove.
> > @@ -1157,8 +1101,6 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
> >    */
> >   void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> >   {
> > -     int i;
> > -     const struct thermal_zone_params *tzp;
> >       struct thermal_zone_device *tz;
> >
> >       if (!cdev)
> > @@ -1175,21 +1117,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> >
> >       /* Unbind all thermal zones associated with 'this' cdev */
> >       list_for_each_entry(tz, &thermal_tz_list, node) {
> > -             if (tz->ops->unbind) {
> > +             if (tz->ops->unbind)
> >                       tz->ops->unbind(tz, cdev);
> > -                     continue;
> > -             }
> > -
> > -             if (!tz->tzp || !tz->tzp->tbp)
> > -                     continue;
> > -
> > -             tzp = tz->tzp;
> > -             for (i = 0; i < tzp->num_tbps; i++) {
> > -                     if (tzp->tbp[i].cdev == cdev) {
> > -                             __unbind(tz, tzp->tbp[i].trip_mask, cdev);
> > -                             tzp->tbp[i].cdev = NULL;
> > -                     }
> > -             }
> >       }
> >
> >       mutex_unlock(&thermal_list_lock);
> > @@ -1200,41 +1129,20 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
> >
> >   static void bind_tz(struct thermal_zone_device *tz)
> >   {
> > -     int i, ret;
> > +     int ret;
> >       struct thermal_cooling_device *pos = NULL;
> > -     const struct thermal_zone_params *tzp = tz->tzp;
> >
> > -     if (!tzp && !tz->ops->bind)
> > +     if (!tz->ops->bind)
> >               return;
> >
> >       mutex_lock(&thermal_list_lock);
> >
> > -     /* If there is ops->bind, try to use ops->bind */
> > -     if (tz->ops->bind) {
> > -             list_for_each_entry(pos, &thermal_cdev_list, node) {
> > -                     ret = tz->ops->bind(tz, pos);
> > -                     if (ret)
> > -                             print_bind_err_msg(tz, pos, ret);
> > -             }
> > -             goto exit;
> > -     }
> > -
> > -     if (!tzp || !tzp->tbp)
> > -             goto exit;
> > -
> >       list_for_each_entry(pos, &thermal_cdev_list, node) {
> > -             for (i = 0; i < tzp->num_tbps; i++) {
> > -                     if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> > -                             continue;
> > -                     if (tzp->tbp[i].match(tz, pos))
> > -                             continue;
> > -                     tzp->tbp[i].cdev = pos;
> > -                     __bind(tz, tzp->tbp[i].trip_mask, pos,
> > -                            tzp->tbp[i].binding_limits,
> > -                            tzp->tbp[i].weight);
> > -             }
> > +             ret = tz->ops->bind(tz, pos);
> > +             if (ret)
> > +                     print_bind_err_msg(tz, pos, ret);
> >       }
> > -exit:
> > +
> >       mutex_unlock(&thermal_list_lock);
> >   }
> >
> > @@ -1491,15 +1399,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_id);
> >    */
> >   void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> >   {
> > -     int i, tz_id;
> > -     const struct thermal_zone_params *tzp;
> > +     int tz_id;
> >       struct thermal_cooling_device *cdev;
> >       struct thermal_zone_device *pos = NULL;
> >
> >       if (!tz)
> >               return;
> >
> > -     tzp = tz->tzp;
> >       tz_id = tz->id;
> >
> >       mutex_lock(&thermal_list_lock);
> > @@ -1514,22 +1420,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> >       list_del(&tz->node);
> >
> >       /* Unbind all cdevs associated with 'this' thermal zone */
> > -     list_for_each_entry(cdev, &thermal_cdev_list, node) {
> > -             if (tz->ops->unbind) {
> > +     list_for_each_entry(cdev, &thermal_cdev_list, node)
> > +             if (tz->ops->unbind)
> >                       tz->ops->unbind(tz, cdev);
> > -                     continue;
> > -             }
> > -
> > -             if (!tzp || !tzp->tbp)
> > -                     break;
> > -
> > -             for (i = 0; i < tzp->num_tbps; i++) {
> > -                     if (tzp->tbp[i].cdev == cdev) {
> > -                             __unbind(tz, tzp->tbp[i].trip_mask, cdev);
> > -                             tzp->tbp[i].cdev = NULL;
> > -                     }
> > -             }
> > -     }
> >
> >       mutex_unlock(&thermal_list_lock);
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index fef625f799ae..ab7460bfdcf6 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -207,41 +207,6 @@ struct thermal_governor {
> >       struct list_head        governor_list;
> >   };
> >
> > -/* Structure that holds binding parameters for a zone */
> > -struct thermal_bind_params {
> > -     struct thermal_cooling_device *cdev;
> > -
> > -     /*
> > -      * This is a measure of 'how effectively these devices can
> > -      * cool 'this' thermal zone. It shall be determined by
> > -      * platform characterization. This value is relative to the
> > -      * rest of the weights so a cooling device whose weight is
> > -      * double that of another cooling device is twice as
> > -      * effective. See Documentation/driver-api/thermal/sysfs-api.rst for more
> > -      * information.
> > -      */
> > -     int weight;
> > -
> > -     /*
> > -      * This is a bit mask that gives the binding relation between this
> > -      * thermal zone and cdev, for a particular trip point.
> > -      * See Documentation/driver-api/thermal/sysfs-api.rst for more information.
> > -      */
> > -     int trip_mask;
> > -
> > -     /*
> > -      * This is an array of cooling state limits. Must have exactly
> > -      * 2 * thermal_zone.number_of_trip_points. It is an array consisting
> > -      * of tuples <lower-state upper-state> of state limits. Each trip
> > -      * will be associated with one state limit tuple when binding.
> > -      * A NULL pointer means <THERMAL_NO_LIMITS THERMAL_NO_LIMITS>
> > -      * on all trips.
> > -      */
> > -     unsigned long *binding_limits;
> > -     int (*match) (struct thermal_zone_device *tz,
> > -                     struct thermal_cooling_device *cdev);
> > -};
> > -
> >   /* Structure to define Thermal Zone parameters */
> >   struct thermal_zone_params {
> >       char governor_name[THERMAL_NAME_LENGTH];
> > @@ -253,9 +218,6 @@ struct thermal_zone_params {
> >        */
> >       bool no_hwmon;
> >
> > -     int num_tbps;   /* Number of tbp entries */
> > -     struct thermal_bind_params *tbp;
> > -
> >       /*
> >        * Sustainable power (heat) that this thermal zone can dissipate in
> >        * mW
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
