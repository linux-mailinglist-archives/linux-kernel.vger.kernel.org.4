Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91035B6DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiIMNFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIMNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:05:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5A1E3FA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:05:42 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12803ac8113so31867257fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zz3ZuyKP9ensUU2Om8FSpGsYSuFsamP2YrTm9IZuHlw=;
        b=f+E0o0DPHiAXnmpaNZ73H5C4RsJLg+2Dwn1XMDPCz8+TOoFU/9uG96vepHmsIOEzO5
         2UzMeFlZsS3dOpSNb1rVaI5lbki8+8mV9F1qEiyOmiaZEoGU2gkyvHR0jD5snNPo756P
         nJ/qnKlnSoRt7xj6HUt7/aJsPS7nyga34CuXYK6FR3tt08DWCbd6FThJzrC0RQwb1Qxv
         Y+UYJ6Z0JY+TJ7L3n/h/8EQdBFDoomrPykXbF4TeP+wuko0qfU/ONJ25TjNN2XyvCdD3
         R0w57Nu7Vh4fpQ6pOqohi9yrCfN1LXfcoPUlQiwcpQDV1WMdZCqx1WGmAqNNnJ1PssBX
         TknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zz3ZuyKP9ensUU2Om8FSpGsYSuFsamP2YrTm9IZuHlw=;
        b=X+tXNiH4m4W4XqCctmvzkiJLWCmJWcTfxcW5ciFeGAjSteJz6tTBVrHqKruHrR3eI9
         XtNL9yvMRxQYhLNbyFurcFf/sP/uWpTwzdXfx2DKQ5WpwNdantl8SO3Zm3jBodwRLB96
         10GDB8t4e8XjzIia4AOQ2/PNy5+fohUGNjhl74pCoR6t4hl6ch97cVkBEroc4exB28jP
         6Q4/vq3SMbPsXQ4p2Eneq+Jo6xHBk/ll2HG45yMBJQypJf/n+aihiiLmuUu7rHhiZcLE
         rg8s7OwJqo35lZnh1nbPvhspj/VWvL8uFCsi2YLSvD3z4k+Qoz2oiW0DNYpZjbCj4n9m
         iKlQ==
X-Gm-Message-State: ACgBeo1W54r6Rs3yizrlmfOMSeWAe6nj6HelOTgs9UPNpGCdW8Z8zjDq
        vjrNXc/9Tx6pp2hD+hxy/nqxtWOmK6ApxhPg4Fk=
X-Google-Smtp-Source: AA6agR5rduGKYZghi/pRmYkSMBadxQji0WAU2U3yLynsQzPDUoOEvNriM8jT51uEQbQwZ7SE19eM1sf6GDZOLvRepw8=
X-Received: by 2002:a05:6808:2384:b0:34f:df01:c011 with SMTP id
 bp4-20020a056808238400b0034fdf01c011mr1447287oib.96.1663074342037; Tue, 13
 Sep 2022 06:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220912032241.16259-1-xu.panda@zte.com.cn>
In-Reply-To: <20220912032241.16259-1-xu.panda@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Sep 2022 09:05:30 -0400
Message-ID: <CADnq5_OsjtPzYic1M9fbY=m7mwA_uxzZ=znVXgVrGjvJ2kRL7Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/display/amdgpu_dm: remove duplicate
 included header files
To:     cgel.zte@gmail.com
Cc:     sunpeng.li@amd.com, Xu Panda <xu.panda@zte.com.cn>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, roman.li@amd.com,
        amd-gfx@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
        aurabindo.pillai@amd.com, dri-devel@lists.freedesktop.org,
        Wayne.Lin@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Sun, Sep 11, 2022 at 11:23 PM <cgel.zte@gmail.com> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>
>
> soc15_common.h is included more than once.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7a93162633ae..0e42bf496a73 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -98,8 +98,6 @@
>  #include "soc15_common.h"
>  #include "vega10_ip_offset.h"
>
> -#include "soc15_common.h"
> -
>  #include "gc/gc_11_0_0_offset.h"
>  #include "gc/gc_11_0_0_sh_mask.h"
>
> --
> 2.15.2
>
