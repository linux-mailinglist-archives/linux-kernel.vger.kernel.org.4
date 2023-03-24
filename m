Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD326C7C48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCXKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCXKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:12:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405DB26C1D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:12:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso2706284wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679652724;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPH4mUwrMOscuf6tp1URuXqKk1vAT8I56zMeO2kHP6A=;
        b=ScVo7VrB621s3bVxksud99veEU0e+ZB6wdSl+A6LXnVuLZeGxas+hx64ic1+FLbroR
         6wKIVSg0P3gcyQSfUWCTF6zYQvnYz6aX+8W5oCmLsG2+AN5j6NkCi9oiAiBB5Zs/AqdR
         yAXRfHpB3aegqKdqFO0wPNq6Jxz0Lojh34ih43NcqeDEWl64NEyVl8wbMD+v01V5+Xss
         vKR2P1UsF+jtD4oicwCpN8PcHW88ScxZRuCbQIlzkNp16oM30Yqnq+l1rrygpK2zqnCm
         Eht9f8cUjFigkScfypH0XvzPxFP2t23KWxwXyDR1ZYfoUIbYpk7LKW5Hao4oEJ83ib1n
         uQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652724;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPH4mUwrMOscuf6tp1URuXqKk1vAT8I56zMeO2kHP6A=;
        b=wsPmxRjKinS48j8989hMD6NBnNOz2OzgJE3TXCGIYvev8YDRw9mxru0NheCAM7ka4I
         ll92UslM2dnuoHJyqAmA2LqNykq6o6qeNhmdMVspj1omHLssdMcXKBzeFChhXkFg/jM3
         m6vhrtefngceA/qbQqWbvcpcSxxkTn4LuBQ+wLu9HNTRsvNp5iK39EzlYlmplGj+V3d3
         IS8DdE3bqHxRCzGG44bJ+Rh/VSxYlN5mhWrCSawojThzMBg2pK972VqJ8IR4zEGTcNnH
         HsaKA9YNFLQlbQhhlz2DyS+LKXnyTJudtgg9aQ5dWaSPvrQmXuJw/NpDuqUEk8zRi6nN
         TM/g==
X-Gm-Message-State: AO0yUKVG9bc5d0d/j72I4P6g+U8fl96IsUzQhvW4HoU5S+UgMpDSMCn2
        5AiZKNcobby3jdyHgirHQzN2/g==
X-Google-Smtp-Source: AK7set8IR6Q6Kilnl52WGIRlbWm3xbvS1BES24oina4LDglaBRJJ/DsWqT5cs2NM3gcARp+LzcMOdQ==
X-Received: by 2002:a05:600c:d5:b0:3ed:2eb5:c2dd with SMTP id u21-20020a05600c00d500b003ed2eb5c2ddmr1862205wmm.39.1679652724674;
        Fri, 24 Mar 2023 03:12:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:213f:a579:70af:e4a0? ([2a01:e0a:982:cbb0:213f:a579:70af:e4a0])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003ee5fa61f45sm4630286wmq.3.2023.03.24.03.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:12:04 -0700 (PDT)
Message-ID: <33c039ff-2702-e058-262a-829199fefa21@linaro.org>
Date:   Fri, 24 Mar 2023 11:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: amlogic: meson-pwrc: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202303241016261854322@zte.com.cn>
Organization: Linaro Developer Services
In-Reply-To: <202303241016261854322@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 03:16, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> index 312fd9afccb0..5d4f12800d93 100644
> --- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> @@ -308,11 +308,9 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
>   	}
> 
>   	rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
> -	if (IS_ERR(rstc)) {
> -		if (PTR_ERR(rstc) != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "failed to get reset lines\n");
> -		return PTR_ERR(rstc);
> -	}
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
> +				     "failed to get reset lines\n");
> 
>   	vpu_clk = devm_clk_get(&pdev->dev, "vpu");
>   	if (IS_ERR(vpu_clk)) {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
