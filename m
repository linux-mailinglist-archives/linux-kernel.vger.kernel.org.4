Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95FA5EEE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiI2GuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiI2Gt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:49:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF74F3B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:49:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b6so486804ljr.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9riNZVJHHiGAu2Pt8+qgKwtbpAbtFPq/WEzep1qznjk=;
        b=GFmvseWTnKL9Z9WgWeMRvQvhAoDiC5Lyhwr7cz9K0gAzBAeDsFp/EhpuesebdJ+Nhn
         x8L4Pf2vSAkcuWbARrlA/ZL2RYZdr/mhTtf4rZCPHTlFWnCI10P/aIldX3ZRk0jVQ9Xn
         4zdT0F0R6S9vXhxy0bjwTPJgkPqasWrLCQNZAoD74sFQY3pwy7ODiaIJf5yZfuEamrtr
         SUilrWMZSGK14TKcRNp6a1Gf8rAY0+qUpWDZnrAFXyT6x//fdJULZSyTDNxVfDv2dgNg
         dc2vaZF/BeRvBk6rDazFkrJWCejzjVbSK6J6eDfzQVHMZ02BzJweCxq9f6PHpxLtfvXq
         OOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9riNZVJHHiGAu2Pt8+qgKwtbpAbtFPq/WEzep1qznjk=;
        b=LqLdkhJ+PmA2SEb29jtWa+iqZbqSbeFYHLfoyDKthp1fzkr2YffheyzLtdPPPAMUNM
         WiiPQp7Uw3HJTp5q+MPTITMRjvtR/dIi5JIiGVhARMVD+ws5Qe/s9908eLq+Mds4PXa0
         tsyafYRhBmX/OSHOvCDJyPgI5AWXO/l+JWz4L9kWoMUQN41D0+j8Uua11YKktmG2+AgC
         tmk16yEesXFNdPn+CCSl3QmWMGFRJaRAq9qQz7dLRA7Op778wVPnghqUS+uYbaBjBbIK
         hc3W6E03lvOeuOSTk1V5FswCcBWDkc21pw9kzUVOU+afhQdI+a/AMjskH1KpwIb/A9Ev
         r5+Q==
X-Gm-Message-State: ACrzQf0PADhFNpwT3WgilYxUmEmiEz2BR0nPLQd9zfEWMaKgljbosJbV
        0rq78K01n87Q8FzG7MvSlYD0ArKA5Rk+Mw==
X-Google-Smtp-Source: AMsMyM6HQoJ5UNKRyCHBISkOOH4HujGYWPOKkoE98SUL/UFadadDiHyVoD70LSpaqusQ1YF5KVmSjQ==
X-Received: by 2002:a05:651c:1504:b0:26c:6331:3463 with SMTP id e4-20020a05651c150400b0026c63313463mr607382ljf.30.1664434192564;
        Wed, 28 Sep 2022 23:49:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j14-20020a05651231ce00b0048af9576d30sm695743lfe.83.2022.09.28.23.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 23:49:52 -0700 (PDT)
Message-ID: <dd887ce0-df72-2818-ecaf-1fcdcc0dfb42@linaro.org>
Date:   Thu, 29 Sep 2022 08:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
 <02967018-8a04-bd82-49e6-1ee475916ebb@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <02967018-8a04-bd82-49e6-1ee475916ebb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 20:37, Dinh Nguyen wrote:
> Hi,
> 
> On 9/28/22 12:15, Krzysztof Kozlowski wrote:
>> On 28/09/2022 18:54, Dinh Nguyen wrote:
>>> Document the optional "altr,sysmgr-syscon" binding that is used to
>>> access the System Manager register that controls the SDMMC clock
>>> phase.
>>>
>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>> ---
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +
>>> +allOf:
>>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const:
>>> +              - altr,socfpga-dw-mshc
>>
>> It still should not be an array, even if there is no warning.
>>
> 
> I apologize, but I'm confused with the message. Do you mean it should 
> not be a "const"?

No, it should not be a const. Open any other schema and check how const
is done there.

Best regards,
Krzysztof

