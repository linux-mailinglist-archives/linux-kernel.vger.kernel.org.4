Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53874E568
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGKDkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:40:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F4137;
        Mon, 10 Jul 2023 20:40:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso636931966b.1;
        Mon, 10 Jul 2023 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689046826; x=1691638826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMtj4UYs2ALa7n/ZlIgzs1s+FnYeY/4KppM4O+yf1cE=;
        b=HhbHX2P4xZvziOE/vKnNYFMPCgWx4W1J0EKj+pTXV1My+w9sk0Wtqo6sfE94zU4Cqq
         JKsiRybeEAdeP4ldFc0RbRzBFZlDkbd67R/m17p0jJqa9Qy3vngg/jgvf7eJZz00fZ/r
         5tP0FigpzLc/dCFM20ueYDHTMMX9JC9JM2GDTxIMLT1FVPhq1IYJHL2cmMTqYR55nxI5
         APchJ+3D1uDcfzrGPnFsYSuj0e5Qitl8g4RCgGMaVBXc9zy8+Me8hUUovLRluSuzoMEZ
         UiOXZMfWbNLgmcjJLu7/zFYCT4O1PCJi5p+8mOIpyuHzSDllNNOfqZzsa0A8vV0zQMnR
         /XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689046826; x=1691638826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMtj4UYs2ALa7n/ZlIgzs1s+FnYeY/4KppM4O+yf1cE=;
        b=HpI/LByXyXzDvXm6D5xfzGiWNZFY3a2O+hISJPM+sO0sWwIAdi/9dfIYWYqLH7BGRT
         s6y6PIzaLIk5QXsR9n02i+1QZFemoK2sBH0OGPdm+b0ocfBPs0fs9wRlJKJZ7q+WK6nr
         LRKHs2NsOriBwSdpAP/IBrr+YOIA6KeP+O/MN0kaDJdjD+rI9RexHCW+Otf34yJeFE12
         2NznmFi9p95vKNRCStXpbcHKsWRSmDxLRbCm25pEKWPozlzHQqUgGXFpork9EBi7vdkT
         4rNKs9a4osb3ZyEyKWcsF73z9mzFsB84uqX1N3D5UH3qOaz0/GD4QrpljOrt8tDL0fPB
         k/qA==
X-Gm-Message-State: ABy/qLYyfrXBC2P2kYq237Eo1PsdsvbjZe0MTBhx3YhPOQkDPHDKsAkb
        m0iqI/SP5pe9/xvHFgw0Q24BOD2CJo5HnX4XbvndlEOg0SQ=
X-Google-Smtp-Source: APBJJlGAnLDMPmo3ekm2H/65jVF0gwkNtvTnDI25p27mfDYRh2YxhJcyPkfbbK0VPHiOiNqiWBEJAdByiS89iwqTE7Q=
X-Received: by 2002:a17:906:20d8:b0:993:eef2:5d56 with SMTP id
 c24-20020a17090620d800b00993eef25d56mr10137762ejc.0.1689046825740; Mon, 10
 Jul 2023 20:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230710033234.28641-1-di.shen@unisoc.com> <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com> <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
In-Reply-To: <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
From:   Di Shen <cindygm567@gmail.com>
Date:   Tue, 11 Jul 2023 11:40:14 +0800
Message-ID: <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, lukasz.luba@arm.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, orsonzhai@gmail.com,
        zhanglyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On Tue, Jul 11, 2023 at 3:33=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Di,
>
>
> On 10/07/2023 15:36, Di Shen wrote:
> > Hi Daniel,
> > Thank you for your reply.
> > On Mon, Jul 10, 2023 at 4:59=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 10/07/2023 05:32, Di Shen wrote:
> >>> When the thermal trip point is changed, the governor should
> >>> be reset so that the policy algorithm can be updated to adapt
> >>> to the new trip point.
> >>>
> >>> 1.Thermal governor is working for the passive trip point or active
> >>> trip point. Therefore, when the trip point is changed it should
> >>> reset the governor only for passic/active trip points.
> >>>
> >>> 2.For "power_allocator" governor reset, the parameters of pid
> >>> controller and the states of power cooling devices should be reset.
> >>>
> >>> 2.1
> >>> The IPA controls temperature using PID mechanism. It is a closed-
> >>> loop feedback monitoring system. It uses the gap between target
> >>> temperature and current temperature which says "error" as the
> >>> input of the PID controller:
> >>>
> >>> err =3D desired_temperature - current_temperature
> >>> P_max =3D
> >>> k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power
> >>>
> >>> That algorithm can 'learn' from the 'observed' in the past reaction
> >>> for it's control decisions and accumulates that information in the
> >>> I(Integral) part so that it can conpensate for those 'learned'
> >>> mistakes.
> >>>
> >>> Based on the above, the most important is the desired temperature
> >>> comes from the trip point. When the trip point is changed, all the
> >>> previous learned errors won't help for the IPA. So the pid parameters
> >>> should be reset for IPA governor reset.
> >>>
> >>> 2.2
> >>> Other wise, the cooling devices should also be reset when the trip
> >>> point is changed.
> >>>
> >>> This patch adds an ops for the thermal_governor structure to reset
> >>> the governor and give the 'reset' function definition for power
> >>> allocator. The ops is called when the trip points are changed via
> >>> sysfs interface.
> >>>
> >>> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >>> ---
> >>>    drivers/thermal/gov_power_allocator.c | 9 +++++++++
> >>>    drivers/thermal/thermal_trip.c        | 5 +++++
> >>>    include/linux/thermal.h               | 3 +++
> >>>    3 files changed, 17 insertions(+)
> >>>
> >>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/=
gov_power_allocator.c
> >>> index 8642f1096b91..8d17a10671e4 100644
> >>> --- a/drivers/thermal/gov_power_allocator.c
> >>> +++ b/drivers/thermal/gov_power_allocator.c
> >>> @@ -729,10 +729,19 @@ static int power_allocator_throttle(struct ther=
mal_zone_device *tz, int trip_id)
> >>>        return allocate_power(tz, trip.temperature);
> >>>    }
> >>>
> >>> +static void power_allocator_reset(struct thermal_zone_device *tz)
> >>> +{
> >>> +     struct power_allocator_params *params =3D tz->governor_data;
> >>> +
> >>> +     reset_pid_controller(params);
> >>> +     allow_maximum_power(tz, true);
> >>
> >> Do you really want to allow the maximum power? What about if the trip
> >> temperature is decreased ?
> >>
> > If the trip temperature is decreased, allow_maximum_power will only
> > be executed once, and then the ipa governor will adapt to the lower tri=
p
> > temperature and calculate the allocated power for cooling actors again.
> > Right?
>
> Sorry for jumping in this fifth version but I'm not sure about resetting
> the change is the right way (and probably, changing a trip point with
> the power allocator is not a good idea)
>
> The platforms where the IPA is planned to be used are creating a dummy
> trip point where the IPA begins the acquisition without cooling devices
> in order to have the math building the PID schema (eg. hi3660.dtsi).
>
> What about the sustainable power vs the trip point temperature? I mean
> we can change the trip temperature but not the sustainable power which
> is directly related to the target temperature. So the resulting power
> computation will be wrong.
>
I totally agree, thanks for reminding me. Sustainable power is the maximum
power available at the target temperature, so it must be updated when the t=
rip
point is changed. Sorry for missing this point. How about calling
get_sustainable_power() to update the sustainable_power? Furthermore, when
the sustainble_power() is changed, the pid constants tzp->k_* must be estim=
ated
again. In get_sustainble_power, it checks that the sustainable_power is upd=
ated,
it will call the estimate_pid_constants() to renew the tzp->k_*.

> The more I think about that, the more I do believe writable trip point
> and IPA are incompatible.
>
> What about forbid that?
>
> For instance, add a set_trip callback instead of resetting in the
> governor and return -EPERM from the IPA?
>
I've seen that you have sent a patch recently which adds the callback
thermal_zone_trips_update(), is that what you said set_trip callback?

> Lukasz ?
>
> > But if the trip temperature is increased, it must allow the maximum pow=
er,
>
> I would not say allow the maximum temperature but the new power head
> room. But that needs an update of the sustainable power information
> related to the new temperature :/
>
> > otherwise, the Line 723 update flag might be false(see the false exampl=
e
> > in patch-v3), the power of cooling devices would be not allowed maximum
> > for a while unless the current temperature is higher than the new
> > switch_on_temp. In this situation, for cpufreq cooling devices, it mean=
s the
> > cpu max_freq is limited, which is bad for device performance. The same =
for
> > other cooling devices, if not reset the cooling state, it may introduce
> > unexpected issues.
> >
> > 705 static int power_allocator_throttle(struct thermal_zone_device
> > *tz, int trip_id)
> > 706 {
> > 707         struct power_allocator_params *params =3D tz->governor_data=
;
> > 708         struct thermal_trip trip;
> > 709         int ret;
> > 710         bool update;
> > 711
> > 712        //......
> > 721         ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on,
> > &trip);
> > 722         if (!ret && (tz->temperature < trip.temperature)) {
> > 723                 update =3D (tz->last_temperature >=3D
> > trip.temperature);
> > 724                 tz->passive =3D 0;
> > 725                 reset_pid_controller(params);
> > 726                 allow_maximum_power(tz, update);
> > 727                 return 0;
> > 728         }
> > 729
> > 730         tz->passive =3D 1;
> > 731          //.......
> > 740 }
> >
> >> You want maximum power only if the mitigation ends.
> >>
> > Yes, you're right, I agree. It's better to do like that, actually,
> > patch-v3 is in line
> > with this point I think, but it is not in the thermal core.
> >
> > Oh, I see!
> > How about modified like that:
> > static void power_allocator_reset(struct thermal_zone_device *tz)
> > {
> >       struct power_allocator_params *params =3D tz->governor_data;
> > +   struct thermal_trip trip;
> > +   int ret;
> >
> >       reset_pid_controller(params);
> > +   ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> > +   if (!ret && (tz->temperature < trip.temperature))
> >               allow_maximum_power(tz, true);
>
> No, that would be wrong. It should be
>         (tz->temperature - hysteresis) < trip.temperature
>
> But if we are in the hysteresis area, we should allow a bit more power
> which depends on the sustainable power which was not updated with the
> trip temperature change :/
>
As what I said before, maybe we can use the get_sustainable_power to update
sustainable_power.

> > }
> > It seems clearer.
> >
> >>> +}
> >>> +
> >>>    static struct thermal_governor thermal_gov_power_allocator =3D {
> >>>        .name           =3D "power_allocator",
> >>>        .bind_to_tz     =3D power_allocator_bind,
> >>>        .unbind_from_tz =3D power_allocator_unbind,
> >>>        .throttle       =3D power_allocator_throttle,
> >>> +     .reset          =3D power_allocator_reset,
> >>>    };
> >>>    THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> >>> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal=
_trip.c
> >>> index 907f3a4d7bc8..13bbe029c6ab 100644
> >>> --- a/drivers/thermal/thermal_trip.c
> >>> +++ b/drivers/thermal/thermal_trip.c
> >>> @@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_de=
vice *tz, int trip_id,
> >>>        if (tz->trips && (t.temperature !=3D trip->temperature || t.hy=
steresis !=3D trip->hysteresis))
> >>>                tz->trips[trip_id] =3D *trip;
> >>>
> >>> +     /* Reset the governor only when the trip type is active or pass=
ive. */
> >>> +     ret =3D (trip->type =3D=3D THERMAL_TRIP_PASSIVE || trip->type =
=3D=3D THERMAL_TRIP_ACTIVE);
> >>
> >> Actually we have the trip points:
> >>
> >> ACTIVE, PASSIVE, HOT and CRITICAL
> >>
> > Correct.
> >
> >> The last two ones should not be writable.
> >>
> >> Instead of this test, it would be cleaner to only make the ACTIVE and
> >> PASSIVE trip point writable when the CONFIG_THERMAL_WRITABLE_TRIPS
> >> option is set. Consequently, other trip points won't be writable and
> >> this test can go away as set_trip will be protected by a RO sysfs file
> >> property.
> >>
> >>> +     if (ret && t.temperature !=3D trip->temperature && tz->governor=
 && tz->governor->reset)
> >>
> >> The temperature test is duplicated because it is already done in the
> >> block before.
> >>
> > So here you mean two points:
> > 1. Make the HOT and CRITICAL point RO so that it can no trip type test
> > when gov->reset
> > 2. not do the temperature test twice
> > Right?
>
> HOT and CRITICAL can not be changed because RO. The core code can use
> this assumption by not checking they are changed.
>
> > For the first point, it's OK for me. But what if someone wants to
> > power off the device earlier
> > or later? I think it should have the access to update the critical
> > temperature.
>  >
> > I'm not really
> > know about the hot trip temperature. So I'm not sure the real reason
> > to make them RO
> > when the trip points are writable. I can't make it RO just because of
> > the code simplification.
>
> That is critical firmware information and it must not be touched by the
> user (even root). Imagine I can set 250=C2=B0C for the critical trip poin=
t
> while the silicon supports 120=C2=B0C only?
>
> So basically, we should protect these trip points by making them RO.
>
> By fixing this, only PASSIVE and ACTIVE trip points can be changed, thus
> checking CRITICAL and HOT above is pointless.
>
Got it. The firmware information should not be modified in software, so
RO is proper.

>
> > For the second point, that's OK. I will simplify in the next patch
> > version. Thank you, Daniel.
>
> Before sending a new version, IMO we should think a bit about writable
> trip points in general because the feature does not look mature.
>
Yes, a slight move in one trip point may affect the situation as a whole,
especially for thermal zones which are governed by IPA. We should think
carefully. And thank you for your sincere comments:)

>
> >>> +             tz->governor->reset(tz);
> >>> +
> >>>        thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> >>>                                      trip->temperature, trip->hystere=
sis);
> >>>
> >>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >>> index 87837094d549..d27d053319bf 100644
> >>> --- a/include/linux/thermal.h
> >>> +++ b/include/linux/thermal.h
> >>> @@ -197,6 +197,8 @@ struct thermal_zone_device {
> >>>     *                  thermal zone.
> >>>     * @throttle:       callback called for every trip point even if t=
emperature is
> >>>     *          below the trip point temperature
> >>> + * @reset:   callback called for governor reset
> >>> + *
> >>>     * @governor_list:  node in thermal_governor_list (in thermal_core=
.c)
> >>>     */
> >>>    struct thermal_governor {
> >>> @@ -204,6 +206,7 @@ struct thermal_governor {
> >>>        int (*bind_to_tz)(struct thermal_zone_device *tz);
> >>>        void (*unbind_from_tz)(struct thermal_zone_device *tz);
> >>>        int (*throttle)(struct thermal_zone_device *tz, int trip);
> >>> +     void (*reset)(struct thermal_zone_device *tz);
> >>>        struct list_head        governor_list;
> >>>    };
> >>>
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> >
> > Best regards,
> > Di
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Best regards,
Di
