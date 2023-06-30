Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2A74435C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF3UmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjF3Ul6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:41:58 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC05A2;
        Fri, 30 Jun 2023 13:41:57 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b0138963ffso2157488fac.0;
        Fri, 30 Jun 2023 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688157717; x=1690749717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hei6z5b4CckyhDST/cotdRvq7xJLORaeNw4Fjc7LJac=;
        b=qqpEc0UHC1Pn4HYeR/nCpyWwl1XTPXm6yo7Prv9WxE4SFrVABUui5vEnzQfaBQqq18
         CopnejN3jW7Xq7rQgVzskJQgOtevz3olqA9fmOJpxNDX4NFLxcqjWSfrdn87OPWCE/yK
         OKiUA6LVeBbDRsORPWuH8rt7lsFNS3WpmdIlMtY3U9TaY8KjAnP30tNfWTwFSakFYkfG
         Uw/B8olBlSDdXwDVq+4+rFSu6QIfhBjU7W5VTpGd5wpojXSjjHJ9KfZNSkemoQ92LlCi
         c4lMYH7dbIt0R24D+z6BPUjqIgPYkuxhC5gMQLOHc0q/Em/hSl69QTu2/38SD+fzmfP3
         CJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688157717; x=1690749717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hei6z5b4CckyhDST/cotdRvq7xJLORaeNw4Fjc7LJac=;
        b=Fb/Bi6CBdEuNjActWPSba2uljNqsL2OMGgO803KPP27WUhIHibBF8rcWUCZ8V9RKSr
         U+U1iDPVOFBfrW4AaWI81K/yhCHnTc2+fxwXjrz0BWO6QHWzsOn9XXdwXIGBnsJK81lx
         wf9esAadwoIEh9KRGS59kcKwKsmhdFRqtBEabXjDUPlO0DU6uygbnnOKQI4btI3F1q3Q
         fAtcnbPmom7PgxVfAN2YSBMMNWH0WsoU6Xp5DZyKQG7GYhmFnPTw0GYPAnQi1YEKMJCJ
         EZC0SjMqHXamRPhfp9Wj8G5M4CKHLdnIUp8VzfTjQXen2NDt/JNIwckQpD62Dth2801A
         13bg==
X-Gm-Message-State: ABy/qLZz3jhwf1QD+Y2hbBUqirf5OaJNm5SleNR31fW0ng8bCVBq5us2
        d4mZUXiDd289QljM5abAvjdFLmgPWP0qVaJ3598GujzQ
X-Google-Smtp-Source: ACHHUZ4aVwFnH3AO8hYQb728JRge1w32PAsmLUhEcQEnMEUqiTkxHgWJnzSzNRrmiAzZuYJh2YYBAlM5pxy3rrE+wYY=
X-Received: by 2002:a05:6870:b6a5:b0:1ad:565f:df6c with SMTP id
 cy37-20020a056870b6a500b001ad565fdf6cmr4974801oab.46.1688157716743; Fri, 30
 Jun 2023 13:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v1-1-5056e09c08fb@linaro.org> <ef074384-1eee-ec88-b02f-c4ada72037a4@linaro.org>
In-Reply-To: <ef074384-1eee-ec88-b02f-c4ada72037a4@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 30 Jun 2023 13:41:45 -0700
Message-ID: <CAF6AEGug0rrX4BV8=XEV2hZw_C3+W+4WV=2bSADzF5rnsoTS0g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Assign revn to A635
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
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

On Wed, Jun 28, 2023 at 12:54=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 28/06/2023 22:05, Konrad Dybcio wrote:
> > Recently, a WARN_ON() was introduced to ensure that revn is filled befo=
re
> > adreno_is_aXYZ is called. This however doesn't work very well when revn=
 is
> > 0 by design (such as for A635). Fill it in as a stopgap solution for
> > -fixes.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> I'd have probably added:
>
> Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified
> before being set")
>
> or
>
> Fixes: 192f4ee3e408 ("drm/msm/a6xx: Add support for Adreno 7c Gen 3 gpu")

I'd lean towards the former, given that this is a temporary workaround
until we do a more comprehensive overhaul and remove revn entirely

BR,
-R

>
>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index cb94cfd137a8..8ea7eae9fc52 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
> >               .address_space_size =3D SZ_16G,
> >       }, {
> >               .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> > +             .revn =3D 635,
> >               .fw =3D {
> >                       [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> >                       [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> >
> > ---
> > base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> > change-id: 20230628-topic-a635-1b3c2c987417
> >
> > Best regards,
>
> --
> With best wishes
> Dmitry
>
