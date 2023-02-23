Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231E6A0CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjBWPWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjBWPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:22:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0E57D21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:22:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so5024526wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cwbrse9pZAxCvyGzfZ4RNvckcnZylA2fH9zi27S+QI=;
        b=NOruivWnthOebJDqC4gaJPdYD62QJ09c3qsdWWT1Bhwb1c4svUr8/bYY8ZmlqHVwst
         uXphoclV4DxL49Vu703Cpn82F0jT40Z73ayldO4wq1OA9AYkTQ0d/exfG7pZK33Oglon
         xG10fGCoFhKNeMEvggIC1YTE/i71GROkyL4kmxaVT0nlwRPOjfDS1PR9s+I8XZPiHTnV
         mHQaa+AZjdRvWf+Fa1C4A8r6tM9NKIZSMtUs9sygQou/pt8VIOlcsdb8dQ/9nFsJ8ncx
         aCFNzb5KOPija2h2uB1a3dgS0lqz0ef3WTlDWuAyv+6aUb0jcsjUejallakvNjDsHGuF
         Evfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cwbrse9pZAxCvyGzfZ4RNvckcnZylA2fH9zi27S+QI=;
        b=ERwf+RCRjU1ptOPg7zteYsLe/N63zSrGtxlcez8aEtgxbh3ybzwpL7ikW8ouJ3Y6iC
         pBTISAGQJDcL5UDFmCgbkxbOGxFuZBBQEMrsBSCmKuKkj2As4ZHvThFz2ajgjZ4fNiKO
         6i4BGeeijyq+mY7qgSxMbM2rPEZwu4ep+gSClrCR+qCWr9Rg3YMtCpvylErKIyxR2+YK
         7d+w4wAfDOyUBnWxh3SZSCJxa3xWLcg5EkHnfRBKSibTRhuLFqK31YwKHcfLvjHAr+yn
         O+4wxX18FuWIlE3gvKyocThy2pk5HnhJ02e6bO74urw6bbor+SFG/kAdKZzIicxjKOjG
         CPsQ==
X-Gm-Message-State: AO0yUKWZvDoBXCwVp7lfOUJ/8C7jBjLDxwELSswX1AHp4QNEjUIUQNCR
        Gii3nLQ8+4galGoXYZnZLw5SKg==
X-Google-Smtp-Source: AK7set++SQwiX6anztrdTaCyOV4SjeN7vFMHvuxS//fEFz98O8goJ7YLvAky+T/G+gUg5Pn95Q+aDA==
X-Received: by 2002:a05:600c:2b46:b0:3e0:14a:697a with SMTP id e6-20020a05600c2b4600b003e0014a697amr10024326wmf.6.1677165765179;
        Thu, 23 Feb 2023 07:22:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003e0015c8618sm4984762wmh.6.2023.02.23.07.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:22:44 -0800 (PST)
Message-ID: <6aa802c2-fe0d-f830-dc4d-3a139003e137@linaro.org>
Date:   Thu, 23 Feb 2023 16:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-3-virag.david003@gmail.com>
 <Y/d1DY/mXe7R5q8W@google.com> <Y/d1omGzBMFqjQx+@google.com>
 <Y/eAPXwdv0kclEVA@mail.local>
 <3a8e24921b9b47834199a7ca78af4d22ed370586.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3a8e24921b9b47834199a7ca78af4d22ed370586.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 16:11, David Virag wrote:
> On Thu, 2023-02-23 at 16:03 +0100, Alexandre Belloni wrote:
>> On 23/02/2023 14:18:10+0000, Lee Jones wrote:
>>> On Thu, 23 Feb 2023, Lee Jones wrote:
>>>
>>>> On Tue, 31 Jan 2023, David Virag wrote:
>>>>
>>>>> The S5M8763 MFD has no device tree compatible, and since board
>>>>> file
>>>>> support for it was removed, there's no way to use this MFD.
>>>>> After
>>>>> removing the remaining code for it from the MFD driver, also
>>>>> remove
>>>>> support for it in the s5m RTC driver, and all remaining
>>>>> references to
>>>>> it.
>>>>>
>>>>> Signed-off-by: David Virag <virag.david003@gmail.com>
>>>>> ---
>>>>>  drivers/rtc/rtc-s5m.c            | 82 ++----------------------
>>>>> --------
>>>>
>>>>>  include/linux/mfd/samsung/core.h |  1 -
>>>>>  include/linux/mfd/samsung/irq.h  | 50 -------------------
>>>>
>>>> Acked-by: Lee Jones <lee@kernel.org>
>>>
>>> Actually, looks like this should probably go in via MFD, so I need
>>> an
>>> RTC Ack.
>>
>> There were comments on 1/2 so I was expecting a v2.
>>
>>
> 
> Krzysztof commented there about the removal of an enum value that's
> actually removed in 2/2 since it would break the RTC driver if it was
> removed in 1/2. He realised that and corrected himself. No need for v2
> AFAIK, unless something else is found.

Yep. I also gave review tags for both of these.

Best regards,
Krzysztof

