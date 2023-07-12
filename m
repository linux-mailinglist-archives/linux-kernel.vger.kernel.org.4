Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E401275084E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGLMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGLMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:30:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1E9B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:30:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so1542468a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689165008; x=1691757008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As5jovVz/stLB9HCpNmduJGzBJFBIZbh6f6RqqdbEgU=;
        b=FywtFp7I+uYfwVkjEUr6hIuKhYCX/lOI70IZ16WSmcisfLjfp9CqVlbuAjPivT97/p
         +i2j14ibDGIHhmVmUBWtu9zNpsdpkPR4iMDqs9qlGq3r4NnXChlqeh1TXXK562wMg+kk
         gVDJPSKt8fn1Aw4WiUndWEUX8HOfclhEowcRrAUdbzVcg6IjGDiVDCkRwPKBS5rRjfYE
         IXiBgQoaBkT+OPrQKqAY6qnIJeHMD63qxz0Zt3YNBsO8Iw+pnOR/K0Du9s2K/uAM2DY8
         7nskj9lBRgyVUCXNQpQZ0NtL/noyrsRo1/CVrDq1Yc+H9ZIFdBY29OrWsr54tyqnPfzr
         6pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165008; x=1691757008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As5jovVz/stLB9HCpNmduJGzBJFBIZbh6f6RqqdbEgU=;
        b=L59D4/tePAylzABeVi1grntTFZmdSSSmHmVkigXjy2n/tlY8I/0VcwoGwGE9YQxTxk
         KSGwk16M4uNdY8AjJd7YBH5iAc5o5IxFWrV5Q3fRjd9UjkgzdgZ90E53rc2LRSPgZZd8
         HbWBn8cln6m+6O9YXoeRqrcbPNHSOgAsssg4XUWgKKbPUOMR/O0Q6N2vZN4dhQEuUn4X
         jSP+bWpHV5N11E6iL8Y+A8jhxi7Au/c7XNRcsDIgY6A9kqX13SrM3G80eN7TLCDOWrl/
         qZcDXSVJmnRIbcp62dADnCNXwyLYHGcLZ7tCEqEXYLZNrFwa+/U2d9GAeQJvlplXiWem
         sAxA==
X-Gm-Message-State: ABy/qLalmDXP3egDTrV8uJg19G1GBOL/+n2poCXv4Dn6U12GL96FePlL
        Gd/11ruc0Xm1EkeIgOu1AXMGKg==
X-Google-Smtp-Source: APBJJlFyqdAsr2Xmn7ERB3sVUUTbBaVW3d7pl/dph84q5U/gYteuRGrHlU/zsVSve6Jjadzi3Tfy8A==
X-Received: by 2002:aa7:cd78:0:b0:51d:a2d9:85a3 with SMTP id ca24-20020aa7cd78000000b0051da2d985a3mr2463329edb.8.1689165008692;
        Wed, 12 Jul 2023 05:30:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402165100b0051dd19d6d6esm2732667edx.73.2023.07.12.05.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:30:08 -0700 (PDT)
Message-ID: <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org>
Date:   Wed, 12 Jul 2023 14:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>
Cc:     conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, vincent.chen@sifive.com,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
 <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
 <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
 <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org>
 <20230712110908.GA23216@hsinchu16>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712110908.GA23216@hsinchu16>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:09, Eric Lin wrote:
> On Sat, Jul 01, 2023 at 10:22:25AM +0200, Krzysztof Kozlowski wrote:
>> On 28/06/2023 18:31, Eric Lin wrote:
>>
>>>>>>
>>>>>>> +      - enum:
>>>>>>> +          - sifive,pL2Cache0
>>>>>>> +          - sifive,pL2Cache1
>>>>>>
>>>>>> What is "0" and "1" here? What do these compatibles represent? Why they
>>>>>> do not have any SoC related part?
>>>>>
>>>>> The pL2Cache1 has minor changes in hardware, but it can use the same
>>>>> pl2 cache driver.
>>>>
>>>> Then why aren't they compatible?
>>>>
>>>
>>> The pL2Cache1 has removed some unused bits in the register compared to
>>> pl2Cache0.
>>> From the hardware perspective, they are not compatible but they can
>>> share the same pl2 cache driver in software.
>>
>> So they are compatible... If they were not compatible, you wouldn't be
>> able to use the same match in the driver.
>>
>>> Thus, we would like to keep both. It would be great if you can provide
>>> some suggestions. Thanks.
>>
>> I propose to make them compatible, like every other piece of SoC. I
>> don't see any benefit of having them separate.
>>
> 
> Hi Krzysztof,
> 
> Sorry for the late reply.
> The pl2 cache is our internal platform IP and is not part of any SoC. 
> 
> The reason why this driver is compatible with the hardware "pl2cache0" and hardware "pl2cache1"
> is that it doesn't program the different parts of the config register
> However, our internal software (e.g., bare-metal software) will program these different parts,
> so it needs to rely on the different compatible string to identify the hardware.
>   
> Additionally, we would like the compatible strings to reflect which hardware is being used Thanks.

I don't understand how does it contradicts anything I said. So you do
agree with me? Or what?

Best regards,
Krzysztof

