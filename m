Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C569C8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjBTKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBTKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:43:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA883CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:43:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ck15so4093606edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nA3eNnkwq+ImGT4j+R/hGpDPVwCQnM+eNRIMDN8kMg=;
        b=gVs4IsdJTUvkMxOUokihjicJW7urma5sunOhHff5RTIE0Etzk1oa1UuK+zoxG+n29R
         7P+OHkh9+sVsfzEhUu1uvWHr4AmgeRpImejxPNmmpUz1RoL/AQM63w7cBKS3TeryDSi6
         i4tTVGT2d5X7w56lVSJkumLfaxVvGLG8CaY8EhvQYOpo6eQ2jw5TDMKi6JuLNxcu70pQ
         KdbrUDJp1RfAY546KDHPdaekWyV6bckEkEKoanz8WTrLtR/D7e/WePLGXD/I01zOeeV8
         5h/7SrH2xJRg6I0yXcED19Iyh9NvE+GznhyRpulOuc+G/DocIS1bkAdfnsUbREICMx1T
         XKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nA3eNnkwq+ImGT4j+R/hGpDPVwCQnM+eNRIMDN8kMg=;
        b=T1OI77WrxKsQYTmDecF72hPw/k7yN9cLAoDXHdHxbGUvxLPlTuv09NHobzztXOObXM
         Hm8gbhhKCUCbYZX4JS3SGSGDlnS4ny3NE0S3EP/n30M2DUDq0RNq233C/jue/RHdhCPF
         hL7x5CCWvdU+d9q08qAP8MDaNr9FDeoT+dV+UCXJ5KfV7AogQm5N+ZNs0fqIFz5/Dl7N
         OcynrZwLlbdAlsHifK+mzKvVhxJ00n77/ewF/HleYJD8LpfHYvpFnFnq3+nxYV4/kc9L
         iuJB44g2iZVx/zPM/V+4i+yrirHXW8MDRx5sxvxWHOUdxSjBm893BLfoTkEvOP67bNYz
         wUlg==
X-Gm-Message-State: AO0yUKUQKcZ9xO/0HHvgLRnGg417BdRZkSLoLnIBFcPf91XrK8b6A3pu
        vXmHh82HigXCTLSsZuubOrTZ6Q==
X-Google-Smtp-Source: AK7set+Iay3lUuiaGj+f62EUAjQtYrSkeHGgYZW75QXTJl0YvGTHUhvTE52plH0XTmV9oJ5bthH+1g==
X-Received: by 2002:a17:906:71c2:b0:88d:2a41:2a4b with SMTP id i2-20020a17090671c200b0088d2a412a4bmr6635748ejk.60.1676889835438;
        Mon, 20 Feb 2023 02:43:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qn19-20020a170907211300b008baeb5c9bdbsm3349814ejb.141.2023.02.20.02.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:43:55 -0800 (PST)
Message-ID: <e2765493-0502-8c6d-39ce-e59581131dbf@linaro.org>
Date:   Mon, 20 Feb 2023 11:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 10:50, Ryan Chen wrote:
>> These are common to all i2c controllers, but I see that i2c-controller.yaml
>> doesn't include them (while i2c.text does).
>>
>> I assume we're OK to include these in the device bindings in the meantime.
>> But in that case, you may also want to include the common "smbus-alert"
>> property, which you consume in your driver.
>>
> Since i2c.text have multi-master, smbus-alert. I don't need those two right?

Yes, these should be dropped.

> 
>>> +  timeout:
>>> +    type: boolean
>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>> +
>>> +  byte-mode:
>>> +    type: boolean
>>> +    description: Force i2c driver use byte mode transmit
>>> +
>>> +  buff-mode:
>>> +    type: boolean
>>> +    description: Force i2c driver use buffer mode transmit
>>
>> These three aren't really a property of the hardware, more of the intended
>> driver configuration. Do they really belong in the DT?
>>
> Sorry, I am confused. 
> This is hardware controller mode setting for each i2c transfer. 
> So I add it in property for change different i2c transfer mode.
> Is my mis-understand the property setting?

You described the property as "Force I2C driver", so it is a not correct
description. DTS is not for controlling driver. You must describe here
hardware feature/property, not driver behavior. Also, it must be clear
for us why this is being customized per each board.

> 
>> [and how would a DT author know which modes to choose?]

Exactly.


Best regards,
Krzysztof

