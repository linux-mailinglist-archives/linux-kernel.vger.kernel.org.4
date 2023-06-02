Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662D67202EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjFBNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjFBNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:16:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87002E7E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:16:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19f45faedfbso1765358fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711783; x=1688303783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK+51MW3toKtyRlc9EMV1WInm0ZLn2YavXgg/4Uqv7E=;
        b=J3MDn/C+dYt62eyFU97yx4D99IrHldmNFUUsPfeGSlTGixOH5zMu5D1LcQ2A1WV4Zc
         G8pxROoqLSufLp8XT8thvtwceQ4NLjNR1OQemH9dpkRs8r3kCn1HxUdrIspu8O5KcZ3n
         Fb2pzv7MxQEueP0ZCxL/xaNBYi+rTZkXCDNDrnXVkwdJAYFZtepBIxmN+x8pZPHkdeVo
         8Dq2aFsC314Wqo5imChJAqJQAMXQ5DBA4epN47NY3bNlrkN4DPfquxPTYqIlTxGE4k9U
         wlj3JHKSLDe9pO6Nn2Qnu5xFAzMvKTcBZNe8d76vg18dLuYUqP/bqGnOEK9mvF0/ziji
         gd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711783; x=1688303783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK+51MW3toKtyRlc9EMV1WInm0ZLn2YavXgg/4Uqv7E=;
        b=PGLAGmBImyA5BmeWrMw0EEex2Pi1YfUZRenjJr3y8Z3wGEM+N4TStHjFdMU0G9+ha5
         gk+iJSyO+u/7d6/b+9x/EX8yJzi5TQ6AjTvvRohjkWJcmBD6xIBgjlA0CeAE+KYee+0z
         lcexTasJ+CY0JJhj5H7SSV/XeDB1BEoH75+Fx4DSjjJ4N2zxkR+aWxMsJUWt4x9Mbydi
         bCegrG74jrdikXNgxyqvdlZGbuWrE4q1GAzLsrj+/4/xi12VrSukVFYV+udH/bCeP00I
         IR7HRGcDdevmmJCvPTRvxDWqTvW5K8inIuc/686ZMCAxtBqLddrnBYZKrORA5ujGrLgE
         ZJPA==
X-Gm-Message-State: AC+VfDz2kaHzavjOXlD1+oxpCT0y6qgQZ3etK85HCDjnyNTfi5+38azn
        cVa1iqrNysVC0e4vcmqN7QxBp9Hjmp2rMQMbOyQ=
X-Google-Smtp-Source: ACHHUZ5ukYZeWQX4kVwhZtlf0is9pN/etZFtkxQqSNfPmK2uWdcjuNhvzS+lfgHmtEEaAxlybI6yZEc6Crg52jyXOOY=
X-Received: by 2002:a05:6870:e285:b0:199:ccad:7dcb with SMTP id
 v5-20020a056870e28500b00199ccad7dcbmr1561398oad.58.1685711783630; Fri, 02 Jun
 2023 06:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230602061753.116781-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230602061753.116781-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 09:16:12 -0400
Message-ID: <CADnq5_N1+TUihtWtM6uLpKN3BMHEJCY1_KiX=M0btTTqcoXCGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jun 2, 2023 at 2:18=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:2377 link_set_d=
pms_on() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5376
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gp=
u/drm/amd/display/dc/link/link_dpms.c
> index 2963267fe74a..f7f1a1586f3b 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2374,8 +2374,8 @@ void link_set_dpms_on(
>                 }
>         }
>
> -               if (dc_is_virtual_signal(pipe_ctx->stream->signal))
> -                       return;
> +       if (dc_is_virtual_signal(pipe_ctx->stream->signal))
> +               return;
>
>         link_enc =3D link_enc_cfg_get_link_enc(link);
>         ASSERT(link_enc);
> --
> 2.20.1.7.g153144c
>
