Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5C5F55B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJENjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJENj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:39:27 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF67B78F;
        Wed,  5 Oct 2022 06:39:21 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-127dca21a7dso19857851fac.12;
        Wed, 05 Oct 2022 06:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh5g/jeg4IcMVIdYOAqzKtEWeQUG7j9eLKz+CVBRSTY=;
        b=G0Yqom4ySGy0L7pQ4uB2OaPDOh36Gx8507Aqk1HMl04B6pAfKS8EYZQmbCcdW8BF6k
         o+nhAPWslSfDrLIOXjDg+f7C9e6fWTiqaZpTD1qDvlY7E9JcapFTeol5jVLw+zeT5PDP
         xqw7a7Nbae+ZkEZVB5p03CLv2Df112oWKCbXQioz2TKL0kg9RqKh/ILJ6SN3a4u3gSa8
         uwKGkcvjOQorbr1meKJ9WKt7OgDPg7/j/CadT3A5PPE3GSoBnTPo79EOA6Gu3QZkhZnS
         m7ofrszpVmCcBnMvo8dKhGINYtd6y0e+boF6B8J3DfD4+XLDgDDxlbeVCtEmbai7p1np
         aCyQ==
X-Gm-Message-State: ACrzQf2bkGbIngf3MikzKIx2WgDqahVgm3oA3/eT9SVj+pOrJzbucGGG
        jaZ811/LQwFBJhy5cqaemy2e55686w==
X-Google-Smtp-Source: AMsMyM5C6tFxD3JDoJ5tDFss5UAJmxP132Evy2zUMEZix7Ezd7j3BSP+YJYi8vnsTcxuy2maFgcD9g==
X-Received: by 2002:a05:6870:f588:b0:131:3f4c:572c with SMTP id eh8-20020a056870f58800b001313f4c572cmr2638570oab.210.1664977160358;
        Wed, 05 Oct 2022 06:39:20 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id q123-20020a4a4b81000000b004763bad30f1sm3422743ooa.11.2022.10.05.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:39:20 -0700 (PDT)
Received: (nullmailer pid 3284822 invoked by uid 1000);
        Wed, 05 Oct 2022 13:39:18 -0000
Date:   Wed, 5 Oct 2022 08:39:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tinghan.shen@mediatek.com, linux@roeck-us.net,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        wim@linux-watchdog.org, allen-kh.cheng@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        seiya.wang@mediatek.com
Subject: Re: [PATCH 4/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6795
Message-ID: <166497715817.3284769.9012408776318065890.robh@kernel.org>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005113517.70628-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 13:35:16 +0200, AngeloGioacchino Del Regno wrote:
> Add the mediatek,mt6795-wdt compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
