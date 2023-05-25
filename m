Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7D7105B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbjEYGjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEYGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:39:44 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE869189;
        Wed, 24 May 2023 23:39:42 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4572fa2a92fso62240e0c.2;
        Wed, 24 May 2023 23:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684996782; x=1687588782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgfz3nPmdI+S3+lmqQSPwAQ/1Clj8Evj/a1VGGmq+xQ=;
        b=T3cMmHhcvuP+7ZN2NgqUHMGn4+w8CPYaAlgxvRNG/znwCGXb47yZVYnKngsBb9P7B+
         g9IEVdgKxHQVLl9p0RyOXqbHTlvFLbvcnX4O/FIETgHowGN9rkxrfxAT7vODH9FXUhXI
         56+xnusvDY6M+gmbHhK3bz8NIhA2hYusd8OUkPLHMAvGLHcqXcS1x+4ajlBZCtpkcGrD
         2MngpJR7Jb5yT2MUjxb6AWMuBY0slbWkLj0I+lSyFqwJstZ57tCDcJlUofXYrW2bJCYU
         8qh44tMQWKIVXHP4rsCuUUIHLGP6B5kBn+GrIa6B9qsXTXqZhGa1g4asVzbofxqN7T5P
         /jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684996782; x=1687588782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgfz3nPmdI+S3+lmqQSPwAQ/1Clj8Evj/a1VGGmq+xQ=;
        b=IQNlGLGdchWq50JwaNH5dl7AuisIfpzp329WHqdLanHmfo5m9Gn6o/61OSjRCNoaPz
         PWqckaRSuNuB9oPoKr1gkrjb7ACjrKd1Hx4jAE3vqAuuN+6a/Md2m+G9i8XHV9XK1cGu
         SJ6bxhju3D74Q1170Aubg8MBn6e6OQXPLr4GJkGWjcpw0lHCiTzMUBasFm3bZwTzrIsE
         tl7Q6qRY5bChg31TWEDOj0Pf0KQ6MBD6OMTiJhw4NL7raHRlforlxkhgGPUf6pd/YzVy
         GywCo8HglyPm+vCb4NVG/W3LCcc2ZYRCI9o+K2kduthXE8ueTEZtaLFm9uWNqOy1Pm/N
         VbjA==
X-Gm-Message-State: AC+VfDwqZWvFVUOigytf8iWVYZInB+2MzqjptGyR96I0lzvD9+oiqN09
        ynqF5M8TdX0ZhpXiMaauMaTRRE3vR64Z696n8r4=
X-Google-Smtp-Source: ACHHUZ5bIBNeZo+jv9CLtMpvIEyomJv5OJ+5YoSCKwOxzNybuCkIMtT/jmFYv+DRVD/DuiaellhYuykZe36Qo3uV07Q=
X-Received: by 2002:a67:bb09:0:b0:421:c588:4d40 with SMTP id
 m9-20020a67bb09000000b00421c5884d40mr6078738vsn.15.1684996781899; Wed, 24 May
 2023 23:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230320095620.7480-1-di.shen@unisoc.com> <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org> <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
 <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org> <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
 <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org> <e31da1fa-168d-9a85-cdb3-66192d887d83@arm.com>
 <ce9b3b01-e496-9e02-5583-41893b7154c7@linaro.org> <6022d391-9ae8-2bb4-0f81-2c99466dc556@arm.com>
In-Reply-To: <6022d391-9ae8-2bb4-0f81-2c99466dc556@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Thu, 25 May 2023 14:39:30 +0800
Message-ID: <CAHYJL4r0yxLDHsTDKdcny6F7Lbzo-D48RGWyax07YUUFuzC2mg@mail.gmail.com>
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:21=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 4/14/23 16:06, Daniel Lezcano wrote:
> > On 14/04/2023 16:18, Lukasz Luba wrote:
> >>
> >>
> >> On 4/14/23 12:12, Daniel Lezcano wrote:
> >>> On 13/04/2023 10:40, Di Shen wrote:
> >>>> We have discussed this question in patch-v1:
> >>>> https://lore.kernel.org/all/f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm=
.com/
> >>>>
> >>>> Simply put, we use the trip_temp in the Android System; set differen=
t
> >>>> trip_temp for thermal control of different scenarios.
> >>>
> >>> The changes are dealing with the trip points and trying to detect the
> >>> threshold. That part should be handled in the thermal core or thermal
> >>> trip side, not in the governor.
> >>>
> >>> AFAICT, if a trip point is changed, then the power allocator should
> >>> be reset, including the cdev state.
> >>>
> >>> It would be more convenient to add an ops to the governor ops
> >>> structure to reset the governor and then call it when a trip point is
> >>> changed in thermal_zone_set_trip()
> >>>
> >>>
> >>
> >> Sounds reasonable to have a proper API and fwk handling this corner
> >> case scenario.
> >> Although, if there is a need for a 'easy-to-backport' fix for IPA only=
,
> >> I agree with this patch, since it's straight forward to put in some
> >> Android kernel. We can later fix the framework to handle this properly=
.
> >> Anyway, both ways are OK to me.
> >
> > Unfortunately, we can not do the maintenance of the Linux kernel based
> > on an 'easy-to-backport' policy to Android.
> >
> > This patch could be applied from-list to Android as a hotfix. But for
> > Linux the fix should be more elaborated. One solution is to add a
> > 'reset' ops and call it from the trip point update function.
>
> Fair enough.
>
> >
> > Did you double check the issue is not impacting the other governors too=
 ?
>
> No, unfortunately, I haven't checked other governors.

Hi Lukasz and Daniel,
I rethought about this issue, and have tried three ways to solve it.
Finally, I realized that the root cause might be the cdev->state
update and notify. We should get back to take cdev->state into
account.

The three ways:
1.From trips updating perspective:
As your suggestion=EF=BC=8Cadd an ops function for thermal_governor
structure=EF=BC=8Cdefine it in IPA governor, and call it when trips are
changed by userspace(sysfs node).

2.From cdev->state updating perspective:
For example, for gov_power_allocator there are two branches reached to
__thermal_cdev_update.

power_allocator_trottle
        |
allow_maximum_power()[gov_power_allocator.c]
        |
__thermal_cdev_update()[thermal_helpers.c]<<<<<<<(1)
        |
thermal_cdev_set_cur_state()
        |
cdev->ops->set_cur_state()
        |
thermal_notify_cdev_state_update()
        |
     .......


power_allocator_throttle()[gov_power_allocator.c]
        |
allocate_power()
        |
power_actor_set_power()
        |
__thermal_cdev_update()[thermal_helpers.c]<<<<<<(2)
        |
      ......

Add a variable last_state for thermal_cooling_device structure to
record the last target cooling state, and before
thermal_notify_cdev_state_update, determine whether the last_state is
equal to current state. If not equal, then
thermal_notify_cdev_state_update.

static void thermal_cdev_set_cur_state(struct thermal_cooling_device
*cdev,
~                                        unsigned long target)
{
        if (cdev->ops->set_cur_state(cdev, target))
                return;

~       if (cdev->last_state !=3D target)
+               thermal_notify_cdev_state_update(cdev->id, target);
+
+       cdev->last_state =3D target;
+
        thermal_cooling_device_stats_update(cdev, target);
}

In this way, it will only update and notify when the state is changed
which means there's no need to use update flag to make sure it updates
cdev->state only once.

It can avoid a lot of unnecessary notifications, not only when the
temperature drops below the first trip point(at this situation
cdev->state is always 0) but also when the policy is working.

3.Similar to the second method, but an easier one.
Actually, in the set_cur_state ops of every cooling device, it has
already checked whether the last cooling state is equal to current
value or not, and returns 0. Like cpufreq cooling device:
static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
                                unsigned long state)
{
        //.......
        /* Request state should be less than max_level */
        if (state > cpufreq_cdev->max_level)
                return -EINVAL;

        /* Check if the old cooling action is same as new cooling
action */
        if (cpufreq_cdev->cpufreq_state =3D=3D state)
                return 0; //return -EAGAIN;
}

What if return a non-zero value? 1 or -EAGAIN(means thy again)? Then
thermal_cdev_set_cur_state() in __thermal_cdev_update() can return
directly without update and notify.

I prefer method 3. Because there's no more new variable or function
compared to 1 and 2, and it can make code more brief.

Well, what do you think about the three ways? Look forward to your
comments. Thank you!

Best regards,
Di
