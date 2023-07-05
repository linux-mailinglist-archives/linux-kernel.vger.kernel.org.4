Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34326747E29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGEHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGEHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:23:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032810C3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:23:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9891c73e0fbso77422366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688541825; x=1691133825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfHsvDQ9gANPVD8NJhKIViMe2g10IPISfPCqc4m/wEU=;
        b=Kfs3hrRItqd9Y7BwC9buaitUGmo3La9s/LDZVVR/eZeWRl8IXBxJUGjPl7VVSCujc4
         mfprd+UZdPsiwiDulfVUBm42k3zIZFk2c4fPArW5zrAVI2Dabho9AZK1IHJMrTm4QxVc
         BJoNoUgcnQzmsm2UgcJ8fyOd/nky2Btk6Zg9nTbQiAK0zAD+h+1JMkW0tb62ZT+Cl9TN
         mywdoYAQe5n8zGTXANOeEHAh/Yz/tZiJoE1zmbIHzulY024fkIX501zAcRVU2asSUpfF
         xCoLzDOtM65yiuDgTzccaVxxRbur+k4Ym9PwPejDfPX84e8pyjbzfUd513EFn5tjvj7v
         38jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541825; x=1691133825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfHsvDQ9gANPVD8NJhKIViMe2g10IPISfPCqc4m/wEU=;
        b=FixoC6vC0w1FzWVZNuAZ6JMDjGTAhioR2fjscQMUo+m3QGBHpdmmNE5ggOsd0moQb8
         h/K5+2bS5jeSTPJyFsZoyezpkx8vIg6+3dvWRFp/J6vPTGDUZyjLwDDRWy5R0bKvoj1Y
         oYyPJsCzx1IFHc6IWPNyLgJZ6N6kTywoB0r+CMHrJwmx5UxWvbw3D2rn8WJ1SIG8V8L2
         NPf95cSMI6FkiJdK7wQBz9XDILtCibYfGy1Lff4VXbr0XcBRJrnooRdNIUESYyF/h8Kh
         iZqQdFFHppAq3LYruE08nihwhrMvH19OeIYsxdZw7FXLqtRIn4sZfqod0dVuLV1sXj3u
         rxoQ==
X-Gm-Message-State: ABy/qLYrp/l/xMGo+7/MyomYh8SSSTwhr3HvD6I9rOH8MmlojK+Sta1P
        YHAytwj5IZUBqLzPNGbJtHoPIA==
X-Google-Smtp-Source: APBJJlHFN29jfTiNUx5sFWnNBEOCkG12dMSYS1/ng4NNgeX2L9P1cSy+erlCNqaNEgJair2vOCiZJw==
X-Received: by 2002:a17:906:2d1:b0:98f:8481:24b3 with SMTP id 17-20020a17090602d100b0098f848124b3mr1189990ejk.37.1688541824853;
        Wed, 05 Jul 2023 00:23:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b009929d998abcsm8546834ejb.209.2023.07.05.00.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 00:23:44 -0700 (PDT)
Message-ID: <175d03f6-122f-bbd2-5d38-61fe4022c5cd@linaro.org>
Date:   Wed, 5 Jul 2023 09:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-3-william.qiu@starfivetech.com>
 <808dac44-a72c-4675-1e4a-0ed96190efb4@linaro.org>
 <90b55926-1d0c-b9c0-3020-5837e2028809@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <90b55926-1d0c-b9c0-3020-5837e2028809@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 09:04, William Qiu wrote:
> 
> 
> On 2023/7/5 14:21, Krzysztof Kozlowski wrote:
>> On 04/07/2023 11:04, William Qiu wrote:
>>> Add QSPI clock operation in device probe.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/
>>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>>> Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/
>>
>>
>>>  
>>> @@ -1840,6 +1858,8 @@ static int cqspi_resume(struct device *dev)
>>>  	struct spi_master *master = dev_get_drvdata(dev);
>>>  
>>>  	clk_prepare_enable(cqspi->clk);
>>> +	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
>>
>> Don't add compatible checks inside the code. It does not scale. We
>> expect compatibles to be listed only in one place - of_device_id - and
>> customize driver with match data / quirks / flags.
>>
>> Comment applies to all your diff hunks.
>>
> I'll use "of_device_get_match_data" to replace it. But the way I added
> reset before is also by compatible checks. Should I change this place to 
> "of_device_get_match_data" as well?

I don't know what's there, but in general driver should be written in a
consistent style.

Best regards,
Krzysztof

