Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A76BED55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCQPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCQPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:51:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584DB7D80
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:51:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x13so22221622edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679068310;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cIpYuiiojMCAobzId5qhGl15omtaJyYTL0wLJn7tlw=;
        b=r4FWwpLz5EizZals039cnMitbYb5uYCyPwkPRq5WbTZ3j9i0MpgFtKDGTSC0sCPYo3
         wq3J8TeaNpeWlTXtk8d2+9jqEVYOhCbM51tGGwjhkRr66icLIqzvLbSyOtWGBAXwP8Y7
         a6fYl8Ol13qYlzmtpX0Y7vm89kS2L7NjddXyeG01OxMUblaCxu3B+Ok3e5GGx9lh0A9D
         uGKeeGcbXkPUtFj8zuxt8Yx6mrwe3Rn19fGkbLzvbJmMVXzCfX+aFjSHMknWbBfVGI2u
         nITkw5gEKVR5x8bAmO75XvCCJTjPJ3iTWGkxTuwNP5YmrSoDpeBW95WVYv3B3Mkfvdnv
         v4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679068310;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cIpYuiiojMCAobzId5qhGl15omtaJyYTL0wLJn7tlw=;
        b=u5WzUS0rDJ9zbgGP8oz5ZZqf3pAPg47SugECSio5ea3rq4n1hCDpVqttdxBwgzI2fB
         ETFSo3Kwr+FUq1Kg1zJNXHTrrzdubVCX5hqHMjCWr8PYnnU4CyG/IoR2ndsJjtZqNLwf
         gRjr5lpCid9ewH2u7zse3TppYhzjDEj2F4NhFP4Rg2vR2CI7c2CRjfVhecUtZUh/6Woj
         OyoHmaUJxAw1voHPP/Y/1OT7yxcQ5P/svm9GlZUCHK/1A0PMO7n4lGf/u5R/ipxv5V+t
         P1D8hU8JYcNdPj+edO9x+vvdldqmRIEjg2+fwDJK1IdngoHvWejWwjPe1fiUn9bw3NQu
         uJWQ==
X-Gm-Message-State: AO0yUKXkQD5vGMfP0hMvPVJ9K7HE9x+K4ShS+vuPYsbjNTjoiTzMx3LV
        EwnXJllaLh9TqCQ4niKKFoN7+w==
X-Google-Smtp-Source: AK7set+tkXJTwK4Pn7J0ZPe/SkUpMPj1xgCu7jKs+Qax7Y3gqkIIsxGyK2DPXf4gUTaMk/QoBWqyHw==
X-Received: by 2002:a17:907:1ca8:b0:91d:9745:407a with SMTP id nb40-20020a1709071ca800b0091d9745407amr58457ejc.14.1679068310057;
        Fri, 17 Mar 2023 08:51:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b008d1693c212csm1105635ejc.8.2023.03.17.08.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 08:51:49 -0700 (PDT)
Message-ID: <c904c1ec-9080-0cc0-ae86-7d369d52e818@linaro.org>
Date:   Fri, 17 Mar 2023 16:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-2-zhuyinbo@loongson.cn>
 <a736c6db-466a-12e4-8e22-c8dc900978d4@linaro.org>
 <e944732b-9a2d-b6ff-8336-7363788809b9@loongson.cn>
 <7469290a-0671-7d2f-b0ce-cdde2a9e66cc@linaro.org>
In-Reply-To: <7469290a-0671-7d2f-b0ce-cdde2a9e66cc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 16:51, Krzysztof Kozlowski wrote:
> On 17/03/2023 11:00, zhuyinbo wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - loongson,ls2k-spi
>>>> +      - loongson,ls7a-spi
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    minItems: 1
>>> I don't understand why did you change it. I did not ask for it.
>>>
>>> Best regards,
>>> Krzysztof
>> Add clocks "minItems: 1" description is for fix yaml file compile issue.
> 
> minItems: 1 is not correct, so you cannot use incorrect code to suppress
> some warning. This should be list the clocks or use maxItems: 1, if you
> have only one clock.

BTW, as Rob's bot reports, this wasn't even tested... Please test the
patches before sending them.

Best regards,
Krzysztof

