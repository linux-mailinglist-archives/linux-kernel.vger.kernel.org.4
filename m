Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53751662212
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbjAIJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjAIJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:49:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A65D13FBD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:48:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso6165255wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOStHq+ipuKaCiBTTx7gP6/oeUX0fNqjIj19PouSSpg=;
        b=cZ/9XaHVUBbP514qYrq2pR1y7dRXw0tyilyZlAxhLkobjHQeEl1+Tc9Yj0tYTZ0cXI
         h+RhSzK7cZPOCpJDK6ojSXzOuiyxohZoEV+d2O7qeME/uVLu5JEgR0B5pTMV32sfC9bG
         JFakde57HTDAI84C7N/+Akk0QewwNrNE6rOTv/wNsuzgZyfNWwlOBLt+eZG+tDmlVnCL
         lyHNgNwRNQuFasAXg8Ayphpv5+EPjxHcz7rJZ80kKIHDt68/L+oEizU/43i9JKYKswXH
         Dxl/I0tsvyMX7/K3M09IJDqyZxwE1L0XWBKwuRJuxIP8plj/Vs+u/HfGPfHPWBB1puQ3
         4IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOStHq+ipuKaCiBTTx7gP6/oeUX0fNqjIj19PouSSpg=;
        b=sROPkD261O0CTGstzsGaHp9vuhloZUYyLJ9XxC1oZFO9Unz9wS/uGx5zbYLPklD2N7
         5FdjGI6dmA/lf/ZtuWcgDcv0lNkhCZ8qvJHHDqB4cX4AONa8pKYTbk33MkwjBmgBy+kl
         hugjZ7i8RYEOLEJxkehk7oxWPocAYbL6Qb1Gz/VjFonoFppVC57gy0wzXwtllT9BRwaC
         9veRF0w7jsKORslxoQlo2rri2OP+3EKlEd/I4JgnTgedOk5dYxXQtml2bw8cl2L/W6nk
         jDrtdeUZlwo8t5SPAU0iIh5cXPQ27y0YoOIBctu24cD8O2307ICCziLOcLHooNEcWkKe
         oMfg==
X-Gm-Message-State: AFqh2ko1K/IiR8wFdS5vJBOIm84rYjYkZYcbUrvcBeIqhLK4BReEfojW
        9U9KGxb9AHE822Ak3nl/41cRe4L6A6wnz1MIiM0=
X-Google-Smtp-Source: AMrXdXtjgMZkpDyDKKP2ABc0V2JbkdfkR6uxgt2XLCgTSPZppJh94NyhGbem0ME7g1JeqYrI+MbAFg==
X-Received: by 2002:a05:600c:a56:b0:3cf:894d:1d06 with SMTP id c22-20020a05600c0a5600b003cf894d1d06mr45658465wmq.30.1673257732599;
        Mon, 09 Jan 2023 01:48:52 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r5-20020a05600c35c500b003d98f92692fsm11722414wmq.17.2023.01.09.01.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:48:51 -0800 (PST)
Message-ID: <d0df69da-e881-46aa-da51-eb3b610dee57@linaro.org>
Date:   Mon, 9 Jan 2023 09:48:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221012155133.287-1-musashino.open@gmail.com>
 <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
 <e8932e3eaf1bd9a690e2f41aad8faf3a@milecki.pl>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <e8932e3eaf1bd9a690e2f41aad8faf3a@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafal,

On 06/01/2023 19:15, Rafał Miłecki wrote:
> Hi Srinivas,
> 
> On 2022-11-11 18:41, Srinivas Kandagatla wrote:
>> On 12/10/2022 16:51, INAGAKI Hiroshi wrote:
>>> This patch fixes crc32 error on Big-Endianness system by conversion of
>>> calculated crc32 value.
>>>
>>> Little-Endianness system:
>>>
>>>    obtained crc32: Little
>>> calculated crc32: Little
>>>
>>> Big-Endianness system:
>>>
>>>    obtained crc32: Little
>>> calculated crc32: Big
>>>
>>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>>
>>> [    8.570000] u_boot_env 
>>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated 
>>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>>> [    8.580000] u_boot_env: probe of 
>>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>>>
>>> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment 
>>> variables")
>>>
>>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>>> ---
>>
>> Applied thanks,
> 
> has this patch been lost somewhere in the process?
> 
> I'm quite sure I saw it in linux-next.git and probably in nvmem.git. Now
> it seems to be gone.
Yes, I had to revert this one as next reported sparse warnings [1] with 
this patch which were not addressed.




--srini

[1] https://lore.kernel.org/linux-mm/202212040713.rVney9e8-lkp@intel.com/T/

