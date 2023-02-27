Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668056A38D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjB0Cia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjB0CiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:38:10 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDD5FCA;
        Sun, 26 Feb 2023 18:37:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id b12so3261966ils.8;
        Sun, 26 Feb 2023 18:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zFvtZ/nUv89yuwhTihR0eeZSdlr0yVt+BERhKSqzcYs=;
        b=M8I3A0vgaQoP4QAv9psHU7BgffF8/j5d5ENtSquHP7WVfEsB5utm78JuArTUgbMCV8
         sBeasFN02jRiQ5y9FyhEX3DWWLdFFbyOLQfRYQi5qL8bJNJVsAcbfzlYz8x41kSaotjg
         of+3Y+9htRFVLivchaeMVHWGthjfNS2eRxpkwUbCAbjYDXo5/TcpSHt8qr+T9kTxH2sO
         bhB6BqUNUIVjdKCFqFwtukaTU7242cyoezVfT5KNEHFNpakfpHdHooxinurYT/rePsIW
         mmfwLqGvuwrsASkcM2QXZTJFqfYzH2FUzuBd//0cIPy8+0kFSXxAYPKDyGNt02jWLryd
         2pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFvtZ/nUv89yuwhTihR0eeZSdlr0yVt+BERhKSqzcYs=;
        b=a1VF7VYmrnK4h6zPsgPmBsWzS8+PzFEl5GnfnoYbEi5tZ12xcPVQRR2PqjCvXjl3g8
         8rGeRCyFzDCYod9i1LmQbaXbvyX9kNjVs1OTlYJnQTRJAXRD1KJRQmxpR8kbiXVb7gIs
         RSeziald4hG7cTiG71VXpYy7C/xmwO5tl7bgQfL7bLu1kwiiXo+Gd1ZHG6g7vvrx6P9x
         L90VM7UpG1CwT0JhvPMEyx27AL9GivmKUMkTLJu5v+1bqGsx4XNW/IRMnq2uaNwCCSLi
         HF0PgRpIMeZHIAgPpKbARXj/WmDAGwzG7lw/Ja+qsYNEnOE3bBfGrZKZczXENa2oJjHx
         GPbA==
X-Gm-Message-State: AO0yUKUXSWaHjMkigitDiCj7w/WL4R6q9IzmFKQpnoVVQ/rFLSLZymQg
        7Q3J3VApJEvvSv328L4s0N9qDD+gI/w=
X-Google-Smtp-Source: AK7set/a1pfEuG2fR1fgJAbAaYhpx43Bjl5HLJyJ6A5ZA+oYG9+sbFwhZ+acENpTTtT7gSDEiWEwzQ==
X-Received: by 2002:a05:6e02:154c:b0:313:e397:ee95 with SMTP id j12-20020a056e02154c00b00313e397ee95mr18908143ilu.4.1677465409649;
        Sun, 26 Feb 2023 18:36:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11-20020a02b90b000000b003c502198ffbsm1759540jan.22.2023.02.26.18.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 18:36:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
Date:   Sun, 26 Feb 2023 18:36:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] hwmon: add a check of devm_add_action
Content-Language: en-US
To:     Kang Chen <void0red@gmail.com>, jdelvare@suse.com
Cc:     mezin.alexander@gmail.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227021720.1578781-1-void0red@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230227021720.1578781-1-void0red@gmail.com>
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

On 2/26/23 18:17, Kang Chen wrote:
> devm_add_action may fails, do the cleanup when if fails.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>   drivers/hwmon/g762.c        | 6 +++++-
>   drivers/hwmon/nzxt-smart2.c | 4 +++-

Two patches, please.

Guenter

>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index 64a0599b2..d06d8bf20 100644
> --- a/drivers/hwmon/g762.c
> +++ b/drivers/hwmon/g762.c
> @@ -620,7 +620,11 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   	data = i2c_get_clientdata(client);
>   	data->clk = clk;
>   
> -	devm_add_action(&client->dev, g762_of_clock_disable, data);
> +	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to add disable clock action\n");
> +		goto clk_unprep;
> +	}
>   	return 0;
>   
>    clk_unprep:
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 2b93ba896..725974cb3 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -737,8 +737,10 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>   	init_waitqueue_head(&drvdata->wq);
>   
>   	mutex_init(&drvdata->mutex);
> -	devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
> +	ret = devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
>   			&drvdata->mutex);
> +	if (ret)
> +		return ret;
>   
>   	ret = hid_parse(hdev);
>   	if (ret)

