Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA06D5A95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjDDIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjDDIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:17:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3010C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:17:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er13so86200542edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680596266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csVvkhT6MaVLbsUjZrgKGXypyh9Z79Wm9AsNuXlC+Tw=;
        b=u5SW6/j99gN7rv7rKP8viYG+qodyH02DXjGfAhiYbslyDCRpoLBbyuH8EnWYqU4MMY
         zbLKyHJsoGwkdihBPaqXybBE3ru8Tt9XEsl+WSBynPEJh373ISEoCVrUtvOwlRL3J9ls
         zyh0+rLYTozYAqDK4Q17QZ527WfWBbWaZrMZJGav6fL4npEME5fZFmHRuCNcqhp1Mx0F
         ViFlaRSVGh3y5Sk+7QseiU4WkhJw/WpWr21iwRKewnNDrRfK7xPaN3bc2qvjR6xABDxu
         oxJQm75rlgV2RMQ2n0pAe3JziKRl5KQXZBxH7N6FpCaM7/wQy/BPTOwRNFLvaBdk2Ip/
         e5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csVvkhT6MaVLbsUjZrgKGXypyh9Z79Wm9AsNuXlC+Tw=;
        b=oUbd81C+XyFTwwQl4cKSu2/ECaExB4ts9ZCksSbxtQbVurLGR/7hNPubmOujDru/v5
         O7NH1pAHh/nn1ZA3/n5PH2gle1oKCj93EL6rtmZB43el5Is3azI3NVnv1qfPyjp5/+Vu
         4jmg5r5SqxW0VlYz94fBNIJ9rPERToWt0lTEyKw2yA7AAQzEjA6hVjYIQ3RidI+kP5zk
         0CATLD4v6yD6Txe6IWlkMojQJpdPurErL9qcolNhCkkaGpLBByGECJjZFzTMEfiWWJMb
         klEddQhoWEx8mbgdZVCWYBYGDmDXTDaTaB+nWvoZsFJRZT+tg05nyieUUsjwu5c0G0PW
         olww==
X-Gm-Message-State: AAQBX9f4dOe+Y99opmmJyknhMMbxUTapmKV1optcyy623wB+V9NQwKjt
        xfZGkzd8bY6hHg4YXlvekqxMJg==
X-Google-Smtp-Source: AKy350ZjdQ/ZfKRN5K6cThQ5389TacCmIKnpzI0DFmA1lMsqy03gk8/y0ABgplSsVnnGwi8NBdGkxg==
X-Received: by 2002:a17:906:7ac9:b0:93d:b767:9fea with SMTP id k9-20020a1709067ac900b0093db7679feamr1473012ejo.31.1680596266294;
        Tue, 04 Apr 2023 01:17:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id t12-20020a170906608c00b0093d0867a65csm5693940ejj.175.2023.04.04.01.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 01:17:45 -0700 (PDT)
Message-ID: <9422ab57-8512-0177-76fa-76347626f941@linaro.org>
Date:   Tue, 4 Apr 2023 10:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
 <9dc60868-b3f2-e30f-f4fe-d2fbd551d948@linaro.org>
 <DU0PR04MB9417000982CDDF5B75E309F488939@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417000982CDDF5B75E309F488939@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 08:44, Peng Fan wrote:


>>
>>> +
>>> +  beeper-hz:
>>> +    description: bell frequency in Hz
>>> +    minimum: 1
>>> +    maximum: 4
>>
>> default is 1000, so how constraints can be lower than default? Also - missing
>> default.
> [Peng Fan] 
> I am not sure what maximum value should be set. Previously I set 256, Rob
> questioned it.

Yep, because 256 is power of 2, so really does not look correct. It is
still lower than default, right?

Best regards,
Krzysztof

