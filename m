Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AF629FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKORHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKORHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:07:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14448114D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:07:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so20667239wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQjpj5u7PFoOUJhgcEag0ttflPQAZOv9S9P/L0Xm91Y=;
        b=kiLUTD+i51VhKgQ10Ak9K2x4ap4mef9+7pQKDqHor/PCrAykQBu1I0BLnsYw8Hlmiw
         v7mcc+73JG3hlFwjEXIClxKxEQ+yEU4LjWNtC4hiLmf5KKn3hr/2EUjC5/MPp06diH9L
         rUre30NwFWslMj4EgamzoUDmkoLJDGrz9UL3LCJOF0jpb4YJFmfdzbkEEIDUepOMtOwS
         PnDZSYhIsGKhIO4RNfFc4RO+46e+rlo2p/ZH5eLHOzbI9lon4DQnoPAfoClqYs2G1XUV
         MhvRsS6vlbHzqUAhipm4Xf8hUPOBngGBUKPYMzG62IEtHyqZjC0DdsD1YIKFWJrVPAr1
         gt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQjpj5u7PFoOUJhgcEag0ttflPQAZOv9S9P/L0Xm91Y=;
        b=OSbJg4kf887dytN1kI/3BGQTmtn2G6DuNuSJbwWSs8n8IQCM/iZXnBHjBkJmNLMr7R
         9dkr/rEBdQBR8fU9h6SoG0z5kK3JJiu3Kl2jpzueq0laHxqFXd2WZgrR4s4xUJlJyuP+
         GIl1QtxgN97QFQRKZEGZPjvtXuGovT6R0qYi1nm5DEIekzin+uPypeSj/4GkyXlahQ9G
         iV1TSy9rjdU1OPIPChjCIMw0x9pXcxwidKUbRsUUwQ+P9GE7tMRpW2XqGZTYTzPdQpA8
         zDKqlK8myvcZU9GHh0DZ4zN7ntoX7ISTJxzHP2mf7Nu3XNNg/C6OomDRF88qKQqN0qEe
         AzqQ==
X-Gm-Message-State: ANoB5pnm3OGRlxGOcj9UlPUcO+m5t9u0N5LJ0k3tfSRy845UAsDSU2X9
        U/3rEOC2Xv8MXHq6dysyalmhTg==
X-Google-Smtp-Source: AA0mqf7PtdtHRajTlaqMHDcH2mNqPpmOPmMmG/PdHH/RFWBat2xbodEL5AxDUejiQS5DFZfPeF6bjA==
X-Received: by 2002:a05:6000:510:b0:241:792f:b1fb with SMTP id a16-20020a056000051000b00241792fb1fbmr9910342wrf.436.1668532060357;
        Tue, 15 Nov 2022 09:07:40 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o24-20020a5d58d8000000b00236695ff94fsm12769481wrf.34.2022.11.15.09.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:07:39 -0800 (PST)
Message-ID: <7420da17-d6d6-10e6-c87e-d3dc37d17ffb@linaro.org>
Date:   Tue, 15 Nov 2022 17:07:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
References: <20221114202943.2389489-1-bmasney@redhat.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20221114202943.2389489-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 20:29, Brian Masney wrote:
> Note that this is a RFC patch and not meant to be merged. I looked into
> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> board (sc8280xp) where the UFS host controller would fail to probe due
> to repeated probe deferrals when trying to get reset-gpios via
> devm_gpiod_get_optional().
> 
> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> pinctrl driver doesn't define one, so of_gpiochip_add() should
> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> happen since the fwnode member on the struct gpiochip is set to null
> when of_gpiochip_add() is called. Let's work around this by ensuring
> that it's set if available.
> 
> Note that this broke sometime within the last few weeks within
> linux-next and I haven't bisected this. I'm posting this in the hopes
> that someone may know offhand which patch(es) may have broken this.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   drivers/gpio/gpiolib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..8bec66008869 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>   	 * Assign fwnode depending on the result of the previous calls,
>   	 * if none of them succeed, assign it to the parent's one.
>   	 */
> -	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> +	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>   
>   	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>   	if (gdev->id < 0) {

Fixes repeated failure to get GPIO despite the controller having 
successfully probed.

[    6.151075] ov9282 21-0060: failed to get reset gpio -517
[    6.160599] ov9282 21-0060: HW configuration is not supported
[    6.160970] hub 1-1:1.0: USB hub found
[    6.168054] imx412 22-001a: failed to get reset gpio -517
[    6.170710] hub 1-1:1.0: 4 ports detected
[    6.175904] imx412 22-001a: HW configuration is not supported

