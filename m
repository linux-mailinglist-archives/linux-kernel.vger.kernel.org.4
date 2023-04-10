Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549566DC28C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDJCKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:10:04 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EF2D58;
        Sun,  9 Apr 2023 19:10:03 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id z23so2574352uav.8;
        Sun, 09 Apr 2023 19:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681092602; x=1683684602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFcvu5+zkuLhosDgx711OF9EImRvKIyqIvZHC4yvlXA=;
        b=BpnPxPdkyHPTkDIqzA4hXSRxzr2dxYR2mQpMH3KoR0o5bzBJLaFD3IBhETbaXKwEKY
         cSGk7blpmohjpscpDBDCOYZk6+oKs4K1SFBNriMhQs4Pu/tuUXqm/vXbytzDZAvnXHMh
         yjYu6VfOR7WKVkuSuQ90xtkJVv0jGxLpacHBdRvxNXkSrqYLOVKbwWNzXcqzXpZG+PfA
         2HLDlq08P2+ho21LJjHyxfUHzN5ALOSMoEuBm3QDIBb0SHUQwu6dR8ZmcOjXdSEQ5bz2
         BNovs/kFrgE229ME8kutIBuw313SskttC+t9VRxEk02OF5a0V7Qo3zPA5+JnY66fbxTQ
         hbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681092602; x=1683684602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFcvu5+zkuLhosDgx711OF9EImRvKIyqIvZHC4yvlXA=;
        b=cnmiX6WiqLPDMboydUgMPtWuGh+uXRYUsWNsJgPKm5fOlK9psy+iLPLaR+sa8o72eN
         V3l6oXCDHiUmNS3QItyINe//5fhxJ1614IhHFGeCjWTnA4vSuIWX3qaWyZrDG4DtrfLV
         QETQpVCivFWzuNLfU+NuJFyhyNkGR7MfRnAqHIdmw8ekg32pMawqNL0dFUwUbzITqlJG
         ++Nqd4ar6+NhjaFPBpNxhXdFjAY8AZfVqfUof5hfF61NtWvM+D7Q1VaKN7SiyKmyPkAy
         oqFz9f0hN/+L5eQyjAneQrEiJbHUbINFwPVajt+OA85jfeIGMEZDx6sUjhEBrYGX5Vhd
         CZBg==
X-Gm-Message-State: AAQBX9dq9LBwFvWozJRXhUomr/OMGaD5c43XVyEu/KDS1xwhOcNOfnZi
        TNvFRL45VtElaGxtntHv+hf+9cDvqQvalszCwrg=
X-Google-Smtp-Source: AKy350ZFKC7Parsfw7wDB2EYgGhB0pawRHBZRWDQbNJBYlDfBhLeVp7zjTnc/LjcGnAc5FtwbFX2Ng0Np1mDzJZeoDs=
X-Received: by 2002:a1f:a948:0:b0:43b:ce3f:12bd with SMTP id
 s69-20020a1fa948000000b0043bce3f12bdmr5012160vke.3.1681092602544; Sun, 09 Apr
 2023 19:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320095620.7480-1-di.shen@unisoc.com> <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
In-Reply-To: <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Mon, 10 Apr 2023 10:09:51 +0800
Message-ID: <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,
Could you please apply this patch if there's no more comment? Thank you.

Best regards,
Di

On Mon, Mar 20, 2023 at 8:29=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 3/20/23 09:56, Di Shen wrote:
> > Commit <0952177f2a1f>(thermal/core/power_allocator: Update once
> > cooling devices when temp is low) adds a update flag to avoid
> > the thermal event is triggered when there is no need, and
> > thermal cdev would be update once when temperature is low.
> >
> > But when the trips are writable, and switch_on_temp is set
> > to be a higher value, the cooling device state may not be
> > reset to 0, because last_temperature is smaller than the
> > switch_on_temp.
> >
> > For example:
> > First:
> > switch_on_temp=3D70 control_temp=3D85;
> > Then userspace change the trip_temp:
> > switch_on_temp=3D45 control_temp=3D55 cur_temp=3D54
> >
> > Then userspace reset the trip_temp:
> > switch_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
> >
> > At this time, the cooling device state should be reset to 0.
> > However, because cur_temp(57) < switch_on_temp(70)
> > last_temp(54) < switch_on_temp(70)  ---->  update =3D false,
> > update is false, the cooling device state can not be reset.
> >
> > This patch adds a function thermal_cdev_needs_update() to
> > renew the update flag value only when the trips are writable,
> > so that thermal cdev->state can be reset after switch_on_temp
> > changed from low to high.
> >
> > Fixes: <0952177f2a1f> (thermal/core/power_allocator: Update once coolin=
g devices when temp is low)
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> >
> > ---
> > V3:
> > - Add fix tag.
> >
> > V2:
> > - Compared to v1, do not revert.
> >
> > - Add a variable(last_switch_on_temp) in power_allocator_params
> >    to record the last switch_on_temp value.
> >
> > - Adds a function to renew the update flag and update the
> >    last_switch_on_temp when thermal trips are writable.
> >
> > V1:
> > - Revert commit 0952177f2a1f.
> > ---
> > ---
> >   drivers/thermal/gov_power_allocator.c | 39 ++++++++++++++++++++++----=
-
> >   1 file changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 0eaf1527d3e3..c9e1f3b15f15 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -59,6 +59,8 @@ static inline s64 div_frac(s64 x, s64 y)
> >    *                  governor switches on when this trip point is cros=
sed.
> >    *                  If the thermal zone only has one passive trip poi=
nt,
> >    *                  @trip_switch_on should be INVALID_TRIP.
> > + * @last_switch_on_temp:Record the last switch_on_temp only when trips
> > +                     are writable.
> >    * @trip_max_desired_temperature:   last passive trip point of the th=
ermal
> >    *                                  zone.  The temperature we are
> >    *                                  controlling for.
> > @@ -70,6 +72,9 @@ struct power_allocator_params {
> >       s64 err_integral;
> >       s32 prev_err;
> >       int trip_switch_on;
> > +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> > +     int last_switch_on_temp;
> > +#endif
> >       int trip_max_desired_temperature;
> >       u32 sustainable_power;
> >   };
> > @@ -554,6 +559,25 @@ static void get_governor_trips(struct thermal_zone=
_device *tz,
> >       }
> >   }
> >
> > +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> > +static bool thermal_cdev_needs_update(struct thermal_zone_device *tz, =
int switch_on_temp)
> > +{
> > +     bool update;
> > +     struct power_allocator_params *params =3D tz->governor_data;
> > +     int last_switch_on_temp =3D params->last_switch_on_temp;
> > +
> > +     update =3D (tz->last_temperature >=3D last_switch_on_temp);
> > +     params->last_switch_on_temp =3D switch_on_temp;
> > +
> > +     return update;
> > +}
> > +#else
> > +static inline bool thermal_cdev_needs_update(struct thermal_zone_devic=
e *tz, int switch_on_temp)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> >   static void reset_pid_controller(struct power_allocator_params *param=
s)
> >   {
> >       params->err_integral =3D 0;
> > @@ -709,12 +733,15 @@ static int power_allocator_throttle(struct therma=
l_zone_device *tz, int trip_id)
> >               return 0;
> >
> >       ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on, &trip=
);
> > -     if (!ret && (tz->temperature < trip.temperature)) {
> > -             update =3D (tz->last_temperature >=3D trip.temperature);
> > -             tz->passive =3D 0;
> > -             reset_pid_controller(params);
> > -             allow_maximum_power(tz, update);
> > -             return 0;
> > +     if (!ret) {
> > +             update =3D thermal_cdev_needs_update(tz, trip.temperature=
);
> > +             if (tz->temperature < trip.temperature) {
> > +                     update |=3D (tz->last_temperature >=3D trip.tempe=
rature);
> > +                     tz->passive =3D 0;
> > +                     reset_pid_controller(params);
> > +                     allow_maximum_power(tz, update);
> > +                     return 0;
> > +             }
> >       }
> >
> >       tz->passive =3D 1;
>
>
> Thanks for the patch. The code looks good. The initial value of
> 'last_switch_on_temp' would be set to 0. It won't harm us because it
> will get the proper value later.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
