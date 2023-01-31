Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED8D683399
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAaRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAaRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:17:36 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523956ED5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:17:08 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15085b8a2f7so20227438fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B87l4oW+IzOa4SGyozTxZ9rljUvc8DJMzBV7y0do9hE=;
        b=fYXjlQqnDIzFyCbHYKX1Q0MyU4ku3gKOxAKgmlKKXgTnXqHkcICbTxk6JPBOE+VotO
         nXJWq2bbVb+W1R1KZhRaOPlm9tI5cEhof+CPFpyPutTiJ/YPP12GdJVcynMH0dlkRacV
         r2L1obxi3aQn+vNEOY6xty+TQBV6XDTtQdJoBTtOee7HzpUhrRjf8Z2MpNwVGmsq3Dkn
         LFPRcDuWMhhJAzqzll1DAgiHz2g+XYpfXerP5CZUasOdhsIhjnADKaaSC7pgPeikd6n/
         0eBpPEPqlr5lkQEScwOqpo1avEWZpcBrczC5EUNpgd0OSyfKwom4R8X7FEiGvy6hy5VT
         zxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B87l4oW+IzOa4SGyozTxZ9rljUvc8DJMzBV7y0do9hE=;
        b=ZsOcds9rYDZ5PAwMEJpsUHIjntGWuQack9pL4b6j600tpKpZ/F6V7OKkDZYdYpdY8P
         UEvyygIuLtUS3vh6nqGRZJqronIGItIf5QQJU0HJlLMhhkm3GKS42ItqDk0n1agBtMn+
         zgxE/J77KslaLU83gvXqfgueWHIcuCBIdpZntiYjY7A5eqPxSQ6QzAL2VTscm/JlzkE5
         uHpMP3BVriswZKNonHJQC6TaZo9ihMZbncKNQ5UPV36jwzZIRgUVcL3nv8Z4lB698fBz
         4ekGQBlr1HtoBEDs7w6k8lcZ37g7iU4osNq2RSSQJHi/LY7a1+sap8AnODMJFCWnyQR2
         jyrA==
X-Gm-Message-State: AO0yUKWcZVbpeHgZF6a91wJMKiCzRSz+scFuBpj9lJbTwaRsXB5w7/OY
        HqKbHzGptEtIG0IEKPTH/cvIeOzFuSNdpUJiKCs=
X-Google-Smtp-Source: AK7set9yXyeTvqbVOfWQG6Pfo29EpuMgUtCfIPlMwTWGtILy/wFMlT/P1PY0Z2Og22WH2A2luE8gGp5X47byjlG82ws=
X-Received: by 2002:a05:6870:b522:b0:163:8cc6:86a with SMTP id
 v34-20020a056870b52200b001638cc6086amr1616043oap.46.1675185392993; Tue, 31
 Jan 2023 09:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20230129151752.1531144-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230129151752.1531144-1-j.neuschaefer@gmx.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Jan 2023 12:16:21 -0500
Message-ID: <CADnq5_MEzZm-QYfxXCR1CcZ4OLE241x_jFU28Uz+QXpP257wjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo ("boradcast")
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Sun, Jan 29, 2023 at 10:18 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Spell it as "broadcast".
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/a=
mdgpu/df_v1_7.c
> index b991609f46c10..5dfab80ffff21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -94,7 +94,7 @@ static void df_v1_7_update_medium_grain_clock_gating(st=
ruct amdgpu_device *adev,
>                 WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
>         }
>
> -       /* Exit boradcast mode */
> +       /* Exit broadcast mode */
>         adev->df.funcs->enable_broadcast_mode(adev, false);
>  }
>
> --
> 2.39.0
>
