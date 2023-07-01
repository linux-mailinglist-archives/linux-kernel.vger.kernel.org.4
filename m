Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5607448A6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGALD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGALD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:03:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097C3C0A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 04:03:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so334554366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688209433; x=1690801433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhqTMzigphscucmhe7mCsjJ8z9OVn1JSWHfhcmXyrPc=;
        b=LKRJEBgTOj5IEA91MIUcoWTKV7pASptI2nJgvzivXbX2fZQQPuQPtaT9D4/G/z76cV
         Arv5qP56U9XeCldVp/gDgtX6mhgDTq589HzIXYFkMERwQKqqZ/AVJgAfKt5lqQNF94/U
         uLk69/lQT8AOYJCXW17jdBulrrrHr5u9ddwr4foMYWyexQjWllOWrcPvgQfJimTe8h+5
         pDEn3X3MykXQ9DtTw+vB9jp2cFkOFDuapXZ+zrhOKtelAZUL5Gk3rn+kKe6h0fhg4Uad
         GzDvMEclkp/EinOf0RHInGwDo71yAZx1+fN8J6UrV8gaOrPnYxsTRrPp2cgvNMyuLtf4
         U9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688209433; x=1690801433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhqTMzigphscucmhe7mCsjJ8z9OVn1JSWHfhcmXyrPc=;
        b=fXos0hpG2D6UvUCvyZ8qa2YU+F8mC2mwPoRqWV+zXP/RTrIhP7QLSQDpbxN4e/0e8X
         cnkSA9W06KR9itXQa28p4m2/tAQoXZQCv4aWfbLJw4EexwEiAMgj2fqQBONOAaotVMFl
         WeFqkI6qjOjb/OsqdpatO1bA4DBFD34SSTwOuFjj+tfV981YvsBlzA/rTn8ctjsEf53w
         2YSsIwhTB7/3yE94gtAuSvhq7E/Tk2Yqpb7xDd0nOg8dKd8iBX8EiE2qgmHhWboeQTJX
         Qq0dDJQKSwZmucNnvVpGgI7AY3NY7mj756lYa+hMTXt1yYT9rO4zv23J0dI+QQfyu3Qk
         76JQ==
X-Gm-Message-State: ABy/qLYqT+r3KZz80CZf+CvlowRO+tpyu3a+Ff+xo7VnzNiQSod+Ng7h
        juDgC6Y6tOgs9w8ivDsntYR2Ww==
X-Google-Smtp-Source: APBJJlG/KJHFR2pxeOBJd4GJGW6+VY61SdKHDQ/D5BZNk1PeSlmGkMEJJrcHYHu7Ht+MB/bZGMnvGg==
X-Received: by 2002:a17:906:4f0a:b0:992:ba2c:2e0c with SMTP id t10-20020a1709064f0a00b00992ba2c2e0cmr4057020eju.36.1688209433622;
        Sat, 01 Jul 2023 04:03:53 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b009888aa1da11sm9047040ejb.188.2023.07.01.04.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 04:03:53 -0700 (PDT)
Message-ID: <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
Date:   Sat, 1 Jul 2023 13:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 03:19, Anjelique Melendez wrote:

>>> +examples:
>>> +  - |
>>> +    pmic {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      qcom,pbs@7400 {
>>> +        compatible = "qcom,pbs";
>>> +        reg = <0x7400>;
>>> +      };
>>
>> Why do you need a child node for this? Is there more than 1 instance in 
>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>
> 
> We currently have another downstream driver (which is planned to get upstreamed)
> which also needs a handle to a pbs device in order to properly trigger events. 

I don't see how does it answer Rob's concerns. Neither mine about
incomplete binding. You don't need pbs node here for that.

Anyway, whatever you have downstream also does not justify any changes.
Either upstream these so we can see it or drop this binding.

Best regards,
Krzysztof

