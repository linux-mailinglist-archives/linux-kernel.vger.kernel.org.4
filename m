Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9371563D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjE3HJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjE3HJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:09:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E321E9C;
        Tue, 30 May 2023 00:09:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso27408255e9.3;
        Tue, 30 May 2023 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685430558; x=1688022558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6hDi9v12OQsdO4dPAE39lZIv/Fbre2f2OfCHhj2zPQ=;
        b=b4DPcyVTmPBs2hE1tbo4jJ2UIvWBu8kEDuynwn6Uq6dDRrmGVWxz/WAKiG0AUOpcN5
         LpbXcGWWXUIHhxjYsnGW1h1gcKkMAgi0P8YAH6Xh7x8n/zYVBKqiOHJtrfSVtfsly0sR
         4iH/EJ1mbkWP1CSYWralqsvIURWq6q2g9Gv4yN0Yn7cg67oCC0413p4rxRKmAdVL6Aoi
         fnnO8lC3pcr7OQnwNg/lyCHcUlNwHs3zP3/dfmZOuJFb2fjW6w7g7iwk6FsFhbzVTLR+
         wN34l10R7S7mMlyPX46kmwx5qHTCjXhN5VCogZ75uvnVvSBqb/eB9v6QRiCFfXBVhtJo
         wlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685430558; x=1688022558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6hDi9v12OQsdO4dPAE39lZIv/Fbre2f2OfCHhj2zPQ=;
        b=J5oggh9tPpBAAzMhw7SQKesK4GT/EuodV5BWTV5CS8L6ZE8XvOfaram9RxQMFG9U0c
         aHHGN++mENGHhlFRLlO26hfhsqlE1I+HYnKEeTe8KDosSt9deC6tlcjpnpZDFXNGQqwi
         MATSsCANteau0/u3h0qUOlvwoqN2A8jRxPp7x0JGuE0c52Neljk3jzgtxJT2i5k9BgzB
         9fO+ZZXZsvA0jrAi28CaOsr9Xr8FFDkdAlfbcuf9mWmC5M24FzFKX2zmQe5wf+H5oBce
         LUQhs+U3veg8ghSwnLluNUuD4PWyoWTcHZqpLKWDdNP4PZoKOmM3Liz+MRKrdsyHD06m
         IkhQ==
X-Gm-Message-State: AC+VfDwo9boyClOCesTvZLHBXp0DxEGRtZ0gcKPiFEzHAOpxrsRJfDEA
        JGyshJh/bxfDLBpnnnIC0wY=
X-Google-Smtp-Source: ACHHUZ6OFB8UaPqd8uVlSeewHtEImgV4PtSa4q5BKtEuG31BOohcA+cLT9ST6PYqlXsaFbefPw/p3A==
X-Received: by 2002:a1c:4c16:0:b0:3f6:cfc7:8bc7 with SMTP id z22-20020a1c4c16000000b003f6cfc78bc7mr892697wmf.17.1685430558052;
        Tue, 30 May 2023 00:09:18 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003f4fe09aa43sm20185089wmr.8.2023.05.30.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 00:09:17 -0700 (PDT)
Message-ID: <8b1cd982-2b49-7dd8-8037-7a362aa4305c@gmail.com>
Date:   Tue, 30 May 2023 09:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend
 and resume
Content-Language: en-US, ca-ES, es-ES
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
 <20230529164605.3552619-3-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230529164605.3552619-3-bero@baylibre.com>
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
> Add suspend and resume support to LVTS driver.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index d0a3f95b7884b..5ea8a9d569ea6 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1169,6 +1169,38 @@ static int lvts_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int lvts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct lvts_domain *lvts_td;
> +	int i;
> +
> +	lvts_td = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> +		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
> +
> +	clk_disable_unprepare(lvts_td->clk);
> +
> +	return 0;
> +}
> +
> +static int lvts_resume(struct platform_device *pdev)
> +{
> +	struct lvts_domain *lvts_td;
> +	int i, ret;
> +
> +	lvts_td = platform_get_drvdata(pdev);
> +
> +	ret = clk_prepare_enable(lvts_td->clk);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> +		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
> +
> +	return 0;
> +}
> +
>   static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
>   	{
>   		.cal_offset = { 0x04, 0x07 },
> @@ -1268,6 +1300,8 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
>   static struct platform_driver lvts_driver = {
>   	.probe = lvts_probe,
>   	.remove = lvts_remove,
> +	.suspend = lvts_suspend,
> +	.resume = lvts_resume,
>   	.driver = {
>   		.name = "mtk-lvts-thermal",
>   		.of_match_table = lvts_of_match,
