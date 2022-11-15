Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8939E62A143
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKOSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKOSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:23:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A21740D;
        Tue, 15 Nov 2022 10:22:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 21so23132303edv.3;
        Tue, 15 Nov 2022 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbeEc7tgUbO+RNH4gJ0zEeAfLqkbBq1WScC8tYctFRY=;
        b=nsNlhXlut2VAlFrUr+ZNHYytJkb2Q+To7TVKHr0kGwAI0txcGc4Q0Bm249ge48pykr
         cqLzPnJS478Z33/SM8eWnbD9DeOu69/zg0e0ga7idRNGbWA0Xm1Yr1Amd57+bRHaA+pc
         jtfKWFLPCe6bPgLfHhYGKVlWMws8C264+iZfUviNzMJFqt9uTZ3NyP+Mqw3ZRSiZZSdu
         nGiDPQ57OW9L+HRJyujTZMLSTUnidS7+Vpy4PxbI3iChellQEIAFebQMGzc6CfAsCbs5
         l1uEkvdieE7UN+RzmnOAiaPnNhCZoF35XYY/gFrByUWGru/2U6dazhVQhJjR5NynSen1
         fW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbeEc7tgUbO+RNH4gJ0zEeAfLqkbBq1WScC8tYctFRY=;
        b=tMYY7OtVj+LqqyWv5oHeRFryZ4Elur9HPzCk+1kEC2mxop2DEdUUyTmbc2vqbEW2R+
         +POarycyuv+wroQwQIY9hC37wePhkH/n5KBQvLXreNSDGZTSHrbmY47sAiID6bwVc8sr
         fCyaPkNS3Tg9L2tmWb0udg8K27RoyeQT57wcfaxRGFx2dIrywyzbStePUn4EM1IMOkvh
         5BrNe6gXA4TiXgWeXqaRTrQ/sl7a8L/7urB7veijKDmPVbbX3CSz2uMq74CNEnXHRDmK
         Qv+V3cClPONLKBA5P7s3u8JWELocqO+MHFqwy6SQbC6xD1Ixz14sNGGzLKBICf6jIkqF
         x4yw==
X-Gm-Message-State: ANoB5pmkYe2L788oE69Jblm8APyUZ4938wnAIlIVZzGX4ovmWnWufkd4
        UABzFfMS+kKNyNTNPS0nma0ydWAYB0XO/RxrkFc=
X-Google-Smtp-Source: AA0mqf76Ix+TXvlQ4nWw8Pb8P1uTYICxMdANSvauu4I55iDfLYTMQg8sohKZfZzMNGcER9gEWYNfy/6Ob4zHDx4w4bs=
X-Received: by 2002:aa7:df90:0:b0:461:37c2:e85c with SMTP id
 b16-20020aa7df90000000b0046137c2e85cmr15610362edy.74.1668536578133; Tue, 15
 Nov 2022 10:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20221115155535.1615278-1-robdclark@gmail.com> <CAD=FV=VJKTHf7qLZkygfnMRSjXEdQ09opCpFM2brUc=uiTGyTw@mail.gmail.com>
In-Reply-To: <CAD=FV=VJKTHf7qLZkygfnMRSjXEdQ09opCpFM2brUc=uiTGyTw@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 15 Nov 2022 10:22:46 -0800
Message-ID: <CAPaKu7T-NxfmagYfHUzSZw044+Py9Tmm4Oo9zq56v07BJ0ynvA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Enable clamp_to_idle for 7c3
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Nov 15, 2022 at 8:01 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Nov 15, 2022 at 7:55 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This was overlooked.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
