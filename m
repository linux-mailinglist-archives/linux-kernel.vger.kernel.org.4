Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6960C7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiJYJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiJYJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:21:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFA15CB1D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:16:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so11317780pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtV+tKTBeqXAnLa1ocBz79FGiw/ZEj0BMwzagYbLe8Q=;
        b=PsKXkZXtmWnp+tVBr/p7G56gTgPHRJ7OdWYL/NcRKOCEmu8gnt7U2oXn3m5MUzQ43r
         RUKwZRKvYvr/U1sE3qR/XG3dY/e3FXUjkf4hQMxxf/jpmAWA6aEO/X+drtk+cc98tr8Q
         GhmZPbnlbHM1vKB0WavxMbebvvz+3m0reWopqtBRjdMVeOsNW8xonhX83EJh4gaKJyU4
         KyQT0vZ5pk8k3sMwUpkyasSjX3QFzvjyy8vBXHogznnizUkfcNrAEA08ZoWbwRYc8g0H
         7Q1L4rtdhMr6CtdrazUvunw9YEGjAQlutnA90wuJCO7r1/2EGMOb90EmWChE2V6u1Jwj
         auUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtV+tKTBeqXAnLa1ocBz79FGiw/ZEj0BMwzagYbLe8Q=;
        b=mowes46gJfUXUDIgQHEK5g4Dm4qyxTxMlU0/yvIVIHkbfQUscnLrgDSOUoHHpuISt7
         /3wV3ebXIla6+wRUKsLxNRKW5TyzUHF+oOas1SvXYGV/7h2nhkcJf5KtH4m81iNNyiNC
         eeUaJu2NcP8AE+214X8doH3jOhBcAfqtWgBe5dWQN1NRU7UgECJIPKX9KEXNdrD+IKSt
         MExZOQsCYMEPJ6HixTXvO4HW6IB5k3Ku7tTM+x2A0H/v0GBOlkHr2p3sTsvJ4/tLFmPV
         OlIlKIVkrAhTSERUXigNgdXE4B3+JQLOnD+445CXPzQMWIvowFp7CoaR3SBNZrMBHx4x
         2T8Q==
X-Gm-Message-State: ACrzQf3/mOq3USKH7cOmZLepnvrKROy9m1/evSOdC/wwj0tLpfUrMzWh
        Y65FhsAAXVDUBO9G7opf6LD02Q==
X-Google-Smtp-Source: AMsMyM5OvGCTXaXrqqslumYN+vWkZa2LgvDCrTrp9wj2GwTyD9qpRpOgXJlGqqSaXk9Brq7WcSCCsw==
X-Received: by 2002:a17:90b:1651:b0:20d:5255:859 with SMTP id il17-20020a17090b165100b0020d52550859mr43501045pjb.185.1666689391302;
        Tue, 25 Oct 2022 02:16:31 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0016c9e5f291bsm879313pll.111.2022.10.25.02.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:16:30 -0700 (PDT)
Message-ID: <dcd22f70-e51c-290e-c11f-9a5ce32748c1@9elements.com>
Date:   Tue, 25 Oct 2022 14:46:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <20221013094838.1529153-2-Naresh.Solanki@9elements.com>
 <20221024161806.GA1855651-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221024161806.GA1855651-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-10-2022 09:48 pm, Rob Herring wrote:
> So if we unload and reload the driver module, it should go back to the
> default?
This is RPM to be set during probe if desired.
> 
> I think it is really, 'target RPM if not already configured' which could
> be keep the setting from a register (e.g. what the bootloader set) or
> perhaps you already have temperature information to use...
Yes. missed it. It should be target-rpm will correct this. in next version.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +  pwm-frequency:
>> +    description:
>> +      PWM frequency for fan in Hertz(Hz).
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  pwm-polarity-inverse:
>> +    description:
>> +      Inverse PWM polarity for fan.
>> +    type: boolean
> As I said before, the PWM binding handles these 2 settings. Use it. Yes,
> it's a bit of an overkill when the child is the consumer of the parent.
> Until some 'clever' h/w engineer decides to use one of the PWMs for
> something else like a backlight.
I would like you to consider this as something recommended by fan 
datasheet for the given fan instance.
This info can be used by fan controller driver to configure PWM 
source/provider accordingly.

If you still feel that may not make sense then I'll remove this property.


Thanks,
Naresh
