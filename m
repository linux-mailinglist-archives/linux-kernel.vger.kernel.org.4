Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6970F386
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjEXJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjEXJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:53:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C549E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:53:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae4c5e1388so564935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1684921995; x=1687513995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJnG8axNZJF8mV0poaZtTlKyVnK4fP30yLXMPuLHFXQ=;
        b=DiR6S4pXejxNNTvVOwVjDrQeVP/ZWDiwQdPYE7u1rpzVCIt8Ap4aN8rFw7hOrGaqdn
         v+REVf06imI3uKuMhOai9vI1iF2pKBkpdggce8LQ8492mtbJJmKAh20e0tRvjnGUixjp
         zKoSpPvOcD+WPoIt4wqL3XQ9BwiBl9qlnRkZ/9gOBSd6O9nqUBbUMY8JdT6+Uf5JFPau
         W6/q2Qv1TktpNaAm3Dmy3R08pHGlU+vcjsRWGsBhaeny5D88pdJlYtCsUkaRNEaEhx5S
         OnFueDuDYqBsZvrJp+r1xwkAxXxBw6XHgDG2p/1ydW6jT8crBBCyA2k4Q6K9ZBlEueVa
         vrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921995; x=1687513995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJnG8axNZJF8mV0poaZtTlKyVnK4fP30yLXMPuLHFXQ=;
        b=Od1joSxFSKBMjG+9r8rH/4p8ZtStJfL7tBGGllrJWQrvo7fB0J+/Me9UHQF6KQwRYs
         85TnbW9ho8YqNteuGRxzlerjP99YUDzFrAtfylFUQkSpJxfW1DzJK6Quv9rB3A3G+AP6
         X5yosY1kvjbDPS0ifECTLyVCY2Z8PEHvRuA8axRkkAKOO8nT++Z+zOozCM+Q+SKONmzw
         o+v24n/AJzwiNvsGebRX/CFaYFgAfbg6ZlUF65r4i1I740rDg+HbVZsvdA1WYhRkqxxb
         z1jE31xwPWdzdvCHHIErrypGjsjdp5bTOOciD7CZuBpnBOK++UQcSHWFZNKSwL7bvJTp
         bAxQ==
X-Gm-Message-State: AC+VfDz5QaRjE2Pox8rZH0Fm99ZP6a10EmtRYaK0dA0R/8ZmSNvJXSYm
        SiRgkScXVmd3t45CIZtqEkOd0Q==
X-Google-Smtp-Source: ACHHUZ4M9MvZ8JYz+44FFKHkjMx4O2lfa58zC7KsQkLINLcDv4/i0cXQfQOt3pB5QOlQdPGiqQsctw==
X-Received: by 2002:a17:903:4284:b0:1a9:b0a3:f03a with SMTP id ju4-20020a170903428400b001a9b0a3f03amr16728258plb.9.1684921994864;
        Wed, 24 May 2023 02:53:14 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001ae5d21e95csm8284552plb.117.2023.05.24.02.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:53:14 -0700 (PDT)
Message-ID: <0d707cdc-2c6f-6506-71c4-85840a1ad1de@9elements.com>
Date:   Wed, 24 May 2023 15:23:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
To:     Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <20230518101423.GE404509@google.com>
 <14badbda-9f27-bd5d-bd59-5515c9824886@9elements.com>
 <20230522071143.GO404509@google.com>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230522071143.GO404509@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 22-05-2023 12:41 pm, Lee Jones wrote:
> On Thu, 18 May 2023, Naresh Solanki wrote:
> 
>> Hi Lee,
>>
>> On 18-05-2023 03:44 pm, Lee Jones wrote:
>>> On Thu, 27 Apr 2023, Naresh Solanki wrote:
>>>
>>>> The previous version of this driver included wildcards in file names
>>>> and descriptions. This patch renames the driver to only support MAX5970
>>>> and MAX5978, which are the only chips that the driver actually supports.
>>>
>>> So multiple devices are supported:
>>>
>>>     MAX5970  ... AND
>>>     MAX5978  ... thus
>>>     MAX597X  ... does make sense, no?
>>>    What are you trying to achieve?
>> Understood. It is important to note that there are indeed other unrelated
>> chips in addition to MAX5970 and MAX5978. Examples include MAX5971, which is
>> a Single-Port, 40W, IEEE 802.3af/at PSE Controller with Integrated MOSFET,
>> and MAX5974A, an Active-Clamped, Spread-Spectrum, Current-Mode PWM
>> Controller, among others.
>>
>> With this change, the intention is to be specific about the chips the driver
>> supports. Instead of using wildcards or a broad "MAX597X" designation, the
>> patch aims to exclusively support the MAX5970 and MAX5978 chips.
> 
> It's a tricky situation when engineers/marketing people name devices in
> a nonsensical manner.  However, "max5970" just as misleading in this
> context as "max597x", thus the patch doesn't improve anything.  It's
> more of a maneuver side-ways.

After considering the feedback received regarding the context of the 
leaf driver for max5970, it has been recommended to specifically use 
"max5970" instead of a general designation like "max597x." However, for 
support related to max5978, the documentation can be referred to.

Therefore, this change is necessary in order to unblock the leaf driver 
and address the feedback received.

Regards,
Naresh
> 
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    drivers/mfd/Kconfig                        |  4 ++--
>>>>    drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
>>>>    include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
>>>>    3 files changed, 19 insertions(+), 19 deletions(-)
>>>>    rename include/linux/mfd/{max597x.h => max5970.h} (92%)
> 
