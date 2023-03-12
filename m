Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABD6B6A15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjCLS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjCLS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:27:36 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257859E57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:22:34 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id k10so40072646edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678645230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQyFHU+PDg5rIzHHbKNfiNiaCBRfg6+xiVlzWocsZCk=;
        b=ENtKxsvL71njxsqQa4aj8WdWCoVeM/YOb1iIKl9rfL8eY9fXJv9DaBWWvaLt9dg4D0
         kX8o6gb9xubLHpg2Vx3n5BDngTaSRSLBa5+c0Pk/lGEYklwtaZJSR+Ie4jAmKhDJ/D7p
         qI6k534KPi/saVMtgJUgy94X4hcDVl3ua+mX4xLnP/W0G6BMaUb2WIEcbY0CKKsRtUDX
         mdDGB9AGHKpBBM8r+oLX6vlw2ZIpA59svouglPdN5w5ah+jaMeubywf5JYQCHmimDEkh
         zpmHxDekkD/U5ly2vVSfixCEJaW9mlJpn2KbDSgr0TTcGOIrm0RAGKGBXXox9ZMH7jht
         0n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQyFHU+PDg5rIzHHbKNfiNiaCBRfg6+xiVlzWocsZCk=;
        b=ta4qBiNSvUdTXM4RZ7TNGeBdy8Ge4H5uZEwtGPrAoCad7phz04cL8max8rXJ4gYd7y
         JK+8NdRf/NRUFlYeIIPNGk4Ne7F29xNEEGKroFTcp/w7beFjHetWF7yEPBldg5d7LUMD
         KYZsnoDzfiRBxLJkw9q0yDuAQu4BF5uY3drKM6oTflwzluE/SrFw1DiyT8ybw6w9H2ji
         EeUCCrlcqxsVh0+gZAPW/ECOUTNhrKPvxv3RQcbQuoUofWtUjudIDvxiSK87Bv+Rq8cV
         Jimt0Nd39xbCECmjIwDaAheI3Ma0yFLa315+/UyBmXQypOHDUsR5p1R5sPlnQNLgBUwR
         68MQ==
X-Gm-Message-State: AO0yUKVYiSEFrY0HL8/c0deX/Dl7nB4z+nf2R4tT0sQeG615Lph0Db9/
        AC2BUUz/vpiz9Hdm0o+5IlsJ+ZIsVocclC7FKhk=
X-Google-Smtp-Source: AK7set8GMUxrCVnfjDOZ40HQQuFO9Inwtw5gLPjZu0jDjgvT6N+rgZdrXrtrOdJjw76bWjY2yz03Rg==
X-Received: by 2002:a17:907:a581:b0:913:f170:c0e with SMTP id vs1-20020a170907a58100b00913f1700c0emr23363397ejc.20.1678644492712;
        Sun, 12 Mar 2023 11:08:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id sb26-20020a170906edda00b008d02b6f3f41sm2446028ejb.211.2023.03.12.11.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:08:12 -0700 (PDT)
Message-ID: <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
Date:   Sun, 12 Mar 2023 19:08:11 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 19:06, Guenter Roeck wrote:
> On Sat, Mar 11, 2023 at 12:16:09PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
>>
> 
> How do you trigger that ? The driver depends on OF_GPIO which
> in turn depends on OF. Arguably that means that of_match_ptr()
> doesnot really make sense, but still I don't see how you can
> trigger the above error message.

I can drop of_match_ptr, it's indeed in many cases not needed.

I just build x86_64 allyesconfig minus OF, with W=1.

Do you want to me to drop of_match_ptr?

Best regards,
Krzysztof

