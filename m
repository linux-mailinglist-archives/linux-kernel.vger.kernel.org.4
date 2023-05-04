Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13F86F6D12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjEDNmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjEDNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:42:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED527D81
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:42:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9619095f479so83034266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683207759; x=1685799759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XclQCB7wsuLH7QcRppmPyiTXI2wCqwp/OyebX9CqAQA=;
        b=zqfiCvIhfmN9k4zckos1BJ2EGxuh8hVux6Xi9B8ad3l2UBt2yLXeWcfkomMNI+NXyJ
         9lBXGvMuEvMSdrOMqfCGozbmrIoFqSqslvWpDyrqbvqM/LpY0sdS4+6VLTt6dAmVNdfP
         bmp6YIby9HTpseFTzUsBQzBx0MjIjySjXnUeRUxLGyxP462HXJkxx8XF6aBqsvcKGJ8S
         s8lGRm3qCO9YtdeFZDUlC1sIwC8dYInivBdmeI+i+eQ6b84Sm+8U9bRAqkkvnR1o+PqF
         uIu8f+JSXgWYQWGN1GUxB/wPb3vBKDY9+dpToktlALtS906bL7/IH6xKNyix+gIRTuph
         qGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207759; x=1685799759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XclQCB7wsuLH7QcRppmPyiTXI2wCqwp/OyebX9CqAQA=;
        b=jdl8zGYDNN/zJGLTtd6FGLkB8Ez5ztZFaIDV2QwhXkfA/Ana9b2XTmk4lmG7UL9iQe
         CIJf+xb4ZalVzqxXOowxQF/ZeWz2x7hwbhPiRxx4+b2NanrtdZ9+jdo6bAPl0d0O2wiN
         xGdD0CmoJST0iet7ukhVXuNjH3xIvLC/xerAr1BgtcengLfKFAOCsErHfV0Qwzb0bUQp
         cEpQSj/ieIByZ0w1egictPmHGJ/eXCIV9XF2pROgzWH0kfP/HgF4hSucdtmK2iumSENK
         TkZyDJqSG6OBibCaKC7x1UvzRY7GJkcWjVpbDW9hMjdVzfvMohhFy5DeonWvTMA4M6TY
         rTng==
X-Gm-Message-State: AC+VfDzTc84uAltCxpCLCwGHHFJDqcxFhX9Z9z4hZk9PkPlC8/2OFn+C
        ji2UJ5zTiqV3PacP+kqBVjxlbyvzp5JI6Cqg7x+Jwg==
X-Google-Smtp-Source: ACHHUZ7NyhfTSFqzA3q9IMvmTqtn0LeSPOINeaVwsKiDoUZEg2vNSGTls9aalOuKm/qfsIEtkWa7lg==
X-Received: by 2002:a17:907:7f08:b0:94f:12c0:4c8f with SMTP id qf8-20020a1709077f0800b0094f12c04c8fmr7109448ejc.50.1683207758733;
        Thu, 04 May 2023 06:42:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id ia22-20020a170907a07600b0096595cc0810sm1431932ejc.72.2023.05.04.06.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:42:38 -0700 (PDT)
Message-ID: <a86c0a3e-91b6-965e-0857-bbcb1ba63ef9@linaro.org>
Date:   Thu, 4 May 2023 15:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add MAX31827
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230504161714.6281-1-daniel.matyas@analog.com>
 <20230504161714.6281-2-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504161714.6281-2-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 18:17, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>

Guenter asked for changelog... What do you expect us to do here?

Best regards,
Krzysztof

