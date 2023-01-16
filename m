Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ACD66C3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAPPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAPPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:32:00 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53F23C47;
        Mon, 16 Jan 2023 07:27:10 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15ee27bb0a8so8763320fac.7;
        Mon, 16 Jan 2023 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+UDRzzqJZNu06Gc3ga3e9IbYLEa/rLRliciSPrDBYRg=;
        b=RZ1n0r4AI2GerlleUSjlaFyWkhgl9jIMqXrEzlp1ISH72sFG9wRxtNfxl3PfYoU30v
         Z80ubSNT6yJGj81XovIyuXolWqXluS6B5cE2P6/fLTlkFPpq2RjcGgCkeTpLVwynlHva
         2hQo9OZ3BIBz9PU2Fjl579mEVJph58m0+YkHhx7cgqdC118Ru/WxV1vkcu6XhYHmPHZA
         PeTCYHCFpJXFkWfN2Sxrxuz3zyASDXMfpvaj88JuB2BrJunQWn/dWiNbmIzQGo3uDTyb
         /ZvCC5gfoLjbgmvLX1n+w+DbI6QC6Ch16CQfCine2/9Pod7zAFqZF3+fpYexfyItzswx
         Yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UDRzzqJZNu06Gc3ga3e9IbYLEa/rLRliciSPrDBYRg=;
        b=szUsaW+DM7Tk/Nu1mVWxUN1o0ukk6R08OSoMVQDdqvyT4Vo/ZQ1mem+tappXxS2bko
         ZH3bsCYMutsxG41JZYLCE951I7/LXbKhmrsZdtO8pbtCTG6X1fgZdIJgeiyiCkMXLUtM
         8HD9krbrWL5YN0DDJw38iv4Dqad8bvOigkuZRdJwslwqIjAtbN+h1ZXEdwT+84djy3w4
         84frSl1SiQQ0UArA3/6Yf138fJfTX1g1d4UE3Fd+eqG6mbT2t3yvVQh7ryoagI3uwfZa
         73BWbtR7LEyAtFihobrBAwvk/8AZwy9wIEvthmfpHf9zSOrWxH9VwBIKX2J6Wfxh2I2j
         qkrg==
X-Gm-Message-State: AFqh2koynJ7xDdEZYiIytiJY6iLkl8AiT2CfetiJG7JuBD81bbzENurb
        KY5U3KwMDL27ePRpHHKQuZdfALRuWZ8=
X-Google-Smtp-Source: AMrXdXvOczUTz6EPlUdVCboKTU+LLgs9MuRt5dnGPTrU4EEQ8diSJ0rUGv8x4kcKVoA+IAM6neRL/w==
X-Received: by 2002:a05:6871:110:b0:15b:868d:137f with SMTP id y16-20020a056871011000b0015b868d137fmr116467oab.1.1673882829313;
        Mon, 16 Jan 2023 07:27:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c6-20020a056870c08600b0014be94a12d0sm14722761oad.44.2023.01.16.07.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 07:27:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bfcac231-682d-8b2c-6c3a-e3a5a04ca5bf@roeck-us.net>
Date:   Mon, 16 Jan 2023 07:27:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] watchdog: mtk_wdt: Add reset_by_toprgu support
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230116105305.31818-1-allen-kh.cheng@mediatek.com>
 <20230116105305.31818-3-allen-kh.cheng@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230116105305.31818-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 02:53, Allen-KH Cheng wrote:
> In some cases, the MediaTek watchdog requires the toprgu to reset
> timer after system resets.
> 
> Provide a reset_by_toprgu parameter for configuration.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 3e6212591e69..a9c437598e7e 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -50,6 +50,7 @@
>   #define WDT_MODE_IRQ_EN		(1 << 3)
>   #define WDT_MODE_AUTO_START	(1 << 4)
>   #define WDT_MODE_DUAL_EN	(1 << 6)
> +#define WDT_MODE_CNT_SEL	(1 << 8)
>   #define WDT_MODE_KEY		0x22000000
>   
>   #define WDT_SWRST		0x14
> @@ -70,6 +71,7 @@ struct mtk_wdt_dev {
>   	spinlock_t lock; /* protects WDT_SWSYSRST reg */
>   	struct reset_controller_dev rcdev;
>   	bool disable_wdt_extrst;
> +	bool reset_by_toprgu;
>   };
>   
>   struct mtk_wdt_data {
> @@ -279,6 +281,8 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
>   		reg &= ~(WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);
>   	if (mtk_wdt->disable_wdt_extrst)
>   		reg &= ~WDT_MODE_EXRST_EN;
> +	if (mtk_wdt->reset_by_toprgu)
> +		reg |= WDT_MODE_CNT_SEL;
>   	reg |= (WDT_MODE_EN | WDT_MODE_KEY);
>   	iowrite32(reg, wdt_base + WDT_MODE);
>   
> @@ -408,6 +412,9 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>   	mtk_wdt->disable_wdt_extrst =
>   		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");
>   
> +	mtk_wdt->reset_by_toprgu =
> +		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
> +
>   	return 0;
>   }
>   

