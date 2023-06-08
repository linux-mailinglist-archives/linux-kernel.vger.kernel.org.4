Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90C728157
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjFHN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:26:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C86E59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:26:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-978863fb00fso119251566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686230806; x=1688822806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzWlAY0Wmvknnc3spmuP+VktzOnlDk3j1gTYnrGy5j0=;
        b=KOSqDLQoTv/GSUjQvSPW820R/w3aStZVHnoyaRmnOMIn18NbF/f78tTmqw8QL1v2gP
         5p3vfHbdDZUYDa/sGYQgaSa4D2v5dmxAxgqDVmJDASA5JaqL5mBih3pArZSNG62L0haJ
         HpRqFxZqUm4Xu6X8+olsiXkoaNECQbO6kJqZDfSCMyFtsWhYLLN0aEh6/Hqt5ZukESTc
         Ys5Xj1Gpt4Ci75Pfqc+sxDngrt6RBrEfIaBgC0PfuPUAmpn0wlDAlsYHTt6tzAHkb0lB
         bbn6E716hESmNIjeTU1TqQ2qY1dpBEqtt3dERKj2nK38QtbZdY8iUPU+ibhBt0ASjMGx
         Sp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230806; x=1688822806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzWlAY0Wmvknnc3spmuP+VktzOnlDk3j1gTYnrGy5j0=;
        b=M0iZZTQUIvyCdXpIrZ897UT+LoSn4WiYBj7yRZBq6GNNbBNEtlF/yUMBMeXMu8uql2
         JR7FB15HvtwofhPVq58roYf7sqEM1Qr+8HN7H2BNW8+BL+3ZB4nv1VKz1/7GeNVM+H8R
         lhsduNsTI5cr+K8A90mbupyDHMEliaXLbF+DCl0L0+3k1SZtWSAbS28iiaQj71iMfv7g
         xL9qbobhLI7jGY3IsH6/3WuwPIeUJXnth5pAttPnsrany8If1y1dLW4le1uvjqfk3uHK
         AtfgDiwGuKNiF4UWOPI2A6O8Cn27UaBB2Hxai4oHm8Sug4BI3lGrA0iv62m5Uq1QIv+y
         Wwqw==
X-Gm-Message-State: AC+VfDyX++Fe340M5oD1+weuicPxPIzcQiVPlbF70RDwG5onyYmAiN7j
        lhQ48TeBrM8hvwsjZoMtQ6r2SA==
X-Google-Smtp-Source: ACHHUZ7ne7JCY+VYzIO80nsZqHqRhnjE92GFb4pNM5AvSXrdGrAEanBKKnmEo+GRnqtD/ReuVDxz7A==
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id hc37-20020a17090716a500b009786be47efbmr9925080ejc.7.1686230806449;
        Thu, 08 Jun 2023 06:26:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id dv26-20020a170906b81a00b00977cc84975fsm704390ejb.72.2023.06.08.06.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:26:46 -0700 (PDT)
Message-ID: <657f8d19-de83-8be6-4a9d-5f13b1df7383@linaro.org>
Date:   Thu, 8 Jun 2023 15:26:44 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 14:10, zhuyinbo wrote:
> 
> 
> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>> On 08/06/2023 13:42, zhuyinbo wrote:
>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>> @@ -16,6 +16,7 @@ properties:
>>>      compatible:
>>>        enum:
>>>          - loongson,ls2k1000-spi
>>> +      - loongson,ls2k0500-spi
>>
>> Aren't they compatible?
>>
> 
> 
> Are you saying that the spi driver is compatible with 2k0500 ?

Didn't you say this through 11 previous revisions?

> Yes.  and the 2k1000 spi hardware was same with 2k0500 common type spi
> hardware.
> 
> but afterwards, it may be necessary to implement a clock drvier for
> 2k0500, because the spi driver was use "devm_clk_get_optional()" to
> get clock and not use "of_property_read_u32(np, "clock-frequency",
> &clk)",  But this seems to have nothing to do with bindings.
>

Best regards,
Krzysztof

