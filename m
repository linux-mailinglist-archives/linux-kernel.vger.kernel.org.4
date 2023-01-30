Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B036815A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjA3PzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbjA3PzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:55:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB876BF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:55:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n6so8744410edo.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73+5T86U3nwRX6cn/cZ9UEzLjkYBQp2UkO5SarJ7D9M=;
        b=BMzCI1bLZ57ZqAkv3ClfCpiiGedJwjJ0TXrREWHF413s+km5WJbkXZpStiUdZJbptI
         uyUk9Uh6nm1RV2jvRYHEWQhohY72O+2K+9IlEZBvuAOELpgjxFEZtY9rF5ajRfK9iWTh
         KAiaDVcshRSwDFU9HK8WMmBiHtRgi2oWYL1XuryoZ8NshtsXUVo+cUOzhSy6PEh/I8hK
         NgHOLuANFnZ2HvMvkfqUz6SfnRaZTS4zad+0D9wQp2ejMtyuM+hz2aeMuE9Hn6mqBOeY
         A1SFO0oLcfzrVQ4R2bDRDfzezFSS3JnNfw9qAlGrMRUMwGWadfHNw8C8zJiYIoi+DRQ1
         YPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73+5T86U3nwRX6cn/cZ9UEzLjkYBQp2UkO5SarJ7D9M=;
        b=wjTN7/q8CEkGcDql9dJAGpBBPcSPLcgr5R2UCl37yxZG+od1Y+iKN02jlAySbB/4FJ
         XdBdqjAEby2bb7fBMV9KTi7422X5Nyvo+anRIqVqjFeX23bocwGKr7wZ/Du8+9lY53pE
         GWrbO6jFcG5OPpklPt6UUJoxPPMk+NdEd3CdhY/mx0m4EXx5S6zdFC1dyzCWMAW52FPo
         sMF7mUee7aK0kAg6u0DghvjGpe51VIkIjV5TD4BT7ORNp+U4iYMHCEkIaDc2JDZ6Mfu2
         zMWGcEWcfpTbCsGPwyTloi+qy08xnBDgENCFSjgx3eruntxMoyu8rrvljpUa1M0IwQOs
         bi9w==
X-Gm-Message-State: AO0yUKVzthIv3t0hZa1JlsiEoLP9n9jbr0WMGwQUNr2GA+XxMIOr4hNC
        uNvl1KBfrzQbLEe8ifzc8drlUHIctO/kcmto
X-Google-Smtp-Source: AK7set92fLRFmGGtGmfRjpw2bs+rXYWYXDUoe9SkLzVoq3R+fz8jfNiKtKSY1Y8KbTYNB23FnM/NlA==
X-Received: by 2002:a05:6402:4504:b0:4a2:1d08:283b with SMTP id ez4-20020a056402450400b004a21d08283bmr10409708edb.11.1675094099965;
        Mon, 30 Jan 2023 07:54:59 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ac7-20020a170907344700b00881c40ceffasm4273777ejc.112.2023.01.30.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:54:59 -0800 (PST)
Message-ID: <75891466-48f7-f86a-d9e5-e4bb4c0e9912@linaro.org>
Date:   Mon, 30 Jan 2023 15:54:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <Y9UmhI3hRVjLVWFp@kroah.com>
 <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
 <Y9exOmknnNHypwsR@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y9exOmknnNHypwsR@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 11:59, Greg KH wrote:
> On Mon, Jan 30, 2023 at 11:27:06AM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 28/01/2023 13:43, Greg KH wrote:
>>> On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
>>>> Hi Greg,
>>>>
>>>> Here are some nvmem patches bit more than usual for 6.3 which includes
>>>>
>>>> - Adding support for nvmem layouts, thanks to Michael and Miquel for
>>>>     driving this effort.
>>>> - Add support to stm32 STM32MP15x OPTEE based nvmem provider
>>>> - Updated to qfprom bindings to include various Qualcomm SoCs.
>>>> - adding sl28vpd provider layout
>>>> - move imx provider to use new layout apis
>>>> - add ONIE provider layout.
>>>> - new helper eth_addr_add().
>>>> - few minor enhancements to core and providersdrivers.
>>>>
>>>> Can you please queue them up for 6.3.
>>>
>>> This series does NOT apply to my char-misc-next branch, which is based
>>> on 6.2-rc5.  What did you generate it against?
>>>
>> These were on top of nvmem-fixes based on 6.2-rc1.
> 
> Ah, always say that please.
My bad, I assumed that fixes will be applied and then these patches. But 
I should have mentioned this clearly.

> 
>>> Can you rebase it and resend?
>>
>> char-misc-next does not have nvmem-fixes yet, which branch should I rebase
>> these on?
> 
> char-misc-next please.  If there are going to be merge conflicts when
> the char-misc-linus branch gets merged into that with these changes, > please let me know.

Yes, for sure this is going to conflict. some of the patches in this set 
are on top of fixes.


--srini


> 
> thanks,
> 
> greg k-h
