Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010906B7565
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCMLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCMLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:10:46 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322D37F3D;
        Mon, 13 Mar 2023 04:10:44 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso6456648ota.1;
        Mon, 13 Mar 2023 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjJqIzPYNA328wueCXjVYeGQDmYHApi9Y9H0kPOvlHY=;
        b=J5/5JjIDsZ1ZCw2co7qrt9UqS4rt7i0U2UsgCerE4I8cAl9e+d9LDwIuIKdcfRhciz
         ER+Uj4GVz73VLMvQpSVuRni6tQpufp5tvZccgQhlzLbb/QKBkcQhZFcLvsYsztrcS+QE
         FF6oSk5McYP0hHpwLB1mWykyWjdWANTrZEkRPUhPeEagr9rkw5h/vGveaveFod19/Kyv
         WfynV7hXxneeylPW0fyD3Rxihyw24dOQ0eeGw9YpzKb7YgViZwVxjI/5ySHVc3hcn80J
         U3mnxbv/9KCnHrF8RNOB7b6672/JTcPf88L24ZqRMfCVf/nV8YDjoLU0Rszk8l+LBYi0
         /cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjJqIzPYNA328wueCXjVYeGQDmYHApi9Y9H0kPOvlHY=;
        b=XNACWy+aNP1FcWW3cpxVh/xbho3htsHFD1/56jMHczBYd0E55kLVlj4sK8hyLdk6E9
         9qxUpISgi8oMYNzROebCD61JUGctzPwzlZB4f/kAaNEfOdnecF2IVRLtQe2C/W2sl8Mz
         UZQMUJAs10kwLqXcmkRFVfc+uewch/TOr9Ct1bKVHjf+jszVlnsi4CHAy80kA1j2KwYZ
         DoRxlPCHJgi5PLhr/2VdT4Th3ZnKsBZd08BWoS62y8TvjyqbPtPI5CpS2FQIWsbe0Akg
         YVonno/QEPcjfKX7pjRAreX2hKyIiPTf1GxZy6Rk5U3EbeOt3ITFcpS3EEJxehOZU+Jo
         U65Q==
X-Gm-Message-State: AO0yUKVVyUlKKZfFMxru9RLgqbJgKG8dLUxFQBi4wp37BE7+Qe8B9mP8
        kBIcycv1gtu0N3P3bvn1xTPz4HPGItXJYzcOkWuH/0cHs8g=
X-Google-Smtp-Source: AK7set/dlszNoWKktQAvP2JtyfjALxz7y85V1hMPELFSCRvNxaP+l36Z2B6h35ry26L1mvVnnzNVsYuFFm2Oef592/k=
X-Received: by 2002:a05:6830:308e:b0:68d:b51a:5cf6 with SMTP id
 g14-20020a056830308e00b0068db51a5cf6mr10847030ots.7.1678705843843; Mon, 13
 Mar 2023 04:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135515.1232-1-di.shen@unisoc.com> <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
 <CAB8ipk_T5RUZxD42d9wg_i8-3UXHFP=4Ffa_NH8Nm7FnyW2Ppw@mail.gmail.com> <8727651b-88ec-efe7-eed2-1ff08faf22b8@arm.com>
In-Reply-To: <8727651b-88ec-efe7-eed2-1ff08faf22b8@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 13 Mar 2023 19:10:33 +0800
Message-ID: <CAB8ipk8dwkaqx7q_57Ehd5OZUfAJKtD_Bk2drpx+Op4grquAdQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On Mon, Mar 13, 2023 at 5:35=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Xuewen,
>
> On 3/13/23 01:40, Xuewen Yan wrote:
> > Hi Lukasz
> >
> > On Fri, Mar 10, 2023 at 11:56=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>
> >> Hi Di,
> >>
> >> On 3/9/23 13:55, Di Shen wrote:
> >>> Commit 0952177f2a1f (thermal/core/power_allocator: Update once coolin=
g devices when temp is low)
> >>> add a update flag to update cooling device only once when temp is low=
.
> >>> But when the switch_on_temp is set to be a higher value, the cooling =
device state
> >>> may not be reset to max, because the last_temp is smaller than the sw=
itch_on_temp.
> >>>
> >>> For example:
> >>> First:
> >>> swicth_on_temp=3D70 control_temp=3D85;
> >>>
> >>> Then userspace change the trip_temp:
> >>> swicth_on_temp=3D45 control_temp=3D55 cur_temp=3D54
> >>>
> >>> Then userspace reset the trip_temp:
> >>> swicth_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
> >>>
> >>> At this time, the cooling device state should be reset to be max.
> >>> However, because cur_temp(57) < switch_on_temp(70)
> >>> last_temp(54) < swicth_on_temp(70) --> update =3D false
> >>> When update is false, the cooling device state can not be reset.
> >>
> >> That's a tricky use case. How is that now possible,
> >
> > We use the trip_temp in the Android System. Often, we set different
> > control temperatures in different scenarios,
> > and when we change the switch_on_temp from small to bigger, we find
> > the power can not be reset to be max.
>
> I see, thanks for letting me know that this is Android.
>
> >
> >
> >>>
> >>> So delete the update condition, so that the cooling device state
> >>> could be reset.
> >>
> >> IMO this is not the desired solution. Daniel reported the issue that
> >> IPA triggers the event sent to user-space even when there is no need.
> >> That's the motivation for the 0952177f2a1f change.
> >>
> >> To address your scenario properly, we need an interface which allows
> >> to respond properly for such situation when someone from user-space
> >> writes a new value to something fundamental as trip point.
> >>
> >> You also have a kernel config enabled:
> >> CONFIG_THERMAL_WRITABLE_TRIPS
> >> which IMO is only for debug kernels for system integrator (according
> >> to the Kconfig description).
> >
> >   Yes, we use it to meet the temperature control needs of different sce=
narios.
> > And now in android with google's GKI2.0, the config must be opened.
>
> OK
>
> >
> >>
> >> When you disable this config in your deploy/product kernel
> >> than this issue would disappear.
> >>
> >>>
> >>> Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once coolin=
g devices when temp is low)
> >>> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >>> ---
> >>>    drivers/thermal/gov_power_allocator.c | 9 +++------
> >>>    1 file changed, 3 insertions(+), 6 deletions(-)
> >>>
> >>
> >> That's why IMO this is not the solution.
> >
> > Yes, but I think we should fix the bug, although the
> > CONFIG_THERMAL_WRITABLE_TRIPS is just for debugging.
> > How about record the last_trip_temp, and when the last_temp >
> > last_trip_temp, set the update tobe true?
>
> Yes, if that config is used in Android then we must fix it.
>
> That last_trip_temp makes sense (but maybe name it last_switch_on_temp).
> Please put that new field into the IPA local
> struct power_allocator_params. We should store the trip temp
> value there every time power_allocator_throttle() is called.
> That can be called due to a write from user-space w/ a new trip point
> value, so should be OK.

Thanks for the suggestion. We would send the patch-v2 as soon as possible.

Thanks!
BR
xuewen
