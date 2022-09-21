Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915145C0110
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIUPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIUPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:24:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3538E4DE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:24:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so9807811lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IkfBzR1pPL4sqH+SzuxDp3p3OntI0w5vunqXgMMZcmo=;
        b=rNBsowUvNyhij2xBv5rDeBpR/yfpdhLrm03ppABwWh8FFbkd/2LG/aHo3skupAQDvq
         56axzEakXeiqhXDy7AL26VkZtFfcHWwtdDe7XC+F2XHK6QeAcQYI7YriAKuk8Q5jXif8
         DSg6iPIcvh4ipe9t90qFpASbcrJ0LsjFYGLGCwAKGqQAH5wJ8z6tI3sV883v1vc4yrKZ
         nmAO6qHeNrD0KQbj8HPcIqlCkJSHP8ftl1/rhz9RsJo/kohlgbdJNfP/ruplDpE9Bkxz
         AemZrWm0VrxTeapXQRFbKWRNUqYeR3p5PgqWvjDHhYb+59d84pFwkPxkmCMupiX/jFmN
         kq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IkfBzR1pPL4sqH+SzuxDp3p3OntI0w5vunqXgMMZcmo=;
        b=Cpbwc48W1hpLydubS0ZDPnblzqsfO5cpbv7+7MvdqBZ1IlxchwdTGbF7HNmMN6hVhy
         ABinF5Bw3Hjr/REVSuv2nEbn1zvV1uNrTjexGU7vwjdAzW16PomLt6TpqyBb0MNglNxy
         1r6fQtmRNeNDwEukTF5234lPHoL7jicPcE1qw/NQPxWAyE9n832UNbft7H09mNPDroXB
         fzL0GVKOzPcjL5fugiH2/7C6TXxYOHPjBzEsHUH22zn0wXqY1KErn8+duS0BdnKmz9ev
         xSUcJpdU/BnfC9oBi6IalAQhLxbP4A/JzgnwDsYaX8ZvOX8A8uZVGtYOyd/yS4SzmFkC
         HeFg==
X-Gm-Message-State: ACrzQf11w0vSQUnPfjO+W8gIdydDbM6+37G24v1oXWaPD4/P7LAOXFqv
        76sY1zPIZABNIgerwwoak2VLsg==
X-Google-Smtp-Source: AMsMyM6t3a9lk8UQZAxKjOsgUpQi1lKsFwa3+vxfPNHOsjx9aGEV8R/rZQ6AF7qqASbhYiSJ3jVZyA==
X-Received: by 2002:a05:6512:c13:b0:49f:9a2f:8b86 with SMTP id z19-20020a0565120c1300b0049f9a2f8b86mr6452173lfu.413.1663773853473;
        Wed, 21 Sep 2022 08:24:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b0049adbc24b99sm483777lfe.24.2022.09.21.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 08:24:13 -0700 (PDT)
Message-ID: <a1ec1143-6340-8572-c46b-0a4f923d7a92@linaro.org>
Date:   Wed, 21 Sep 2022 17:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-11-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921094244.606948-11-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:42, Daniel Lezcano wrote:
> The thermal_zone_get_trip() does the same check as
> of_thermal_is_trip_valid(). Replace the call to
> of_thermal_is_trip_valid() by thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

