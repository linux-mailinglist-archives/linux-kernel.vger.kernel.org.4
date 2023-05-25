Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3371127C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjEYRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:39:13 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78FB6;
        Thu, 25 May 2023 10:39:12 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-54fd177fbd4so419515eaf.3;
        Thu, 25 May 2023 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685036351; x=1687628351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4D8c9QPyqmoOXQDae1retuejjcC/UV6PHLGp3fhhjw=;
        b=cWK/TeSz7AD4BvpRQaMJ2AbrRrrf6WKrpQ31ln3A9MDdvoh1Sg6u4XectXi9T9z/Tw
         AYcM/jmSiuWiW/Y7cSut9dkxmvSSnwynvrd/RkP+sd0XxRZnxS+m/nhwBpUj9pyCG75Q
         +/Fx/Dda9E8NlcWKvp5PBiYBt5GOwUYvJdn7h4zEzj4f6dKV0Ug8MSbiukNwXryGzGpE
         JjdQSNxOE4Ed6PLcSO6QunQ4XoQx8q+2pOwv8yPRAdNm8sBNmLYrcuRZ4IAkGRBgdh41
         aTGtHXos9bezeG3UDyLvDbzDWLyl0jfA4i5JLxhgz5/07y5O7XOsgLfctZEMvW8kbgfa
         JGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036351; x=1687628351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4D8c9QPyqmoOXQDae1retuejjcC/UV6PHLGp3fhhjw=;
        b=VtTSHVjSRaVLoeWHJlGKX1EimQ75DN4WPAWn5X7hOVXmM96UGnL0Gtp82mHnEaWFRx
         jzR8SQ4WqCPUOiTWQ5tj9APP6CjsjB+pfW0UOI0M4Gl4DHvlGZDx9wWzT34n64bym3ym
         JOzSFSax7x3KrLIBldWNlE9FnoHOPkNXmNpvL/qTaN9Q0y2XMdHWlTJuJM1b9xMb1qVz
         ZuG9Z6a88Iwk/m4po6jIq7XgKJCw7DPKlhlL20mshTYSUTDIl629VcBNRmfopS4GLDBv
         3VUQLUqLZZDO4I/VUdlfy3XkEM9I5xGDim7/f/Lvu9uuvxtbIeicrn5wwQQlIDWWL7Fq
         7xTQ==
X-Gm-Message-State: AC+VfDwzYwfJ6K83ukneR8xSHbm0wKGqRBLZFo2Ck4PnDWonrSbNthsu
        A3lnMjpTDIAW4HHfbNyHaLx2PQpyj2lK+fV7vCsWOjuY
X-Google-Smtp-Source: ACHHUZ6vYd/72HrFnILIsPPxkV9WtXgdY0reZpTVE+28Qcv/gfC8YrS3WgW3xvAxoExi5idG0G+2nqlifIhKg3jLxd0=
X-Received: by 2002:a4a:5782:0:b0:557:cd4e:c116 with SMTP id
 u124-20020a4a5782000000b00557cd4ec116mr65019ooa.1.1685036351462; Thu, 25 May
 2023 10:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org> <20230517-topic-a7xx_prep-v2-2-5b9daa2b2cf0@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v2-2-5b9daa2b2cf0@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 25 May 2023 10:38:59 -0700
Message-ID: <CAF6AEGsm=o-KgOtm01FSvMOB_uj6VOaONNu5FUr4phUixYNG3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/msm/a6xx: Explain CP_PROTECT_CNTL writes in a6xx_set_cp_protect
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, May 19, 2023 at 6:29=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> We have the necessary information, so explain which bit does what.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 9fb214f150dd..deed42675fe2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -771,9 +771,10 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>         }
>
>         /*
> -        * Enable access protection to privileged registers, fault on an =
access
> -        * protect violation and select the last span to protect from the=
 start
> -        * address all the way to the end of the register address space
> +        * BIT(0) - Enable access protection to privileged registers
> +        * BIT(1) - Enable fault on an access protect violation
> +        * BIT(3) - Select the last span to protect from the start
> +        *          address all the way to the end of the register addres=
s space

Even better would be to give these bitfields names in the xml, which
also gets you more meaningful decoding.  We've been better about not
open-coding a lot of stuff on the mesa side, but it is a bit easier
with header generation integrated into the build..  but less
open-coding on the kernel side is still a noble goal

BR,
-R

>          */
>         gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL, BIT(0) | BIT(1) | BIT(3)=
);
>
>
> --
> 2.40.1
>
