Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104DF6BE1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCQHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCQHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:13:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE452F7C;
        Fri, 17 Mar 2023 00:13:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw3so4412230plb.6;
        Fri, 17 Mar 2023 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679037223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rS8vmgsmQUQexeshG8mg626xwm1wz51m7Q+8asY/2Rw=;
        b=dhf4sO35yzWINMqYFOfO0OiEfnkf/Ms5Tso+UVfgZtZ42r+r1xIn4kJhUgYmKxeJ8u
         h3FwuIt3itmFdxlFgYinuYSUk0xEqo1ee3o/qqq9lQ8ZkyZpCgg4mUFE9EFIUsGkBlYl
         t3/UgPnDTOaqqkSqGZoy26MXGe9NkqMR+RD1pBgNfyABMSxnBmIkQ9EHDiRfFP36QnOl
         icyehwAC9hy6osr8EvZdfagt48ecy1B4eYDuW55L3ZdWMtTEM27V4sRSiws7WGUdAqHt
         zsSWCvMjrWr3YZ41EBOcLCUMtmiuHIrKLRHDiBIECDZwlsav3sVw0KxN4pmnqKD28Lor
         /Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679037223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS8vmgsmQUQexeshG8mg626xwm1wz51m7Q+8asY/2Rw=;
        b=y3C2Y3wQQrWdylZhJ5dERAJeHcz1J1WHlTu1S0dZtvtfXB4Qdm3010HBMdjNnq4MRx
         IlIBk1xsOr7v8Z6tnWpVX00BoaQCN17QiLHE2a1wI+Be51ZLh0LGRo960sfSymZjIIXP
         KPwgFtT9WL0DioQOTT8OUKJ8aZUR2uBByJ9Grzby0bG+iINwGZ8rdHsn3lH9rvhUW2kP
         7QCYAnP8KY5nHtjy+zzritkuTnestk0wS33WNKOpiTEtJaetYE87AUijgJ0fk8XBG2xf
         kmiHGoegCBbtG2zY+aH5FI7V9FVdvwqoOYM6zaEfjH669iUdjGDK+fcQIIBYK4NKAd4i
         sXTQ==
X-Gm-Message-State: AO0yUKX/i5UcPMUQcfoSwzILyid1669IqUpE+B5a6RMT2GnacB9pySun
        1V/X3FnJhOlKEySloPaYdwQ=
X-Google-Smtp-Source: AK7set+ragKq/pQ1oF0HYlPS9kQvnXfjm0DjLY6PdurywOwCN6KVkYzJcWX/Km5eamNV0UdUUIq+bw==
X-Received: by 2002:a17:90b:350e:b0:23d:3f32:1cd5 with SMTP id ls14-20020a17090b350e00b0023d3f321cd5mr7053391pjb.26.1679037223289;
        Fri, 17 Mar 2023 00:13:43 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709029b8a00b0019a7bb18f98sm853322plp.48.2023.03.17.00.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 00:13:42 -0700 (PDT)
Message-ID: <1120263c-60d3-d359-5e68-d922fdc20c87@gmail.com>
Date:   Fri, 17 Mar 2023 15:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Jacky Huang <ychuang570808@gmail.com>
Subject: Re: [PATCH 13/15] reset: Add Nuvoton ma35d1 reset driver support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-14-ychuang570808@gmail.com>
 <cbfad8ff-fe52-4e25-40d8-84ff43f5c3ad@linaro.org>
Content-Language: en-US
In-Reply-To: <cbfad8ff-fe52-4e25-40d8-84ff43f5c3ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


On 2023/3/16 下午 03:51, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:29, Jacky Huang wrote:
>> From: Jacky Huang<ychuang3@nuvoton.com>
>>
>> This driver supports individual IP reset for ma35d1. The reset
>> control registers is a subset of system control registers.
>>
>> Signed-off-by: Jacky Huang<ychuang3@nuvoton.com>
>> ---
>>   drivers/reset/Kconfig        |   6 ++
>>   drivers/reset/Makefile       |   1 +
>>   drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 159 insertions(+)
>>   create mode 100644 drivers/reset/reset-ma35d1.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 2a52c990d4fe..47671060d259 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -143,6 +143,12 @@ config RESET_NPCM
>>   	  This enables the reset controller driver for Nuvoton NPCM
>>   	  BMC SoCs.
>>   
>> +config RESET_NUVOTON_MA35D1
>> +	bool "Nuvton MA35D1 Reset Driver"
>> +	default ARCH_NUVOTON
> || COMPILE_TEST

I will add this config. Thank you.

>> +	help
>> +	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
>> +
> Best regards,
> Krzysztof
>

Best regards,

Jacky Huang

