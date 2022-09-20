Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A795BE6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiITNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiITNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:24:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897862FD;
        Tue, 20 Sep 2022 06:24:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1648207wms.5;
        Tue, 20 Sep 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/1DbyJn3NUscYLhtpPQ3RU31E+x0F3RQcYcyQ/D7jVY=;
        b=lymRQT1Fh/haltHq+c4DfrZ2Vjez0vb0cbfqnKp15iD+TC7/Gu5mm0V/j7XRU67PZl
         8aY04+8budmFC08xsGmHaadBhIa05u01BlpBcpuEn8gvLFeNRazGsk3stYwoVQ8lh31E
         5Knf9gBOHPZ887ZhdwW8TJl37WvEbSQetft301NJm1+zWJsmDGBqrt+Hyflf+8XG0IhB
         zcee/Vi+0zqrVDBRXlxa5Tmx6fQVLHqwz3YyXfpsqBaAMkQMjKpGWSKv+99LQ8MhQaIi
         IGWUJbofoFf/O3oLF8enIrd6bAYsCb4x089Z0dea4DH9LCGl2jaUgtZUPxMJMjqi+nf3
         0kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/1DbyJn3NUscYLhtpPQ3RU31E+x0F3RQcYcyQ/D7jVY=;
        b=DUkFRoSxNgbPuaeHx9xTgWjH9pFyLG9+DmPzjGEG77AvQeNV0koGs6iPcS6TPlMADk
         wK0Pq3zUy0XRwIqDvMSr+j6plElKL9rEQmDBKmqxiTFxGc0PUe5VODa+GtFF9IqtepcX
         Wqw2pPVwdOkUME17qgUj2TZgKZrp2gUCr6n4+pzxUzAJENt0pbqxjPb2cGpEA+l6JTqk
         M7WxReiWOW+upCAm4fjFvGD6lH3dn62vyxr3kTMHK91lcltLoPoa7khzlICO+S0GzXJC
         2tXWJzbkFAO9u4P9f3WSseK35Pr1XkYZTVAQxyzZWcPDwYPpkityak1h/aky/N2xUiyp
         Tdsg==
X-Gm-Message-State: ACrzQf3iq+qRJbIhU+FB6EWo8GEDGB97O7dAXDAA/cHhFkChWF4/L3bU
        Dy4BJbDYsUQfTKVy1T5hX78=
X-Google-Smtp-Source: AMsMyM6L1U3dW3UkRoSC4hPVSn/TVSLABF/XFnp9f4QUECMmv6RsWqmnEcetm2stnZCk7Fytb5X+0A==
X-Received: by 2002:a05:600c:3844:b0:3b4:becc:e43 with SMTP id s4-20020a05600c384400b003b4becc0e43mr2466114wmr.33.1663680272675;
        Tue, 20 Sep 2022 06:24:32 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c3ba100b003b3401f1e24sm2891530wms.28.2022.09.20.06.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:24:31 -0700 (PDT)
Message-ID: <e3dccc71-42fd-6734-8d57-9a14ef708514@gmail.com>
Date:   Tue, 20 Sep 2022 15:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 3/3] watchdog: mediatek: mt8188: add wdt support
Content-Language: en-US
To:     Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220920105622.25666-1-Runyang.Chen@mediatek.com>
 <20220920105622.25666-4-Runyang.Chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220920105622.25666-4-Runyang.Chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2022 12:56, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Support MT8188 watchdog device.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/watchdog/mtk_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index e97787536792..b53763ad90cf 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/reset/mt7986-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>   #include <dt-bindings/reset/mt8192-resets.h>
>   #include <dt-bindings/reset/mt8195-resets.h>
>   #include <linux/delay.h>
> @@ -90,6 +91,10 @@ static const struct mtk_wdt_data mt8186_data = {
>   	.toprgu_sw_rst_num = MT8186_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt8188_data = {
> +	.toprgu_sw_rst_num = MT8188_TOPRGU_SW_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt8192_data = {
>   	.toprgu_sw_rst_num = MT8192_TOPRGU_SW_RST_NUM,
>   };
> @@ -429,6 +434,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>   	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> +	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
>   	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
>   	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
>   	{ /* sentinel */ }
