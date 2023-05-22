Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4C70B8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjEVJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjEVJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:30:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B0B7;
        Mon, 22 May 2023 02:30:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so1921280e87.2;
        Mon, 22 May 2023 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684747816; x=1687339816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2xyW26ygJSV7jGPDNFX5kKvBpAiH74OJxHDLif1V4o=;
        b=RUD8CW17ehLYABgkufotE7+2qA9MpQEUmH+a8Rzsv+BHTFpkQXkp/vUAoPyUND4WUa
         df8zjLmWIsuyQpd0DvHu/G3O1/2e4FVgynUTVzKZOAHv9L/ks4U2wElYhdG0cnXNDszK
         gTO/PkGc7RM8MyNAW2R1JXFqVuLd8vUvteqAFCV4ZHPafnbrsgCOMF9tMaGlDLolyrMT
         itm3YGRJC6uJ8Sd1fKBuIgsQ3GwQti55DHbBOfA/xI6JndZhdZZLa4YvdkyDekb9MBGh
         QVy2wxgngibHXKXssGnCfKbqsalSZPeUWc3hs2T62tJ5IaU+EyDu2k4A0jQw6RLQ8yJZ
         bd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684747816; x=1687339816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2xyW26ygJSV7jGPDNFX5kKvBpAiH74OJxHDLif1V4o=;
        b=kZ4odup+StFceeCkcrUvVAnLCKKzFx4vpFUqgWJ8JI2FipMpcKPCBBByADdCxwzpQ7
         ynUk8e+Spu5nLPoPUXeB1Hbdnb0Y+erPBUQa6+doC5gEYkwDHWZlR5rN1KSTCDwIqor0
         crGtJ6PionkzZUuDEwwbTVlWICNwOk5oGplCUT0hcNyqEF4zvNYFjIH4nvR5vZXeENNQ
         9aCI2iVDxXcEwflnRYUVqWNhI0xoGaQGkMBiTMaxpVRTARubMRgR2/EytWgyXY5dJik3
         CRj9GKFUiC2+4JImxg2KbPuAlEEKvm0CVZywpv5kI+Y0QeyRpxmLhpGuaBwGD6pZgUFU
         NWNw==
X-Gm-Message-State: AC+VfDyNKzMXtwg85tByvv17jn1WvNKG+epTrb46jUZUWZCEZHTXnXCp
        UHKgXUKeDQHyVIkCaAmhzAD/0UZ5LyfrPUWaPw8=
X-Google-Smtp-Source: ACHHUZ6/K2VPQrqZf4bbMsZ6RsWzfsJGdcrFrCLU2weoNL6fRpXehhPH0QBKWbv2BmkB7pm4G6ojPKMVBze4qdsiKeM=
X-Received: by 2002:ac2:4259:0:b0:4f3:a55a:bace with SMTP id
 m25-20020ac24259000000b004f3a55abacemr2981630lfl.7.1684747815493; Mon, 22 May
 2023 02:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-2-d1bac46db075@freebox.fr> <6e807c05-a990-5692-3f84-2e4153c8c278@linaro.org>
 <905b4150-6e15-4172-10cf-19aa0ebf817c@quicinc.com> <50fc88f9-4304-110c-84e8-15dfdeee062f@linaro.org>
In-Reply-To: <50fc88f9-4304-110c-84e8-15dfdeee062f@linaro.org>
From:   Arnaud Vrac <rawoul@gmail.com>
Date:   Mon, 22 May 2023 11:30:02 +0200
Message-ID: <CAN5H-g4zEkxrUr2_0QZfNHndVqF=L-Bx3OTbKnFjQVmoYc7FyQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 02/11] drm/msm/dpu: use the actual lm maximum
 width instead of a hardcoded value
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jeykumar Sankaran <quic_jeykumar@quicinc.com>,
        Arnaud Vrac <avrac@freebox.fr>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

Le sam. 20 mai 2023 =C3=A0 22:49, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> a =C3=A9crit :
>
> On 20/04/2023 20:47, Jeykumar Sankaran wrote:
> >
> >
> > On 4/19/2023 3:23 PM, Dmitry Baryshkov wrote:
> >> On 19/04/2023 17:41, Arnaud Vrac wrote:
> >>> This avoids using two LMs instead of one when the display width is lo=
wer
> >>> than the maximum supported value. For example on MSM8996/MSM8998, the
> >>> actual maxwidth is 2560, so we would use two LMs for 1280x720 or
> >>> 1920x1080 resolutions, while one is enough.
> >>>
> >>> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> >>
> >> While this looks correct (and following what we have in 4.4), later
> >> vendor kernels specify the topology explicitly. Probably we should
> >> check this with the hw guys, because it might be the following case:
> >> even though a single LM can supply the mode, it will spend more power
> >> compared to two LMs.
> >>
> >>
> > Yes. 2 LM split will allow the HW to run in lower mdp core clock. Can
> > you maintain the split_threshold in the hw catalog until per mode
> > topology is available?
>
> I don't think it warrants the trouble, unless we have a real usecase
> when the device is short of LMs.
>
> Arnaud, I'll mark this patch as Rejected for now, unless it fixes an LM
> shortage for your platform.

It's fine, if I remember correctly I wrote this patch because display
wouldn't work before I fixed the LM pairings on msm8998, but now it's
not a requirement anymore.

>
> >
> > Jeykumar S
> >>> ---
> >>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++-----
> >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>> index 1dc5dbe585723..dd2914726c4f6 100644
> >>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>> @@ -53,8 +53,6 @@
> >>>   #define IDLE_SHORT_TIMEOUT    1
> >>> -#define MAX_HDISPLAY_SPLIT 1080
> >>> -
> >>>   /* timeout in frames waiting for frame done */
> >>>   #define DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES 5
> >>> @@ -568,10 +566,12 @@ static struct msm_display_topology
> >>> dpu_encoder_get_topology(
> >>>        */
> >>>       if (intf_count =3D=3D 2)
> >>>           topology.num_lm =3D 2;
> >>> -    else if (!dpu_kms->catalog->caps->has_3d_merge)
> >>> -        topology.num_lm =3D 1;
> >>> +    else if (dpu_kms->catalog->caps->has_3d_merge &&
> >>> +         dpu_kms->catalog->mixer_count > 0 &&
> >>> +         mode->hdisplay > dpu_kms->catalog->mixer[0].sblk->maxwidth)
> >>> +        topology.num_lm =3D 2;
> >>>       else
> >>> -        topology.num_lm =3D (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? =
2
> >>> : 1;
> >>> +        topology.num_lm =3D 1;
> >>>       if (crtc_state->ctm)
> >>>           topology.num_dspp =3D topology.num_lm;
> >>>
> >>
>
> --
> With best wishes
> Dmitry
>
