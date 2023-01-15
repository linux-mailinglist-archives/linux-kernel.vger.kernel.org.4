Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0B66B094
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAOLV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjAOLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:21:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC93CDD3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:21:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id v6so18991093ejg.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6rItGYiDxNk2shTTaac9GPkWnRw/7H7zjsJkHXB0gw=;
        b=CSC3PyXrxCYny70V6nQemTI3NeqWsMgTEk/B/Znu8UNjDspEl+oJqrSAQSsW+yBUoR
         yQp2eC5MxfKIiqUT3mq4eebA2OioHzpzgASjcFx+m8cdJuo9In+g/dJFerwR7ysc/kIy
         vbl6cGarqblvIARf2jvYc5VPJ2S7aWR+O8InLEdbviok36dUNSjH7hEjCfUDT9/O9aFE
         /3Hqs2fDJM5ElotWukQUx+jrDRBYuQTJOy3U8aIrST56pklXGXYEd0V0y9jToX9thm7m
         HrVpMzeZKwWOi2l2AqypHdtokqKYr/xTX/D6FgoZGAmiiZrn/9bHOEggrXXhQgOyR1vi
         zpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6rItGYiDxNk2shTTaac9GPkWnRw/7H7zjsJkHXB0gw=;
        b=cllJYUnYsRpYR4dDfaaAr88qnkUs39TpGZP0qIKnrRR5H5INF7qeJic1DGLR8GO8i2
         vK45GbtNS9AJjNcuRWdSDkYyw/G5iS0CpTAgN5xtFYlPxExZw5tBcs+OrTPw+sf8hyJM
         FjuCAmWPcWmp5NjUw0bvzNJUJaULHcwyuX0YoupVwLjhkCxUUvjwh3vovQyAnwEM2j3l
         iLliN0S2R4fMw5mt9aMoexGKQmwKX3PzKzv/qX49+KOzPvtiwSSV/iF+fEj+BdJgSN+5
         oHIxN9ddXPlNozdJjxPJfDZaLjcvbyDXlbA6F3LbwrWIdcLIV+cdeU3+off0YhDdue5m
         VJWg==
X-Gm-Message-State: AFqh2krnsMKGOGsge+dRal5NAsiFDSyFu62jyjoMq/xnf19gn3ndRPJK
        3BouhALy0lZRD75N7zBlk/UrUA==
X-Google-Smtp-Source: AMrXdXsOTlJmUk3i+GSWxpJCUZy5z8cKOVbXUdVjTYXJ+IYaNU++XjKAP0KMBUAh07cdQw25Jn9Jcg==
X-Received: by 2002:a17:906:6690:b0:86e:e4ae:791c with SMTP id z16-20020a170906669000b0086ee4ae791cmr2540434ejo.62.1673781680838;
        Sun, 15 Jan 2023 03:21:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm10749192ejd.91.2023.01.15.03.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 03:21:20 -0800 (PST)
Message-ID: <5e784285-c391-91f4-c9d1-a53443fc4264@linaro.org>
Date:   Sun, 15 Jan 2023 12:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
 <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 14/01/2023 21:33, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
>> WCD9340 codec node is not a property of the SoC, but board.  Move it to
>> separate file and include it in the specific boards.  On all others,
>> keep the Slimbus node disabled as it is empty.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Generally this should be SoC-independent, for example some newer
> MSM8998 devices shipped with the 9340 codec that most 845 devices
> used, but earlier ones used the WCD9335 found on MSM8996

OK, but I don't get if you expect me to change anything?

Best regards,
Krzysztof

