Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9C5BF67F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIUGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIUGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:39:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F88F583
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:39:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k10so7594199lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=otR0nNYDhUnhsN3OyUB7km5BpUtGxbbyPiKzEuh5rHI=;
        b=uWqCYraJmg5iZcIkkkQ1ppjz9FlMoAWe8koubDIbSUfiUm7l6y13QkhT8JTdY9XHsE
         GDG/QBKBKOdxc/txbI3G09XcWf1RMZ8ZLFXe7+lsZohI0VYm5mXgBYosyZrpjQLw8OY8
         n6SmAetLMdG9ab4Tex4A2xtMGVb1xCsRRX8yDO3pCeORDmHmnKZn6uQfseBTOmE83SDH
         I9ai6Eww7Rj1nsyeyZIAl+8ITNQLHLclJ5kRS41ylbnysmRRzatgulSuwRaPUGNmfl7i
         fp748ddLWr0c2u+4H3DdoWPhUgB+YofWUOhsmVcopJmiUDuA2gfdYwuj4+8DH4sjQL7a
         kINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=otR0nNYDhUnhsN3OyUB7km5BpUtGxbbyPiKzEuh5rHI=;
        b=rf7rtZAyWZeA0AfCTbrXsQCfwmngvisEC8FF3Akiw1PGgtZwVQ6se4MSjx3qQZHBql
         VusF9nnEGH/KiTGXOKJPgSRMKRZVbWxK7m5n3PVsnGch5uPuXdOG4LWip8Ug0LG1SYav
         WC7LGsM014gSOykxhwMflQfdypJV0hTfwnVd2IB50NYxR1qZzSnPq4Z6CljITBiBNXkT
         ngjjGNA1kZpWQbqaO4wX1HAj3cdwPGDAnO0DqawQCF/N8AfAv/D7QSWDt0fQEWB9bINf
         JmX5OeR0kqlGsmK4vnFWeG4P3q4MK/dDah0CQGI9v/1dY+z6obohD++5reQZyEoEFS52
         VoTg==
X-Gm-Message-State: ACrzQf2VBMdHDHWM2XJn+ozF8tXXMgAsNHlhFBkni54CjSw+ZCB/0V6V
        B9X3vpGwDQMOsW7WFQGo0K0fcg==
X-Google-Smtp-Source: AMsMyM6xeNvDHsWcEi+fZKXEaCmx5B60tduf07EnI0POnx4LZUYmhJpUhA/mzARjbAI6D73G9SISFA==
X-Received: by 2002:a05:6512:22c6:b0:498:fff7:b57f with SMTP id g6-20020a05651222c600b00498fff7b57fmr9150098lfu.582.1663742376985;
        Tue, 20 Sep 2022 23:39:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b00497a61453a9sm295228lfe.243.2022.09.20.23.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:39:36 -0700 (PDT)
Message-ID: <011ce9d2-ea39-9235-323a-eac453effb66@linaro.org>
Date:   Wed, 21 Sep 2022 08:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, kishon@ti.com,
        vkoul@kernel.org, dan.carpenter@oracle.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sjakhade@cadence.com
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
 <2dfb57cd-d9d4-9a26-dd4c-f116894c9baf@linaro.org>
 <fdeb4f4f-2712-fe35-a5c2-935d3a4baf38@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fdeb4f4f-2712-fe35-a5c2-935d3a4baf38@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 06:27, Siddharth Vadapalli wrote:
> Hello Krzysztof,
>
>>> +    then:
>>> +      properties:
>>> +        ti,qsgmii-main-ports:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +          items:
>>> +            minimum: 1
>>> +            maximum: 8
>>> +
>>>    - if:
>>>        not:
>>>          properties:
>>> @@ -94,6 +133,7 @@ allOf:
>>>              contains:
>>>                enum:
>>>                  - ti,j7200-cpsw5g-phy-gmii-sel
>>> +                - ti,j721e-cpsw9g-phy-gmii-sel
>>>      then:
>>>        properties:
>>>          ti,qsgmii-main-ports: false
>>
>> This is interesting here... Did you test the bindings with your DTS?
> 
> Yes, I tried it out with different compatibles in the DTS file for the
> node, making sure that the property "ti,qsgmii-main-ports" is allowed
> only for the "ti,j7200-cpsw5g-phy-gmii-sel" and the
> "ti,j721e-cpsw9g-phy-gmii-sel" compatibles. Additionally, I also tested
> that the "minItems", "maxItems", "minimum" and "maximum" checks apply.
> All of the rules within the "allOf", are enforced one after the other in
> sequence, based on my testing. Please let me know in case of any
> suggestions to implement it in a better way.

Great! I think I see now what I missed previously. The last hunk with
"ti,qsgmii-main-ports: false" is in a if: with negation ("not:")?

Best regards,
Krzysztof
