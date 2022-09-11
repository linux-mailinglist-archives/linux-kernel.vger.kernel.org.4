Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C55B4E67
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIKL2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIKL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:28:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB72E6BE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:27:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a8so10349223lff.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wODXrUGa3xJje0kIbd8qZg/z/wc1dTw39zG2Qx5AyhI=;
        b=AkNi3/z9b9CHqnJdIfnIBVDDMABspoLSeuVjYlbR5LJn7OoLnkReI5eVApXBhxQD++
         BhRUBswOj2pgzEAfLQsiwAbTtVPs+nIoxM3nLwrOI7K4s58D4N/PUhHrvjWyhjzkJnrd
         0kU/zGfsf3UoSVxYCToP69gSe0n7Hmcy8moTgbE+0WxvdjlExnPsvvFdZOCb98B09HbX
         baoKiktVRdbWQVfrNqQ6t+ndzbGfPmau2hvJVYMpzvH2k79I4rxGITYm0IrcHrE5B43N
         tdfZ7JJI9zQNWZQk1EDARNlERktOHp+EXvJ91rKFaS8yFhHxys+BnCpjuke8PNE0vAQM
         QXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wODXrUGa3xJje0kIbd8qZg/z/wc1dTw39zG2Qx5AyhI=;
        b=vbSbvUjOyDhds3hixot+ifFa8hgSdkt3z7XYi8VoOdos+0y+rHPjp+3n54OQezFB6M
         fHpdQC3F8qa9C7SIhDhFOuADZpHEjIClbHpD9t2yan43TPJfNCgQmDERTINcrlwbKr6n
         5uxiQdYEQC9qYZ215aSNJbfN6G6d9rJM4+FHvtPvB3lC4fc52y9RmfR07+08MBzW4IAU
         8akIYhD+bB5ED16Qe99hO7j+10GKbVngnn2MYrxF3my+EPxQXcer0R6ZUbCoXIeXOAUq
         C1diJt5ZHXGnR0WN943HiS3YFEyPOp8NfFltLCv+2j0FmfsicdQtK2OpjBVrAnaKl/sU
         AZ4A==
X-Gm-Message-State: ACgBeo0/riY8FhO8PimMC2tYEAYYS7vigpBCaSI3qIl9GbKr8ex7e/CR
        xwC8kSssIvjf4dz8ybAB0anNMA==
X-Google-Smtp-Source: AA6agR7+C80U63XwG32U92syOxTjw9Jp4ccOZIjl5T+WYcwHZ2T0df7+gpCmPXCVRBqqVz2H4iE9TQ==
X-Received: by 2002:a05:6512:11f1:b0:497:adc5:629a with SMTP id p17-20020a05651211f100b00497adc5629amr5928383lfs.419.1662895677571;
        Sun, 11 Sep 2022 04:27:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d23-20020a194f17000000b00492e69be4d6sm585484lfb.27.2022.09.11.04.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 04:27:57 -0700 (PDT)
Message-ID: <834eafc7-adb8-4977-a8c0-e34c44a583f3@linaro.org>
Date:   Sun, 11 Sep 2022 13:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 04/10] dt-bindings: arm: apple: Add t6001/t6002 Mac
 Studio compatibles
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-5-j@jannau.net>
 <25b42684-1bee-b7f6-a89d-ed0b0ea7428b@linaro.org>
 <20220910113714.GC4024@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220910113714.GC4024@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2022 13:37, Janne Grunau wrote:
>>>    The compatible property should follow this format:
>>>  
>>> @@ -79,8 +81,15 @@ properties:
>>>            - enum:
>>>                - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
>>>                - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
>>> +              - apple,j375c # Mac Studio (M1 Max, 2022)
>>>            - const: apple,t6001
>>>            - const: apple,arm-platform
>>
>> Blank line.
> 
> Added. The other entries in this list are not separated by blank lines.  
> What would preferred to fix this? A whitespace only patch or can just 
> add those additional blank lines in this change?

Both would work for me.

Best regards,
Krzysztof
