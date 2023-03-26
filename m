Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054326C91E4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 01:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCZA4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 20:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZA4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 20:56:14 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39FBB8E;
        Sat, 25 Mar 2023 17:56:13 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17997ccf711so5763639fac.0;
        Sat, 25 Mar 2023 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679792171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAwqO8DmblyvZIKV1qNsnAE1hHK5TyffAw/NgAmyT5k=;
        b=amnPa9ykmh0NipOZ5rN9IBmY77F05sjIytUNydCstPU5sDt7uYmNqilQmvP0Mi/5RY
         fQM3Of7U6YcIGV1gDXk9epIfNIK4cSrAoZEzg4VNlfxYdSvp5hAMNYEu16B7G1I5UDci
         LBqRLzTNKf6ljUmq18IqAOxx3J+VJVXrCEP5AgkJb3mt9G+Ey01JTm0Ym0OuP3TZ6+HM
         aoA7KlfaGOVZfbwp4A/PfWThOCA7QM8GcOr0EJNcrTRJ+ZpLPBbyVAwyht+ZDp2adslO
         UYU1Jyk3Yu7oAqm2TYbc6NZCSeIlnSVgo6I0wML27TWJoX1xpLerHVQQ0nqL9VEX8bY5
         cr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679792171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAwqO8DmblyvZIKV1qNsnAE1hHK5TyffAw/NgAmyT5k=;
        b=hYJDmKDtKomyjbevJqMQmoBIn8lSjqXFjrvxwlT/qPXO50ZIwv/+Ms63iu8LFKu3e1
         YMeJh2/LDCLgY/1o4zs/YYJLdrYWOUWjhlEJSGssbEk8ro4UCkerdBhbfUJ9Zn7w8iOI
         9lXvnbMZMiXSTfXNGuyhPLibafXApR9K52MNXzMd09o8UASHeBZ0ju0eWvneokVB7dU9
         i4dFiTX1KJkacNqBGJjOQRDx6N2GbMoVJ0iPg1SDcWuXmUYA8i0e8aQv7+A9P3mcpT34
         dytbwBSyj8TeMzRY/yPYEbSPwRNnllRgUb8JmeMjob65Hcsy27xaiNvu+ynWgptXvYpJ
         xqdQ==
X-Gm-Message-State: AO0yUKVykC7rE5HvRRBXqU0GvKyFbxIQ+22nXdweFWlIZ1WkyREvEkbR
        yfvVcCNATc1Iij+7/dWuLo4=
X-Google-Smtp-Source: AK7set9hXBU/hTVV0DiOuJRCuAHYZa35pnjIiPFEqWj24/Oq/SOkrDzzylZ+KhKLbzVRBGBL+CAF0A==
X-Received: by 2002:a05:6870:5884:b0:177:ab4c:fc90 with SMTP id be4-20020a056870588400b00177ab4cfc90mr5539624oab.32.1679792171553;
        Sat, 25 Mar 2023 17:56:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:189a:e969:3b47:81d? ([2600:1700:2442:6db0:189a:e969:3b47:81d])
        by smtp.gmail.com with ESMTPSA id yv18-20020a05687c229200b001729072f759sm8585936oab.0.2023.03.25.17.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 17:56:10 -0700 (PDT)
Message-ID: <4b483680-2532-98e9-71b0-4b2ced508313@gmail.com>
Date:   Sat, 25 Mar 2023 19:56:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] of: unittest: option to allow tests that trigger
 kernel stack dump
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230301012116.1488132-1-frowand.list@gmail.com>
 <20230301012116.1488132-2-frowand.list@gmail.com>
 <018f54ee-55cc-e30b-4595-ce555fff1708@roeck-us.net>
 <96cfd1ee-768d-cc03-53dd-35ccf2396863@gmail.com>
 <20230324214341.GA20080-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230324214341.GA20080-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 16:43, Rob Herring wrote:
> On Wed, Mar 01, 2023 at 10:01:36AM -0600, Frank Rowand wrote:
>> On 2/28/23 22:07, Guenter Roeck wrote:
>>> On 2/28/23 17:21, Frank Rowand wrote:
>>>> Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
>>>> some tests that trigger a kernel stack dump.  Filtering the boot
>>>> messages with scripts/dtc/of_unittest_expect detects that the stack
>>>> dump is expected instead of being a test error.
>>>>
>>>> Test beds might interpret the stack dumps as errors, resulting in
>>>> needless debugging and error reports.  These test beds are likely
>>>> to remove unittests due to these stack dumps. To avoid these problems,
>>>> have unittest default to skip the tests that trigger a stack dump.
>>>>
>>>> Add a kernel cmdline option to not skip those tests.  This option can
>>>> be used by testers who are able to interpret the stack dumps as not
>>>> an error.
>>>>
>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>>>> ---
>>>>   drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++---
>>>>   1 file changed, 51 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>>> index b5a7a31d8bd2..3a9bc2bc4ba1 100644
>>>> --- a/drivers/of/unittest.c
>>>> +++ b/drivers/of/unittest.c
>>>> @@ -70,6 +70,36 @@ static struct unittest_results {
>>>>   #define EXPECT_NOT_END(level, fmt, ...) \
>>>>       printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
>>>>   +/*
>>>> + * Some tests will cause the kernel to emit a stack dump, aka back trace,
>>>> + * when the test is successful.  The tests should make it possible for
>>>> + * test beds to detect that the trace is not an error via EXPECT_BEGIN().
>>>> + *
>>>> + * Most test beds do not process the EXPECT_BEGIN() information and may
>>>> + * flag the stack dump as an error, thus reporting a false failure.  It
>>>> + * is hoped that the KTAP version 4 specification will add the EXPECT_BEGIN()
>>>> + * processing to test beds.
>>>> + *
>>>> + * By default, skip tests that cause a stack dump.  Test beds that process
>>>> + * EXPECT_BEGIN() information should enable these tests via a kernel boot
>>>> + * command line option.
>>>> + */
>>>> +static int stackdump_tests_enabled;
>>>> +
>>>> +static int __init enable_unittest_stackdump(char *str)
>>>> +{
>>>> +    stackdump_tests_enabled = 1;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __init disable_unittest_stackdump(char *str)
>>>> +{
>>>> +    stackdump_tests_enabled = 0;
>>>> +    return 0;
>>>> +}
>>>> +early_param("of_unittest_stackdump", enable_unittest_stackdump);
>>>> +early_param("no_of_unittest_stackdump", disable_unittest_stackdump);
>>>
>>> Does no_of_unittest_stackdump have any benefit or value ?
>>
>> I would say no, but it is a common pattern to provide both
>> foo and no_foo.
> 
> It is? I see one documented example. I see numerous ones that are 
> 'no_foo'.

I reconsidered.  I plan to remove the no_of_unittest_stackdump in v2, updated
to the current kernel version.

-Frank

> 
> This doesn't scale well if lots of tests need to disable it. Perhaps it 
> should be more generic (at least documentation/naming wise even if the 
> implmentation lives in DT unittest for now).
> 
> Rob

