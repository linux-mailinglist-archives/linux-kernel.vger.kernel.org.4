Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E505B3B18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiIIOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiIIOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:49:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7141D07
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:49:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r12so562538ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1lT/OwCHyhNISvxKwmUNe1P3eQPE7RJKCQSdPy50UzE=;
        b=LL8KHI64pzX+EE+m7YrSqXVqEbWe/evZYmgB5IlX6OiViKPmZOtVFFvuvP+ONGMtF/
         yeD4apJmT7LrdXVpyGooMqigYr899ECX0cV4ExBCwYjQe7K/QKUoBkO8cWzeU87cEIWB
         NhkmQkBPwMw/viVVfWGEchCfnRfIjqv8ldB1nuAZTjGY70XAyxX/CafPnd2u8+PaVdbh
         YU17kw8XGn8KSbsjIiR0/vjJ+TiltDHa/aA8JvjlmW0KLMHjjgl1RMKGwHTXWRkrzh+0
         MqQkfLRmc6CGY5s4aXzNjFTNwLvblH+vWnPm9CZxLsn9cvc49dLvkMQLCMDfGVCJkG83
         ICQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1lT/OwCHyhNISvxKwmUNe1P3eQPE7RJKCQSdPy50UzE=;
        b=zHF0qM9DvcfHv/MDFc9xAggpEVPXnCidyYoaaYggQMIY4/Sc5jVGrKmFhXwIrNpsFU
         /cqGYJZPS+jp1W+cJF0mywzY+O8jMnVKdosQuX86qctCb8lMVd6Vw87tjNlG0zstmuS+
         NKOpqEqqRjPTZPsVjwgQd6z7PuzjBE6opH0EVRXys46aiahKkIS1BsheH7M3Y0PE6VI3
         oisew9zTjAdJbowPbUg1T2LsvZ7shZXa8idcdBnngoEVHGZbWdKm7kWIlu+UW3EoA3Y2
         l4cVH6TePhwR+e00yxFFHKId4LxfTjkAFHXJ/0WSfAJViJ4N2caaR7xRSvLTHcBKQVkY
         gi1Q==
X-Gm-Message-State: ACgBeo3yQUvqmmvnwmkhPziqorOwJWk0FQdBD4ou6R9JHvwnl7dJL8og
        Hgjo3RQZWJeMWXO+28wIKC1qaBdRGSVgbg==
X-Google-Smtp-Source: AA6agR6u+KSVbD526kUEJ8cIa10gmU57gO5jd+ec5TAeVHwqSwIieJ7/F+zqOx4AfuvkxZpRX7a1Ow==
X-Received: by 2002:a2e:a551:0:b0:25f:eb63:2588 with SMTP id e17-20020a2ea551000000b0025feb632588mr4168453ljn.9.1662734983596;
        Fri, 09 Sep 2022 07:49:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a16-20020a2eb170000000b0026be76327f2sm114241ljm.13.2022.09.09.07.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:49:42 -0700 (PDT)
Message-ID: <9d5e8a41-8e0a-c67a-1b68-f743b4680510@linaro.org>
Date:   Fri, 9 Sep 2022 16:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:37, Ibrahim Tilki wrote:
> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Please wait with applying for Rob's bot to check it.

Best regards,
Krzysztof
