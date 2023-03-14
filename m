Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03126B88B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCNCli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCNClg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:41:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF648736D;
        Mon, 13 Mar 2023 19:41:34 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so7845021otv.0;
        Mon, 13 Mar 2023 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678761693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE/nGLdvkwfVUr4AhhgCtbqbn2lhxYvpOjtLEftaoNs=;
        b=Kvnx/PXP2K9FTtl53AwFntps/LNg9+zresClR9bux70AkKpDxkfxxl+HqsLOzw9I1/
         bgWkKMalvIz6VLb3U2+GDyQtLCJ65Huyieq/HbY3yH+Yk7hsTB0XmQykwLV2u5KLtX43
         aZqwN60mNDX1yvDovM5kz+xatEpRiqV6WIhMCc4vOLYK093kEOHSJpEP5z6KfElOvo/M
         dgft2WOh1taV4c8oqpgV5mV6E/vXb5szO9LhMPfvR2NBKHkekN4bZbnDdu74O2luYAK6
         Bs7UWHZpm73TglZ8NL+EPrVSbpomALoRo/b/M4fjdO8nhM4EpYsvrb2Kca1ck9Piic+a
         d04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678761693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE/nGLdvkwfVUr4AhhgCtbqbn2lhxYvpOjtLEftaoNs=;
        b=DkXF/fm6/QyQclJgWQJyxANW2LcF/wPQfKjaSR3DgiOjQvyYo/lQbXAKA4n3ej4zfc
         wvlssmC4xKvc5JIRMi7VZ1oeDby5Ffjzc16CWuYzupfEsKk9vOq+NdBQN+CfFsVrxIf0
         t+Ni26hIRXku6mKwXWwQ430kNLpd8gqFSmXQE9tRqIXtrzssllq8Ct6B9Gr5zC2pYAhj
         uZUcx1KqBeFklM6bsM+u8iRisFobUrwClntD98irBLoAsoJtDlVwNezuTY1uoZwZsVmZ
         +78EcyVdqThADQiFYf7dL/P8LZwG+wf4B+N680w2rBVBqucXUOBrlsNh+twZaFlj2nYp
         Y7zw==
X-Gm-Message-State: AO0yUKWqFabEb8iiV+wvIB3YK9Z9AcYTJeD/kE20N/pKRduzDPB5lhn8
        JFobTPm2f3e89gLjmU42dH2pKuHqj5NU9W6KtnU=
X-Google-Smtp-Source: AK7set+dZp5MJC+ixj38X8XdXwUuUNnBBW/efhr7qTl680muyO+JxZ1L2fuBf9IYWlnOZ6M/EXfPkB6KcxU9gmnFMHQ=
X-Received: by 2002:a9d:5f87:0:b0:68d:7557:f74c with SMTP id
 g7-20020a9d5f87000000b0068d7557f74cmr12404212oti.7.1678761693376; Mon, 13 Mar
 2023 19:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135515.1232-1-di.shen@unisoc.com> <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
 <CAB8ipk_T5RUZxD42d9wg_i8-3UXHFP=4Ffa_NH8Nm7FnyW2Ppw@mail.gmail.com>
 <8727651b-88ec-efe7-eed2-1ff08faf22b8@arm.com> <CAB8ipk8dwkaqx7q_57Ehd5OZUfAJKtD_Bk2drpx+Op4grquAdQ@mail.gmail.com>
 <f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com>
In-Reply-To: <f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 14 Mar 2023 10:41:22 +0800
Message-ID: <CAB8ipk9rcZh9MF1PaT=4tfhX0mknNL2PdmJQRWHtRNeiXf9oag@mail.gmail.com>
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
To:     Lukasz Luba <lukasz.luba@arm.com>, orson.zhai@unisoc.com,
        orsonzhai@gmail.com, Chunyan Zhang <zhang.lyra@gmail.com>
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

add Orson and lyra

Hi Lukasz

On Mon, Mar 13, 2023 at 7:18=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 3/13/23 11:10, Xuewen Yan wrote:
> > Hi Lukasz
> >
> > On Mon, Mar 13, 2023 at 5:35=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >> Hi Xuewen,
> >>
> >> On 3/13/23 01:40, Xuewen Yan wrote:
> >>> Hi Lukasz
> >>>
> >>> On Fri, Mar 10, 2023 at 11:56=E2=80=AFPM Lukasz Luba <lukasz.luba@arm=
.com> wrote:
> >>>>
> >>>> Hi Di,
> >>>>
> >>>> On 3/9/23 13:55, Di Shen wrote:
> >>>>> Commit 0952177f2a1f (thermal/core/power_allocator: Update once cool=
ing devices when temp is low)
> >>>>> add a update flag to update cooling device only once when temp is l=
ow.
> >>>>> But when the switch_on_temp is set to be a higher value, the coolin=
g device state
> >>>>> may not be reset to max, because the last_temp is smaller than the =
switch_on_temp.
> >>>>>
> >>>>> For example:
> >>>>> First:
> >>>>> swicth_on_temp=3D70 control_temp=3D85;
> >>>>>
> >>>>> Then userspace change the trip_temp:
> >>>>> swicth_on_temp=3D45 control_temp=3D55 cur_temp=3D54
> >>>>>
> >>>>> Then userspace reset the trip_temp:
> >>>>> swicth_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
> >>>>>
> >>>>> At this time, the cooling device state should be reset to be max.
> >>>>> However, because cur_temp(57) < switch_on_temp(70)
> >>>>> last_temp(54) < swicth_on_temp(70) --> update =3D false
> >>>>> When update is false, the cooling device state can not be reset.
> >>>>
> >>>> That's a tricky use case. How is that now possible,
> >>>
> >>> We use the trip_temp in the Android System. Often, we set different
> >>> control temperatures in different scenarios,
> >>> and when we change the switch_on_temp from small to bigger, we find
> >>> the power can not be reset to be max.
> >>
> >> I see, thanks for letting me know that this is Android.
> >>
> >>>
> >>>
> >>>>>
> >>>>> So delete the update condition, so that the cooling device state
> >>>>> could be reset.
> >>>>
> >>>> IMO this is not the desired solution. Daniel reported the issue that
> >>>> IPA triggers the event sent to user-space even when there is no need=
.
> >>>> That's the motivation for the 0952177f2a1f change.
> >>>>
> >>>> To address your scenario properly, we need an interface which allows
> >>>> to respond properly for such situation when someone from user-space
> >>>> writes a new value to something fundamental as trip point.
> >>>>
> >>>> You also have a kernel config enabled:
> >>>> CONFIG_THERMAL_WRITABLE_TRIPS
> >>>> which IMO is only for debug kernels for system integrator (according
> >>>> to the Kconfig description).
> >>>
> >>>    Yes, we use it to meet the temperature control needs of different =
scenarios.
> >>> And now in android with google's GKI2.0, the config must be opened.
> >>
> >> OK
> >>
> >>>
> >>>>
> >>>> When you disable this config in your deploy/product kernel
> >>>> than this issue would disappear.
> >>>>
> >>>>>
> >>>>> Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cool=
ing devices when temp is low)
> >>>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >>>>> ---
> >>>>>     drivers/thermal/gov_power_allocator.c | 9 +++------
> >>>>>     1 file changed, 3 insertions(+), 6 deletions(-)
> >>>>>
> >>>>
> >>>> That's why IMO this is not the solution.
> >>>
> >>> Yes, but I think we should fix the bug, although the
> >>> CONFIG_THERMAL_WRITABLE_TRIPS is just for debugging.
> >>> How about record the last_trip_temp, and when the last_temp >
> >>> last_trip_temp, set the update tobe true?
> >>
> >> Yes, if that config is used in Android then we must fix it.
> >>
> >> That last_trip_temp makes sense (but maybe name it last_switch_on_temp=
).
> >> Please put that new field into the IPA local
> >> struct power_allocator_params. We should store the trip temp
> >> value there every time power_allocator_throttle() is called.
> >> That can be called due to a write from user-space w/ a new trip point
> >> value, so should be OK.
> >
> > Thanks for the suggestion. We would send the patch-v2 as soon as possib=
le.
>
> Thanks!
> I'll review that and check on my board.
> BTW, which board/device you use with this IPA? Maybe I can buy it
> and also test to capture such regression in future.

We use our company(unisoc)'s mobile phone, and the development board
with the same chip should be available in the market. And Orson would
help and then reply to you.

Thanks!
BR
xuewen
