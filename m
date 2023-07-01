Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9E744A5A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGAPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGAPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:50:05 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0612686;
        Sat,  1 Jul 2023 08:50:04 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-565a8d74daeso1892614eaf.1;
        Sat, 01 Jul 2023 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688226604; x=1690818604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWux/IF/aECwza6GtENWenn3smgX2WPjU/KjFJmhyNc=;
        b=l9wb+bOH/n1H8L5N4d9tmf6kooHd3qjzenIY3zLrw0SuFKjc3azDJMYM/nFuXtPALu
         fwfbHUh51ekSOCL0alqQpF3e466+djZhphZEUWSITdvB9evWLVWX3S1vayFR1fHc0Mtj
         n7ZX2GfQe/QBd/TwwXrWkReGea1vgdFTgof4jKIefEcFhEjqTqd+zrrL/o1LQbT+9Dm5
         1xHsTtQpLYq5NU02jWZYFM3rSVBROZyKfM4GbiF2MmL52G7plaPLkKKb94bkg5vip0pw
         uhuOLwcqa0/voIsYdbUoYe4XmH0WUWkrykf4nrE5GHvaPQ8XSl25Mw/i8qE8oaDRYIuB
         7Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688226604; x=1690818604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWux/IF/aECwza6GtENWenn3smgX2WPjU/KjFJmhyNc=;
        b=G8H8XRzJQ+C9Jklfp2Fva9+GCHy3bvSZMGymmVfzAIzkVXVsk3RQ1SYWfcONdMS9Zn
         I++zxSI5QS9XH3ZZeuu7pYGGeuLzSyu+bvhHcIISF0gmX2rg68tW2sn2jsVZmIkUdCmI
         fErMstMqIWOLhOqQTYgYxEk0hFL34MKz+yKK1OF9CqAQ0ElPPfNznR22CbptdUlynUzK
         jfuOh9cUxeCXvepeT7uM3n4a4EqJR9x6ryu/mJv+4KbVkyqiu8MhIjaxMPwssI+b0LTI
         ZxaNMuvyHVJDFYCPmEcTZPb+t9K+89SxhT5JbOCt7z+lQKGfWRkRwvsQQhMwVU3FomHD
         qD0A==
X-Gm-Message-State: AC+VfDw/3DM8IjhO4rzhtJkBPIVqmpQyR9IdoxBDkUeCfqG5Plf6kwZR
        YvR4V2Yo/BPWUCzx+aQYA8hh9udrXP69b1NQPyI=
X-Google-Smtp-Source: ACHHUZ5p3Qamj32aSw4TXw6zcYs7G/XAByy351uI6wBsUAb95PSUxyzPUUUpESCbgaw4X1aoUbKIgnqr0SYz7yzOjiQ=
X-Received: by 2002:a05:6820:447:b0:560:c558:b6f9 with SMTP id
 p7-20020a056820044700b00560c558b6f9mr6089123oou.2.1688226604145; Sat, 01 Jul
 2023 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org>
In-Reply-To: <20230628-topic-a635-v2-1-5494c881b8be@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 1 Jul 2023 08:49:52 -0700
Message-ID: <CAF6AEGsH0BZd_yyn7UtJ3cLbbw2A5qdg8gQ6SORzQKjsMsnvHA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 4:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> Recently, a WARN_ON() was introduced to ensure that revn is filled before
> adreno_is_aXYZ is called. This however doesn't work very well when revn i=
s
> 0 by design (such as for A635). Fill it in as a stopgap solution for
> -fixes.
>
> Fixes: cc943f43ece7 ("drm/msm/adreno: warn if chip revn is verified befor=
e being set")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - add fixes
> - Link to v1: https://lore.kernel.org/r/20230628-topic-a635-v1-1-5056e09c=
08fb@linaro.org
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index cb94cfd137a8..8ea7eae9fc52 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -345,6 +345,7 @@ static const struct adreno_info gpulist[] =3D {
>                 .address_space_size =3D SZ_16G,
>         }, {
>                 .rev =3D ADRENO_REV(6, 3, 5, ANY_ID),
> +               .revn =3D 635,
>                 .fw =3D {
>                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
>                         [ADRENO_FW_GMU] =3D "a660_gmu.bin",
>

hmm, I realized a problem with this, it would change what
MSM_PARAM_GPU_ID and more importantly MSM_PARAM_CHIP_ID return..  The
former should be "harmless", although it isn't a good idea for uabi
changes to be a side effect of a fix.  The latter is more problematic.

I think I'm leaning more towards reverting commit cc943f43ece7
("drm/msm/adreno: warn if chip revn is verified before being set") for
-fixes.  I'm still thinking about options for a longer term fix.

BR,
-R


> ---
> base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
> change-id: 20230628-topic-a635-1b3c2c987417
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
