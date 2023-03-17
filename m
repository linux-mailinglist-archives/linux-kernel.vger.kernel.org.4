Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD86BE535
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCQJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCQJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:14:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCA9387D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:13:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so17805087edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cpBYnKN5+YMFMw4tpn2s+6a2wFSz7gO8ZG313XuCv4=;
        b=FnqJnDfJTBi41p9JHh2V4t9548s1xSHZk6EhJKO2KgFARu+eOEDIROmxBeCN72zWEt
         rXKKFkFnh7MaSbygTcYQnQw6DomruPVc97RonbsScgLiLBHhBhFTor3ygxEcHDPFT0zM
         +SmoboRs+Es/JA9Gij/nX0aRL8Evwsbe6Nr6E7/xS3j8UKi2zFWJB8mP2lzoaXB7UyOM
         ptLx8MyGxhtb15z9T4IxnHMN7ZjjnBuPS9vdjAwXjoJ7Ha4YFVudkyW4XEEtUNKzI7sf
         H6yhIQ3F+2pB4qjLD+VNUGHSJ3hKVEOLwEvIPDHWG2H4U2t8GeR5Pg1FJgcxFH6lPUZI
         /0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cpBYnKN5+YMFMw4tpn2s+6a2wFSz7gO8ZG313XuCv4=;
        b=QiS2QKBwYJVM0dGY2P4R915wPoQN2w3LN33qeOw/iPPmEsq/cdmtVY6b8n5uxf9F+q
         hjyfoV9wX1YMwSN+P8uhndJXSTghHp8w762752VmeGDslaZ7lTD2eS6DKoXKJNPCDx4T
         lRDX2UF21cQOuv+ZVj4hmIsMyI4lIlFIp0KV65/i95JygKRKi6jZ1TDBifY3p8XU0sCB
         zT1rfiQOBesT3SsWUCTCEnMP4+syz14azgCOhiGVB2cf+4maM9maDBWCF9XrySdEjtI3
         0GejDiMvbFLaZzsoRzU9hwQ/iXZhEguD03mwEsOw7bly2hqgTbwtQ1vpD/6dd6DlXwkh
         jmPw==
X-Gm-Message-State: AO0yUKVp+pgHit4TbhV/rtJ3AFBI+cuWehR4g2bqRJkNRLzmaNeTX/Eu
        jhXun8YZQR3XIoTk/ajLzdZFhA==
X-Google-Smtp-Source: AK7set8AbOUSg9RLLGhVLscb7j5DdC0tsCnYce7R6YkcgOcQcZDKJYLl8/4X0z9PrsNAsTJb0yyzGw==
X-Received: by 2002:a17:906:56:b0:91f:7455:cb1d with SMTP id 22-20020a170906005600b0091f7455cb1dmr13023353ejg.57.1679044416747;
        Fri, 17 Mar 2023 02:13:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709066b9400b0093114ce0837sm740814ejr.51.2023.03.17.02.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:13:36 -0700 (PDT)
Message-ID: <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
Date:   Fri, 17 Mar 2023 10:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
 <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 04:47, Jacky Huang wrote:
> 
>>
>>> +
>>> +  nuvoton,pll-mode:
>>> +    description:
>>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>>> +      spectrum mode.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    maxItems: 5
>>> +    items:
>>> +      minimum: 0
>>> +      maximum: 2
>> Why exactly this is suitable for DT?
> 
> I will use strings instead.

I have doubts why PLL mode is a property of DT. Is this a board-specific
property?

> 
>>
>>> +
>>> +  nuvoton,sys:
>>> +    description:
>>> +      Phandle to the system management controller.
>>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> Drop quotes.
>>
>> You need here constraints, look for existing examples.
>>
> 
> I would like to modify this as:
> 
> 
>    nuvoton,sys:
>      description:
>        Use to unlock and lock some clock controller registers. The lock
>        control register is in system controller.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: phandle to the system controller.

In such case you do not have array. Just make it phandle and drop the items.



Best regards,
Krzysztof

