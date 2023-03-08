Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7246B15A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCHWxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:53:14 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84F34F5E;
        Wed,  8 Mar 2023 14:53:12 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id bj30so292077oib.6;
        Wed, 08 Mar 2023 14:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuqaB12E/7ngxaZSj8+nNOabs9E8O9u5mS2YqCJwwyM=;
        b=bZ/qE8oYTR31UPdybJZePaYKAc9rhOdIcpGbCw1BfMkkMZQyfl3RgUH/9JTnEEb5pU
         hj6wVkAIZJTN+beDS8cV56lja9y0b0rVaAkcO2nhPn+dazrQqsqO6r4UIcgRVB70AYPT
         jbUX8WH0t0lbBXrBnstXlxZSI6zkwOChCPvGYTSkygBKJKtd1YxKOBqJgS6nFEEpMhTA
         MZ/jOhJYBQm+y1lnqzjB/KXYJE7R3K5Q1MgNCzOoZXR15yeT7J4m3xstplYjdMJPn+Mt
         uA/U8V6br7TYcLCfreKwJGTUrrypRPcdlDY+g8RzCcxTpvEfSqlFAV3+gnrssdhA3sEw
         yWxw==
X-Gm-Message-State: AO0yUKWoclvZ0W9XvaIdwC3Yav1kCD+RUy340Vf+mYq024iQmnjxOZqv
        id87TaMdZYkRcCt3fvydTQ==
X-Google-Smtp-Source: AK7set/JsmNvMFZfoHYzJSHo/B2HND/OIf4wuhBQxRS2EIhzSv68ARsX30CfkPjJdX71RA0lvZO0nw==
X-Received: by 2002:a05:6808:994:b0:384:2f05:55e7 with SMTP id a20-20020a056808099400b003842f0555e7mr8215887oic.55.1678315991298;
        Wed, 08 Mar 2023 14:53:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y205-20020aca32d6000000b00383eaf88e75sm6883273oiy.39.2023.03.08.14.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:53:10 -0800 (PST)
Received: (nullmailer pid 4020456 invoked by uid 1000);
        Wed, 08 Mar 2023 22:53:10 -0000
Date:   Wed, 8 Mar 2023 16:53:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] Fixes dt-bindings: display: mediatek: Fix the fallback
 for mediatek,mt8186-disp-ccorr
Message-ID: <20230308225310.GA4017099-robh@kernel.org>
References: <20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:40:11PM +0100, Alexandre Mergnat wrote:
> The item which have the mediatek,mt8192-disp-ccorr const compatible already
> exist above. Remove duplicated fallback.

Drop 'Fixes ' at the beginning of the subject.

> 
> Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback for mediatek,mt8186-disp-ccorr")
> 

No blank line here.

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Fix MTK color correction binding
> 
> The fallback compatible has been duplicated in the 137272ef1b0f commit.
> 
> To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 ---
>  1 file changed, 3 deletions(-)

With the above,

Reviewed-by: Rob Herring <robh@kernel.org>
