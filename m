Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50185E5B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIVGrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIVGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:47:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE3B6D26
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:47:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i26so13026701lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pxOUMi2UlNuNZNBfBYrU6Nf39rmJtF0e2MNNct3zImo=;
        b=vk1GuB2k4kmJdpMkTG4B7+OVahxU0ZUd6kIXxWgoP9V42D5i1SrhBqxiirtcRKcZqq
         BCbNctyioKxFEQAhmXvM+E5clDZZAoicbDe/x+7/FaVBK6oo9OxDaYiWT4kwClcRE2So
         63ggoSk6jAnUJECMY45z97Kju1xzn8lzGPW0+xRR/Zq7GW1+Xa93ySFNLxSaajG9z3J/
         +meywODDAS6WPee4PcMaG3eaevESx0+1gmFJlv/hBVZC60i1RTvOpMUSlYIGNZEGeCRL
         kFIg9d6WpWgMt6wj7KISVouHHkxaCMC4HvK1W+6qeI2odLKuNczX3fAZsoiDvTdtqEag
         yuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pxOUMi2UlNuNZNBfBYrU6Nf39rmJtF0e2MNNct3zImo=;
        b=uRjtexDuXYLONBieOVNMbjoF2sY0qzxaQF9m5K+2x0HSvKEoilAYd2mM6hn+nJmlwQ
         OOq7RMI1mWOigii6y1RoMlqN47yk1iynHkXQa/bHWyWiHpI80UQOStJVvUkJ2wOOQmGu
         Lu9cFY2xG91B2LiR9JmIPDBz5YsAARVTSU776dlzkoVv90ahA02Fpc+wO+Ztm8Y3WZoM
         Z2BHsWTGPVCshmi5i0xrUuM31sLvMtHWJlNOL0m1QE2mDqYyREd24f12lS3aut/Ra8eL
         VPldkpUEeVS3WiLpsJIAG1qKyQUFKn6g5vbNAKRte1gwdAD0tNBeQA2d8z0HSeYIZvme
         KYUw==
X-Gm-Message-State: ACrzQf1teJAm9fH4ASzC6UL1CM7Mlh8Hks41vkE5R5fFE9pkvftF+XDL
        aunzjnCvuBky0tQfo6enqAIhJvq/EDx8Bg==
X-Google-Smtp-Source: AMsMyM4MYGSd6TlYxlHDNat+xh7DY9HHdMhnES4FG2AUReeGbG1VnfcySuyKxUSSFKjCwz1VpzjPRg==
X-Received: by 2002:a19:dc1a:0:b0:494:903a:1fa8 with SMTP id t26-20020a19dc1a000000b00494903a1fa8mr660247lfg.55.1663829235551;
        Wed, 21 Sep 2022 23:47:15 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a2-20020a056512200200b0048cc076a03dsm778352lfb.237.2022.09.21.23.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:47:14 -0700 (PDT)
Message-ID: <035f5834-6fb7-95ba-1569-6dbf8eface49@linaro.org>
Date:   Thu, 22 Sep 2022 08:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-2-aladyshev22@gmail.com>
 <20220922063514.f6euqlw35jrkpee4@krzk-bin>
In-Reply-To: <20220922063514.f6euqlw35jrkpee4@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 08:35, Krzysztof Kozlowski wrote:
> On Thu, 22 Sep 2022 00:09:46 +0300, Konstantin Aladyshev wrote:
>> Document AMD DaytonaX board compatible.
>>
>> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1680833
> 
> 
> /: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dtb

Ignore, this is not related.

Best regards,
Krzysztof

