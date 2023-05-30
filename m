Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285671677C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjE3Prq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjE3Prj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:47:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E61132
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:47:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30ad458f085so3179302f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461633; x=1688053633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X98uEJIUr5N96PKhi+a99X85M9f95CxufPpRR6wZq8A=;
        b=I4GPQWEllzF6GBOexpjF+zqBiGkBryBgzrEJtXRHQddmLLIOOng95jwaUCgCr1tgsL
         Jv05YlGGBLV0dnEU2jx+6DUkVpHbZZepwRBsWcxCtgO8LoZjofiJopoMWOJYUc+vHkEQ
         0nkVIfh2wmrheNx40RaXua8/vNVNYV3VLClb9m6E/Ib2FLzBWX3w9HnRDP2/WMrzrS8f
         v4h6Xo4rA+eN7dUYhsWR5dZNWvYr3wPUYkyCzlOkIvWmVKVA7aPpl5Uo/hMqOlL9W4Vv
         BdMCjM0CqmsjMAMQfh3IpccWhHSKKBIVBKD0aCHhWnL/8VqQTWkP4jpb17llwILviawK
         Yhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461633; x=1688053633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X98uEJIUr5N96PKhi+a99X85M9f95CxufPpRR6wZq8A=;
        b=k7k4yHXS5dFUt05zeoPCquGWXKHkICT7CswQljIUJsJoWkG1ZeWB5mSBhj2lN7/Vtc
         Bi3BobPxQsZCnX+e6ZK0ddzbQBdlBYUkKOSZ7yQfB4gnGuPa7OvWQ3rx1rNIpdrsEz3v
         LSIaDDgenzPWhN2cUIe/eHZAHkFKLbC8Gi8aHMu38NpQi7ZBOdl7zGUsbY/ZGwCSeQ/Z
         zL/q9GChlgh7ut1y5PiSkKq4zQ2jwxXhW2IVXXRAmNC8c71KKgSNeO89iHprvw0UAY93
         5hgJwgEnwg2bSTwfIyEPZ7QsaRTltl3mdzukjIW4EzRxg4xZ4ssHGRkUyDaSxvvvJg46
         BO2Q==
X-Gm-Message-State: AC+VfDyn56AIfRy93Qu4CHzLEazB5FGwF3KKaRYXr7zXQ9ftOyxI19nX
        l4tqwZnDJyoQBKuIWWlnUCH+UQ==
X-Google-Smtp-Source: ACHHUZ7srJ4pOnP/FvjZ38eh3SqEMIgReJFKmoPPE7Dt9i4SzWqtjk05iWZ0+SjI68fY+m6jsF8SOw==
X-Received: by 2002:adf:f485:0:b0:30a:c681:fd2e with SMTP id l5-20020adff485000000b0030ac681fd2emr2350372wro.22.1685461633507;
        Tue, 30 May 2023 08:47:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf? ([2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf])
        by smtp.googlemail.com with ESMTPSA id d1-20020adfe881000000b0030631a599a0sm3735752wrm.24.2023.05.30.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:47:13 -0700 (PDT)
Message-ID: <35dea714-6a0f-4673-fd33-23644ea85d33@linaro.org>
Date:   Tue, 30 May 2023 17:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] lvts_thermal.c: Fix error checking for debugfs_create_dir
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517160326.10732-1-osmtendev@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230517160326.10732-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 18:03, Osama Muhammad wrote:
> This patch fixes the error checking in lvts_thermal.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is 'IS_ERR' inline function.

We do no longer check debugfs functions return values.

eg.

  https://www.spinics.net/lists/linux-spi/msg37903.html
  https://lore.kernel.org/lkml/2023052835-oxidant-doily-404f@gregkh/


> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index d0a3f95b7884..61386be78fa0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -188,7 +188,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>   	int i;
>   
>   	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
> -	if (!lvts_td->dom_dentry)
> +	if (IS_ERR(lvts_td->dom_dentry))
>   		return 0;
>   
>   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
> @@ -197,7 +197,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>   
>   		sprintf(name, "controller%d", i);
>   		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
> -		if (!dentry)
> +		if (IS_ERR(dentry))
>   			continue;
>   
>   		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

