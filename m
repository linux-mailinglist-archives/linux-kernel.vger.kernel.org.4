Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A600A744AAF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGARQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGARQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:16:54 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72D6210B;
        Sat,  1 Jul 2023 10:16:53 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-565db4666d7so1190210eaf.0;
        Sat, 01 Jul 2023 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688231813; x=1690823813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FOHhHz8+MfElfgvBPpP2HygXloGAXdP6WQyskY3Lqw=;
        b=VhxPXvhCs3ycjCDO+Dy2nynhvaVsZodu/cPsKh6TdrZx+2ydCj1/D7Cdey9FlrWBuZ
         OWgtDy/JF4UyIcL89ZsWD0/17vlpIYzg+md98ADu6lqrVi102cNU3u9pShepwJRAhzxT
         1j95E4deSkM0xcLcctYo7UaaqcByTbidYW+tNqKHZTQuHeWyBZz6lH/Fun4hSp0tCU6w
         5CrHPdS9+aoFH/06lkOicO1kzKGIbENarQw7q5cYkQpzW8mS9yaXak9nPP1E1hAbKozO
         6yDMAUPU/p9D1A8W+KQ+7Ea9T6SSzFIDWfGwOj8wlZGTUprtYGutbBQfDboJfvDs5UYJ
         e/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688231813; x=1690823813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FOHhHz8+MfElfgvBPpP2HygXloGAXdP6WQyskY3Lqw=;
        b=dKS4zHIY0T+bN6p4f0pT0iopiloeyHbQIHuqtWL8MN5OfaGp9qKTmETX2uFvX9iT30
         bc55Ta1sn2kS8Jt8KGHwSpiIJJxEcyZh32tHU1Truwn3MGjIK2FhATu2uqkk2gBJ48Dr
         Kmf3sS+NAEXFBeEyoZ5OuSQO7hlZ1XwXWLrqBTs6nbs7cIB+hQ9fHTuWqanqfmz70p3W
         jm3tfrl3yELgqpiCBNisFGS/TciJRquGJxk9g42rHmRjEpZe04Y8T7fzHAP+OErIcA7b
         0QPu1OsmkemgLXPqDkm7iSEQVgbuGnE0usg8BMw6GRnMX7VEi0E9buHWYuieSVDjQITB
         kxRQ==
X-Gm-Message-State: AC+VfDza3bbRY75+SGtkmM/mU15KmpjdAHUMFe94wOO6e1xrYOnu+q+M
        NcnhKqRXtdQGAKtvA2np9bS5WEuEbGE/oQpHynI=
X-Google-Smtp-Source: ACHHUZ5U44GWnVjlc4/4StJf+Bvj8Unvd3fhQwc7n0VbSC+OiNVi57XgfziYn+IsJTTl47k6q7YLRYMD5kVNNIK+YcM=
X-Received: by 2002:a4a:4158:0:b0:565:9e41:85d8 with SMTP id
 x85-20020a4a4158000000b005659e4185d8mr4409368ooa.6.1688231812920; Sat, 01 Jul
 2023 10:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org> <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
In-Reply-To: <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 1 Jul 2023 10:16:41 -0700
Message-ID: <CAF6AEGvBsnLU18cMwh_yoYAJe59k7kSFNaA4RB12yYxoU4PMbQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Assign revn to A635
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 8:49=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> On Fri, Jun 30, 2023 at 4:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@lina=
ro.org> wrote:
> >
> > Recently, a WARN_ON() was introduced to ensure that revn is filled befo=
re
> > adreno_is_aXYZ is called. This however doesn't work very well when revn=
 is
> > 0 by design (such as for A635). Fill it in as a stopgap solution for
> > -fixes.
> >
> > Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified bef=
ore being set")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Changes in v2:
> > - add fixes
> > - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-5056e0=
9c08fb@linaro.org
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index cb94cfd137a8..8ea7eae9fc52 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
> >                 .address_space_size =3D SZ_16G,
> >         }, {
> >                 .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> > +               .revn =3D 635,
> >                 .fw =3D {
> >                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> >                         [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> >
>
> hmm, I realized a problem with this, it would change what
> MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
> former should be "harmless", although it isn't a good idea for uabi
> changes to be a side effect of a fix.  The latter is more problematic.
>
> I think I'm leaning more towards reverting commit cc943f43ece7
> ("drm/msm/adreno: warn if chip revn is verified before being set") for
> -fixes.  I'm still thinking about options for a longer term fix.

This is what I came up with as far as better way to solve this:

https://patchwork.freedesktop.org/series/120108/

BR,
-R

> BR,
> -R
>
>
> > ---
> > base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> > change-id: 20230628-topic-a635-1b3c2c987417
> >
> > Best regards,
> > --
> > Konrad Dybcio <konrad.dybcio@linaro.org>
> >
