Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DAF69EFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBVH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBVH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:58:45 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DF5FFB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:58:32 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p2so2404661uap.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G9H0xjhxYBLZPbX8nqO91E9hjJ6R+Sm3uDvahoqNPyc=;
        b=DNemaIQH3jRofAK7MbaDUIqc7f3HRn0kIhuSzD7GLxols1+ghLJzjYiSaKSC5aT2oy
         hDKSvR0/2g6fHPRaHu+gFWFCf5vOucJ41X9kBOqAGlWfYzPaU1bMP9Z6tjgosQFsU1bm
         RkZHOBGvtI8b7FGMn2SLXWnLEhVYvSNNU76gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9H0xjhxYBLZPbX8nqO91E9hjJ6R+Sm3uDvahoqNPyc=;
        b=aiuzA8CaS3887PgABBxSJGxsw95+7hVGjjURo2WUfhgQzDYWliJnHU4GUatBkBIs0g
         hoSJhgW7e9+sdSgJsLI4Qa9gYOlmM1HTPafoNi4dOqcXlf0kU81odJ0x4mo9qehrpi1l
         qW6P9LJySyFGzFS0mJRj63U8Pu+mvWyZFDMdiQXB+JaSvKKs2lk0XIyiw6e4YzXyhXCG
         HrciWLyei/TfHs0PA72jZSNrJcutjdxAJU0i4i5C3xJze/5RwDJ/qA7Co13TWUEvUdw7
         FwvRFRUn7nVw7Qn8JWdZMDpbc9RyYZ8iIBk+OdDV4J3Xx76BBAEXqXNZHDwiOZu5W4c7
         VfZg==
X-Gm-Message-State: AO0yUKXkepWLvyoulPyfN4E37w+nYJk5vFXjYgR/SMllRrhF4kjlzIfR
        wm+FXv/mln/wLiC2i8aEX8TdUYWP2vVKPNdEay66fQ==
X-Google-Smtp-Source: AK7set8o2S3rJyKNzdUr4xZ9nrsGuSmtC2Ccm3LZaoX+pcw8mPI/KNjgf7s21ruTldmlELA+TVaMg7TzGpythFAFdbc=
X-Received: by 2002:ab0:6ed3:0:b0:68b:716e:ed8a with SMTP id
 c19-20020ab06ed3000000b0068b716eed8amr2520250uav.0.1677052711248; Tue, 21 Feb
 2023 23:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 15:58:20 +0800
Message-ID: <CAGXv+5E17b=nT3tquBxA6KkN3XLqNcWHeioeMtDaR+8SQhk8Kg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: gpu: mali-bifrost: Split out
 MediaTek power-domains variation
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for adding new bindings for new MediaTek SoCs, split out
> the power-domain-names and power-domainsvariation from the `else` in

                                          ^ missing space

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> the current mediatek,mt8183-mali conditional.
>
> The sram-supply part is left in place to be disallowed for anything
> that is not compatible with "mediatek,mt8183-mali" as this regulator
> is MediaTek-specific and it is, and will ever be, used only for this
> specific string due to the addition of the mediatek-regulator-coupler
> driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 02699d389be1..ac174c17e25f 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -145,6 +145,18 @@ allOf:
>          - power-domains
>          - resets
>          - reset-names
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - mediatek,mt8183-mali
> +    then:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names: false
>    - if:
>        properties:
>          compatible:
> @@ -166,9 +178,6 @@ allOf:
>          - power-domain-names
>      else:
>        properties:
> -        power-domains:
> -          maxItems: 1
> -        power-domain-names: false
>          sram-supply: false
>    - if:
>        properties:
> --
> 2.39.2
>
