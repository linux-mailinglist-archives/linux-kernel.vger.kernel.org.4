Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61DD71798C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjEaIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjEaIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:05:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04F132;
        Wed, 31 May 2023 01:05:16 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7FF26606EAC;
        Wed, 31 May 2023 09:05:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685520315;
        bh=f5OvxJa8ehIWi5I9QZ1DR6Nr8ujEAfBfpi6+QCPyFu4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eYrL8GXKUbi0r2G3hBCKlOKgJi1jjDq9eHqnc9/a0cUf7+I04gPJzb/weRFWprffJ
         1SIS86UZt7SFZgTXZBgtLMU3oXCOAzYwiHLGO/RFxiF99CPvanoD2s0EsQDDSBwEkz
         5rh0C2S59B6rljP6njC/tLWZzIAAo5D4rPUOvFelK+Eif8RP0f3IZ92nHCZvGz7Pmu
         DCEHRPePaV3lFQ49Pl/SnvCpu4CSk160+yjQFY0hs+P0s5v1tw9ouoD/GW4tE3FMAA
         OeuRY6qdKUAzUq1Q0eLTdLIbtQ064lZoJE8nyTJv/Kq5aSlywf5kqLZCc7jKEWJV3R
         +ls8+RJMkcHeQ==
Message-ID: <371790cd-5a7c-8fa6-cc38-3a3680525092@collabora.com>
Date:   Wed, 31 May 2023 10:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend
 and resume
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <20230530195132.2286163-3-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230530195132.2286163-3-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 21:51, Bernhard Rosenkränzer ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add suspend and resume support to LVTS driver.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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

Should we do that in noirq handlers?
We're risking to miss a thermal interrupt.

Regards,
Angelo

> +	.resume = lvts_resume,
>   	.driver = {
>   		.name = "mtk-lvts-thermal",
>   		.of_match_table = lvts_of_match,

