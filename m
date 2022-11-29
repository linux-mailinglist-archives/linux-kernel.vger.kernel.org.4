Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502E63BB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiK2IQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiK2IQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:16:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8057B6E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:16:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ns17so5131945pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqqcI3upkMKe9jgtqKPfvBFqEpkKc3bYwpA9ihzXqPc=;
        b=LYQWMzk8fwk1ZXmPY95LWiyuQwTHRdE8/013KjievETTzx7IAC0a5IzM3gOqgC0N3h
         BGZ1rjgpjork3tK/0TK52o+jQ+jjaW2ofjci1U6dboFGw+qeAsPq0uT0FKeSKqwnyACB
         kOrJEL3QlRQkEIotOyBICUKPrGdcz5zjn3uqcYM0+kf7Om+1snmCOvnldmlzL4wDcZS8
         BCrnYIhR1I9KJowh4A1THFz6kMKwHKfFdkd0qUwcZ0LFSmBhg1SWgApm7CEjNac7HMPq
         AiEJvP377sA56YM4wOxpq+je/NbGuUodZGmFcfVeZg8/jwo0USFj7N3t8MBwdS8oJx2s
         QqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqqcI3upkMKe9jgtqKPfvBFqEpkKc3bYwpA9ihzXqPc=;
        b=sNAzXYWr5kZhZS8xOPI2O67WRde+LfF1WjeYc6VzBpvD3x7SgjMPLIF6S9qbOVwoOL
         WrkkvUHuAIlRfteDZxsr1oPFWQb0wzHHIqBSAEZjJDKiCSfcV5HBo8F2CxAoWdUHpzDj
         L0lCxoPYYlF5LwF1cS68qZ5fb6f13AVhzcwQyVZSDH5KYgD2JhbiYNNozq3BMBr6Qfj3
         1XDj+9vYjYLLfMK/9rU/cawKHTC7UUyo/L/6YJrKEMC+CpBBd8TYxiuLiaS4AECgq1PX
         vOtp86QZX0bZt5DJP0rBXPBPnY/HKHSLmny/Pe7SMNPc0gSfuaLMBmniDGVpzP+8OZ18
         w+gw==
X-Gm-Message-State: ANoB5pnFnOlK8JyF0OQuH+nZidi27F3+rR6T9CDoiJhJIUmqWfufOkdH
        X0D6dibrnSg4RBSLR/NkhN9XMw==
X-Google-Smtp-Source: AA0mqf7WLgfLUvX+Ih5A322VuHGcPluj23ukCLLsh8ExG1Cct3WD55Q/hYioCdzGlv/r/Hf9XAQIyQ==
X-Received: by 2002:a17:90a:307:b0:213:ff80:b37f with SMTP id 7-20020a17090a030700b00213ff80b37fmr65116475pje.118.1669709804401;
        Tue, 29 Nov 2022 00:16:44 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7954d000000b00574740c99e9sm9302290pfq.129.2022.11.29.00.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:16:44 -0800 (PST)
Message-ID: <1b015a86-0d65-8597-0512-b313769e307b@9elements.com>
Date:   Tue, 29 Nov 2022 13:46:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus/core): Implement irq support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <20221128174715.1969957-3-Naresh.Solanki@9elements.com>
 <bda19726-74f3-b76d-c30c-eb2543979690@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <bda19726-74f3-b76d-c30c-eb2543979690@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 29-11-2022 04:39 am, Guenter Roeck wrote:
> On 11/28/22 09:47, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Implement PMBUS irq handler to notify regulator events.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> As I am sure I have mentioned before, this needs to primarily handle
> sysfs notifications to hwmon status attributes and to generate kobject
> events. Regulator events are secondary / optional.

Based on previous feedback, PMBus interrupt handler is made generic
Based on the use case I have in my machine, my application need to 
monitor regulator event as soon as they occur and hence the patch.

> 
> Thanks,
> Guenter
> 
Regards,
Naresh
