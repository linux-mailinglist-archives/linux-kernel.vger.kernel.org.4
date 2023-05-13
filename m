Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4767015CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjEMJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbjEMJdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:33:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1D49E0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:33:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-956ff2399b1so2059477866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970383; x=1686562383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bjlRqIfrmAy2t4cl4T8kdHUjaX/ag9QYXtsc2MuGRw=;
        b=KKQhGqn7zd4PYy+zRI6+QsJzUQCoT8os7Yd4pgH9KccYC86dIm5huzj0f85Ezak930
         V7fsmYhQLbzfZ96+NaGjzetLCtPswBNc4rvSdycSiG4TWDh1rpwJdAhAlcRsPduIwkgW
         Q0FU83RiDiNZoQpJjH7UM9Km6ZXdG8FYviL+7D9rHeHNGpylQTFaWzmNqN5SVnbwr1+j
         Q9TVyUuF547crHDEqZyQsctegU1jYm9T9Z91Ohb/xJw1gYTFd0PzyxO45u8eyyJ6jNBY
         p/nofwhceNjX4stMTM9iocOkTtRp0lmHdh3T/uFGHOsk+9EG2aoZSJAHzyUqdOvJu/Re
         5AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970383; x=1686562383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bjlRqIfrmAy2t4cl4T8kdHUjaX/ag9QYXtsc2MuGRw=;
        b=j6v11Wx1xrpGaY4zQp5iC3ohSEzVHe8o8q/nrC/JCOOTCydHnLjmbzVuX5Qgps5ABt
         IvRr/PIkNh5+R6KcHi1w90D+hkXFc/AEDPpSbq+0IuQfJouVmTH1zxL3gJA+SBYFRmJ2
         wZSKxRul6WX1jqhyR5FOVhQ91MQlPgtn98Y7tRY6FJxkgZQu+n1t50ouq9sYx/rzMlj5
         NtH1nD79ao+JPCxJ8J9S6tC3r+RKaVjRic1KIqNq9bC48o3mmquCLkS7cKHfN6p6jHZc
         Pwcb9Xw8fqlAsKVecy4izRhn5UKa03dKk5TNMgLewTrowBNZzqTinC81LGjLUxRFUC33
         xqsA==
X-Gm-Message-State: AC+VfDwP6GNWNVrdgZtDe//rAEln4wUa0coIWKr/IJqGkxdYl7kngRHE
        90SAIzwzPeKgSKvBmDPkdd4lOQ==
X-Google-Smtp-Source: ACHHUZ4sWARPNPph+9RlcI3oXg7kqpz2p34sb8nigaWurTMe8EkI2O7CnE5vyrkmM8Mt4jk3/N0mmA==
X-Received: by 2002:a17:907:a4d:b0:95e:de94:5bea with SMTP id be13-20020a1709070a4d00b0095ede945beamr25096100ejc.56.1683970382855;
        Sat, 13 May 2023 02:33:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709063c5200b00965a56f82absm6547662ejg.212.2023.05.13.02.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:33:02 -0700 (PDT)
Message-ID: <525d7b15-ffbd-22d9-7ad5-0a0ff7290620@linaro.org>
Date:   Sat, 13 May 2023 11:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com>
 <20230328114729.61436-1-aakarsh.jain@samsung.com>
 <ad96f28a-7b2d-a58b-50fb-648063ed0b18@linaro.org>
 <000001d983eb$e0692280$a13b6780$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d983eb$e0692280$a13b6780$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 11:34, Aakarsh Jain wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 28 March 2023 20:06
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
>> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
>> david.plowman@raspberrypi.com; mark.rutland@arm.com;
>> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
>> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com
>> Subject: Re: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to json-
>> schema
>>
>> On 28/03/2023 13:47, Aakarsh Jain wrote:
>>> Convert s5p-mfc bindings to DT schema format using json-schema.
>>>
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> ---
>>> changes since v6:
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions. However, there's no need to repost patches *only* to add the
>> tags. The upstream maintainer will do that for acks received on the version
>> they apply.
>>
>> https://protect2.fireeye.com/v1/url?k=03601d03-62eb0848-0361964c-
>> 74fe485fb305-ca0023b5279dd925&q=1&e=9490b51d-9547-4566-bb76-
>> 8c1401745ae1&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17%2Fs
>> ource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L540
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof
> 
> 
> Hi Krzysztof,
> 
> I don’t see this patch in linux-next. It's been more than a month now. 
> Please let me know if any other changes required.

I already provided you review tag.

Best regards,
Krzysztof

