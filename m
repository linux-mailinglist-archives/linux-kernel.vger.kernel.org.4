Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA5623200
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKISDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiKISDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:03:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA606426
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:03:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so26979786wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JW3fkWgeAG3LT4kZ6rcMCrGgnOiIVlFxIYHqqCAg8qs=;
        b=lQ+SPL8FwdXmfcTzLpYYBS17369BtI2K5e3Q720yl0CpD4+sF0J2A2pXEV/F2sHJtG
         twPlu+RX4BePLR7u8nDZLB8A6ZpLn18SEpk0An51PrNdFi9kzU2aRTDm8P93tgFHe90s
         kTZzgOhaatBC/di9nY5d/kxp7Y2w2ZhA8/P4LGCuo/bc7PJF47rUT5xkLbqWBcJkx6Fa
         Y4dDjLChh1iFAlc48G2EVCXtSSHqnhsl7w1a+TBMaaMuLpNbZ2gF179z1lRCRARaeBeX
         c+ZC9mcbI+rJk4e/L+Tm1UlL8CV8tfp46VSY8BsZNMDwvVWnPoMCPK7tM4+47SNJ/t0N
         GMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW3fkWgeAG3LT4kZ6rcMCrGgnOiIVlFxIYHqqCAg8qs=;
        b=Jn3BE/YMlELsdc1TaZx3YQ9E7TQ1ZiiHKCEtgq7CbcRArbAcOre9jNzKBx7Br5KYFQ
         0RILiI31UYJCiaPjiBYrzqBE9Kyv+GPfrzKtNKU8/Vhu8DaF8pilDBlm/fIV8knmb8w7
         Cijdjs1aIdvdVLWC/6fI4zUlfFcBehMxruQeGzJ132E/r2Bowq2dqKwLhp5nrLBRK6f9
         vC2SrQ4dNifxZdfFMikixuO2tCnKr7KvzI4XHD7RgDhfKxu/2vFQ8Hse8U+d75SQg+qj
         47pshSWOq0EpeeJrMvzKrYBYeDz3TvO8tvO9ULODoeQA+B6m0ig1P78ycODEOjfkIRiN
         AIhw==
X-Gm-Message-State: ACrzQf3sgCUzl6B6CFzn8ZXcSXjXgaA8BFvZ3zZ8GwMd2+l6w+/mbU2+
        4B1EVGnaGrkt3tGj3g99bwhxqg==
X-Google-Smtp-Source: AMsMyM6SeXTYaN56/vVPHIrwx/UP6BpPLjNPyIdTSjxe/Rs+selrIt/kcFmP7DR2igBjtS13ycWK4A==
X-Received: by 2002:a5d:68ce:0:b0:236:9981:d216 with SMTP id p14-20020a5d68ce000000b002369981d216mr38881975wrw.384.1668016982241;
        Wed, 09 Nov 2022 10:03:02 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m2-20020a056000008200b0023662d97130sm13563050wrx.20.2022.11.09.10.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:03:01 -0800 (PST)
Message-ID: <52fa1899-6eb9-389f-2ff1-22164356df66@linaro.org>
Date:   Wed, 9 Nov 2022 18:02:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Content-Language: en-US
To:     Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
 <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
 <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
 <a4ae3648-2943-55e0-243f-71a3c5f71ad8@foss.st.com>
 <4789703d-0434-2e72-0001-5a7e1014f816@linaro.org>
 <6df7b823-463b-d6fa-9662-54f39463a894@foss.st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <6df7b823-463b-d6fa-9662-54f39463a894@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 17:35, Patrick DELAUNAY wrote:
>>>
>>>
>>>>
>>>> Why not add TEE client based new driver instead of ifdefing around 
>>>> this driver? Also I see there is not much common across both drivers 
>>>> anyway.
>>>
>>>
>>> I hesitate between the 2 solutions. I choose this update to handle 
>>> the STM32MP15 support with OP-TEE.
>>
>> How are you to handing this?
>>
>>>
>>> For backward compatibility reason the same driver STM32 ROMEM 
>>> associated to compatible "st,stm32mp15-bsec" should be kept.
>>>
>>> - the lower OTP can directly accessible by Linux (the IP is not 
>>> secured) => boot with SPL
>>
>> Can we determine this at runtime?
> 
> 
> Not directly with IP register, but we detect the OP-TEE support at runtime.
> 
You mean using CONFIG_OP_TEE ?


> 
>>
>>>
>>> - the upper OTP and the write operation are requested by 
>>> STMicroelectronics SMCs
>>>
>>>     => boot with TF-A SPMIN and old OP-TEE (before migration to STM32 
>>> BSEC PTA)
>>>
>>>
>>> But in the future OP-TEE the access to OTP should be also done with 
>>> STM32 BSEC PTA...
>>
>> Given that we have only one compatible for these two type of 
>> combinations how are you planning to deal with both the cases and 
>> still be backward compatible?
