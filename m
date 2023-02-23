Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A6D6A04C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjBWJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjBWJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:28:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4364C6D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so1442330wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gb2qxqmKS0rtdO++khKuhDFOUfUplSmtQFJjeC7elRk=;
        b=KN2AKHoO96bfhSZx+IPwU/tbpQPchmaFp81rNz+ltuEuiZU09uMVGjD1JKiKbjRmRa
         OQcqfWt7sTKFnS1LK56f5SAunmpKwGUI93gfW3wxd8rWUrU5SGkAKGfnZUn3R0L8QWHq
         8WyXfLzZdyI5vM6uqx84dNcvxQuRjeUNW81mPEEaZhDcdDiyvSUNPDP65Jt5VrDt/faD
         c1FkM9GWtxEA+juEK/t9LIfKYc3RfzgqZDQ5tJoG5u3j8DTl/xBTMPV2ruhLZnmnc7mY
         1I5tjLKZ8bIFIQM+lVlGnU7OXnmfHfbpU8E6qozvdCp9B/+hr5FdmcRVuR/y8q0yEDIB
         flcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb2qxqmKS0rtdO++khKuhDFOUfUplSmtQFJjeC7elRk=;
        b=STeezRdWDT7ymL2KQ2k+02rLpmxy/Muzl5TAvVXbOcGFLT1hQLW2JcMbUP9MevCO/D
         4Ep9f06ghydtEy/uECzed+dZnB045sLMLk3pSGPAHsAEPlrLhdrSKdaLZXYGW2BaPy7R
         VDWVHwVg7JINc9/TQECvv1BTqRWXGTk2WyjmFyV65IYgh2oTH5pZtWP61qF5BwJLL1lE
         03okzH/xcSM3Opn2W7Onl/aT/tXtHpHDibPqAl6SFJs7z8oaK5vW3qB/mk3OO4PCt+Pr
         J+Jd2OoZnbFxW2juW3iRtOcVKnaLhk6C4x5h77fPYaopldQ0zaD7KVBk9/uI/oo0+d0u
         HGkw==
X-Gm-Message-State: AO0yUKVrs1JjRCPbmwOCCm6KkMpMMjyOKwxSI3lCRPXf5/T/JRN7lRt3
        1/pWIddVMNyH/80y24GM0ypqyw==
X-Google-Smtp-Source: AK7set+MOmXu33I9nFWggqC/PShcnHbeYlNKSpRLAYvmxxPXpSzF23457FlD7byxWvQBb18MzZRLYA==
X-Received: by 2002:a5d:4b81:0:b0:2c5:4de1:ba23 with SMTP id b1-20020a5d4b81000000b002c54de1ba23mr9910494wrt.19.1677144530866;
        Thu, 23 Feb 2023 01:28:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d8-20020adffbc8000000b002c5d3f0f737sm8757431wrs.30.2023.02.23.01.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:28:50 -0800 (PST)
Message-ID: <5c255eb3-ec9e-d66f-4a2b-ccc32edf5672@linaro.org>
Date:   Thu, 23 Feb 2023 10:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
 <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <80d873d4-d813-6c25-8f47-f5ff9af718ec@linaro.org>
 <SEZPR06MB5269502D7CBCD5698B65FF9FF2A59@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c0ac0ab3-87fc-e74a-b4e2-3cf1b3a8a5e2@linaro.org>
 <SEZPR06MB52698CCA6AE59DDC6C15CBE4F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <94238c42-1250-4d51-86e5-0a960dea0ffc@linaro.org>
 <SEZPR06MB52696835ED8E2709D6A454DAF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b7ca24ea-a265-81cb-3da6-19f938b35878@linaro.org>
 <SEZPR06MB5269052D7ADCD0D0F939E60DF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB5269052D7ADCD0D0F939E60DF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 11:47, Ryan Chen wrote:
>>>> connector. That slave will keep state to drive clock stretching.
>>>>> So it is specific enable in i2c bus#1. Others is not needed enable timeout.
>>>>> Does this draw is more clear in scenario?
>>>>
>>>> I2C bus #1 works in slave mode? So you always need it for slave work?
>>>
>>> Yes, it is both slave/master mode. It is always dual role. Slave must always
>> work.
>>> Due to another board master will send.
>>
>> I meant that you need this property when it works in slave mode? It would be
>> then redundant to have in DT as it is implied by the mode.
> 
> But timeout feature is also apply in master. It for avoid suddenly slave miss(un-plug) 
> Master can timeout and release the SDA/SCL, return. 

OK, yet the property should describe the hardware, not the register
feature you want to program. You need to properly model it in DT binding
to represent hardware setup, not your desired Linux driver behavior.

>>>>> The same draw, in this case, i2c bus#1 that is multi-master transfer
>>>> architecture.
>>>>> Both will inactive with trunk data. That cane enable i2c#1 use DMA
>>>>> transfer
>>>> to reduce CPU utilized.
>>>>> Others (bus#2/3) can keep byte/buff mode.
>>>>
>>>> Isn't then current bus configuration for I2C#1 known to the driver?
>>>> Jeremy asked few other questions around here...
>>>
>>> No, The driver don't know currently board configuration.
>>
>> It knows whether it is working in multi-master/slave mode.
> 
> But in DT can decide which i2c bus number can use dma or buffer mode transfer.
> If in another i2c bus support master only, also can use dma to transfer trunk data to another slave. 

and none of these were explained in commit msg or device description.

Best regards,
Krzysztof

