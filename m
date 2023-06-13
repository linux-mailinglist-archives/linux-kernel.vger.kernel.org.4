Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6398B72D73E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjFMCE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFMCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:04:56 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB0ECE55;
        Mon, 12 Jun 2023 19:04:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cx+enEzodkRl0EAA--.9356S3;
        Tue, 13 Jun 2023 10:04:52 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeTAzodkLCgYAA--.3640S3;
        Tue, 13 Jun 2023 10:04:48 +0800 (CST)
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
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
 <84ccf4cc-072d-adbf-0361-95ceae13f333@linaro.org>
 <5d060cac-ff28-60e9-98a8-f2bd4d378455@loongson.cn>
 <4e30870d-86e2-8536-8e0d-aab4ce5027d2@linaro.org>
 <0c532e09-4821-5e07-92e6-7bc3cd79869e@loongson.cn>
 <d24f1e60-0ef3-2cb9-9675-846d861ef0c8@linaro.org>
 <9fec9cfa-0686-91d8-cba4-91ea67243b47@loongson.cn>
 <28e776f8-1e37-79f4-5c10-a57c5cd7d4e4@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <f12dacd0-532d-c92a-19ee-9bcff2a778d9@loongson.cn>
Date:   Tue, 13 Jun 2023 10:04:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <28e776f8-1e37-79f4-5c10-a57c5cd7d4e4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeTAzodkLCgYAA--.3640S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/13 上午2:03, Krzysztof Kozlowski 写道:
> On 12/06/2023 13:29, zhuyinbo wrote:
>>
>>
>> 在 2023/6/12 下午4:16, Krzysztof Kozlowski 写道:
>>>>>>>>>> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>>>>>>>>>>> On 08/06/2023 13:42, zhuyinbo wrote:
>>>>>>>>>>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>>>>> @@ -16,6 +16,7 @@ properties:
>>>>>>>>>>>>           compatible:
>>>>>>>>>>>>             enum:
>>>>>>>>>>>>               - loongson,ls2k1000-spi
>>>>>>>>>>>> +      - loongson,ls2k0500-spi
>>>>>>>>>>>
>>>>>>>>>>> Aren't they compatible?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Are you saying that the spi driver is compatible with 2k0500 ?
>>>>>>>>>
>>>>>>>>> Didn't you say this through 11 previous revisions?
>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, did I understand your meaning incorrectly ?
>>>>>>>
>>>>>>> If they are compatible, then they are not part of one enum. They could
>>>>>>> not be as this would easily fail in testing of your DTS.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> The "loongson,ls2k0500-spi" wasn't a compatible in previous version and
>>>>>> I will add "loongson,ls2k0500-spi" as a compatible in spi driver and
>>>>>> added it as a part of the one enum in dt-binding.
>>>>>
>>>>> No, because you claimed - if I understood correctly - that they are
>>>>> compatible. Don't add fake entries to the driver.
>>>>>
>>>>
>>>>
>>>> I'm a bit confused, and I just need to add 'loongson,ls2k0500-spi' as
>>>> one enum in dt-bindings, but driver don't add this entry ?
>>>
>>> Compatibility is expressed with a list:
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#compatible
>>> so it cannot be just one enum, but "items". There are hundreds of
>>> examples including example-schema.
>>
>>
>> Is it a description like the following?
>>
>>    properties:
>>      compatible:
>> -    enum:
>> -      - loongson,ls2k1000-spi
>> +    oneOf:
>> +      - enum:
>> +          - loongson,ls2k1000-spi
>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1000-spi
>> +          - const: loongson,ls2k1000-spi
> 
> Remove this items part - it does not make sense. Device is not
> compatible with itself. Rest looks ok.


okay, I got it.

Thanks,
Yinbo

