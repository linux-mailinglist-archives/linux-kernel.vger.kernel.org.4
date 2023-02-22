Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1F69F06D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBVIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBVIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:37:59 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97940C8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:37:57 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id j14so7784406vse.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sComzmbCpABMxGUkRsCiLtkyNheYwmjw48ljpFz3J24=;
        b=lj5Wy8MK1mwapRAvUlPMKSor05OyZO5FDMUF3vmS3b4AA19H4/OTNnPn7urBRBWgNH
         pDCjTxYoDNOOE7BuYRmNwu8P0aIwLJ3yduJkfc4bTH71uQwH93SttIJkswsYVXhj1J2Q
         T6Ad3ZCsTfC91iXkA1tnIcoklpBf4kIODobuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sComzmbCpABMxGUkRsCiLtkyNheYwmjw48ljpFz3J24=;
        b=mZd6v1FQYlsxmGGwxNRKd6WfSXcC/kOu50XDUFhOAi4+H3lx7hfRbUx9O6RrDtxjyU
         k4jyR6KR/+MItU63mJxgxYqyggebf3qc1pLiRhp8yHXuFcFUjaJDuV2AP+G78c6d6V+e
         dkJH4BwTZoZaPH2xWwt31N3zU0iyPPupXCIJ2AlpDo/7N8dz5B5q8XsRbwKEeU2kFVPq
         h4oQEXOlac5N8IfVfmQkiyaexW2oFM/hJvy6TcsGcWsYV5nSZzCKKFWa6ZzSiBobAY+3
         lpq98M6QPfQVdrO1u0VRhg7vyWZtpj+t/BiPCjyDN6kQXsa1ckw6sq9WvGnad0HmTHcL
         6IDw==
X-Gm-Message-State: AO0yUKXNrrr0L6bx4BlcElKirnebQInozM0xSx9vLlei9RRyl1Ondym8
        gSl3wio3LNcQsQ8QmooIP4fcVtg48pSwS6rFbYEZCw==
X-Google-Smtp-Source: AK7set9FVEBAsLpdo2AF0VsdpWJoDj/pIevIOUHBKq0lW8mgWZ/QSNKhLwdL5NxD1KgYlkJH1/ua8amP+kkHXYKWlsw=
X-Received: by 2002:a05:6102:570b:b0:3fc:58d:f90f with SMTP id
 dg11-20020a056102570b00b003fc058df90fmr1571526vsb.60.1677055076838; Wed, 22
 Feb 2023 00:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 16:37:45 +0800
Message-ID: <CAGXv+5Ed-5Nq0zNzCGzez3fnW2yxW7zFx9B6k58Y4yb8P+hvpw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: gpu: mali-bifrost: Add a compatible
 for MediaTek MT8186
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
> Get GPU support on MT8186 by adding its compatible.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index be18b161959b..43a841d4e94d 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -15,6 +15,11 @@ properties:
>
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-mali
> +          - const: mediatek,mt8183b-mali
> +          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable

The MT8186 has Mali-G52 MC2 2EE, while the MT8183 has Mali-G72 MP3.
So we actually need a new entry with two power domains.

Our downstream Mali driver & DT use just that.

ChenYu
