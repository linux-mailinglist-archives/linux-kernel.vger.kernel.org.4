Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9186297C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKOLyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKOLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:54:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648513D57
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:54:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so6895926lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01M9df8tHEyJsnDu3Von3eC66Ovw8+fdVMK/4EPvKL4=;
        b=lw04QckrbhSCNd9EHeNnNZtyF2InJ2jFPBT4yGMDCzayGNKo8xubNc2hm34mroaHxX
         fridHOemeNkwKAhfN0kcO8Qu3IbMO8trPOiqVXRVLU6kPv3B4ydLPnr8X1W9Pqk+rNKG
         fQXbE//yjDsvbl6xIOZncN33sErj7c6iafdd1FNpMhubil62TX1u1CItdGovO2DyHAZg
         J/HoI4Gg84ieh+Kxb3ouwggakpliJbZJaBMh25NI8eCknSNzEM0fOaevriEhy9I5pFiq
         8JhhkY1yLPCSMlHhoPdfiwzUoE+jVC+3PVXG2eU78QIAYdg0917nl/hnFCGkXpkELEFl
         m00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01M9df8tHEyJsnDu3Von3eC66Ovw8+fdVMK/4EPvKL4=;
        b=hDh7n/LvsHY5FmSDshaoeHHj+l2VhPwytSs5TE23fZjklTUCXi4lbEYMvQp8sFCZOQ
         7CUH9mHxZk6vpYadaURGXm64YSJ5arcNXZPnTTyc/iIubKTgoPJj+QRHg6kdUkDn4LlK
         3+u8E4wesDz1gPotGGBms6p6vPk0dDwM3xuWTrRaaOxFggusCRKxxNujGQE3NV7WICBW
         IqJtO4K3mbPBAql6EBjXlACv+2Gi4kFFfhKMbtiYrOpyH9piHhP196myVmLQ4KAyHplQ
         qBLq64JH5DmZJyhNuWirlgY0bAJiHFRro2nxsYXta44uBZ0d9TXky1D1NjF9hJKs/rMI
         LzLw==
X-Gm-Message-State: ANoB5pnEESvcUPs6X9aokDgESZg/+f6HpM/+xHzxPd+S7/1QUlz1BSpF
        g5srDmHUpAjG/Nh19SRMq5DmbA==
X-Google-Smtp-Source: AA0mqf4nVRlkN4WXp0Xq3TTm+K7JwtvEIeRQzNdksjvfhcJNcg2gAd2Ht4d73oXkbZ4mpOD227iRGw==
X-Received: by 2002:a05:6512:400f:b0:4a2:b42a:6d7 with SMTP id br15-20020a056512400f00b004a2b42a06d7mr6071339lfb.649.1668513241192;
        Tue, 15 Nov 2022 03:54:01 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b0048af3c090f8sm2201764lfr.13.2022.11.15.03.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 03:54:00 -0800 (PST)
Message-ID: <f51cfe4d-9cb9-e680-8e27-e6ba457a97d0@linaro.org>
Date:   Tue, 15 Nov 2022 12:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
To:     Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
References: <20221114202943.2389489-1-bmasney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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


On 14/11/2022 21:29, Brian Masney wrote:
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

Fixes boot on 8450 on next-20221115


Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

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
