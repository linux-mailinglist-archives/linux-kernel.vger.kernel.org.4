Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881270E11B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjEWP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjEWP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:56:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD38E;
        Tue, 23 May 2023 08:56:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3982f09df74so478592b6e.0;
        Tue, 23 May 2023 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684857362; x=1687449362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feR7RDbEdLIuOxFRuDJ8YtvTuElIb6gfqh0e2jlKlZ4=;
        b=BQ/BwtssHhbZ5SXgrL5qqcG4DxAtKpPixF+jH7TZmPAC6I3vktKSEdVhZDZ+ztF5Up
         X3wixHyR4QgoCizXCGPnprd+j9fKQZ8YfRCxcOPlVvd+/TIHG2uLsCxwd83ztdxm/2hq
         w0SwwSU2mAxn5+9WETXaqT7JLlyeES6GGGpGJGNb7kyYSW32dRzDMH8YQNjcENmueK5H
         CyukFJtQHtcLKhQn1KZhezhSsFaC0FzrGS6Wy24v5tKB2mfal6IUZwXkXTDl60M9X/re
         YjrqAi5wA6nuB5HYA4yMhgYBJDsvCPiZz7Tzu9q1ibzAWEX1acOd3gdM2kJpcci6tghO
         +VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857362; x=1687449362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feR7RDbEdLIuOxFRuDJ8YtvTuElIb6gfqh0e2jlKlZ4=;
        b=HbkQ9tYSx905XvU8gSLjarGnK6GXHqEBqR3Y8qY4jEMDIPnxwZENArpJSQ8r16O2Vq
         bqSobfbRlaxaMwf62lFhKGr/O9BpJMLp1s20B0Bsxcxm1jWq0ggrpIETo05oTJmhhFmK
         7NcLXqv29PKq8M3UCSZSNaaSG5hiJujo33H29W0+Ikk+3Omu9zOcHS6mZyi5uzgsTC3C
         xKUTRbslGdAraY7VPJp4sNn+imvPnE+kg0lENTkVUehQ295Zaek6Hq7TjHBVmO9JCDze
         jWZ+/JT7oK4aT6TphbH1Gz0Vq0AZqkGBa41TwL4dm7nv6K0ys3In7CoGoyWx9QwDvjbQ
         DwdQ==
X-Gm-Message-State: AC+VfDwEL7LSz9UUZ9ED6JrRvuTqnCOQ1X4DZ9EZ8UvV3X5l/wQ688sb
        UjhVTxUOvMdRzy3u4tRQCiNIUCBDwD+uDmLOKajNe2YP
X-Google-Smtp-Source: ACHHUZ4ZyUpdVtXyIatHPpZHmnxoVWfMnEnl1OVupErapn37R44kVZgKLmbC5muGz5Am7Mmro0S57dh0vvs0jDarnnk=
X-Received: by 2002:aca:1109:0:b0:383:ca99:c70e with SMTP id
 9-20020aca1109000000b00383ca99c70emr6905361oir.59.1684857362565; Tue, 23 May
 2023 08:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021811.122014-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230523021811.122014-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 May 2023 11:55:51 -0400
Message-ID: <CADnq5_OxXz7TSvkarQxC8-342SxO+YE4PU_4mSADYtr0urofvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove duplicate include
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org
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

Applied.  Thanks!

On Mon, May 22, 2023 at 10:18=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c: amdgpu_xcp.h is included more =
than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5281
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index e5cfb3adb3b3..7fb2d38b010a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -23,7 +23,6 @@
>  #include <linux/firmware.h>
>
>  #include "amdgpu.h"
> -#include "amdgpu_xcp.h"
>  #include "amdgpu_gfx.h"
>  #include "soc15.h"
>  #include "soc15d.h"
> --
> 2.20.1.7.g153144c
>
