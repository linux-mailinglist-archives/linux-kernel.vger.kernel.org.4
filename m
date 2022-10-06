Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC05F6D66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiJFSQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJFSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:16:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C915E0EB;
        Thu,  6 Oct 2022 11:15:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l4so2426157plb.8;
        Thu, 06 Oct 2022 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INuwAkmrXHqnSNjAnlxKdqABDBx0o7c8IwuxVAwc7ks=;
        b=DJ1zlZzwwZ3npaG7z4VyIw6AXG5DKyK43lDsBwzClOf1w79t3Qn3/E/1iidGT5YaAX
         oRHFN4DWlUuNbOt/9rcuHh21i98fpXO9eqR0bVdeF5g6kQKlfLWYk/lH6hrw+Lwg834d
         Q9yjllg6CuB0s5kaoQF1RR4mXcLc6m72Pq00CRY2nvFJpS+/CnY2mLjeYXg9J+gZDnzg
         wziIrRf8yg+JZxMyQvnZQrs85lCd/dNXPBLeO/z3aIt50z4alkQGIUdyJQoLLQMmRIbk
         Q9MewppXq5UU9Q0gR5HeMzlm3LDdWDvkN6uPtMgncsS+w9DXH347yMLAFREDFjCttk+z
         JKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INuwAkmrXHqnSNjAnlxKdqABDBx0o7c8IwuxVAwc7ks=;
        b=T3eAftga/l8B7YV7K4s2+LlOB+Rc6RiMz4ATbnCwTw2QODo9a/EG1mGVfCU3nDxQDY
         50KuR5QG04vYPhdTM8psewnj1PIg5uKhbyz1ZnjKjt7dzCaV+cxIRTKjTbGRT5sXGCH3
         mOlbrOZaeZDQbn82hBqKHxEzp51fhaohy2I5fzn7PIkCSDB2HmW3B3v0265gwZSH2hIL
         HSAHweKDGd2CbWcdMcG/QP9LyLVZhXw9iXG3LVecTzQ0mV2d91Z8CdNYOpteZstwDoBa
         E646Oo1CKj4v4R9UtWMmPQrfA4Rtuyfw7zcm4LhYnv8P3Uydr1aKpN3JHAW1YXtDzfDx
         l0Ww==
X-Gm-Message-State: ACrzQf3pipYauRcrCvpMtPF0w/lBaf8o6PB1Pe+kqfyQtUlXGyca5hWt
        MGVfJ9DIzy4jwK8yr9PFvJQ=
X-Google-Smtp-Source: AMsMyM6c64HgA/XQXZ3v7axjSYazhpsFlm79JcdUGoueQB46M8UKKFfOXW67AIijeqJSBFg6kzqueA==
X-Received: by 2002:a17:903:32ce:b0:17f:75dd:de88 with SMTP id i14-20020a17090332ce00b0017f75ddde88mr1091980plr.5.1665080157064;
        Thu, 06 Oct 2022 11:15:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d19-20020a631d53000000b00440507bb7fcsm54117pgm.31.2022.10.06.11.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:15:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Oct 2022 11:15:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] watchdog: mtk_wdt: Add support for MT6795 Helio X10
 watchdog and toprgu
Message-ID: <20221006181554.GA762091@roeck-us.net>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005113517.70628-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 01:35:17PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for the toprgu reset controller and watchdog for the
> MediaTek MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mtk_wdt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index e97787536792..5fa42b7d4b4d 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <dt-bindings/reset/mt2712-resets.h>
> +#include <dt-bindings/reset/mediatek,mt6795-resets.h>
>  #include <dt-bindings/reset/mt7986-resets.h>
>  #include <dt-bindings/reset/mt8183-resets.h>
>  #include <dt-bindings/reset/mt8186-resets.h>
> @@ -78,6 +79,10 @@ static const struct mtk_wdt_data mt2712_data = {
>  	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
>  };
>  
> +static const struct mtk_wdt_data mt6795_data = {
> +	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
> +};
> +
>  static const struct mtk_wdt_data mt7986_data = {
>  	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
>  };
> @@ -426,6 +431,7 @@ static int mtk_wdt_resume(struct device *dev)
>  static const struct of_device_id mtk_wdt_dt_ids[] = {
>  	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>  	{ .compatible = "mediatek,mt6589-wdt" },
> +	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
>  	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>  	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>  	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> -- 
> 2.37.2
> 
