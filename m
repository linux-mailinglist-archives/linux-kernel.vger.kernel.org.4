Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E796C1F17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCTSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCTSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:08:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCC3D09D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:02:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so17227280edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679335291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM+VTccTgKKJhcpvDtZyUzpHTVkC1zUM89tHGOsd2Eg=;
        b=MdWkwWoq7eQtYUJNjtH28Ms0rmVkvJlQH+jCn9GbablKI+9IejS9SYyUE3lKQjrh88
         pmOECRjw/ekd353EZ1btInyv/ZVibh75SGpYYOsQDzCd0ysKAD3psQ4yAqAR3cbdgXSy
         7+cNpyuxIESUl8AZzNif7ebGe6Oqjs+CksesgJe3tasud+kgSbi/JDEZ6/T2qaaMU/5r
         GO8YaT8bMrPH0CBptDjHyRRfJFOtNR00YGFYzsOQbDf3/7MVXa/dUZqR5GE4sUBNByx4
         knrqxc+HqwfvGeLM5TGRd5h5JqatjiNsvAYyufZ+t2O8zpZ8/lJYmJCR7aKnD4kAwO4l
         Y57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM+VTccTgKKJhcpvDtZyUzpHTVkC1zUM89tHGOsd2Eg=;
        b=LVjMUiDX6HWv1I2sx30eK50sKBfP3KLpW52hN0Z2emAFhBjPKn7pLNmPLnuwD44sNr
         mOXcN5Niqkr9f6/LZ6/nRRXMeXbeh4E4uoekjllm8IYLUAnAJj6WRZajOP2s8jRJdfDK
         EXWAbwEhUzYG31FM2RCE6tH+R2WD2oODW1yrZ3bT0HiQqkXevtmHmmhTLwccZ1EK8Chd
         vRSHFTb89WSjn2kHC7ySzgKgI6Up0Xk0KZMkRrhUJ8lCFXTiqulDsN6dt1ak7FSU51dA
         R0dGvZ8/fbax7brXSoqxcCiLSVoT1Qo9cYx9uYferclOfqAKfBx6ANxpnrB1L7QyCQPm
         WFcA==
X-Gm-Message-State: AO0yUKWueKaMtkP88dGqLn5LDMCafgAFDYlHoZ3uQVtRXByuSToJXZg8
        6OC/SGTrTs7nq+0o/KxMMgqh6A==
X-Google-Smtp-Source: AK7set+eCZFLAqmq1uV0YjgWysTK6Ve+/pjp/6F8eiwl8cl3hKzNoCy1TIr7y87uTAkPVVkY4oZiVQ==
X-Received: by 2002:a17:906:3bd1:b0:931:cac0:60ef with SMTP id v17-20020a1709063bd100b00931cac060efmr9813235ejf.50.1679335291656;
        Mon, 20 Mar 2023 11:01:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170907985300b008c327bef167sm4710779ejc.7.2023.03.20.11.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:01:31 -0700 (PDT)
Message-ID: <5109c01b-48bd-2854-3f42-bf8ef8b4a821@linaro.org>
Date:   Mon, 20 Mar 2023 19:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
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

On 20/03/2023 17:18, Sergio Paracuellos wrote:
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ralink,rt2880-sysc
> +          - ralink,rt3050-sysc
> +          - ralink,rt3052-sysc
> +          - ralink,rt3352-sysc
> +          - ralink,rt3883-sysc
> +          - ralink,rt5350-sysc
> +          - ralink,mt7620-sysc
> +          - ralink,mt7620a-sysc
> +          - ralink,mt7628-sysc
> +          - ralink,mt7688-sysc

One more comment - this and maybe other compatibles - have wrong vendor
prefix. This is mediatek, not ralink.


Best regards,
Krzysztof

