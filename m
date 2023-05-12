Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE6700931
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjELN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbjELN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:27:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D02D78
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:27:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso576717066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683898074; x=1686490074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VD5PcTi8VRrp309PpMLfZ3kC4zNdkYyEF/2ynI3Np6c=;
        b=LzKkn9tpFvC6MnnHF8L1tUBeeNVYcz/FtSNzmeQHFwAsTPyT+P8ziZxh8PeVgejysC
         BOIskHKFDgq/aGaatCvrsH0WfjHVWnssIXHoM+YlFphVe1Yr5kXCTJayW0mt5ri9TXKY
         6PfQt7mUsdtG3TvLQqFkHxgBJHz3vTaorBa9CH9wrZ5XjBhsuOW8bgGgkpNqFVTbLCLP
         I8XnpKa5MyjgtUv9xLK1AIYwdGcJdAe+E5PJVsrSkOUmg8HMda99qV7hL81eCTn5SHZK
         tpXb6fq/cDhw8w5Squa+m0IMS7sGS65nQTZr5U8oLW1lzTYUMISUTcCtkC8l1fsjbhVn
         yDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683898074; x=1686490074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD5PcTi8VRrp309PpMLfZ3kC4zNdkYyEF/2ynI3Np6c=;
        b=Be1qjEiF+DKFSGmueg4oJ9FKSHwG3UPH8LvI/XoXqE5rKa1ggb1mcQyDf37+kCqqx9
         b9WDIunbe0iSR1S/53oJlkShXEjezOnYcKRWIClXRT1uowsfMdG2tmj484JFifHUKwj2
         Vm1fd2AP80ZXbwn/J25A4B2HgluJiY5AK087CL9zDvIVeNhh4q7h3G//QHp6ox1VcyNi
         grACSot46/wt92EGJsb4TSNfv57ajr3zoC56P6MlIwDQI8mENVE84Pizp59qtM8pux4a
         GUQI6hpwDeqh++AN9IXcG6sj7lGh9VoKCqEoieG7q2ytykpT0Q2dOlRzROW40R1rw3We
         4hJQ==
X-Gm-Message-State: AC+VfDwwMLZgry/x6h9HGi+TCpKnFYPEzQkuffHOvnLr7yohwxckfVNl
        Ydocwyme8/gwn+MaaOm0xzBihA==
X-Google-Smtp-Source: ACHHUZ7yZELRHb8K60z3dD0fa2TVHOYnjrcFMdiAsmIUWvHn/eq/ileKnFYBrVCTkGoCl27r4Yuagg==
X-Received: by 2002:a17:906:58d2:b0:956:fdb6:bc77 with SMTP id e18-20020a17090658d200b00956fdb6bc77mr26692954ejs.30.1683898073754;
        Fri, 12 May 2023 06:27:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm5369619ejk.134.2023.05.12.06.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 06:27:53 -0700 (PDT)
Message-ID: <d65fb9b9-2fa8-7ec3-e577-eb93764e7060@linaro.org>
Date:   Fri, 12 May 2023 15:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/2] dt-bindings: hwmon: add MAX31827
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230512142050.12204-1-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512142050.12204-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 16:20, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> v7 -> v8: Added '--base=[Linux 6.4-rc1 commmit]' when using 'git
> format-patch'

It does not make much sense in your setup, look below:

(...)


> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> prerequisite-patch-id: 7a4b4994760cfa8c07187d319e53e9956a8b639e
> prerequisite-patch-id: af1a81cb4ad3137780afb102586a3489f9615303
> prerequisite-patch-id: a4ed1db487f0ee9506b3aa7bb672595a7b793cca
> prerequisite-patch-id: 421416a1110c5cc09e11afe2db6528cbca6d9492
> prerequisite-patch-id: 8ced9e002e35952cd614acc0e2108f17a502a5fc

All these commits are unknown. It will not help us to create proper base.

> prerequisite-patch-id: 82d101227b696dc95c11bca8594f80b438537359
> prerequisite-patch-id: dfe7b1d583daa8dbb2d2af8fc993622b65f83826
> prerequisite-patch-id: 431a19e35c672a668b696858eace775c56f1e1e7
> prerequisite-patch-id: 0b485820cf1c980bba3adedb9fd88b87ee3cc157
> prerequisite-patch-id: 8d767b2e1313428538bea1490032f639cd1ccff1
> prerequisite-patch-id: c1ef543ae6716d6ccad416250ca68c8a0eec058f
> prerequisite-patch-id: 4c78ac1e346676b76fd8850f8edc2b08bdb78f52
> prerequisite-patch-id: e6fa20eba19f686b0f4133b1c7bd5894f703498f
> prerequisite-patch-id: 83d74aa2b6f8cfefeb14dd5e90705982b952a757
> prerequisite-patch-id: 4ac1c2c31de74af80624f66489fcc87e533dd32a
> prerequisite-patch-id: 77a377c5214f2cddd3455d1fcda34ccf28973883
> prerequisite-patch-id: 2edf34328d29191533344d36f43abdc7479b4ae2
> prerequisite-patch-id: 77e8f55f78744797df7efdc0d2b18740cfe099b9
> prerequisite-patch-id: ab123ba97f1abe14016c30fae72b55a87363d5ef
> prerequisite-patch-id: 7323aaafb0edd7edd51a5c6f8be1bb275f9dba9c
> prerequisite-patch-id: 4a61b49c7ab4522967fd122f8bf38d679022df57
> prerequisite-patch-id: 869ae6fe33242cbc0373cf1e1e92c7b240f9e1ee
> prerequisite-patch-id: 12f8d3b3d21ea08368246f7cf3d42ec920297953
> prerequisite-patch-id: 3cdfc61d4d0aa70f68d095a7df4e814259e9cc47
> prerequisite-patch-id: 726807583bfd50c10a1090f067261266efbc6aa9
> prerequisite-patch-id: eea50a388d43e8447a5ef2969af5df7a354e356c
> prerequisite-patch-id: db216360c53cefee67966e28397efcd0591601e7
> prerequisite-patch-id: ff327329d945c9502df11b15f4d037d355bee546
> prerequisite-patch-id: a197064fc6a5e20d4c9ef5f508491b457d2564ca
> prerequisite-patch-id: c0d5d63ae43075a035a632d61975ad1e1bba4e69
> prerequisite-patch-id: 2c4053f5cf0ab2707bd528a36a926f49d3e678ba
> prerequisite-patch-id: 2bc0059cb68aa397ea841c153b2f6bfc4e998de8
> prerequisite-patch-id: d5e64ab8afa8a2761a51ec295709ed25b65f450c
> prerequisite-patch-id: c8d1ca12e9e502f366bf04d98b1011b299433d65
> prerequisite-patch-id: 955a12cb7b43bb60c913c097f58c6bd6d131962e
> prerequisite-patch-id: 142599135b7ffa62f14d96755c3a5c2db45140b9
> prerequisite-patch-id: d8415b405107d9d024566a415ad1b03a4606f9e2
> prerequisite-patch-id: 0ecb6a8d2c011477889ba4db43a79fe8b0031b5a
> prerequisite-patch-id: e755275a6776660db45f4c77e83100df26b714e6
> prerequisite-patch-id: 61989ab7e10a1fb21144ae314bb01772fceee65c
> prerequisite-patch-id: 42f546d2579f59ae937ca266ad104a745141317a
> prerequisite-patch-id: 8b3afdd0e40d71a10a8170dd1be45232838cea0b
> prerequisite-patch-id: dd4a4ad7eed59aff993717ec6e4552e2220125a2
> prerequisite-patch-id: 02012f5d2e0f147338b267a23ed715ca452ecea4
> prerequisite-patch-id: fff041f18c7d7b462d4b4c89ec5259e19ad07307
> prerequisite-patch-id: 419d0a8254089778c04f24cc702caa3d365ea375
> prerequisite-patch-id: 4bcb80ddab7867c8186f340897583aab541642a8
> prerequisite-patch-id: 2968cce365bedd0affbb1d3b2fbf41dce3027de7
> prerequisite-patch-id: 075f35a92da9f1df4040e2ede8904016276a72fd
> prerequisite-patch-id: 435f2b1401e4d6bd611b1467dd95619cc58f7e94
> prerequisite-patch-id: 3da11fd73cf9d6eb84a73fe2cad1865869b02506
> prerequisite-patch-id: dccbed28650f98e89823e795468752613872c3a2
> prerequisite-patch-id: 04589ce94898a31f50e44bc65065644651cd37bf
> prerequisite-patch-id: b72c5f8e20711683185cc841913502fd0ee4e9c7
> prerequisite-patch-id: a0b0736241e379dd9183620099389193118ab36e
> prerequisite-patch-id: 57993217073c627364964ff45e9bda1f6466ab2c
> prerequisite-patch-id: af1650070543b7eaa9196015c3ed80d02434c33f
> prerequisite-patch-id: 72b63d356271003082e578ffe7664db8cd79086a
> prerequisite-patch-id: 895a854faf88359013784d2b63c17876ae2afeca
> prerequisite-patch-id: 0957d914360db266f0a8434542516e187739d53e
> prerequisite-patch-id: a5c3cf2b3336198b7d7cc511d94b6dd093e0280b
> prerequisite-patch-id: 0db3a4c3a542799cdedd61aebf4e8ae876674173
> prerequisite-patch-id: 296a53f101dd57c4f932a70c57ba38fd2b787c17
> prerequisite-patch-id: 0fd3d04fcb0a3cac132e978f3debbba16ae04a02
> prerequisite-patch-id: fafa7c3b6daaf039bd60f5164cd2afeae88a2958
> prerequisite-patch-id: c8dede88dbfb842524a21c61dc1adbe6ec2d5e2b
> prerequisite-patch-id: 6c03e7d35c4f81bfe0f7897d40738c4ddfeeb327
> prerequisite-patch-id: 95a510d6e4a37ae1fa3e6718281ba7f8bf296578
> prerequisite-patch-id: e484fc1845969ef3556e47bd7923f827fb0314a3
> prerequisite-patch-id: f3a231db2fbb4575045b246a0639af8ddee51743
> prerequisite-patch-id: fa976c8bcea009372c77a66d31471654dedd1b9a
> prerequisite-patch-id: 93cb412ad243b4ce378ee2cbaf842573091a7939
> prerequisite-patch-id: ae93263bd307ec0709b73f2a5e27fc62e7d66c01
> prerequisite-patch-id: a412aec7b2a33927a1fba5639ba65ee4b6fbd06d
> prerequisite-patch-id: 5505ba1ffab06c2c65aece8f67c3fd622b41bbd9
> prerequisite-patch-id: 49cf1b6bf4557be2664aa732c4dfec09d49f4223
> prerequisite-patch-id: c36e546a903a76df4f347852cf98bcb5a5bd9ef3
> prerequisite-patch-id: 91d94d46d985d5223d7990c3c4b56e564cd1b29b
> prerequisite-patch-id: 4e3b1188de3758e6f78159f419dc8cf878bdc758
> prerequisite-patch-id: adef43035108d6d0803b33ea47e2479d48768d74
> prerequisite-patch-id: 6574822878421fa57e477c1d03eef02f1d1c99a2
> prerequisite-patch-id: 814de8fe08a1a87455be7999ff2b5a9b16172ea7
> prerequisite-patch-id: c51ad04c37f0c394ddeff7a6a81ff11ec79cc337
> prerequisite-patch-id: b574d288c12dfa34cd28e7a13f97dce1ac49c5b2
> prerequisite-patch-id: 9eeeb28a9379c54ed7df313427586d22c3fa2b0b
> prerequisite-patch-id: 4e3917a7957cb01a7fc16786896437db15cd2f37
> prerequisite-patch-id: 6c56a4f9cd863730d6a373252a89c168144c74fc
> prerequisite-patch-id: 35ba8113f4a35ed06fdced77b486beebcf832051
> prerequisite-patch-id: bacc1b8d2c13f0e3d5b9415f137d9485790bd02d
> prerequisite-patch-id: 120f0081316830ddbb2a578c84d2fbb4d0a0bbf6
> prerequisite-patch-id: c07ec668fd051742fa7c95c3837757a46e61c506
> prerequisite-patch-id: 5e19ba08b46189498be3887fed503a948ac45fdd
> prerequisite-patch-id: b80fecfdf09d662023b8aaf2172ff233e4dd6e3c
> prerequisite-patch-id: f26f40b3ad3583c79e0e1e1a96e097858eba5969

The patch is fine, but whatever build failures you have, the base is
solution only if they come from patches from maintainer's tree.

Best regards,
Krzysztof

