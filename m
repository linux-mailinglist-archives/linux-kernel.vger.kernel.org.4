Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6D7495F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjGFG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGFG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:59:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F39E63
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:59:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso349754e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688626749; x=1691218749;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n9jFGb+PSmEKw8iM/L00npVmUzIMITjEUhyzwx30WLI=;
        b=bmDp52z15koXF7vGD+7OtpSMg8hXMZxBA5HXT+R2fq3fCMXEPDAL6DMaPcZrckr+L5
         kQRjAKeMtrn0RWYeixsJIdXvpfEkHydJscG8G8oy7nFvsV0WBJZHENFa7tyY87aufkrR
         WmysYoFxfFwHVOzn8HTqVamcfMl31dAG1T9yzKiB7GxN4HtGXPbjAW9dOOHZ/v8R+xB4
         RRpVHVhZgfR2oQNn2INzHjN1qzM1cJ5Rs5mMHwRzKjKJPwaAllJ0GoMiS/zgLRJzITyN
         5S4Aqakeq9i9MbDh1OAp0bkOvLRo0OiT0Jp/aihP30j9ohvhtEXwFROlJ8glr0V0hyLi
         a21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688626749; x=1691218749;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9jFGb+PSmEKw8iM/L00npVmUzIMITjEUhyzwx30WLI=;
        b=PCdoRiLwlFEv+l1bS4XuA4y27yswyGIxDO6yrVBoD2gCwrfIyzBohGrjTGo2nUwOwc
         TyOCzP9eFjYCeU9mlbUTjNsIIZ85t+XYBIdx1KgR9NerGpNWM1H9r8B7B4x4POpZFfEx
         gv7x08bCHLP9f9T/nCcbykF8BQ2Vylh5r4a9NGxfhkLIcR8Kq0ZWnD4x62awUn526opW
         bXofd6B1Rchmilkdto6rogLCb3aGOQMW8JO9pNwfAp+HSaKABZ4Ll4H2MWLPxrkAXVef
         quuEccSgwUKb3+oIYIEMyk5sYrUqjnQ7GwM3+X1w7fpqUgn3Kgq+0FXRpeZCvro5SnC+
         Qarw==
X-Gm-Message-State: ABy/qLYhWP2WqtjsAekUDorlobY7UKEnP2NmPxvqfp0s72Akw32nM0Vq
        aPAg4YXXw+jmkdnEMaJ34iMolw==
X-Google-Smtp-Source: APBJJlHTzvV9NhPMkxSawgnU9Y4RN/6R8ct5nXX+3GLyP9CpFEYnVs5XlufLfY0d5j2KuXPAyOMDFg==
X-Received: by 2002:a05:6512:451:b0:4f9:5ac3:4133 with SMTP id y17-20020a056512045100b004f95ac34133mr825472lfk.25.1688626748995;
        Wed, 05 Jul 2023 23:59:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id z8-20020adfdf88000000b003143bb5ecd5sm1001522wrl.69.2023.07.05.23.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:59:08 -0700 (PDT)
Message-ID: <3beac94b-1a82-df36-1390-8321aa1a8e57@linaro.org>
Date:   Thu, 6 Jul 2023 08:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/7] tty: serial: meson: use dev_err_probe
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kelvin.zhang@amlogic.com, xianwei.zhao@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-2-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-2-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> Use dev_err_probe() helper for error checking and standard logging.
> It makes the driver's probe() function a little bit shorter.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2501db5a7aaf..bca54f3d92a1 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -726,8 +726,8 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>   
>   	if (meson_ports[pdev->id]) {
> -		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
> -		return -EBUSY;
> +		return dev_err_probe(&pdev->dev, -EBUSY,
> +				     "port %d already allocated\n", pdev->id);
>   	}
>   
>   	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
