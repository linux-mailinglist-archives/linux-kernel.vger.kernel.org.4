Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31856D9874
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbjDFNmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:42:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04F128
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:42:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l12so39549171wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680788567; x=1683380567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvtPGAEEf5TLZHXMr3mlEiR7Z7erQF1kYIANEz8VstA=;
        b=a7QS4va62iGCSO8AyeQAKUdEbvW5VyUXHcLH/y0s4a5baVl4aAvt8g6OLm9jQ4oWIR
         6kddjq34EN5EVUTJG4qTUje/7ZB6GJtlePXYdwAc1qZqal5+b6+Q84lAmc6nBjmzMGyq
         7pxLxl7rpYkwygjjP9z6t6BZpU0SXrawKyYXrMTg5p+t+oUdgzugjbYmVzpyE18QT6Cc
         ZWXEGX8H3iQ2U1BuluqtOoCWOx3BKA2uBnktChNODaA2iuAg7gR3cGW6C6YiIsZDr8MU
         TsgDwNi9QvLw/WYglmaBYyKdFfOVTxg1haRgZhcxVHoQDd0WLMc50cmykCPz2IExP7wf
         PA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788567; x=1683380567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvtPGAEEf5TLZHXMr3mlEiR7Z7erQF1kYIANEz8VstA=;
        b=NTl4HtZl1uCfdaPU7PPjy++QGkCgZaXw0W7Pc8UQc6t7znw0MGfNOdz1CTVOHQ5AJa
         3wqVqQ5QmCzJKi4U6aM61Q1Zt1EJQvLHhfnounI06I1fsDWoQ2md1xvQdryS9Vp5pcKc
         kHt05j9Hc2FQwdjBKW4QJu0/qLGCcnNllbb71QKt2cmWJYCxs4MSfTNDw5H5H2OAdKCN
         bb7mh34KaeZ95WwSmE5mobrDguvENm8GRxaDNPuY+0WicBi8nie/0cUrW4QyYiqHcIcH
         CAN+Q6Ru0cpCE2rR/Ypp9MPnWfsYBL6D4tAcKNUNDjQ9om+nao8p/XtuvE2zx8rplDKO
         83CA==
X-Gm-Message-State: AAQBX9fq+YyU8lZucwGMIl+TFPxM1mP9aZPUu4WPW71Ad1RGJ3qKohcX
        EgXoLEentfLwai413XG1Av6EBw==
X-Google-Smtp-Source: AKy350ayvHxA2H92V7esjNR2IO1UHuMtiS5CK4VR0BsNjHgdgP30iAe4lhqjQt+iNt9THojmW1UyNQ==
X-Received: by 2002:a5d:4d45:0:b0:2d4:5117:f4b with SMTP id a5-20020a5d4d45000000b002d451170f4bmr4789556wru.26.1680788567342;
        Thu, 06 Apr 2023 06:42:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id i16-20020a05600c355000b003ede6540190sm5482472wmq.0.2023.04.06.06.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:42:46 -0700 (PDT)
Message-ID: <d9ffa8d7-9ab0-bb72-a277-f85790b7439c@linaro.org>
Date:   Thu, 6 Apr 2023 15:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource/drivers/timer-imx-gpt: Remove non-DT function
Content-Language: en-US
To:     Fabio Estevam <festevam@denx.de>
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230307124313.708255-1-festevam@denx.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307124313.708255-1-festevam@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 13:43, Fabio Estevam wrote:
> mxc_timer_init() was originally only used by non-DT i.MX platforms.
> 
> i.MX has already been converted to be a DT-only platform.
> 
> Remove the unused mxc_timer_init() function.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

