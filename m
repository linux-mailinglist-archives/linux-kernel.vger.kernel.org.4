Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6A6973A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjBOB2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjBOB2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:28:36 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19625469A;
        Tue, 14 Feb 2023 17:28:36 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bd6so14566986oib.6;
        Tue, 14 Feb 2023 17:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wP7ZSWKSYiSNh4//0LGY48SytGVZ1Q61Ky7oicSasw4=;
        b=dChf08Fgnzc/7i6cHdWw4ZCN8pOkax0iU+IhPt21tPCgPwuXypoS40QqLbiAv/33P8
         /3K6c9U99sy0+Gx2dYpPoxWKvQKpZkuOlJ0SeeZQYbJC0lXEaAAXc92slmCULAKqBRSI
         PKQWWXZ90P4WZY9iZJx6zI2Lk6OelHvcgkQXxGBMuVKTasv+qKRcNSgV7Og3tsPQMPCN
         im5nOOY8X8jOROq8eTUDRr0lmjhVgmnHtfhLdzks8zgWdJc/7/bLgwOOAhy3X8lKliCs
         P8R6uQntT9k6532jw0Qr1bDlMapQ3R9JwbNo61VTJILAf3rla3wOUk1F+dUccL+8kzsm
         bvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP7ZSWKSYiSNh4//0LGY48SytGVZ1Q61Ky7oicSasw4=;
        b=kG1TgTvuU1KPImnqewL8k9o09hSljKHNVW2gzcwLeJQjNdeJRj29m5DGNuAD5TcV16
         lGeHEmTnCwcr2dtQaidD/hY7DgHejFk3b7mwrUvr6pc9/W1uHOtaAGl0JOtYm3ZZaF5D
         lRNjDCU4wcLx0Mpic6vuOXTtFc3/Ky6MU0Rjuvf8qn/u+MLFmviLDIeQ5z2hb2wTT8L3
         5SzCUvgd+eAXxL+fq3hGSfGrwTjxyYCErRmnuZnQp9DZRKgqbMvsSsK2QQ1BZGtGfr+7
         dJWZH1HbhbQ1ztLQDcelD8UBYMl93P+uvKlHKZCedA+EkgW7qQOGiP+ONSiANdaynbp9
         QVNA==
X-Gm-Message-State: AO0yUKWYhtC/LjO28ueg2/sJAPN/gTlTOi0BGlmfPGOSa+MfF+lKO2AU
        3FoisB7ePZEnxNkMJrLV3Y5E17ugV0ZNj9oKpDlm2RrX
X-Google-Smtp-Source: AK7set/EfopdPMu3y6nt7yUm2rlRHgHLya+Z6RM5IvHr0a1MZI40AQ50Jr0ypH+faKcjsdOkWLzLFYp9mgf3o4zXExM=
X-Received: by 2002:aca:d743:0:b0:37d:81a9:5103 with SMTP id
 o64-20020acad743000000b0037d81a95103mr52567oig.38.1676424515344; Tue, 14 Feb
 2023 17:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-11-konrad.dybcio@linaro.org> <CAF6AEGva3ecxTOx3Yb+Wh-1K=jYA3tDo_aXg09jS9pzJupYExQ@mail.gmail.com>
 <a4627ca5-46e6-2f32-c0e2-a85990e02f54@linaro.org> <1c57fcfd-8e94-649b-df6f-655626f94454@linaro.org>
In-Reply-To: <1c57fcfd-8e94-649b-df6f-655626f94454@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 14 Feb 2023 17:28:50 -0800
Message-ID: <CAF6AEGs=7TxfUPOu1aP09WsehCwYHnZE_oDoZ3KOzrqY=NDrbA@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] drm/msm/a6xx: Fix up A6XX protected registers
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 4:38 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 15.02.2023 01:10, Dmitry Baryshkov wrote:
> > On 14/02/2023 23:56, Rob Clark wrote:
> >> On Tue, Feb 14, 2023 at 9:32 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>
> >>> One of the protected ranges was too small (compared to the data we
> >>> have downstream). Fix it.
> >>>
> >>> Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>> index 503c750216e6..d6b38bfdb3b4 100644
> >>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>> @@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
> >>>          A6XX_PROTECT_NORDWR(0x00800, 0x0082),
> >>>          A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
> >>>          A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
> >>> -       A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
> >>> +       A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),
> >>
> >> Nak, this is intentional, we need userspace to be able to configure
> >> the CP counters.  Otherwise this would break fdperf, perfetto, etc
> >>
> >> (although maybe we should comment where we diverge from downstream)
> >
> > Yes, please. Otherwise it is extremely hard to understand the reason for diversion between the vendor driver and our one.
> +1
>
> I am content with dropping this patch from this series, so long
> as you leave a clue for others to not scratch their heads on this!

Yeah, I admit it is kinda a trap as-is.  And makes things less obvious
what to do when porting from downstream.  When I get a few minutes
I'll double check that there weren't any other exceptions (I don't
think they were but it has been a while) and add some comments.

BR,
-R

> Konrad
> >
> >>
> >> BR,
> >> -R
> >>
> >>>          A6XX_PROTECT_NORDWR(0x00900, 0x004d),
> >>>          A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
> >>>          A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
> >>> --
> >>> 2.39.1
> >>>
> >
