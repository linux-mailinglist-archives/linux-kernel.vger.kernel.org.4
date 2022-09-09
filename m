Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139FE5B3CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIIQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIIQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:22:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA4134C25
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:22:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m15so3542821lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MgOBdz53e+t87kKqd4TZLP6vZLF5gtndstA+ec1Aknk=;
        b=SA0q6v7WFCZ0NkbLn/v5SvOcfYIcsNE1pHno2gRdu3RzxIK3w/lGrI59GmTr8ClVxY
         xL0LyJr5e9Jd9Aqh6oLszMt4rwX1LtmnbV/if9am8Aj9Qw9K/6usRxWrXNEYTuTnkTHS
         EAaW3gZqWKwoSfMlqzIZBc6NcJp1MMDEX0N2Pjgq36cUF8JSMhFp5Ny20TxHCNlgHimd
         O2yHTSpik07JD9aFq2jxEsCO876qE+uujlaUEcsz8p8qpBCajuMckVd+rMpe3Pphg5Yb
         7JN81J5eC5YGfrogRPU4qOVXXJmJEii6g59PJmye5urkXWXSYul/EGmaTJ0KPIqwPtnS
         g92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MgOBdz53e+t87kKqd4TZLP6vZLF5gtndstA+ec1Aknk=;
        b=tsLqqIl+oFTMxiw2CL4XJN9zckPf5vwaI4+OSBsvBYtbtZDpcqAgbzKpYfPPtpKjuV
         hbYNE4T69sE9C+bJbb3jJnhkq5N6eAU0nXl28ptfgOEOgQXBjiiFjS9k48/iERiOmiRa
         YBv1FKim9xHwqshiD3W53xAUzI5iNfhdL8e4wKv4EnNAMyWmc1/VWyeVkBdcRn/nvS/Z
         2JvnMPKrMguKHZXMcbTf1S4caLYUZGkfpngsrxC3hbOHlLHq/JCpfptR0NxvxaGJVVgq
         BPU2+Ds7gi2FCkWB1zC6A4TEyxwGToWQUicUj7gFuc0n+WQ7IdsKuWNs4XUG0bsyu/Qz
         0MIw==
X-Gm-Message-State: ACgBeo1pAPwSA1aawKd03Ct5fz3wmHXbar9kdEcUHFQnPHAcprb9KN0m
        4/vLHW3cqp3gX85rR423mLvd5Q==
X-Google-Smtp-Source: AA6agR51AV15Ajs3VKrTDnILk8BSNJaQuqTfV0CYUJcyYjY5bVRFjwFPnsrAQoTr0Gsh2Gf5ZrmZ8A==
X-Received: by 2002:a05:6512:1083:b0:48b:a1bb:a8b4 with SMTP id j3-20020a056512108300b0048ba1bba8b4mr4328388lfg.342.1662740562331;
        Fri, 09 Sep 2022 09:22:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b00497acd310efsm134446lfq.188.2022.09.09.09.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:22:41 -0700 (PDT)
Message-ID: <9593bff8-2738-8196-6e08-32551eabef58@linaro.org>
Date:   Fri, 9 Sep 2022 18:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: st,st-sensors add LPS22DF.
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.co.uk>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
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

On 09/09/2022 18:16, Martyn Welch wrote:
> Add support for the ST LPS22DF, an I2C/SPI pressure sensor.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
