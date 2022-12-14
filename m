Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FD64C52E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiLNIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiLNIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:40:12 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AC12D2C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:40:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o12so6164570pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIedX/a+ZyVoKz+m/UL7d9+fegiypi7Lib9P6OHv4HU=;
        b=TWJZ/jV8kbAA5Jh3iCtarFZ+0x5RqRIuROyJufDM578IYkUfN/I/sUlwS1KCrzRH4w
         fJMYxb9U4lDzQOMW7BY9NqG8ussOBUgIhgwdgOuPGKwPtQOChbKg8YEm/D7+FByky3VL
         vLyfvyArtmq3rAjo2QY/okLuHluZ4BlaJfPJIGo29UJ1jgnVDOx4BLDMxD1z94JUd6MA
         NZ/82k5rZ3JzCq35uUjTDdueAxG1YzxqVJGMrAWGmN4noWZ9VzFTI5aKwFih7BhnWW+x
         mcJN0kekjysUM5cFJA7DgyAQaWNne6jRfsLdYfgewvZR6cIiP1vnaQsB2rmLTCQHT0P3
         GUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIedX/a+ZyVoKz+m/UL7d9+fegiypi7Lib9P6OHv4HU=;
        b=1Tb96FKF8JxNSC79nqmsNylYOiSggB6Di/FE2Lyui+MJkPzqr9Z0dukq67yHMCCwWu
         sLMJK0NpSvsN5BmYdtJgpbf+KBLVX9dqvxK3rnuF6BlM1YL5TDpWDdOq/mAY6wuL1uoQ
         b3qHKQ7ynNt99YpH0KfsMz1OqPbjaZPA8LBWPj7mJSXe8V5GrnmULihGllX4yBLDRwnO
         6LXSxDaSJVOruvmE+6IcCQQb9i+nde0rRfcH+lM7/VhQv3s7bwOMOdStlnpJgIj8p4Nh
         +K8sdG2xHLmvrv2+MFbfpNI+gqYwLkuxOnokVtpAlT68XQs6MHKvizlEMvOAH34az0Mn
         nPOg==
X-Gm-Message-State: ANoB5pknVvjiTQqV5uj/C+itoydylZlT7RpppEQKTGvn2XBrWmq7RT7t
        Xg4iFRsB6XeiwlXvHzYMI0Wc7q0fHgmPxYNFDmA=
X-Google-Smtp-Source: AA0mqf6T0mEk5pNZJIPVJtrH8qnl+ff48CYVPMxa1zSuLBNs4KHrSw9yY5Z/Xk8Uoea7qt9D28+CRA==
X-Received: by 2002:a17:902:8ec1:b0:188:6a62:9d89 with SMTP id x1-20020a1709028ec100b001886a629d89mr22284999plo.54.1671007211573;
        Wed, 14 Dec 2022 00:40:11 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b00189b910c6ccsm1282362plg.125.2022.12.14.00.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:40:11 -0800 (PST)
Message-ID: <921915e5-6b36-9d2d-ebd7-632403e3086a@9elements.com>
Date:   Wed, 14 Dec 2022 14:10:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
 <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
 <Y5HXWk4d5J9VgFBV@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y5HXWk4d5J9VgFBV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On 08-12-2022 05:53 pm, Lee Jones wrote:
> On Fri, 18 Nov 2022, Naresh Solanki wrote:
> 
>>
>>
>> On 17-11-2022 03:45 pm, Lee Jones wrote:
>>> On Wed, 16 Nov 2022, Naresh Solanki wrote:
>>>
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> Implement a regulator driver with IRQ support for fault management.
>>>> Written against documentation [1] and [2] and tested on real hardware.
>>>>
>>>> Every channel has its own regulator supplies nammed 'vss1-supply' and
>>>> 'vss2-supply'. The regulator supply is used to determine the output
>>>> voltage, as the smart switch provides no output regulation.
>>>> The driver requires the 'shunt-resistor-micro-ohms' property to be
>>>> present in Device Tree to properly calculate current related
>>>> values.
>>>>
>>>> Datasheet links:
>>>> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>>> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    drivers/mfd/Kconfig         |  12 +++++
>>>>    drivers/mfd/Makefile        |   1 +
>>>>    drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 207 insertions(+)
>>>>    create mode 100644 drivers/mfd/max597x.c
>>>>    create mode 100644 include/linux/mfd/max597x.h
>>>
>>> Ignoring my comments won't make them go away. :)
>>>
>>> Please tell me why you need a whole new driver, instead of adding
>>> support to simple-mfd-i2c?
>>>
>> I felt current implementation to be simpler, clearer & straight forward.
> 
> If you can make it work with simple-mfd-i2c, please do so.
simple-mfd-i2c doesn't has mechanism to pass device type(max5978 vs 
max5970).
> 
> No need to submit an entirely new driver for these simple use-cases.
> 
Regards,
Naresh
