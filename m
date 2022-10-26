Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8760E471
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiJZP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiJZP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:26:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE6FAA45;
        Wed, 26 Oct 2022 08:26:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso691285otf.13;
        Wed, 26 Oct 2022 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rETPEk1QmQkLedue9Aq10b8Dr7LRzg0Ndi5czbR2hBM=;
        b=B54fnVfPIbpKgzqs0UjFdW9Dwxh0Wp9I9IRyxLfsKmP0Mp73HqbzpGVooDNWoZgeoT
         6cIfWt2pIJfaj0DDk5q306TAGKrPs9Fxa+L/PJNvzuFZq9NAXocoYQ7GgX2lxwFV1xxo
         8n/J+XcXsQUuwuYp0vpQWNvjN2396K0QfnRIkW5Zf7n8HQ3jOhGThDRCt8BXFvIMwbtX
         gn9I6hft/vhUM5XaUwAFKLs76MNsXFntXHzM/w2ZprifyvGHMqp9MW5KmoyulztQ/0pX
         4OVxLlOilLlj7Kgy1S9rTWhLppX5qxiKxoBQvcA4bg4xqxsTmfSglXMAEgYGUbuEJWhI
         j6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rETPEk1QmQkLedue9Aq10b8Dr7LRzg0Ndi5czbR2hBM=;
        b=Sd0XTe6I5JJcmQqqJG6/dMJchRoE1ycXNZCwCEH1hEEaZzgCqJ609gttAPeAvAHLx4
         WAJuYbO3xKZ+Yvfp/9zmU8dEOEeUt6kZNeCa0Sk/WGjoGvMAV+dZS/5INTEX5EK82gVK
         HWvnLc7l2NQM6DIO99i0Nys675VDVfWt2p8bEnYV7U6qRYEIL/4QqIob3YRTn7idtj2X
         WkdsLYjvpVKijUqTr+mTlXP0P4RLTc8v24XhUArufGMGzusj7QUF060nUcGB7t6uMj7J
         DG0dqlORyCAIn2mAAoglgMVtoLS3onh4plnBf7fwlCj5g8Id/Q2T1W9BH2eMkUg1RuxF
         NMeg==
X-Gm-Message-State: ACrzQf3eRf7OPWVGw+6YUv4Uaoo9h95Njwldi/qWZ50a0tS7rbdHhCmu
        mWzuYhCvmZefXVRZrn6zw+k=
X-Google-Smtp-Source: AMsMyM48086VLKArZW0qg/GJXwajJeYDYn0Mw0euDn179MpRlshE5OrXRRv/dWeDXWc6cWBR3Sbhyg==
X-Received: by 2002:a05:6830:603:b0:661:b07c:bf24 with SMTP id w3-20020a056830060300b00661b07cbf24mr22137103oti.208.1666798007507;
        Wed, 26 Oct 2022 08:26:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fo27-20020a0568709a1b00b0013b0b19100fsm3218662oab.32.2022.10.26.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:26:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Oct 2022 08:26:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Runyang Chen <Runyang.Chen@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Message-ID: <20221026152645.GA2946818@roeck-us.net>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
 <20221026063327.20037-2-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026063327.20037-2-Runyang.Chen@mediatek.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:33:25PM +0800, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add dt-binding documentation of watchdog for MediaTek MT8188 Soc
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This conflicts with the ongoing yaml conversion of this file
which is still not accepted.

https://patchwork.kernel.org/project/linux-watchdog/patch/20221005113517.70628-4-angelogioacchino.delregno@collabora.com/

Nevertheless, I'll apply this series to my watchdog-next branch
and assume that it will be included in the next version of the
yaml conversion patch.

For my and Wim's reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 762c62e428ef..b900c85d4560 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -17,6 +17,7 @@ Required properties:
>  	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
>  	"mediatek,mt8183-wdt": for MT8183
>  	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
> +	"mediatek,mt8188-wdt", "mediatek,mt6589-wdt": for MT8188
>  	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>  	"mediatek,mt8192-wdt": for MT8192
>  	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
