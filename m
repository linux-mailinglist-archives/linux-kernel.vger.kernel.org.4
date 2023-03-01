Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952E6A66E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCAEHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCAEHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:07:20 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C11ACF3;
        Tue, 28 Feb 2023 20:07:19 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a1so7656545iln.9;
        Tue, 28 Feb 2023 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677643638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=34NFfCpl2ugJCk18M5HFAnMc3Csw+/1Vb9q5/O6tJ7Q=;
        b=P6PXUFq5hR+CKKxw8mCIcAAOBTCzPZVqKvHftgD/NeFFOF4b+OND8vnLqdScM3Bj2z
         WVyu8/tP9W28tPCdjbtIVJYtzPgYjsaCNTExcljeGrt0H6hdHiYlMlzskqHSZcHUdFpX
         q+6rfCVH7H+P1LX4yYzS9wurCaELJw7tXAsH2E0acbH16RjRMR0UP8kVRWFCKGeiw2oq
         qyFUi08ex7s294SINysQ1ij1Gt8IN4FuEnGkKuOvVh33nNnknuYmfuuhu0GPfYN1CBm9
         ALHn3gtDk7bEL/Fh6AX1mfr/B4RKnWFSbHyYRwa2cPgau7ZyIBQNdylR/q+d1NMEa8co
         kzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677643638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34NFfCpl2ugJCk18M5HFAnMc3Csw+/1Vb9q5/O6tJ7Q=;
        b=NewDUu/HkTq+iy+pcjQ4fjDDXazq5lyYrT2w6k48oKm5PbacdWoqyPTStFv0K1vUYq
         lBRqDduQBHjNpLcA3StJi4Ss8YELgap2uCXTOwOP42xbByJBMr4sPCJXYiMnqx9ia/IT
         T7vKhB/tsq/s8FRq2xKaGU8J/iZMaryrV9xGXInUwuCWbm8hqzRrSlnEGeMYFl/oAEwR
         5PJYZv15cKv8Brn6VgZ9WQIYpuBn+XqmvIpsxMXuO7JLTLnLCNxK0/ycgNEov7lY4Vi9
         zDTJeR3IqlblemaYRXr4FzMyUSkOyoJdHshd9+ixD4VSAtXNXHP4haoI8qP4QnhhM3VR
         NOkA==
X-Gm-Message-State: AO0yUKWP1ubOC4LiLvzLw3uWQhyN+UJFh5X/MH0ZWPnUxFQxWUmpMum+
        Y6r2vHRo6Ai4wLndglc98BI=
X-Google-Smtp-Source: AK7set8BO8kmRLWPHQAepLh/KJA9eGmluOmaO4N38iT89XrNPhJV5gJZUUErhj4WphANT9Zh0UhcEQ==
X-Received: by 2002:a05:6e02:219b:b0:316:f93f:6baa with SMTP id j27-20020a056e02219b00b00316f93f6baamr5492289ila.31.1677643638503;
        Tue, 28 Feb 2023 20:07:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y21-20020a02bb15000000b003acfdc75a53sm3657081jan.48.2023.02.28.20.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 20:07:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <018f54ee-55cc-e30b-4595-ce555fff1708@roeck-us.net>
Date:   Tue, 28 Feb 2023 20:07:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] of: unittest: option to allow tests that trigger
 kernel stack dump
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230301012116.1488132-1-frowand.list@gmail.com>
 <20230301012116.1488132-2-frowand.list@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230301012116.1488132-2-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 17:21, Frank Rowand wrote:
> Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
> some tests that trigger a kernel stack dump.  Filtering the boot
> messages with scripts/dtc/of_unittest_expect detects that the stack
> dump is expected instead of being a test error.
> 
> Test beds might interpret the stack dumps as errors, resulting in
> needless debugging and error reports.  These test beds are likely
> to remove unittests due to these stack dumps. To avoid these problems,
> have unittest default to skip the tests that trigger a stack dump.
> 
> Add a kernel cmdline option to not skip those tests.  This option can
> be used by testers who are able to interpret the stack dumps as not
> an error.
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> ---
>   drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index b5a7a31d8bd2..3a9bc2bc4ba1 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -70,6 +70,36 @@ static struct unittest_results {
>   #define EXPECT_NOT_END(level, fmt, ...) \
>   	printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
>   
> +/*
> + * Some tests will cause the kernel to emit a stack dump, aka back trace,
> + * when the test is successful.  The tests should make it possible for
> + * test beds to detect that the trace is not an error via EXPECT_BEGIN().
> + *
> + * Most test beds do not process the EXPECT_BEGIN() information and may
> + * flag the stack dump as an error, thus reporting a false failure.  It
> + * is hoped that the KTAP version 4 specification will add the EXPECT_BEGIN()
> + * processing to test beds.
> + *
> + * By default, skip tests that cause a stack dump.  Test beds that process
> + * EXPECT_BEGIN() information should enable these tests via a kernel boot
> + * command line option.
> + */
> +static int stackdump_tests_enabled;
> +
> +static int __init enable_unittest_stackdump(char *str)
> +{
> +	stackdump_tests_enabled = 1;
> +	return 0;
> +}
> +
> +static int __init disable_unittest_stackdump(char *str)
> +{
> +	stackdump_tests_enabled = 0;
> +	return 0;
> +}
> +early_param("of_unittest_stackdump", enable_unittest_stackdump);
> +early_param("no_of_unittest_stackdump", disable_unittest_stackdump);

Does no_of_unittest_stackdump have any benefit or value ?

Thanks,
Guenter

