Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774369EDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBVELe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBVELb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:11:31 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C234C33
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:11:30 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p18so2089291uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVCtOFAQeCdlxuy/+5enfIE1//lIAo1ZANgQnvIFVR8=;
        b=Uk4/+eknl4RG+uywnGzIfuqQmgRvVQ+nJ72nRpvWVpw8DycQ7PGaOKHAAhTCWQrWIk
         PwjsgquqnSsQUM8hoP5yXC0oMtEi8Mo1blXigVQ4Zv+xKW9wHEQKmG/yKjz/N1uIkg5+
         S4V5VONmU8s2dmp/j6W48Hkq+OGx+t5gqRJSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVCtOFAQeCdlxuy/+5enfIE1//lIAo1ZANgQnvIFVR8=;
        b=Jy1B8oyUQMw8tbPEvfJ/HxsJXFA+9qbr+vBEcA+ClyTRc2kKbybjhEeH/b2LQus56m
         GOO2x5LB0014H+vL2KfZX6UhqMz1GCqeZHbqUZ0E/2/5Yzvgdc6IDSzAt6upb1OV9QHo
         2xF09L8bdbZev0GD9mB/3yT/4pKow82WmyNyB0xkLCovP5LWFNF5w2tgFdh7BmDbis0V
         z+RsgGygvuaoqmUB6UXnUz/YOnZQbB9ExeZoYVC5yuPzVdx4x+zRTFxPPPVbQBRJ9OM6
         zYo+Qi+nZw/oxonj/Dbisx0KLXokKb+E4TND+9Ia/0NoRDzI9PuaHQ8bgiFiPg5j679k
         9gGQ==
X-Gm-Message-State: AO0yUKXF0lan7a6TfSSQtxl8cfYtYfNzcZe8kroN0RRo9c5LPe5j+VKW
        YK719iuCGqUK+bwi8dGZmZw/up66Zulp0ro81y+Ayw==
X-Google-Smtp-Source: AK7set/nftjCq1OYuGKOwe46GNxAufRZH/wve/epWZydqSAOCAqd5GxdqmmuSkjxHSKOqAw+INE+gEreuCXBaRsdDs0=
X-Received: by 2002:a1f:208d:0:b0:3e8:66ce:a639 with SMTP id
 g135-20020a1f208d000000b003e866cea639mr1230544vkg.2.1677039089247; Tue, 21
 Feb 2023 20:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 12:11:18 +0800
Message-ID: <CAGXv+5Hc0qceN3Cr89ZF8K9-EwqF7v26qsdRS2mE_FE_nr7OiA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drm/panfrost: Add the MT8192 GPU ID
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

On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
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

> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

FYI MT8195 has a minor revision for Mali-G57. See https://crrev.com/c/2834981
The commit doesn't say what issues were resolved or still linger though.

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
