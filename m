Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECA67B06B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjAYK6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjAYK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:58:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1FF367D3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:58:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o17-20020a05600c511100b003db021ef437so984938wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuRPLNR6yWS1Hhhteoa3n5LG/0eiGai3p1MOQTw2W5s=;
        b=qqFffHbYUgKbOOFK779uTpAVqso7+NLJ/7bkN4/5eZa9nhE1BPZvGN3hRo3hkZ3If2
         3RWGYiofa3jdZiE4bKPCi1FVcI+kL75gFexqitR3HBMune8mzdR8HSeH9XQhh9pUMRy8
         2cseCQVoiJI8qenQzHDFGLvukgF1CksXVjXuSEnXYPRKVRiIudsXe8mf74z2ePTcHwal
         YPJGGPZTBIhwFTWYYFxKFKb0F3lG5ELQo/JZgPgT2l2r7iD9tPyXsuqqMchhPfW89QE6
         i3s7ZwdM4vHo1CDyO8Jv9xqoZc85wY8jNSSVXHvpU+hR4CK9VcL8WSrEdnymd8U8Uw2B
         Is4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuRPLNR6yWS1Hhhteoa3n5LG/0eiGai3p1MOQTw2W5s=;
        b=klxsj3nk1s78SFugyk+E+/n7ddfwjQSDg/3NLKCrzgF/QU81s7tWkmRbVDRi9iu5C6
         WjWrGy41feyvkiyWQI/3CpD8UqivkTpb/RUeDyD2vZCsLaVOGjtPbRCmqFaVWtrkVUkw
         TxaSZkxOzBLt4lm3yPdF2npIOh0ZkyGAAHGUGaICcX0fOppYV0dwWCYCoXvpoBqMdTO0
         MisHoFvGYCQHdNKbqZtuKfIw15m6oajroJy4whJGl0nB7Z/OcldMacEGdsHH0aaZtuoA
         V9O4gik9wER9LT5SW4HDesJWbRJJ02r5+h19tkRPLjWuEMKs0oFw47QTvthDl4xXKne1
         RWIQ==
X-Gm-Message-State: AFqh2krn1P53NTv8JmWHeyTb24FcgDvy2efSY7JAnGXmASdVz/SxbOZe
        hYYa9GMdArAst+mOYAaRpNmIvyWboUFmJgMS
X-Google-Smtp-Source: AMrXdXsGs6ewgIxoJSL9+UnhSb5FQ3Ji1mS2KqH1XkA7xk9/CI9dYwSwz8HLhMpk3nQ8WUuQSXcz8Q==
X-Received: by 2002:a05:600c:255:b0:3da:f9b7:74c7 with SMTP id 21-20020a05600c025500b003daf9b774c7mr29933425wmj.13.1674644322703;
        Wed, 25 Jan 2023 02:58:42 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm6645021wmo.2.2023.01.25.02.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:58:42 -0800 (PST)
Message-ID: <96e7aaf5-76ef-9356-84e2-ee1f747dafcd@linaro.org>
Date:   Wed, 25 Jan 2023 11:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 5/5] thermal: mediatek: try again if first temp read is
 bogus
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
 <20221018-up-i350-thermal-bringup-v8-5-23e8fbb08837@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221018-up-i350-thermal-bringup-v8-5-23e8fbb08837@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 10:50, Amjad Ouled-Ameur wrote:
> In mtk_thermal_bank_temperature, return -EAGAIN instead of 0
> on the first read of sensor that often are bogus values.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/thermal/mtk_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index b8e06f6c7c42..e7be450cd40a 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -736,7 +736,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   		 * not immediately shut down.
>   		 */
>   		if (temp > 200000)
> -			temp = 0;
> +			temp = -EAGAIN;

Did you try to add a delay between the bank init and the thermal zone 
device register (eg. 1ms) ?

May be the HW did not have time to initialize and capture a temperature 
before thermal_zone_device_register() is called (this one calls get_temp) ?

>   		if (temp > max)
>   			max = temp;
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

