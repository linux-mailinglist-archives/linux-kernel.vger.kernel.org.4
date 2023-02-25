Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2D6A29F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBYNMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:12:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753791287C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:12:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so4160012wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=venjkIokm8GSX2ge2Rc27dt76cxYVR85slS/SbYCDaI=;
        b=KfUc2TMjMgU8j1j5SmUZ57UkfL5HxpCSKgAhZP4qQizXeVmtzxOfOOVXIQqIFzVCov
         W1t32Qi2f2NnVvw3/KA9aGL4FFk3c+lqbm9pu4B/pkzM0fT1WndSEmFTyIgDzWyCcamB
         P7Cg6CnwRv2c7yzhNoFO9W8LCjaa0WJ8qvABY4/5J2kcsnkyQhOnnzHBAWQIyfRI8eOY
         z1izimCojPZ1dlYwiIHO78xzP+lishGZ0telNVWnRI7ViLb1MVdb0JgihnpGYtwAbl1F
         xLAocLciAwklAg8tXJxbCuN81IQHpukbq9IkHQ7LxEUhcHnGqnDz3WGKx4uQ5JbnDahQ
         dXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=venjkIokm8GSX2ge2Rc27dt76cxYVR85slS/SbYCDaI=;
        b=IXfLUX/7rWYmGSr0o5Q+pYPLfpiXmhDdZyQl+XEqcsyz8f8gFxct9nupEb9C12h1oy
         NPJhYSYN/iV7BZY8qtG7fLlC/yppSeztW+8Kwk9h3EQ5THBo7BO/puyXQPqn/HgFnpNQ
         lMlXtFoST1pfGDH3pNItQaVLn/daCx5pHR+qWBoeOPjGs30ylj1hGzHcxHgBalLC99PT
         kwK9ZtjMydbzRUEUtBxZuWGqEQunINuDvK8fkEuIuKPCLBJuQ5uL0X+GVEfrP0hCjxuf
         IEBPJ5plLn0YOS9VPb+GV6/3xPsI2maUXZsFvsId3B9kNaEK6FIT8xkSeftNqyre4Mb4
         ZgRg==
X-Gm-Message-State: AO0yUKVlXx1RxJ69P9uUtVHk1cZ6Q7mPHNfeVUrahVXlzlbM3YlRmClf
        72CrhXEDvnYScCabYbQWoLsmgQ==
X-Google-Smtp-Source: AK7set8O2VSqgwAnq/imhIlGDJngF7y0agxJuG7tVFHHKetGgD5yTpJ/duKxSgrL/CZ9LsS2rTAzRA==
X-Received: by 2002:a05:600c:1656:b0:3dc:46f6:e607 with SMTP id o22-20020a05600c165600b003dc46f6e607mr13468231wmn.3.1677330718912;
        Sat, 25 Feb 2023 05:11:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b003eb3933ef10sm823506wmo.46.2023.02.25.05.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 05:11:58 -0800 (PST)
Message-ID: <23f7e0d9-32e5-654d-9b4d-84c91f833b2f@linaro.org>
Date:   Sat, 25 Feb 2023 14:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com>
 <76395d89-1c56-12b2-b6f7-e77603019b70@linaro.org>
 <e9da7a1e-d48f-014b-a0a7-841c77feb12f@gmail.com>
 <9a25020c-de26-5c1d-f7ff-c2dbb38d3872@linaro.org>
 <473e0ac5-f12a-c66f-6696-8b7fe6e540f0@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <473e0ac5-f12a-c66f-6696-8b7fe6e540f0@gmail.com>
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

On 25/02/2023 13:48, INAGAKI Hiroshi wrote:
> Hi Krzysztof,
> 
> thank you for the response.
> 
> On 2023/02/24 21:53, Krzysztof Kozlowski wrote:
>> On 24/02/2023 13:28, INAGAKI Hiroshi wrote:
>>
>>>>> +
>>>>> +/ {
>>>>> +	model = "IIJ SA-W2";
>>>>> +	compatible = "iij,sa-w2", "marvell,armada380";
>>>> It would be nice to start documenting the board compatibles, at least
>>>> for new boards.
>>> So...how do I do that?
>> Start with something like this for Marvell:
>>
>> https://lore.kernel.org/all/20230222203847.2664903-2-colin.foster@in-advantage.com/
> 
> Oh, got it. So marvell/armada-38x.yaml needs to be created from 
> armada-38x.txt like armada-37xx.yaml.

I don't understand why we need three or more files... all or almost all
platforms are having them in one file. So just merge them to one.

> 
> Questions:
> 
> - who should be assigned to "maintainers:" in new yaml?

Maintainer of platform.

> - should the old text file be deleted when new yaml is created?

If you convert, then yes, but we did not talk about conversion but at
least starting documenting the new ones.



Best regards,
Krzysztof

