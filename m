Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E012A6A198D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjBXKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBXKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:07:42 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D54936FC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:06:32 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id v27so12791213vsa.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ds+e0Ih6UL/cn2qDTbsziNvDdZY4duRrpUzCZIYiaLU=;
        b=afCawh6DuktGjlOudCjHqoYpmBUiUP5Ue7N5HIcodXbWKYh46tetr3moqM2V46f0PX
         k1kLAoF9UNzrw7ZwGSQok0opvqeYx5eiPfdra365llKKcEmrJH4+S7HeMFY5qIO653f0
         0UUg86COEMbN7GEPS/1KbEO7+MlWMZ4Poe1nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds+e0Ih6UL/cn2qDTbsziNvDdZY4duRrpUzCZIYiaLU=;
        b=M6vzQ0GlGG8MZ5RDSwniIL2waInRKY47mm/VaM01nG0+T4wxjgQtlI4GxINWTqwi0p
         fyzR2du8bs9xXKPQ1oHGji+7wJPuQVGLWnEiMc43aVAdrIxlJRvSNF6nrXoyICL3pj2y
         tMkqoE0Hq+qTh2DQhh5IGag+NmVeljroOdrZeO5wFAD1vz0l0X84KTh0Sv7lPNWVb5EY
         QUAgfV8rA3CXWCzfI6BeQ2retHPqD2Xirqgp4T1jmyLZ5qb8AM1tsaLCVa3YCRAS+7ru
         rA4PfbyT8k5dDybBeYm0PWycd4p4jH/4fYQS4Kcucis72jZwv5n+Pbh5h/vWxZjuj9fM
         hgpg==
X-Gm-Message-State: AO0yUKU7zs0X+ZQO8XFdvwN267Ge6GqNGNCaFeh606H2gvj7PW2wuKx0
        94sOc3d1vhTcFMJGDSBV/5sz81EFPleXM/CngqIgqH6qdcFf7p5q
X-Google-Smtp-Source: AK7set/tL0nx+dCLvdLFPGL6MZqwGOMrTaZ11JDqKi1o+dz+K1NCp5pT/0RlUA0xvnbRGHDGRyh3fqWz6RCt7wSFp7Q=
X-Received: by 2002:a67:f650:0:b0:415:2063:e403 with SMTP id
 u16-20020a67f650000000b004152063e403mr2102294vso.3.1677233186030; Fri, 24 Feb
 2023 02:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:06:15 +0800
Message-ID: <CAGXv+5Hzin_5aTqMRRztWbDR64z6_oFOx2hUVnpJBvk9xDzrfw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] drm/panfrost: Add the MT8192 GPU ID
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:35 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> MediaTek MT8192 has a Mali-G57 with a special GPU ID. Add its GPU ID,
> but treat it as otherwise identical to a standard Mali-G57.
>
> We do _not_ fix up the GPU ID here -- userspace needs to be aware of the
> special GPU ID, in case we find functional differences between
> MediaTek's implementation and the standard Mali-G57 down the line.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

As previously mentioned, MT8195 Mali G57 has minor revision number 1.
Do we need to handle that?

> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 6452e4e900dd..d28b99732dde 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -204,6 +204,14 @@ static const struct panfrost_model gpu_models[] = {
>
>         GPU_MODEL(g57, 0x9001,
>                 GPU_REV(g57, 0, 0)),
> +
> +       /* MediaTek MT8192 has a Mali-G57 with a different GPU ID from the
> +        * standard. Arm's driver does not appear to handle this model.
> +        * ChromeOS has a hack downstream for it. Treat it as equivalent to
> +        * standard Mali-G57 for now.
> +        */
> +       GPU_MODEL(g57, 0x9003,
> +               GPU_REV(g57, 0, 0)),
>  };
>
>  static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
> --
> 2.39.2
>
