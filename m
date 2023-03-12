Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC456B6BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCLVOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:14:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6827D63
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:14:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so41108138edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678655685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZ9la0oJabKkUlhSJxtNntN3YhdmaYBpeFktFP6comw=;
        b=er8yjZT3F0TproMMvT5neGO/8GGMj5B/j+UedSbizxTiSobBvTodRRpjtfJfvhcF/M
         RGEnf6PcvQ9GHP2Cin7rpoiboQFoTV22ytKbN0BbcSKhc+N3aOIQIIWZy+0Et+1UXdrY
         nu5EVLbKd9HZVJUIA0vR927m2z7yzUHWYEmJNRvpd0EMCtY9D14dXSdxx4Gg8JeQX/hM
         N2XTBpPJHHD5vRLglTVSrQ4fVXd4+MISTEow4N67dNe1j+jV8ZY9cJLkNG5t4oAa9UeV
         WaFLYuWbgbmRCGOqjvRoIP2KECZ2v/jnd64wrXMvZh3ARQEe7RzYywlqjfmGcloGDmyA
         OLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ9la0oJabKkUlhSJxtNntN3YhdmaYBpeFktFP6comw=;
        b=NOSyBHwRC/438R+3h1srY5gr9XeFlyT8zhaIAdnb67YiQARMY8bUUskGEadeGOTgNR
         sOJjBcODUY7260t/kAWSP9S1Yoyyn98pXvTvDJczsy0ciq5A0Oyi1ncbHQb7CNyPReRd
         6BU3IS2+1My4R3KzynyY7lJeooaOMARm3+DLLbqre5+68I4VrpAIpK8+DZVNi0Lh7AV8
         m/UguvoGMW3sRmVF56ncvKjpqiF6sSLgvcarOs7olwOQZ/dD+Wbu4ck1dSrPd9v+yrNX
         OE+iG31L9xjKZIlrBAwPRZNrUORFBzpI4zIts+bJfZwVre4wwKJlt5X9K401WGpDqshS
         bxlw==
X-Gm-Message-State: AO0yUKUFQA6Vofr7RKeLi9ydUJl1y+udhXlSCEZxeiakWuQLxzeHSy7V
        Qvtp84EQJtFBzlvECwkVNAKbi13DUQw22DhNGzE=
X-Google-Smtp-Source: AK7set9ytvmNobGpn73pug7++tcIsIHe4WoiUMx0M0HAOOZhwv4JmCaJcoKsZI69syXavyfi0TYfrA==
X-Received: by 2002:a17:907:6d91:b0:878:58e6:f1eb with SMTP id sb17-20020a1709076d9100b0087858e6f1ebmr39217301ejc.23.1678655685671;
        Sun, 12 Mar 2023 14:14:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id sk15-20020a170906630f00b009079442dd11sm2596867ejc.154.2023.03.12.14.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 14:14:45 -0700 (PDT)
Message-ID: <92fc2b5e-05fe-4f69-916c-82795b0d0db2@linaro.org>
Date:   Sun, 12 Mar 2023 22:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
 <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
 <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
 <9343421e-d35d-8d99-1ea7-1f81e28fbabb@roeck-us.net>
 <688b6817-9d57-6c92-1ce0-6f97cb8c4cc2@linaro.org>
 <062a2834-ece9-49ed-0e15-30730b65ef50@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <062a2834-ece9-49ed-0e15-30730b65ef50@roeck-us.net>
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

On 12/03/2023 22:03, Guenter Roeck wrote:
>>
>> The driver would not built. I mean, I did not cheat here to built it
>> with incorrect config.
>>
>> I rather suspect that config is broken due to:
>> WARNING: unmet direct dependencies detected for OF_GPIO
>> WARNING: unmet direct dependencies detected for GPIO_SYSCON
>> WARNING: unmet direct dependencies detected for MFD_STMFX
>>
>> This was next-20230308
>>
> Interesting. That has been fixed in next-20230310, where
> SENSORS_GPIO_FAN is again deselected if CONFIG_OF is disabled.

Nice, I picked by coincidence lucky base :)

Best regards,
Krzysztof

