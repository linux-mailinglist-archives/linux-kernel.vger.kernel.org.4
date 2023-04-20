Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795706E8B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjDTH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjDTH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:26:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CDC6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:26:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a5so4219393ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681975596; x=1684567596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaCVvuCh0ifaod/8Osz9wRqo6LYk9iFhMUaDZ5ywzU4=;
        b=HSxwHGoFkt1pfTNx3P/aMn78Qft/H5J/iUpd5Dtt67Q3lLbJ2cqELZ280B8RVP9ZI6
         3YEMJHi59bhftwaSq+SH/3AXJhaP72uPkdWkxKcscMJxNwhsArxyCQV7s5V83hTyicNF
         nfjlFpvVTHCEdsqLwdIe8aEJFzXtSrtI/GvaNr8cKS6z9VHGyaaq4Dns5byfIuQr3B/g
         QY46hQIq0uY417faOyPO4xbA9sv6kwLDQzVR6AVEpIOMOkDjU2X38NFzBnTFtIBRCzsn
         J8DeyanOx0w8Wa8rRbKW0DbN7Z7jtmPwVRGE8siIG3mhgk7dzNOISL3OOSA5cpmjtj3d
         ZFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975596; x=1684567596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaCVvuCh0ifaod/8Osz9wRqo6LYk9iFhMUaDZ5ywzU4=;
        b=IP0azk2DStbn26poagxni3v841/eTYnDBuhyz5ILGnDNnp4OYGQN25k/aUHZbRXofv
         N01SjvkXFKzgTZR6tnwHUjiDFhLRpn5WklAyPzOIwqpIK0zomi4xiiRxen4nTaeIy0AI
         HC+Nujl5w7umEmVXwXES3X9dqmRDqQ19lpeWwgGeCbP4X9goY2llHeCj5vr9F2o3VB93
         ujwtSkpmHHHjZk5AdUZzxjkuNNIt5oCSTlxBvsZ3TXdle9a7mVl0fS/i5qauwMnsFInp
         iwcaym4Dgl7wC9gOPmirqbG+bMkDVyfJ+ZFTKcvRjm6NjL3TORq4+T/iXonACfx7vDwr
         4xPQ==
X-Gm-Message-State: AAQBX9fWyKfUamxclX3iJGf4tMlhz83YLb0xCqp0M2yn9sV2htmWVdbk
        G369sEqb9mXpzesqZRmDSpaX2WMhI/HvGHexJFGW
X-Google-Smtp-Source: AKy350b+6jWk+FNIWk6cavQH152CzIc90gdPX+pCwubbVAUdMA3XRND8Zrw5SaaDEkP1wAvzR+tWGB6OxqTQhZLcC8g=
X-Received: by 2002:a17:906:4b17:b0:94a:4c68:c1aa with SMTP id
 y23-20020a1709064b1700b0094a4c68c1aamr241124eju.7.1681975595637; Thu, 20 Apr
 2023 00:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-4-d1bac46db075@freebox.fr> <74c59560-8a79-150f-0c1e-13f22eb35cb2@linaro.org>
In-Reply-To: <74c59560-8a79-150f-0c1e-13f22eb35cb2@linaro.org>
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Thu, 20 Apr 2023 09:26:24 +0200
Message-ID: <CAG9NU6_Ua_XLa+c=_93fs5chzQTyPf11W4F87UYbny1k-feoJw@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/msm/dpu: allow using lm mixer base stage
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

Le jeu. 20 avr. 2023 =C3=A0 00:43, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> a =C3=A9crit :
>
> On 19/04/2023 17:41, Arnaud Vrac wrote:
> > The dpu backend already handles applying alpha to the base stage, so we
> > can use it to render the bottom plane in all cases. This allows mixing
> > one additional plane with the hardware mixer.
> >
> > Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
>
> This might require additional changes. First, for the STAGE_BASE pipe
> in the source split mode (iow using two LMs) should programmed with
> respect to the right LM's x offset (rather than usual left top-left LM).
> See  mdss_mdp_pipe_position_update().

Ok, I did test with 2 LMs and it seems to be working, I'll investigate.

>
> Also this might need some interaction with CTL_MIXER_BORDER_OUT being
> set or not. If I remember correctly, if there bottom plane is not
> fullscreen or if there are no planes at all, we should set
> CTL_MIXER_BORDER_OUT (which takes STAGE_BASE) and start assigning them
> from STAGE0. If not, we can use STAGE_BASE.

I also tested with both fullscreen and non-fullscreen primary plane,
and no plane. I'll check this.

>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_plane.c
> > index 14b5cfe306113..148921ed62f85 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -881,7 +881,7 @@ static int dpu_plane_atomic_check(struct drm_plane =
*plane,
> >       r_pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_NONE;
> >       r_pipe->sspp =3D NULL;
> >
> > -     pstate->stage =3D DPU_STAGE_0 + pstate->base.normalized_zpos;
> > +     pstate->stage =3D DPU_STAGE_BASE + pstate->base.normalized_zpos;
> >       if (pstate->stage >=3D pdpu->catalog->caps->max_mixer_blendstages=
) {
> >               DPU_ERROR("> %d plane stages assigned\n",
> >                         pdpu->catalog->caps->max_mixer_blendstages - DP=
U_STAGE_0);
> >
>
> --
> With best wishes
> Dmitry
>
