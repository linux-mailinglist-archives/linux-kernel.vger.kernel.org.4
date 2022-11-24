Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853B6374FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKXJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiKXJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:19:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FC1122DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:19:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j16so1610525lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJccgccyb+EDgilHyzIVzUT8LWA3KCS4EFgVZgSZ4m8=;
        b=hSyzXlBj6dz9FcnrVQ1MXRdS72trSrlT7/unwCu9LrWu6Uk9YsScLFyt+TE9+69002
         EIpOoDfQTXizwfBQfUiU+3ap9jA/S7U4PNkaPIfSmwevLcCIEDyGxb9hcvm/soYld08k
         +ETnz9/3EwWekX9AEAsa3ppnrdhknjLDCH+VSNU/sHcuRSxAA94Mo0e//qljYbEgzWnK
         EcY+yakAz2rHlJ9D4QsEGAuSkP6f8bzxEohvlN4dwnz8aRas1sOUFS8SOC+GyWH0MVdn
         /j7Td/I2xrudjmHHvSJijZXqd556caVXMc4l3ZddgBCsxvDXiHHkpChz75DbHfJhzCJx
         kCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJccgccyb+EDgilHyzIVzUT8LWA3KCS4EFgVZgSZ4m8=;
        b=z7V2Apof5/lM8mwmdwL+7Pb8PP9K2hlEwwbND1nyW0HHs75oqMm6vgOeO1z5/d0QVy
         WEWvwKuXtfHwxaavEvbdKD9WUj62s9oQGLlDuVd1uvS/y/9VT9YnDM070+dDpfiXtf+W
         zO8ZPhqHlEzcURXAE97LFKFtVNDsklo7SfahwpNqly8FM7e/eoTiGuD05Qy6Y7HnO6g3
         JTU18PBXXlA2iCBnuuYgNbht8rprO1L9OaT7ImrJnmF3OXbvJcSd0zgQ/BRgI7RkkDAJ
         mbsfgF7DQKWP84CjZNNty2P/teQwegxS+rTPC0aBbvQ5277x58GPEgFyzzztv/ZtSodz
         fPzw==
X-Gm-Message-State: ANoB5pnsFxvGaNErjaADYAWKsftodKwwfelrrmByiitYtWdYAi6DFhWC
        wOhzOpnkLOpJlDgTQB8Y01/Yyw==
X-Google-Smtp-Source: AA0mqf4aV9JDNfBISW/b7TmLrMhFaWYBJYE8Sf8k5oWOic6aPYZ5a1sxNm/fL4qPU+UDMV6fRU1YDg==
X-Received: by 2002:a05:6512:3ed:b0:4b4:f696:6dbc with SMTP id n13-20020a05651203ed00b004b4f6966dbcmr342182lfq.593.1669281594943;
        Thu, 24 Nov 2022 01:19:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u25-20020a196a19000000b00498fd423cc3sm60108lfu.295.2022.11.24.01.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:19:54 -0800 (PST)
Message-ID: <2751584a-782e-2bdd-b72d-4a726e6ede8d@linaro.org>
Date:   Thu, 24 Nov 2022 10:19:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
 <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
 <20221121091118.48628-3-sriranjani.p@samsung.com>
 <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
 <000001d8ff32$c8b78e30$5a26aa90$@samsung.com>
 <03a26971-e54b-a8e7-c02f-ae5a8feba71a@linaro.org>
 <001601d8ff41$231deaf0$6959c0d0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <001601d8ff41$231deaf0$6959c0d0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 14:40, Sriranjani P wrote:
>>
>>>
>>> So I can think of following two approaches:
>>> 1: For the time being I will put this sysreg node in between
>>> clock_peric node and clock_fysys0 node and clock_fsys1 node as per
>>> increasing unit address. I will clean up other exynos and FSD DTSI
>>> files and post a new patch
>>
>> Not sure what cleaning you have in mind.
>>
>>> 2: First I will clean up exynos and FSD DTSI files and then post this sysreg
>> patch keeping it at appropriate place.
>>
>> What cleaning?
> 
> By cleaning I meant fixing these dtsi files to have the device nodes in the order of ascending unit address.

Such cleanup is fine.

Best regards,
Krzysztof

