Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F5650EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiLSPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLSPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:38:40 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959268FD4;
        Mon, 19 Dec 2022 07:38:39 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1322d768ba7so11952440fac.5;
        Mon, 19 Dec 2022 07:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOiCy0WjVxH8DVieLn08mRiczm9EV7y8BSE0KN+iAsY=;
        b=DjxjbgqDIIrpkIVMc+4BESYvR89pi6HZNba9DDVg5hiBWLHxND+tlbjwJ+ogCLRtLO
         duhMwYnWVfP/m2ChjmGM/6bPk62Y4Tp5Yi1mOwowE0dv9nSJapsJoLbAP/5tH4oq1Qhs
         +jFzBA+UzprfVjp0W75l2MYm5GyndBeQebJOgcL9X97YYFJRxRsGteECRTtxHn1fe/DK
         iUnxYsaEPBqfuakrnwJ07rnkwTSmEi7ssjSQW3Wq0f2FAOpyNwG1ayPHtGvM2EL1lJGb
         MpDyS8F04WBmHqASNlWQatr7CCEbjbxj+bF1dELlz0+as+oaodnX7hxr7pbZiQS8HN4Z
         p7PQ==
X-Gm-Message-State: ANoB5pnpS6SrxBGWQNlGfmUeYLwNP1aL2gnW5EsBjWLPB3+kiNEIiOfB
        MiUIdYx8i2YLyHPuFVJFsQ==
X-Google-Smtp-Source: AA0mqf4x/VJvpocUXMYkW+FznjpJCn7AIX+ML2f8QWtAFUzzyWkj/yArsDdRcpF8jQ89ySsWI3scNA==
X-Received: by 2002:a05:6871:784:b0:137:3adb:9149 with SMTP id o4-20020a056871078400b001373adb9149mr20697434oap.16.1671464318860;
        Mon, 19 Dec 2022 07:38:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870e31500b00148316f78fesm4870553oad.2.2022.12.19.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:38:38 -0800 (PST)
Received: (nullmailer pid 1431223 invoked by uid 1000);
        Mon, 19 Dec 2022 15:38:37 -0000
Date:   Mon, 19 Dec 2022 09:38:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: spi: mtk-snfi: Add read latch
 latency property
Message-ID: <20221219153837.GA1426412-robh@kernel.org>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
 <20221219024019.31974-7-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219024019.31974-7-xiangsheng.hou@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 10:40:15AM +0800, Xiangsheng Hou wrote:
> Add mediatek,rx-latch-latency-ns property which adjust data read
> latch latency in the unit of nanoseconds.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> index bab23f1b11fd..1e5e89a693c3 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -45,6 +45,9 @@ properties:
>      description: device-tree node of the accompanying ECC engine.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  mediatek,rx-latch-latency-ns:
> +    description: Data read latch latency, unit is nanoseconds.

Doesn't the common 'rx-sample-delay-ns' work for you?

Rob
