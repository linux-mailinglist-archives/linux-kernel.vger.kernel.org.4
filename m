Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509166A7067
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCAQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:01:41 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA643453;
        Wed,  1 Mar 2023 08:01:38 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id p8-20020a4a3c48000000b0052527a9d5f0so2169048oof.1;
        Wed, 01 Mar 2023 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677686498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGNflb0ajOkdmuY+LNebxSZ86wnGKRlkggqvuXEoVOE=;
        b=GveqTujHntdvzY+t7e93caxcSwCWvQI2xt3sgbt/+5qhoXVA+G/BICOf4B4Tz7+cFP
         qSxGzckK0v+FPQ0b6yncmYaJQKmUGJC1aE7iRR3AX5qR1jEwVc1hVkr9V1qit+21AxTG
         5zJ/y/Ox4Y1V2HnMZV435iPcSaQcygCmvdZuolgh2PQDfaIHmJZC29YDEYEIfN56QRmj
         47rrRjb4Mu7JS8k9SKd5+DQe43p7cS6K7iNtbOVmp2R6tBGL5VNT2HpmNgyQ8WDQLr3G
         4Yl/N0bBMgdZ8JcBp/2f/w5822hynYpPAQdGeSLUedHJu+t7PL1gfIfVWyyqxQxTPrHR
         ZpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677686498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGNflb0ajOkdmuY+LNebxSZ86wnGKRlkggqvuXEoVOE=;
        b=nx5Y71aRQZJY0bmelQc11GA9DKh4TPSi02R/TjmwwhkcQRd1T7M1NqhzqfPlZwL26O
         y8vztcRCgN6vynyT+08Lgweal2djBh4w5DTCXNlPwuYNAgkDzc1FRZoKV47U468bAuAT
         bUZPwgGRn1WdVkfJpn9S3DdCp94Nzy7o/WppoXGr13DfVa7ulLslTmXe+wZH1UqQNGqN
         ZMYqBAU5v/sxcTDx+3d2BXnGROYmojDIxACsqToVrAi6EWTT27v7ft12FcpBnd1tNn/D
         Oe3x737tKWWv0Iw2KUtglay7y+2QSadwVIllHxNhsPzAVU5S1lCeMmr4y7VmQ4EKyloH
         dcaw==
X-Gm-Message-State: AO0yUKUKCEhLVATjzvufPbFeffSoH/0W4WlKzmfgsSqnXea398KTAQqD
        h/fq2U+SqSp5FxaeSh5ZVBg=
X-Google-Smtp-Source: AK7set97rV3xBpkZ8iCWM8R3t/ott/t+7KacVVgxezD/hc3hZ+HJ/kopNrOz4TtMbQro5VAdxHodMQ==
X-Received: by 2002:a4a:ce9a:0:b0:525:2f4b:db55 with SMTP id f26-20020a4ace9a000000b005252f4bdb55mr3323106oos.4.1677686497833;
        Wed, 01 Mar 2023 08:01:37 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:488d:18da:bebc:d316? ([2600:1700:2442:6db0:488d:18da:bebc:d316])
        by smtp.gmail.com with ESMTPSA id 13-20020a9d060d000000b0068bcf7995aesm5054522otn.64.2023.03.01.08.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 08:01:37 -0800 (PST)
Message-ID: <96cfd1ee-768d-cc03-53dd-35ccf2396863@gmail.com>
Date:   Wed, 1 Mar 2023 10:01:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] of: unittest: option to allow tests that trigger
 kernel stack dump
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230301012116.1488132-1-frowand.list@gmail.com>
 <20230301012116.1488132-2-frowand.list@gmail.com>
 <018f54ee-55cc-e30b-4595-ce555fff1708@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <018f54ee-55cc-e30b-4595-ce555fff1708@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 22:07, Guenter Roeck wrote:
> On 2/28/23 17:21, Frank Rowand wrote:
>> Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
>> some tests that trigger a kernel stack dump.  Filtering the boot
>> messages with scripts/dtc/of_unittest_expect detects that the stack
>> dump is expected instead of being a test error.
>>
>> Test beds might interpret the stack dumps as errors, resulting in
>> needless debugging and error reports.  These test beds are likely
>> to remove unittests due to these stack dumps. To avoid these problems,
>> have unittest default to skip the tests that trigger a stack dump.
>>
>> Add a kernel cmdline option to not skip those tests.  This option can
>> be used by testers who are able to interpret the stack dumps as not
>> an error.
>>
>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>> ---
>>   drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index b5a7a31d8bd2..3a9bc2bc4ba1 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -70,6 +70,36 @@ static struct unittest_results {
>>   #define EXPECT_NOT_END(level, fmt, ...) \
>>       printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
>>   +/*
>> + * Some tests will cause the kernel to emit a stack dump, aka back trace,
>> + * when the test is successful.  The tests should make it possible for
>> + * test beds to detect that the trace is not an error via EXPECT_BEGIN().
>> + *
>> + * Most test beds do not process the EXPECT_BEGIN() information and may
>> + * flag the stack dump as an error, thus reporting a false failure.  It
>> + * is hoped that the KTAP version 4 specification will add the EXPECT_BEGIN()
>> + * processing to test beds.
>> + *
>> + * By default, skip tests that cause a stack dump.  Test beds that process
>> + * EXPECT_BEGIN() information should enable these tests via a kernel boot
>> + * command line option.
>> + */
>> +static int stackdump_tests_enabled;
>> +
>> +static int __init enable_unittest_stackdump(char *str)
>> +{
>> +    stackdump_tests_enabled = 1;
>> +    return 0;
>> +}
>> +
>> +static int __init disable_unittest_stackdump(char *str)
>> +{
>> +    stackdump_tests_enabled = 0;
>> +    return 0;
>> +}
>> +early_param("of_unittest_stackdump", enable_unittest_stackdump);
>> +early_param("no_of_unittest_stackdump", disable_unittest_stackdump);
> 
> Does no_of_unittest_stackdump have any benefit or value ?

I would say no, but it is a common pattern to provide both
foo and no_foo.

-Frank

> 
> Thanks,
> Guenter
> 

