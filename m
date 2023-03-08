Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC76B0650
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCHLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCHLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:47:15 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A12B9C94;
        Wed,  8 Mar 2023 03:47:13 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so8837242otv.0;
        Wed, 08 Mar 2023 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678276032;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQ2WPTCbyvL+AflkQHfaPs3zDSYxWs314C3qyI21Pg8=;
        b=qermU0F5O00qgMK7xKWZTCdtW28sugdSXmu1Oiu+iXHTTHKJlMUCEkP/Iz1ldq0iSn
         0OLZRgUzzxxKuzB+glG4VYGaDRtoouh4wvj41yvAvd9nWx3IBUAVsH6hJC8mpG2aTzt9
         zS8QW4aZbOXqUQtbHJI7qlUNCSIdFyUhUhqtBGJDXZ2oy0km6nXmAPmtiBG/+qn7SbOx
         B1WV+xe6O/7nPwFZ/dwH5T2pnaJUGzByhnsgCyLSXmCWJxFELHxFGcDCRfvcztVDS/tD
         Ac8sHPxhJRDScUJfADNCO6e91CzTWSH7VnspjvSNbdf504hbjHDWr57QWAyr6LUqHLfi
         T9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276032;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ2WPTCbyvL+AflkQHfaPs3zDSYxWs314C3qyI21Pg8=;
        b=HDkGvyrTcIpVu/4TWwaJbqFgGh7q6ir00g1vcxFfCZmnDgi9XeS6jPWAgFzjI6rECe
         4HLQ3X4jACwfRdNXpcQ9Icr72LKwznw/yMO+1UOO5+ZpUzoDt/LIeIGmlbBUcNOhUcKQ
         WSiiaHS/63Dn/AbT1oFUt3Dv/dQtACTnB6Wjr/3VMh4P2KB7t4Z02vTVybgEJWtUsuAC
         65r2QcMs5TaEsgx4ebUA8oWz9WbvsmfQd26OgOqB+6n/R4JWw2NVHtEO6FG9MsHF1mRB
         VQuXherjUP0Ev2PacbK002H3MQeGr2cpxlUl/1/TrXl94bPrlYQTK7Vdd+IDXXaOeMCm
         ggUg==
X-Gm-Message-State: AO0yUKXzgWrBQ4L7/aOpZ198XYgj5kvmkBgFM+HoyhXcJXM2t4TK87M6
        X6u8NOtJ0zfJKTG6o6bhs/HTPyX8tSU=
X-Google-Smtp-Source: AK7set8Sv7RnRI1MI5vDqZL0ZKir6hUO+x5gZ6uXumiuS5D2v3XSKRJz6I8R8rSMIAL3lGyMQs9PVw==
X-Received: by 2002:a05:6830:310b:b0:693:c424:185f with SMTP id b11-20020a056830310b00b00693c424185fmr11710236ots.36.1678276032556;
        Wed, 08 Mar 2023 03:47:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a26-20020a056830101a00b00693ea7bfdc2sm6277062otp.76.2023.03.08.03.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:47:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4dd46b6-3582-129b-e75b-085571abaf72@roeck-us.net>
Date:   Wed, 8 Mar 2023 03:47:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
 <20230302124015.75546-3-y.oudjana@protonmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: mtk_wdt: Add support for MT6735 WDT
In-Reply-To: <20230302124015.75546-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 04:40, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add support for the watchdog timer/top reset generation unit found on MT6735.
> Disable WDT_MODE_IRQ_EN in mtk_wdt_restart in order to make TOPRGU assert
> the SYSRST pin instead of issuing an IRQ. This change may be needed in other
> SoCs as well.
> 

This is two functional changes in one patch. Also, the "may be needed"
is vague. It is either needed or it isn't.

> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/watchdog/mtk_wdt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index a9c437598e7e..5a7a7b2b3727 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include <dt-bindings/reset/mt2712-resets.h>
> +#include <dt-bindings/reset/mediatek,mt6735-wdt.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
>   #include <dt-bindings/reset/mt7986-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
> @@ -82,6 +83,10 @@ static const struct mtk_wdt_data mt2712_data = {
>   	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt6735_data = {
> +	.toprgu_sw_rst_num = MT6735_TOPRGU_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt6795_data = {
>   	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
>   };
> @@ -187,9 +192,15 @@ static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
>   {
>   	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base;
> +	u32 reg;
>   
>   	wdt_base = mtk_wdt->wdt_base;
>   
> +	/* Enable reset in order to issue a system reset instead of an IRQ */
> +	reg = readl(wdt_base + WDT_MODE);
> +	reg &= ~WDT_MODE_IRQ_EN;
> +	writel(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
> +

This is at the very least misleading. It appears to confuse
"reset" (which is triggered by writing a specific value into the
WDT_SWRST register) with the action to be taken when the watchdog
triggers. The code below does not trigger the watchdog; it is
supposed to trigger a soft reset, which should be independent
of the above.

So this needs more explanation than just "issue a system reset
instead of an IRQ", because that is presumably not supposed to
be what is happening when writing into the WDT_SWRST register.

The above also doesn't explain what is supposed to happen if
WDT_MODE_EXRST_EN is not set, adding more to the confusion.

Guenter

>   	while (1) {
>   		writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
>   		mdelay(5);
> @@ -443,6 +454,7 @@ static int mtk_wdt_resume(struct device *dev)
>   static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>   	{ .compatible = "mediatek,mt6589-wdt" },
> +	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
>   	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
>   	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },

