Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6ED62E158
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiKQQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiKQQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:17:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B67781B5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:17:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so3329386ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwSaeIACqOc/3D5hwWL05wlXkafkiqEUfntFDSCeRg8=;
        b=n+Dco4AbKMFghmsvTI6U0ZFZUmP9wNJKLy3OvKTUHm/GIgrM5IVcMgSZsSMuS5mKdm
         0ORgWascxvCB7sN7cP3n1aCnFB+3Xn5JS3NFMiVmoBCxB6ALP/fJtaRj3lLiCTKn19AR
         vIkUreNffvbM5WQgzKHEKdPk1yK+mxlXStr3De1dbve5n2G/YDMyQAxI7+xuaVhbT2Jt
         wjYjujaYYn1KISjIz9DLuJMdLh/UuBAZVPmE5DVw+XRE03FtEn+eEThzN6IaXaGGAzWV
         t602/9G1Dev+RN5Z7Vl8vjKN06nE5+sMBpoj5PR746OYYChJFUS2gWUs/xsySpqmenUn
         2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwSaeIACqOc/3D5hwWL05wlXkafkiqEUfntFDSCeRg8=;
        b=w08EudugX+FHMrJMiLlPufnDIm8ArAvUbnDxCz65Kkh8OP+aKWbwMy5LlArnXTEiXa
         d49HXu75OAfAG56w/Vullmv4QTk1IOt5cKdMsd1P+JQdWkaJnwOcFIgsurXamK+xu5IF
         i5KLPHZCdR8TLZ3j5/c8ah/ksPl8sHUVqlZt6AD7LpP7XKLjjtpjN/LXvMzHkrh/0stH
         DTo6/QB+OTRUUnmbzNijAtaNSmrLB0+Wst8zRWbSFifsX2iFbMjRoYXe+lgyZRPUFjZo
         9zzJi+FSjN1kJnKZtNAhkJ5l7LMMx8JlGMhD9IkawB0iN9U4BSYetuAFJUpgzGGUJPAn
         1L+Q==
X-Gm-Message-State: ANoB5pnukkkymMnpO3p+JAvm5XLsexPtIGQVDfVr/E4FWAuNj5HiSEWa
        NQXxgMlgM35N+K0XDWmVfdUA7Q==
X-Google-Smtp-Source: AA0mqf5ceR7FxY9z0T/rtAmxRVTw26ugt5VrF+L1xjmgZzWCwoF4ZzO2XfXMKGrg1cwO6qWiuScxog==
X-Received: by 2002:a2e:2c05:0:b0:277:13ef:53ad with SMTP id s5-20020a2e2c05000000b0027713ef53admr1342662ljs.327.1668701846339;
        Thu, 17 Nov 2022 08:17:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512114300b004afac783b5esm211616lfg.238.2022.11.17.08.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:17:25 -0800 (PST)
Message-ID: <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
Date:   Thu, 17 Nov 2022 17:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Content-Language: en-US
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
 <20221115174355.00004a01@Huawei.com>
 <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 17:12, Gerald Loacker wrote:
>>
>>> +
>>> +  compatible:
>>> +    const: ti,tmag5273
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>>> +
>>> +  ti,angle-enable:
>>> +    description:
>>> +      Enables angle measurement in the selected plane.
>>> +      0 = OFF
>>> +      1 = X-Y (default)
>>> +      2 = Y-Z
>>> +      3 = X-Z
>>
>> This feels like something we should be configuring at runtime rather that
>> DT, or is it driven by board design or similar?
>>
> 
> We use this sensor for a zoom wheel application, there is an EVM from TI
> for this as well. So this is for setting the mounting position of the wheel.

That's ok, but does not explain why choice of angle measurement should
be a property of the hardware. I could imagine configuring device to
measure sometimes X-Y and sometimes X-Z, depending on the use case. Use
case can change runtime.


Best regards,
Krzysztof

