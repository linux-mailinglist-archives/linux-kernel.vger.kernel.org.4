Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E55F6D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiJFSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiJFSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:12:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781EFF23B;
        Thu,  6 Oct 2022 11:12:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l4so2419170plb.8;
        Thu, 06 Oct 2022 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPvMVkgPdsNf80rz7k0a5WRJw4bKxleUIlz2BgflFH8=;
        b=qiwpMb5sCiOOvdw8s4nYdgUGzTk18rO6iLScxPrheyllF+geonkIrPRddQ6cwQH4pc
         mB31K9yGLj9S2eo7MR0SU+fSAXJ3hsUt4TXENovPuH6MdzIFYUfaq1Hj7DVs18//KA0C
         M3g5hGc9hKHGOu0mCOG53waM9tBhEjYXP2fhISS5LvZXZhKnaoy2kIiqvVaoNDqkwEyR
         SlWRvwgs6Syh4pSkYwYdR+4JsVyvYTop8YUKW1f15xKfWuuk9VyXUsLYcGZODsR/s6Zs
         7zMdK6aIVUGuNgMslpPJjZ4HxeoGBhyNGFTFnrHsm10DfX2Zck2RB/TBS/n/St8xniwW
         VQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPvMVkgPdsNf80rz7k0a5WRJw4bKxleUIlz2BgflFH8=;
        b=nVT5PXUZoJsQ7M7739qQTb91IQ+lBIgmABNHeS74Vxhg7LkWbsmNPLB6D/Zj9pmWPG
         s+MDDPM8lDIwo3ctLtxgo+Rf2Fr1jPDjlD1zyOkf2Hx2rMQ6xappsPniM3EEz2/qx20W
         TpCl9TiPms06A5wCpV9Xcf332xdbZtNh+qNkvouEP9jkuNYK/520ikZQQkgpIL9dTlH3
         x1/kkcvZEiFGB5J7n19CPTjDZ6JqGFHt7cl90gKzG7O8n5YLbvK/lx3W/gGmFRXywQ87
         rZjnoS/s0iVMOXTEx1gwKlMageduB/noAEyEtHEaVH38jMXF0ORo45apLNFTArWPTUwW
         qkAA==
X-Gm-Message-State: ACrzQf1IqbntkRd/7dboa8xHe89xVOKg1rEPSKLTqHcCVboDPMNqIUl8
        z80Anthe+2myAQIJw687V6Q=
X-Google-Smtp-Source: AMsMyM4KyrcrFHmKtPHVDrezSvqbeuuip0f3OCMsAV0JwH2L8T6IIqzdzWEOKogxHO36cFnHopaWAA==
X-Received: by 2002:a17:90b:3b47:b0:202:d9d4:23f7 with SMTP id ot7-20020a17090b3b4700b00202d9d423f7mr11794193pjb.56.1665079975573;
        Thu, 06 Oct 2022 11:12:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w191-20020a627bc8000000b00560e5da42d5sm9068974pfc.201.2022.10.06.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:12:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Oct 2022 11:12:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 7/8] watchdog: mtk_wdt: Add support for MT6795 Helio X10
 watchdog and toprgu
Message-ID: <20221006181253.GA761987@roeck-us.net>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-8-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006120715.24815-8-allen-kh.cheng@mediatek.com>
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

On Thu, Oct 06, 2022 at 08:07:14PM +0800, Allen-KH Cheng wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add support for the toprgu reset controller and watchdog for the
> MediaTek MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

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
> 2.18.0
> 
