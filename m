Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE773BE33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjFWSAP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjFWSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:00:11 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9026B0;
        Fri, 23 Jun 2023 11:00:09 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-988a4a7be58so21496266b.0;
        Fri, 23 Jun 2023 11:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543208; x=1690135208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0va1mb6bq4MZFowSDRaXkuLvgSfhyk8ksAjyHi+zCc8=;
        b=YiVm2Radc7W0XYPKVwGh9sIKa4kFDTip965gCMXeXNPu4Y0136XOo55LixKtfuIN/7
         75ZgbZHDlFAbMk4ASAdTLEbf1i0N/rdtPPYM7F+4E+bbOWA6F8Xo+9FZ9k0Aa2dixSI+
         eMNrwPo9z/fV3kCTtjmhNXusbMajgMPLRYUhUXKDKTJn33l7SSE64fpvWbbUE3M0fLK/
         /29p0DiExXH3+Kw3i1LGHvwKb/K3ISyAr4ZYGRXNjfXi/NL3MjZKvbH6U5anrAob3wmm
         INv330NSOjNhzKBRZy86AXK9j3SWON05KP6bL6HipiL4B+3miqgPi5DzJuG7XRuYRYeq
         L5EQ==
X-Gm-Message-State: AC+VfDxU/zv+/7cq9RknetX+Quziz2gmJmKhBmDwAgJDSRXdipN2Pm9M
        Z9/gDp8UxSiQq+TE81XXZ/qzj9B9lOsyYxu2ZsHWxBvz
X-Google-Smtp-Source: ACHHUZ6SSV5uqRZfR8iaGkDSPwib5HccxZ0D4VdalRzFBXljVpzSCynKj7zZYJfUvtnN0CZ1rhvmYoXLJX184aGzuGk=
X-Received: by 2002:a17:906:728b:b0:988:f9ba:e18d with SMTP id
 b11-20020a170906728b00b00988f9bae18dmr9880639ejl.6.1687543207701; Fri, 23 Jun
 2023 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-5-daniel.lezcano@linaro.org> <CAJZ5v0iv6HkxmV08JyUO3K1YMPXerEb5qNobVkUNv2zW+qVh+w@mail.gmail.com>
 <93448681-8a0b-f565-1a98-a8607ff37488@linaro.org>
In-Reply-To: <93448681-8a0b-f565-1a98-a8607ff37488@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 19:59:55 +0200
Message-ID: <CAJZ5v0iKmtWcGVk_NZNgCR-r3UvgpAi_tEDe5v90aF7xbVUTCg@mail.gmail.com>
Subject: Re: [PATCH 4/8] thermal/core: Update the generic trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 8:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> thanks for the comments
>
>
> On 20/06/2023 13:28, Rafael J. Wysocki wrote:
> > On Thu, May 25, 2023 at 4:02 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> At this point, the generic trip points rework allows to create a
> >> thermal zone with a fixed number of trip points. This usage satisfy
> >> almost all of the existing drivers.
> >>
> >> A few remaining drivers have a mechanism where the firmware updates
> >> the trip points. But there is no such update mechanism for the generic
> >> trip points, thus those drivers can not be converted to the generic
> >> approach.
> >>
> >> This patch provides a function 'thermal_zone_trips_update()' allowing
> >> to change the trip points of a thermal zone.
> >>
> >> At the same time, with the logic the trip points array is passed as a
> >> parameter to the thermal zone at creation time, we make our own
> >> private trip points array by copying the one passed as parameter.
> >
> > So the design seems to require the caller to create a new array of
> > trip points and pass it to thermal_zone_trips_update(), so it can
> > replace the zone's trips array with it.
> >
> > If only one trip point changes and there are multiple defined, this is
> > rather not efficient.
>
> This update is only for replacing the current trip array when one or
> several trip points are added or removed. We can see that in one or two
> drivers only.

Well, I'm not sure about this adding/removing idea, because of the
sysfs issue mentioned below.

Surely, some trip points can be made invalid by setting their
temperatures to the "invalid" value, but they cannot be removed,
because they are already represented in sysfs and may have been
enumerated by user space which will get confused by removing them.

Conversely, if new trip points are added, they will not appear in
sysfs and so user space will never become aware of them.

> This function is supposed to be called rarely (and I doubt there is
> really a lot of hardware sending notification to add/remove trip points).
>
> For changing a trip point property like its temperature or its
> hysteresis, we keep the usual set_trip_point() function.

Do you mean the ->set_trip_temp/hyst() zone callback?

But isn't that to be used by the core in order to notify the driver of
a change, rather than the other way around?

Here, we have a situation where the driver needs to let the core know
that something has changed.

> > Do you want to prevent the core from using stale trip points this way?
> >   If so, it should be stated here.
>
> No, that will be a side effect. We can put this point apart, it will be
> addressed in a cleanup series after everything is converted to the
> generic trip points.

I think we need to talk about the design.  It looks like you have one
in mind, but I'm not really sure what it is.

>
> > Moreover, at least in the cases when num_trips doesn't change, it
> > might be more efficient to walk the new trips[] array and only copy
> > the ones that have changed over their old versions.
>
> IMO, that is over-engineered, especially for dedicating this
> optimization for a very few drivers and ultra rare usages.

I'm not sure.

One thing to remember is that, in general, the core and the drivers
need to communicate both ways regarding trip points.  For example,
when a trip point is updated via sysfs, the core needs to tell the
driver about that.  Conversely, if a trip point is updated by the
platform firmware (say), the driver needs to tell the core about that.

> > I am also not sure if this interface is going to be convenient from
> > the user's perspective, especially if the trips get sorted by the core
> > (in the future).  They would need to recreate the entire trips array
> > every time from scratch, even if only one trip point changes, which
> > means quite a bit of churn for thermal zones with many trip points.
>
> Actually, the driver is not supposed to deal with the array. It can
> create the array on the stack, pass it to the
> thermal_zone_device_register_with_trips() function and forget about it.
>
> The trip points array should not be used by a driver anymore.

Well, say that the core invokes ->set_trip_temp() for a certain trip
point.  How is the driver going to know which trip point this is about
if it cannot access the trip points table in the zone?

> > It might be better to allow them to update trips in place and notify
> > the core about the change, all under the zone lock to prevent the core
> > from using trips simultaneously.
>
> I'm not sure to understand. The core code is called with this function
> and takes the lock.
>
> > And arguably, changing num_trips would be questionable due to the
> > sysfs consistency reasons mentioned below.
>
> [ ... ]
>
> >> Note, no code has been found where the trip points update leads to a
> >> refresh of the trip points in sysfs, so it is very unlikey the number
> >> of trip points changes. However, for the sake of consistency it would
> >> be nicer to have the trip points being refreshed in sysfs also, but
> >> that could be done in a separate set of changes.
> >
> > So at this point user space has already enumerated the trip points, so
> > it may fail if some of them go away or it may not be able to use any
> > new trip points appearing in sysfs.
>
> Yes, that is why I think the adding/removal of the trip points was never
> really supported. I would be very curious to see a platform with such a
> feature.
>
> > For this reason, until there is a way to notify user space about the
> > need to re-enumerate trip points (and user space indicates support for
> > it), the only trip point property that may change in sysfs is the
> > temperature.
>
> The userspace can be notified when there is a change with:
>
> THERMAL_GENL_EVENT_TZ_TRIP_CHANGE
> THERMAL_GENL_EVENT_TZ_TRIP_ADD
> THERMAL_GENL_EVENT_TZ_TRIP_DELETE
>
> The last two ones are not implemented today but that could be done after
> as that would be a new feature.
>
> Let me summarize the situation:
>
>   - The trip point crossing events are not correctly detected because of
> how they are handled and we need to sort them out.

Sure.

>   - In order to sort them out, we need to convert the drivers to the
> generic trip point and remove all those get_trip_* | set_trip_* ops

IIUC, there are cases when the trip point temperature may be set via
sysfs.  In some of them, the core needs to tell the driver what
temperature to set for the trip, so the hardware or the platform
notifies it of excursions.  The ->set_* callbacks are still going to
be needed for that if I'm not mistaken.

>   - Almost all the drivers are converted except the ACPI thermal and the
> intel_soc_dts_iosf drivers which are blocking the feature

Sorry about that.  Hopefully, I'll have some time to sort this out
during the next couple of weeks.

I still would like to discuss the design related to that, though.

>   - The ACPI thermal driver can potentially add or remove a trip point
> but we are not sure that can happen

It may as per the spec, but whether or not this case needs to be
handled is a good question.

This depends on whether or not user space is prepared to deal with
trip points appearing and going away.  I suspect that it isn't.

>   - We need to decorrelate the trip id and the array index for the ACPI
> thermal driver

That should be doable.

> The generic trip points change is a big chunk of work and I would like
> to have some progress to fix the trip crossing detection along with the
> removal of the resulting dead code.
>
> Given there may not be a real usage of the thermal trip number update,
> can we stay simple and keep the proposed change but forcing the same
> number of trip points ?

I suppose so.

> We can then improve the existing code if it is really needed
