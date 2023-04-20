Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717686E8AED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjDTHI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjDTHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:08:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908F110
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:08:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b16so4194113ejz.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681974533; x=1684566533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvojUsR5pwErXxzLqJHjlEXoz6gI0576CmK0oCJxdpc=;
        b=EAo2Ow3XS1RZ8Q6tdvY+KMv4wd4ak0f8BPocMInIOOFHNFIvuNFzOPCuf90+iwfEgQ
         ZHspYHA6cUYNt5Wgy8/DALjenpgaoNsZVVnOeFM4wbnG+KcFyqLnPb4Rhq/O0yweYnl7
         CYMo+WGq2i8VlcfntymZq6LjZZfDAUQbqMNQcVueagYpplsjB/G9itlTHLHsRArA2mzy
         Y7cpIE39ZVutrHQ/bwm3Ya6cScf537u6tSqFC7ssXf6QLH2GRKojshXPUAMFzyF2fG8H
         FwVgOBTnypFAHXr2yXHmpJz+FOoQQeqpZWXF6PzlTiIoWGkYu8toSbCAON6nc2xY+5xS
         5uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974533; x=1684566533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvojUsR5pwErXxzLqJHjlEXoz6gI0576CmK0oCJxdpc=;
        b=lYYEL1zt4V3rpxMTCZ8wXTiNm46o03T/ajBZNyCcKHaPRjjVjJPKI+2b3vB6u7nF5S
         RopEc6pKj7sY47uiA36U5MvH4Q4n19xkOd+z8hG1zJEcVUPnhk6IyAcSQQTrLmVxwb+E
         IWRBnq8m+E5Ok7SQT2CW+fXPnEsz18UIBeJc43ZMleiQv2AIRb85Tv5LZdJ1lC+YgNGM
         Wb2pgWln+UizjZIxTmmWE+kPZSZpmdcjlZiADuhJtMRK0viXvwyaL5xj0VGS75IRwl+B
         u/hFwuJ5Bam72CT9z7mCIV1W3xyNKqR/9tq1yDr37tc6fHw5o5GHZszSIfmh9E9YGHW3
         jQxA==
X-Gm-Message-State: AAQBX9cqQKCmN4hFZRDkWlE3qUTv61Ii+QlbnyLb/8GfNbhsv9LWOmCb
        EkmR8IVbKGiwbjFZbOUdyXjrDfLjOgW5YR4lE+AQkgqOhTdC60g=
X-Google-Smtp-Source: AKy350YkIRiL6/g0txyPQcEysULNj8gjrNyWWXcoEDSMWOaKX/YTC+6vqefm8B56QsKbeEQmmG9BwMkojEpTRumRSyg=
X-Received: by 2002:a17:907:980a:b0:94f:c1f:6d09 with SMTP id
 ji10-20020a170907980a00b0094f0c1f6d09mr214789ejc.7.1681974533034; Thu, 20 Apr
 2023 00:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-11-d1bac46db075@freebox.fr> <08e79278-ad30-73e3-a56c-f569b3fea407@linaro.org>
In-Reply-To: <08e79278-ad30-73e3-a56c-f569b3fea407@linaro.org>
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Thu, 20 Apr 2023 09:08:42 +0200
Message-ID: <CAG9NU68AqX3P1MrrLvfSKMyw+OsfZ7tyk9F9zU7qvA-QzzqO5g@mail.gmail.com>
Subject: Re: [PATCH 11/11] drm/msm/dpu: do not use mixer that supports dspp
 when not required
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 20 avr. 2023 =C3=A0 01:18, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> a =C3=A9crit :
>
> On 19/04/2023 17:41, Arnaud Vrac wrote:
> > This avoids using lm blocks that support DSPP when not needed, to
> > keep those resources available.
>
> This will break some of the platforms. Consider qcm2290 which has a
> single LM with DSPP. So, _dpu_rm_check_lm_and_get_connected_blks should
> be performed in two steps: first skip non-DSPP-enabled LMs when DSPP is
> not required. Then, if the LM (pair) is not found, look for any suitable
> LM(pair).

Good point, I'll add the change.

>
> >
> > Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_rm.c
> > index f4dda88a73f7d..4b393d46c743f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > @@ -362,7 +362,7 @@ static bool _dpu_rm_check_lm_and_get_connected_blks=
(struct dpu_rm *rm,
> >       *pp_idx =3D idx;
> >
> >       if (!reqs->topology.num_dspp)
> > -             return true;
> > +             return !lm_cfg->dspp;
> >
> >       idx =3D lm_cfg->dspp - DSPP_0;
> >       if (idx < 0 || idx >=3D ARRAY_SIZE(rm->dspp_blks)) {
> >
>
> --
> With best wishes
> Dmitry
>
