Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACD6744E3B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGBO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGBO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:56:37 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC823C3;
        Sun,  2 Jul 2023 07:56:36 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5636425bf98so1765200eaf.1;
        Sun, 02 Jul 2023 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688309796; x=1690901796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnmGb9vKhvzi0XZPMqQ1ONABGe8k3k8AgsBTL2GUhi4=;
        b=QBxJ8F4qsF9q3pHTHu1sm2WXY6dxOl4OxFU4lGR0w/kk6B32FeW77ydj3AiWQNjtr4
         gPh0kcsXER7eaXmpG1zZxMVtmYjmDNTv26A9IP/yjZsZ663ouyL4CrEn0L/NukfCMwEr
         giF3RLjszk0crTJ9soBbz/pP0b2jJhRepfiPxwEb2L82cOsmY0HRGUElgspT9j9M7cQy
         dPNxd09U+eBIp8MlKwRO0RiJMKResR4jqGcmcH9RtobQha4s/XR3rcwqeluO2lXOsPzD
         BRFcmm5LTN8N8lsNJD2TG+r6Wht/3u/7tRBm05ghgt5GxzNWXXKTQ+tnuBPu4BT8TKJa
         cO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688309796; x=1690901796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnmGb9vKhvzi0XZPMqQ1ONABGe8k3k8AgsBTL2GUhi4=;
        b=KCgU7BoNfi3Svj3gweGVHlVkVVlLo0yIvYvE4YG2H3iRjriJOIJXAhGHsXQQIx8L6Z
         ZBq/arShRsiOQoGJA9iINMQyjCnrP2d5bBfruQs8sJhovzHtsKaiqJwjkBmUChdW1dlH
         /BUnCrTCrnVy1OUUDZz9PWiuzgZlyw2o6mLymc9JWqaLrpG9NuDZPQHityqoWVq40FfG
         DppIjg2Rj6uzuRg3GGZVTHsfLX7Jg4TX2vz28x2f4VVKhpqeayPzX2uhTaFVq8t01jsh
         3cTu4h14GJMLcvGkKOp6zmm1FWR2juhAHBkVUDzkIkiOFmCJpJgknm4MAs4z8AqumKwU
         6AIw==
X-Gm-Message-State: AC+VfDzbbGxY7txCaH92ApxaZD2PYhT1Pav65s+t7xrV354uir6Dp04+
        tHVS0qnn7p1mxwiGBdx6d5OPMPEWhrmVX3R0VWw=
X-Google-Smtp-Source: ACHHUZ48R2opv8q9VHF9PDqXVetMrGp5glWf4N9VKvHQgw3ILmXreuejWtmmif3rgCMtfF9lIquqA6gJLD6NiiRqzrU=
X-Received: by 2002:a4a:4997:0:b0:560:c32a:8e10 with SMTP id
 z145-20020a4a4997000000b00560c32a8e10mr4769999ooa.0.1688309796025; Sun, 02
 Jul 2023 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org>
 <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
 <CAA8EJpripp+Hf=GvCit75naGQqK8owHzPb+VuYHin393HcFPwA@mail.gmail.com>
 <CAF6AEGsdPhWO+hw3FHiqtMfiF34_RtrvvS4apykHNBbtmdj7fQ@mail.gmail.com> <5e70cb31-61a7-55d7-b3a5-5051e6d338e9@linaro.org>
In-Reply-To: <5e70cb31-61a7-55d7-b3a5-5051e6d338e9@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 2 Jul 2023 07:56:24 -0700
Message-ID: <CAF6AEGv3S2FUgSsCTLOtp63ge5ONSMQfS7Yn6nxr6b8a6Q5YZg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Assign revn to A635
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>
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

On Sun, Jul 2, 2023 at 7:34=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 02/07/2023 17:31, Rob Clark wrote:
> > On Sat, Jul 1, 2023 at 5:24=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Sat, 1 Jul 2023 at 18:50, Rob Clark <robdclark@gmail.com> wrote:
> >>>
> >>> On Fri, Jun 30, 2023 at 4:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@=
linaro.org> wrote:
> >>>>
> >>>> Recently, a WARN_ON() was introduced to ensure that revn is filled b=
efore
> >>>> adreno_is_aXYZ is called. This however doesn't work very well when r=
evn is
> >>>> 0 by design (such as for A635). Fill it in as a stopgap solution for
> >>>> -fixes.
> >>>>
> >>>> Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified =
before being set")
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>>> Changes in v2:
> >>>> - add fixes
> >>>> - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-505=
6e09c08fb@linaro.org
> >>>> ---
> >>>>   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >>>>   1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gp=
u/drm/msm/adreno/adreno_device.c
> >>>> index cb94cfd137a8..8ea7eae9fc52 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >>>> @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
> >>>>                  .address_space_size =3D SZ_16G,
> >>>>          }, {
> >>>>                  .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> >>>> +               .revn =3D 635,
> >>>>                  .fw =3D {
> >>>>                          [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> >>>>                          [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> >>>>
> >>>
> >>> hmm, I realized a problem with this, it would change what
> >>> MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
> >>> former should be "harmless", although it isn't a good idea for uabi
> >>> changes to be a side effect of a fix.  The latter is more problematic=
.
> >>
> >> I'd say MSM_PARAM_GPU_ID is broken for 635 anyway (won't it return 0
> >> in this case)?
> >> So the new value should be correct.
> >
> > no, it is very much intentional that GPU_ID returns 0 for newer GPUs,
> > userspace should be matching on CHIP_ID.  (Also, we should be moving
> > away from trying to infer generation/etc from CHIP_ID.. userspace is
> > farther ahead of the kernel on this.)
>
> Thanks for the explanation. So in theory we can change this to always
> return 0? Or must we keep it to keep UABI / compatibility?
>
> I'm trying to understand if we can drop revn at all.

I'm not sure how likely it is that someone would try a very old mesa
with a new kernel, but that combo would break if we dropped revn
completely and returned 0 for GPU_ID.  But I would like to move away
from using revn internally.  (And probably move away from the patch-id
wildcard matching, and instead just explicitly list all known patch-id
values so we can start treating CHIP_ID as just an opaque identifier.)

BR,
-R

>
> >
> >> But more importantly, why are we exporting speedbin in
> >> MSM_PARAM_CHIP_ID only if there is no revn? And why are we exporting
> >> the speedbin at all as a part of CHIP_ID?
> >
> > Basically just being paranoid about not changing uabi.  It probably
> > would be ok to export the speedbin for all, but I'd have to double
> > check mesa version history.
>
> Thanks!
>
> >
> > BR,
> > -R
> >
> >>>
> >>> I think I'm leaning more towards reverting commit cc943f43ece7
> >>> ("drm/msm/adreno: warn if chip revn is verified before being set") fo=
r
> >>> -fixes.  I'm still thinking about options for a longer term fix.
> >>>
> >>> BR,
> >>> -R
> >>>
> >>>
> >>>> ---
> >>>> base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> >>>> change-id: 20230628-topic-a635-1b3c2c987417
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>
> >>
> >>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
> --
> With best wishes
> Dmitry
>
