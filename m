Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DA6293C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiKOJC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKOJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:01:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155921275;
        Tue, 15 Nov 2022 01:01:10 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E0ED66029B1;
        Tue, 15 Nov 2022 09:01:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668502869;
        bh=TdB8L6iEEelm86FFJ5OJDly7KU/ks58hSw2iu/gT3lA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NW2VKuuy4edI9qk2ZfR4FKnUJHCl6D+hk7cJ7hbgf3Iee8A3ncAXEqSvKixutOWtO
         WlF+Xqn7w9LLtZmuR75LEyDU7yTXtB+LKxMvCmpAOHP6n8tglFcnBNyUuVyqMDFHeb
         oKI1vVp1sxB5QPiNuDnxGyWGBWFv/Ier9zzjdrKs9VIFaeAwkvhtcuiTUtyGC7i2ml
         N4NBXozO4kFP7a7XAJAVBBJ+c6qkf1zeqxEMmJtpPIgoBeiKdr86ZXC39eEggn8is/
         Z+2w9uCm8ImX947KoJdfCcfKrp64z8ouFRUnu7bZEK0RFzkSJunIC7QnHkge3mUjOC
         yWixTIwUSYTDw==
Message-ID: <70505f57-244d-1fea-3590-8158be25383a@collabora.com>
Date:   Tue, 15 Nov 2022 10:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 02/15] dt-bindings: watchdog: mtk-wdt: Add MT8365 SoC
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-3-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221115025421.59847-3-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 03:54, Bernhard Rosenkränzer ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Hello,

There's a mtk-wdt.txt schema conversion around that's well reviewed and that
will land before, if not at the same time, as your mt8365-evk series (judging
by the fact that you anyway have to send a v3...)

Can you please rebase this commit over [1]?

Thanks,
Angelo

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=693051

> ---
>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 762c62e428ef2..835af28b46de0 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -20,6 +20,7 @@ Required properties:
>   	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>   	"mediatek,mt8192-wdt": for MT8192
>   	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
> +	"mediatek,mt8365-wdt", "mediatek,mt6589-wdt": for MT8365
>   
>   - reg : Specifies base physical address and size of the registers.
>   

