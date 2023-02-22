Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF769EFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjBVICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjBVIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:01:59 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39D36FFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:01:58 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id b20so7440622vsu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlzo2IJo5C30mjLFPDclNhtFd2xIEgosfbXcJe2YvVE=;
        b=MeWMKnUvCa5h3wnNxrVJwgGjMGC7euso+9Epxo9WZnMC3zklZnUMAdZ6JmNt6tv94J
         wnGbHnAcop4UQ5kLLD/AngU8vKm9bLOO7c19mmm5R8uwYNy7xW8gjJozc4V+7pdANJmi
         Me6WFN7P7gptD+fkV3vqzODRL+tt7nUGbDd3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tlzo2IJo5C30mjLFPDclNhtFd2xIEgosfbXcJe2YvVE=;
        b=6q+Af0XiIPrFPSdl+a8/7UN5EUpcyib10bgdcGCGODpPrEo9R0QiC15VhXWmE3xwBO
         ZUOLUUykpxuaZI9mLlS6CIlZN8IZvC4hyvEWKOdemhr9KJaDoPWR+bf8TVKzg17NP64v
         rjCFXJliOl4wwfXWHYYcJWIudgztOHDRFmdXtrpzRXLTX9kmjq0Jys+Zd7V65PAvt7hU
         QiHsB5OXzWrsaNhOucyHjH/Umsj4x0ofAKX9i8AZAqyjhvobJRZpWKnWCUsDIBhmwhSl
         vtUNPVrNMM9p/4+/zg2KXMD8p0UMLD2fxs6DyI2aork3etDYCF7MDTADglRkmXf7+Psg
         Ad1w==
X-Gm-Message-State: AO0yUKXS8R0Dl4cVUBAcLLwZTJ/+cblJUmfHfEEoAoiuxodKggQgRDkD
        1l765QpztG7kh9UG+VjMbkUw/lqhuSPxkx4V+sjF4g==
X-Google-Smtp-Source: AK7set/K733MxVsNaWaZ582QR4RHXcNoi9G2ZoQ2+vNsIwgFsMxrfQGCDYAD5F2km2PqCut/v0ZaIlykDJA2RFfbm3I=
X-Received: by 2002:a05:6102:570b:b0:3fc:58d:f90f with SMTP id
 dg11-20020a056102570b00b003fc058df90fmr1556381vsb.60.1677052917662; Wed, 22
 Feb 2023 00:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 16:01:46 +0800
Message-ID: <CAGXv+5FJ6ze5tECGMoJT3yALDoSkshQPj0dUy_KwLJoWo9AYCg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
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
> Since new platform data was required in Panfrost for getting GPU DVFS
> finally working on MediaTek SoCs, add a new "mediatek,mt8183b-mali"
> compatible.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
