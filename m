Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CC72A077
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFIQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjFIQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:45:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F73A8B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:45:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-970056276acso300902966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686329136; x=1688921136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RIIh3RMuz6uU20aNEpxUR1/DLtTXsu5aO8Bkim9LaI=;
        b=tpn8c0QxhvUPGeAk7v1bazUG5T044xyUVQ1ETJsq3If9/uxrr4p9KmDWY3eEeH0myR
         nE5C3bR3AUYUwEGok1ulTVpMQRiiUBxMHzVm30zusfgoNAEvCF3/e36fULfj6mszLm0T
         p1vGQE4g8YAlKBgViKAHZ5pLtG4VwewhBZ6Sg8XkxK2qboUlr/HN/w9G7nUVGPg6/jID
         0sAV1ThUpunkTopIpG4xIoAtMr2fT+HIERj7I7Qo0qqufAucxB56V0qyC2GGJPkFZ9ev
         1l/1Rxd6zGfRMGS8YTXXhEiX2WUOCK63apAuHhPZPo69m4Z2eEUA/46cnMw/Pzhy5RlY
         EJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329136; x=1688921136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RIIh3RMuz6uU20aNEpxUR1/DLtTXsu5aO8Bkim9LaI=;
        b=cv2sRXGIZ4B2cOKgFClB8GYaZkUhOF9wwwBm9yBLPD8FxW1g3ebJXQWw8/es9AGI0t
         NQFaCeTvYLqUr0F/oCvtMu7euv4UPFqzPKI5Fysdah3VWWIiU2+SwBwDN4WLniXecskS
         2A2InoLl6WozHMg/tkSbqJA13r4p1+rQDGq/RExprZc6zLd7dfAJw8dsfabZ93FpXngR
         o7X4aMyl2mUjMt3GzzXasDwjaSqSqUDnquY/m4Ovc1qoBZQf3O3wBz6XIlumUVuHikCD
         XHJrgldKdBgBLcou6qdeyGXHnTBoItiHo2uFR7fyBXdYYi3CbDH0RZA67QXrfN84IkkU
         1iAQ==
X-Gm-Message-State: AC+VfDyGyCnk3RYct8ERdjIMr8Kfk+j2FbsRQZj799NwpksaVaSwjykz
        Gv9tt78g8qHoiusPa2yXjm9TaQ==
X-Google-Smtp-Source: ACHHUZ5yorw4a7hRPcReLDwKgBFnFTT04M+u87dM16NVU/TBES2+kKpiuq6DNAS02s3W6UOWXfI0jA==
X-Received: by 2002:a17:907:6d0e:b0:973:f72f:dfac with SMTP id sa14-20020a1709076d0e00b00973f72fdfacmr1648380ejc.67.1686329135708;
        Fri, 09 Jun 2023 09:45:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709065a8600b0097866bc5119sm1472179ejq.200.2023.06.09.09.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:45:35 -0700 (PDT)
Message-ID: <84ccf4cc-072d-adbf-0361-95ceae13f333@linaro.org>
Date:   Fri, 9 Jun 2023 18:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
 <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
 <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
 <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
 <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
 <657f8d19-de83-8be6-4a9d-5f13b1df7383@linaro.org>
 <b0e5e13e-6746-bd90-2a49-31ee6dd3e8a2@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b0e5e13e-6746-bd90-2a49-31ee6dd3e8a2@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 05:13, zhuyinbo wrote:
> 
> 
> 在 2023/6/8 下午9:26, Krzysztof Kozlowski 写道:
>> On 08/06/2023 14:10, zhuyinbo wrote:
>>>
>>>
>>> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>>>> On 08/06/2023 13:42, zhuyinbo wrote:
>>>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>> @@ -16,6 +16,7 @@ properties:
>>>>>       compatible:
>>>>>         enum:
>>>>>           - loongson,ls2k1000-spi
>>>>> +      - loongson,ls2k0500-spi
>>>>
>>>> Aren't they compatible?
>>>>
>>>
>>>
>>> Are you saying that the spi driver is compatible with 2k0500 ?
>>
>> Didn't you say this through 11 previous revisions?
> 
> 
> Yes, did I understand your meaning incorrectly ?

If they are compatible, then they are not part of one enum. They could
not be as this would easily fail in testing of your DTS.

Best regards,
Krzysztof

