Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880CE6C58D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCVVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCVVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:36:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FF12F35
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:36:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so45704845edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679520972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emprVTk0aixuPLLYvid5ND+yCvDHUt4XwwazaHkoj/A=;
        b=bMvKHYio3BoBF7p9Jgs7dYZNhV4ETBRwXxr8aWASUCf8wXUWFgPQHSQlj0Xuu8KhBi
         LAvUIVLbL4wsMk/WQM1gKFz6jbCkCulg2K0lcMtyt4Ghjz/jVCVrW1KHFmn3R73HwwiH
         jnbxX8QzoWxOsJnm3c0ifg8SY4X9ueScJWUrg665c6JHgZfZX3lImk5dOuLMGjcj01dZ
         F/MCt7JVjJSQsjwbthPektF/hO2HTINqOH8xT1ziNpM0fYkG8WzcyF9FNFRP+v2WM6Ro
         7FyZ4FlEk8rKySDhlPEa6laEH/Tjx8uP5poPwFqB9n1zcagKFhpjNmzOy+gSlNMIp4Jt
         uMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emprVTk0aixuPLLYvid5ND+yCvDHUt4XwwazaHkoj/A=;
        b=KOYUXw6vkLjYzejYToUVJr7E8pe8z+nrbZqnGpNhaoSV1skgEolMstc2CNR7TsldlM
         KLRn7U/EVgIwmoCPTaHHy475IR2CaCVneJyzCcKKgY9jUQmS6OUvdBlv/1Yg6YTel72F
         0sF5gh+EXpk8moplBMSPvP0NJ/fG+PxmiK6WqvNSO/PZufEw/AKu7pVXR81LXhrsrnb7
         3hNSv3wruaIEnaAHeDwl2FOAsnWdIqo9SA1Ilv4R/Rg2Bmf6dGlSKhRjJW+GLP5MZFwy
         Enp9Mu3xm/X4+NzXGt9hcPQDWhFiR3/MWDFP3o0eKEHe7hEfyNNaMLO680rAtFERR4DP
         DjSw==
X-Gm-Message-State: AO0yUKWHWaFtQ6ZgyrxuURfGdqVtsSCN+FitGPVhVfJzgyvn5u1wgvOk
        R2p5Lbyno3UnBO93RPQwZFJVHA==
X-Google-Smtp-Source: AK7set+ohi/R4BeazBEJpap964vNxy/i+fazZYnxgwoPW6ri6bn7qvTi5j5l8+s94/pUgwfwrkH+vg==
X-Received: by 2002:a17:907:75d8:b0:8aa:502c:44d3 with SMTP id jl24-20020a17090775d800b008aa502c44d3mr8809588ejc.41.1679520972100;
        Wed, 22 Mar 2023 14:36:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170906f90d00b00927341bf69dsm7741703ejb.88.2023.03.22.14.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:36:11 -0700 (PDT)
Message-ID: <2adad86c-1321-d5ab-839b-49273249718b@linaro.org>
Date:   Wed, 22 Mar 2023 22:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230321171020.74736-1-jpanis@baylibre.com>
 <20230321171020.74736-2-jpanis@baylibre.com>
 <88a6856e-c766-d4a5-1882-5350fd0e248a@linaro.org>
 <bffba580-e737-8996-4812-3c76c880acc9@baylibre.com>
 <de3acab7-cf76-3135-9ff8-a0e5537a434b@linaro.org>
 <a63d420c-54ad-e7b0-cc10-64bb942b4e6a@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a63d420c-54ad-e7b0-cc10-64bb942b4e6a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 14:55, Julien Panis wrote:
> 
> 
> On 3/22/23 09:16, Krzysztof Kozlowski wrote:
>> On 22/03/2023 09:01, Julien Panis wrote:
>>>>> +  ti,multi-phase-id:
>>>>> +    description: |
>>>>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>>>>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> No improvements here. As Rob pointed out, this looks like coupled
>>>> regulators.
>>> I used 'oneOf' logic to handle mutual exclusion. But it seems that I did not
>>> understand what you and Rob expected.
>>> Does some generic property already exist for 'coupled regulators' ?
>> Yes, see regulator.yaml binding.
> 
> Krzysztof, I talked with the regulator API/yaml maintainer.
> Actually, our multiphase concept is different than coupled regulators:
> https://lore.kernel.org/all/ZBr+7X3lcFdI8p%2Fo@sirena.org.uk/
> 
> We must not use the generic 'coupled regulator' property here.
> So, 'ti,multi-phase-id' can be kept.

Yeah. I think we do not have generic property for this.

Best regards,
Krzysztof

