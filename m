Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86886B1197
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCHTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCHTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:00:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183B8EA3B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:00:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ec29so38911488edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 11:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678302044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t11cxmne+0VdAolMvDq/xltshYeH2IXmpwmlXchwk3k=;
        b=AGLZkhWFlMA8ZWIjUlo0+w3j+VFetWhvUJxpWk0y0IoM53AD4KkK9U4PLEdndBDqQg
         xu5jkIFSsnXO74ausz2POBUYhA7DpXBG7rJIc4SXzSBYunKc/Uq0Y848Fi0ibHHV/t5n
         MTQPTJxKtdipKusQ+0r6Ct67v3Uhl12P3UszYAS9WvufRH08OOT4Ija27PAYJQRdXlKp
         XZNnumm6spmdNIbzNbaDDPOLazEWmpj0RwawvbRfKEcEXr/FwTB8KDX7I7koQNrwq5cO
         2NnwC/96XcIxWGgxA/jq9dJF5MOv+mIIfBpddgzLuiAxZeAWBbrYLNKr0ssGSGaGbQxJ
         B3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t11cxmne+0VdAolMvDq/xltshYeH2IXmpwmlXchwk3k=;
        b=wuGhdMNsH25lYpyiWfq4ZijbHgmORYtw7Kozzu8R0Zcn/ovu85Fpu45OF7T0P2Ax5I
         C7SWxd8Unr7yaYlLBSfHdPkhR2/SOQS1jo3JwHhRuLLkWHZgF3JvAXR4HwN4Wv+OcS96
         saVoZ43Ns2nl+Xw7qcws8ZC0UDGrsnToNHFykll5auqZzSnkAkyqnSGVOsVHyxnBFiaU
         iN6OkqKZShDRyGZ92x5q9O/J2Ac48W5FLhzsFZb/ZJEYk0dNtvhXM3lcNc3dWFl1g9bz
         IGaL06uLKzw46hRkt51faHvxKKRwkXzNt9gnMFaI5k9a0+NFaEp2Gr+4sA81v8JVxG5P
         fw9g==
X-Gm-Message-State: AO0yUKVw679qGybYDUjyBcy+CXbwlZrH3oJpWRodvqU15RVMIPnVFmSi
        XfHjMmUFfrVhM8Dw4xS04KHnGw==
X-Google-Smtp-Source: AK7set/+5jp0MA8IXZg5DhthNgI1lxVOkSh+a5PHrXyYyfbVxm4Qz0kTiahcu3zvWUYmETajoJJw5w==
X-Received: by 2002:a17:907:7e9a:b0:88a:a27c:c282 with SMTP id qb26-20020a1709077e9a00b0088aa27cc282mr25411368ejc.47.1678302044260;
        Wed, 08 Mar 2023 11:00:44 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id dt2-20020a170906b78200b008dcf89a72d7sm7955386ejb.147.2023.03.08.11.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 11:00:43 -0800 (PST)
Message-ID: <def9197e-bb3c-b9f2-35c5-168b632ef93e@linaro.org>
Date:   Wed, 8 Mar 2023 20:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add binding for MediaTek
 MT6735 power controller
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230302122708.73848-1-y.oudjana@protonmail.com>
 <20230302122708.73848-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302122708.73848-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 13:27, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT binding for MediaTek MT6735 SCPSYS power controller.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/power/mediatek,power-controller.yaml  |  2 ++
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |  1 +
>  include/dt-bindings/power/mt6735-power.h           | 14 ++++++++++++++
>  3 files changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6735-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index c9acef80f452..710db61cab53 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -23,6 +23,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - mediatek,mt6735-power-controller
>        - mediatek,mt6795-power-controller
>        - mediatek,mt8167-power-controller
>        - mediatek,mt8173-power-controller
> @@ -81,6 +82,7 @@ $defs:
>        reg:
>          description: |
>            Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/mt6735-power.h" - for MT6735 type power domain.

Isn't the comment obvious? Maybe let's stop adding them?

>                "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
>                "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
>                "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 2bc367793aec..3530a6668b48 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -20,6 +20,7 @@ Required properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-scpsys"
>  	- "mediatek,mt2712-scpsys"
> +	- "mediatek,mt6735-scpsys"
>  	- "mediatek,mt6765-scpsys"
>  	- "mediatek,mt6797-scpsys"
>  	- "mediatek,mt7622-scpsys"
> diff --git a/include/dt-bindings/power/mt6735-power.h b/include/dt-bindings/power/mt6735-power.h
> new file mode 100644
> index 000000000000..782b49a88773
> --- /dev/null
> +++ b/include/dt-bindings/power/mt6735-power.h

I am pretty sure we already discussed the file naming with some other
patches... mediatek,mt6735-power-controller.h

Best regards,
Krzysztof

