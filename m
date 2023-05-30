Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8377715611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjE3HCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjE3HCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:02:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D6A0;
        Tue, 30 May 2023 00:02:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so4077536f8f.1;
        Tue, 30 May 2023 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685430136; x=1688022136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Cn7BURMfmZTSYvAjUDhBc61q3ac6L86uf0D6qKr5nQ=;
        b=WpE/5OkdjAN1NHXIXDvk3BA+6Uw8nXLVBhjegNsl0WOf+FI9SjL/8dwAypy0fH/dni
         eYr2EPSAv3Mm6fS2d9UcbJihuuLHWW6QSluXwl1TDmOfzNG7rq6mgjBUrpORfzHqdDmw
         /6z+nK+ArUp8/pUXGwghd+56vjzGK3OSxiqrT2PboYNxkf+4J2WJk7fhSZ+fLnxYCeGw
         zwc4h2sIdMIK47LwE3VP4Gyw+ijlLxG3/xfUuu6d1FsR9EPDCdXk3XK51118g793ccbj
         04JfLdObng6t6xQf/P2PCR63O9Yt/1Yp5CwgGXoT2pDpX9LXbg3LA91X18lUDif2wbRO
         CTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685430136; x=1688022136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cn7BURMfmZTSYvAjUDhBc61q3ac6L86uf0D6qKr5nQ=;
        b=ZrFuw6L9Qv+o/Q32+QV5lJgUgfzqve+M6pGRsS85GyPYCRFHB3HWw4nqqlZs/Z6LXY
         VcYFAoMT69iM5/uh1BrzZEDgVnSB0q/Rob/hRVf8b+lrHTMfMB5VlVIC6NOSzo1Q2j0I
         UX5E0V0xyXRhyVo1kFGo87w98RssSOGXV/Q39pAoS2NuGppQgkeoTQX0qs3tqhfSvfOM
         MalaYOikWqvtUH27bG3t1Dg36ciVDxFhMxRQla/WN1ZPui6ps0SIfPIsGdinauLyZXS4
         AijFo9ojm2tCidXKyCdBtUIzGYQ7mKj9gla28FNGxjy1u4+P39Y4hggR/8mJONj9S/g1
         v8AA==
X-Gm-Message-State: AC+VfDyoDUORRwKziS9istIPLT0MCEeUJH/detGhlK5g/DGdyhnICku1
        cYhEY9gN05KoPgEgoX32cEg=
X-Google-Smtp-Source: ACHHUZ5rEMZz9DjgkZq0RFTt+kP47yJCCtuAlQ7pT+0tm1OwSGI9LO+LI9ebP3HRLxOGW1tkQ9pTUA==
X-Received: by 2002:a5d:5147:0:b0:30a:e510:ab77 with SMTP id u7-20020a5d5147000000b0030ae510ab77mr835727wrt.19.1685430135360;
        Tue, 30 May 2023 00:02:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c7413000000b003f60e143d38sm16401935wmc.11.2023.05.30.00.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 00:02:13 -0700 (PDT)
Message-ID: <6ba24acc-a12e-5d8e-684f-7032f4c53d6a@gmail.com>
Date:   Tue, 30 May 2023 09:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for mt8192
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230529164605.3552619-1-bero@baylibre.com>
 <20230529164605.3552619-2-bero@baylibre.com>
Content-Language: en-US, ca-ES, es-ES
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230529164605.3552619-2-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2023 18:46, Bernhard Rosenkränzer wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controller definition for MT8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../thermal/mediatek,lvts-thermal.h           | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> index 8fa5a46675c46..5e9eb62174268 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -26,4 +26,23 @@
>   #define MT8195_AP_CAM0  15
>   #define MT8195_AP_CAM1  16
>   
> +#define MT8192_MCU_BIG_CPU0     0
> +#define MT8192_MCU_BIG_CPU1     1
> +#define MT8192_MCU_BIG_CPU2     2
> +#define MT8192_MCU_BIG_CPU3     3
> +#define MT8192_MCU_LITTLE_CPU0  4
> +#define MT8192_MCU_LITTLE_CPU1  5
> +#define MT8192_MCU_LITTLE_CPU2  6
> +#define MT8192_MCU_LITTLE_CPU3  7
> +
> +#define MT8192_AP_VPU0  8
> +#define MT8192_AP_VPU1  9
> +#define MT8192_AP_GPU0  10
> +#define MT8192_AP_GPU1  11
> +#define MT8192_AP_INFRA 12
> +#define MT8192_AP_CAM   13
> +#define MT8192_AP_MD0   14
> +#define MT8192_AP_MD1   15
> +#define MT8192_AP_MD2   16
> +
>   #endif /* __MEDIATEK_LVTS_DT_H */
