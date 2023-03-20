Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9306C1F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCTSJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCTSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:08:49 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADDB3D925;
        Mon, 20 Mar 2023 11:02:44 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id g7-20020a4ae887000000b0053b544f7e8aso2861ooe.12;
        Mon, 20 Mar 2023 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v9R5gnCY6fdHFgH5PKyKB7qBIPOqi3I48b2pUQUxIw=;
        b=BEvixRIUWdZ++zol6HP2FDqAImpYFJVOYn8eoRuuKOqhwahmC5d/IShmuHYtg/dggD
         3EsPNGlgrzf3IyYJpLbYHXFu8OZRMdgljUUNnsAAatON5W6gxhe148gVIkWTWm1LpcyH
         NMPEIitAs2+d1b/13yFpAG73H34vLdQEFs9dWGgKvahbsID5XBZ7sV54H5Bh0ob34n+J
         7XPeZEITpNd+s7g0oQ0esjbgBy8GrSgN7cRPw1eCSlQaITl6H6mw4Fs3qheNGRszqgUW
         o4pRJqL6d/zZ4NpVHx3Tu6VHbn0IG7aG4hIKcvI2nNJ1QA5+tqQZ/XmnTgoHMBPvN5u+
         NmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v9R5gnCY6fdHFgH5PKyKB7qBIPOqi3I48b2pUQUxIw=;
        b=z36mc2LP5eWALS0spYMKUxktM75feNjda+2FfsqZm/aJXZi8mVWCb1K7w+Vkgcg5eF
         6iimFvL8x8FpiE1MeXib/FdoT4FGmDF9Fu25j5LEVy0BT5LVkiR3Q9566diweXOLhR8x
         Homwb/HB/MhYp2W3KHxvwQ+l1NMUWDr48c/pRctWYc7LbjNbFp/kKmvVH2zKjAz/qtf3
         2x1Du10E4W56B0MJw1XwSVAlNrxzacRTwV1XRzwd96LJfkYy+yuMlzxxHiUmUvcSjRnX
         qk8Lzipm+oxoIJpTiOMHp1h1R4Lm+igJpv/VZ+2COttT9m07yaXK17UiwOQ4ud/tKUUn
         L8jg==
X-Gm-Message-State: AO0yUKUydtfQIpFJ2CbU1t/+Jlceu50AGTP2Q+ifGm4pvscRi60fE29J
        zeUhc66rPTY8VBzMmKehJCfDErFLl/z9OI7o+vw=
X-Google-Smtp-Source: AK7set9AD56qu+Gun/6aRs1RMmgFg9rKa49NcMCWQF/Z2GZO0K8Lp2H8d2haPlsGoAz5zglTnBSuCq77k3G24DUgNIE=
X-Received: by 2002:a4a:a301:0:b0:525:5f43:215a with SMTP id
 q1-20020a4aa301000000b005255f43215amr304148ool.1.1679335347762; Mon, 20 Mar
 2023 11:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
 <20230223-topic-opp-v3-4-5f22163cd1df@linaro.org> <2f2467d1-f5f3-86dd-edba-fc26e60d142f@marek.ca>
 <8e9fc1c0-f74f-ba82-fade-31212637d6bb@linaro.org>
In-Reply-To: <8e9fc1c0-f74f-ba82-fade-31212637d6bb@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Mar 2023 11:02:16 -0700
Message-ID: <CAF6AEGvYJg1r4A7bvfNrck-wfWv7+sQ8DnN=R_RaSK=tE1tzGw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v3 4/7] drm/msm/a2xx: Implement .gpu_busy
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 9:54=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 24.02.2023 16:04, Jonathan Marek wrote:
> > This won't work because a2xx freedreno userspace expects to own all the=
 perfcounters.
> >
> > This will break perfcounters for userspace, and when userspace isn't us=
ing perfcounters, this won't count correctly because userspace writes 0 to =
CP_PERFMON_CNTL at the start of every submit.
>
> Rob, would you be willing to take this without the a2xx bits? It
> should still be fine, except without devfreq. Not that we had
> any significant sort of scaling on a2xx before.

Yup, sounds like a plan

BR,
-R

> Konrad
> >
> > On 2/23/23 5:52 AM, Konrad Dybcio wrote:
> >> Implement gpu_busy based on the downstream msm-3.4 code [1]. This
> >> allows us to use devfreq on this old old old hardware!
> >>
> >> [1] https://github.com/LineageOS/android_kernel_sony_apq8064/blob/line=
age-16.0/drivers/gpu/msm/adreno_a2xx.c#L1975
> >>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>   drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 26 +++++++++++++++++++++++++=
+
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a2xx_gpu.c
> >> index c67089a7ebc1..104bdf28cdaf 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> >> @@ -481,6 +481,31 @@ a2xx_create_address_space(struct msm_gpu *gpu, st=
ruct platform_device *pdev)
> >>       return aspace;
> >>   }
> >>   +/* While the precise size of this field is unknown, it holds at lea=
st these three values.. */
> >> +static u64 a2xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_samp=
le_rate)
> >> +{
> >> +    u64 busy_cycles;
> >> +
> >> +    /* Freeze the counter */
> >> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_FREEZE);
> >> +
> >> +    busy_cycles =3D gpu_read64(gpu, REG_A2XX_RBBM_PERFCOUNTER1_LO);
> >> +
> >> +    /* Reset the counter */
> >> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_RESET);
> >> +
> >> +    /* Re-enable the performance monitors */
> >> +    gpu_rmw(gpu, REG_A2XX_RBBM_PM_OVERRIDE2,
> >> +        A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE,
> >> +        A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE);
> >> +    gpu_write(gpu, REG_A2XX_RBBM_PERFCOUNTER1_SELECT, 1);
> >> +    gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_ENABLE);
> >> +
> >> +    *out_sample_rate =3D clk_get_rate(gpu->core_clk);
> >> +
> >> +    return busy_cycles;
> >> +}
> >> +
> >>   static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer =
*ring)
> >>   {
> >>       ring->memptrs->rptr =3D gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
> >> @@ -502,6 +527,7 @@ static const struct adreno_gpu_funcs funcs =3D {
> >>   #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> >>           .show =3D adreno_show,
> >>   #endif
> >> +        .gpu_busy =3D a2xx_gpu_busy,
> >>           .gpu_state_get =3D a2xx_gpu_state_get,
> >>           .gpu_state_put =3D adreno_gpu_state_put,
> >>           .create_address_space =3D a2xx_create_address_space,
> >>
