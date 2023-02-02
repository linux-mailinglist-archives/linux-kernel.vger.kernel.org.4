Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECC688762
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjBBTNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBBTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:13:07 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753ED7A9B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:13:01 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z2so1187019ilq.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sze4SPkyx71GgTTpWniQiWnzfqpKfnGfdRyUcgKtQxI=;
        b=P1iCtDSmhy7TDXIs4AHa31OwJPsSNlFkjffGNkhdzZac6S4KXHJhIw/yUKu21tcahe
         MSVFuy8acefJgAVI8EFxdSOnbM7cGVKF5IeQQlt0hz1c22uykcdaVQyvFJm2cqXeYNdn
         1xvJVsPAhKf+/aWWN7s7OMbvg7e8LhI5GCqfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sze4SPkyx71GgTTpWniQiWnzfqpKfnGfdRyUcgKtQxI=;
        b=cwjU7H/GiK8sNZFt2HtyWKWEkXjbUafmQSIG1IGYwcS2s9VTH8ACrpFgTP+I6YeIMh
         9Qound5eVFCWVr/17gY/0o2dY2ZE6WEE08rZDb+JW55/YoW6YTndBY3+OvVrF+KYknuH
         5RVfy/rY+Xkx8XTyqYV/gY24DPuQCUbEw72eqT01YR8M6iEYyo+5ZLv0rQV0ok7rpBOf
         NxbHXqFah/j8Pwj7DIDXS/UsiQAqrGm8jHGcdhRTwNwxMR8utEjRcE9AD6jX3ACqsSAU
         puz3TRzO7XI+jHXow1TMXZsoOiRFYHFxZDkOfSfnzUrsP7cfvkRo6hBGuYuCpDsI4Vud
         nrRQ==
X-Gm-Message-State: AO0yUKUZm/tQzW48RN4pUbci2jtTOdUurvYA5d0IQIBh9+d+FpcNW1DX
        /pjlM35Zm1ndC2hbSlFqESevIg==
X-Google-Smtp-Source: AK7set/S3fSxSa2iWklBy+crpw5U360y/+JVsFZvjT2X4u/YMtdF4l70hlyn6wVLEqhsnhZHTl01Sw==
X-Received: by 2002:a05:6e02:1746:b0:30d:bf1a:b174 with SMTP id y6-20020a056e02174600b0030dbf1ab174mr6291143ill.1.1675365180398;
        Thu, 02 Feb 2023 11:13:00 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ch14-20020a0566383e8e00b00388660ca27dsm179623jab.4.2023.02.02.11.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:12:59 -0800 (PST)
Message-ID: <7d8f7371-6ca9-cb4b-5e82-2b2a21ee8ab8@linuxfoundation.org>
Date:   Thu, 2 Feb 2023 12:12:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230131221105.39216-1-skhan@linuxfoundation.org>
 <87edr8vu8q.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87edr8vu8q.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 10:43, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> Add a new section to the admin-guide with information of interest to
>> application developers and system integrators doing analysis of the
>> Linux kernel for safety critical applications.
>>
>> This section will contain documents supporting analysis of kernel
>> interactions with applications, and key kernel subsystems expectations.
>>
>> Add a new workload-tracing document to this new section.
>>
>> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v2: Addressed review comments on v2
>>
>>   Documentation/admin-guide/index.rst           |  11 +
>>   .../admin-guide/workload-tracing.rst          | 605 ++++++++++++++++++
>>   2 files changed, 616 insertions(+)
>>   create mode 100644 Documentation/admin-guide/workload-tracing.rst
> 
> I've applied this with a couple of sphinx tweaks, including:
> 

>> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
>> +
>> +Discovering Linux kernel subsystems used by a workload
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> This doesn't follow our normal conventions, so I made it:
> 
>> ======================================================
>> Discovering Linux kernel subsystems used by a workload
>> ======================================================
> 
> Instead.
> 

Thank you.

-- Shuah

