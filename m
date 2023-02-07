Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7C68D77F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBGNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjBGNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:00:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63B39CE6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:00:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so10995100wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8356G0ixrthqJeN28CG9y80D2Z75FJcc11F+7VGnio=;
        b=S3wzBB5NFcZmPn5qH9zTuYEcJa1RBcpsC4cQ+IpUqG5G8wDtO/rNhgluXYICZnpa2E
         h0H191B53OVYM0GecQv2GO5AzzI3KrpV20JXyjN6Bwd9qNhYaOEVyIaL8NkmayyZylxY
         CXt/z/fxlf5yd9ZGyJW66nDvfwqIFU5Ehams64KFxym9mhOXSredFEFxePTVDRSlcJ7T
         rsN16PTsHp0cjCmKdEjdpIkCHxK7daJIDFAdueUYxy/5n8RJDwNdBxMOmPTJlA6HA67e
         muKjYCkA8+rvSX5hvrYiL3UzvL2iY2cUdJeLrSzjP32Taaup9y9JqoJ7+q/1/HwsA8h0
         wEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8356G0ixrthqJeN28CG9y80D2Z75FJcc11F+7VGnio=;
        b=6T2qwKfG8INlwEH1t4uPS4TJUsMhRmQ4NkTizbrBfSKtZPLpdr5x/YU211XL12Dp6z
         +h2AECxPL9BspPmAiR5vfY1ka2FYFlpYi9GVe56ALbX+v//wcwAHxVoL18fORxXkhc/P
         Jy5JEJ9ER6i8imIqZZr7jt6OdSr2moiMRSKdU6N+xVhOTsUoIrNBukYpGdpxZyZ+ek5L
         q+IJeUO2Fs7vjGbnhjcjeaV4dg7qyD65gIRsAzECMm2yIMXddDwuMrQ1wfVlvSM5gl2X
         jsGqmbjGaQ+mdjjYgk6zL7xUCOYAGOwy3lV7rJK5wL5NI1ZZ1ryDjfcszB9q75JR82eT
         XUOw==
X-Gm-Message-State: AO0yUKXUyMOVkeObcP3tpuHg7UYG+87/GTUAtPQFk7rsgg6TZzUfJzWy
        hMFn0Q1qnI//RfHyEvOZfE+2WQ==
X-Google-Smtp-Source: AK7set+FOWndI8Z6n4n8EYKXWdmdd4I/2cAiD7qwm96lBb0MjLTo70rwDS+uJ5+vgp2K0dZOmLirJQ==
X-Received: by 2002:a05:600c:3412:b0:3e0:481:c88f with SMTP id y18-20020a05600c341200b003e00481c88fmr3759507wmp.30.1675774799551;
        Tue, 07 Feb 2023 04:59:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c1c0a00b003dd1c45a7b0sm15203438wms.23.2023.02.07.04.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 04:59:59 -0800 (PST)
Message-ID: <8337e4a3-a25b-aa1a-9409-6fe1fb4ea84e@linaro.org>
Date:   Tue, 7 Feb 2023 13:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhou Furong <furong.zhou@linux.intel.com>
Cc:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-3-m.zatovic1@gmail.com> <Y9ynYmIhygqp3U5u@kroah.com>
 <cd6bd118-68ef-1742-fd9d-08a65872b02c@linux.intel.com>
 <Y+DVyPUXBliomobN@kroah.com>
 <581353bc-cc2c-295b-1f9a-04bcf705261b@linux.intel.com>
 <Y+Hq9gqq9tRhP+eD@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+Hq9gqq9tRhP+eD@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 07:08, Greg KH wrote:
> On Tue, Feb 07, 2023 at 08:36:47AM +0800, Zhou Furong wrote:
>>
>>
>> On 2023/2/6 18:26, Greg KH wrote:
>>> On Mon, Feb 06, 2023 at 05:49:44PM +0800, Zhou Furong wrote:
>>>>
>>>>>> +
>>>>>> +#include <linux/device.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/slab.h>
>>>>>> +#include <linux/wiegand.h>
>>>>>> +#include <linux/dma-mapping.h>
>>>>>> +#include <linux/dmaengine.h>
>>>>>> +#include <linux/property.h>
>>>>>> +
>>>>
>>>> please order headers
>>>
>>> Why?  What order?  For what gain >
>>
>> If all header file ordered in alphabet, it will be easy to find if a header
>> file has been included or not when header file list is long.
> 
> That's what search in your editor is for :)
> 
> This is not a real problem with this code, sorry.

I would say the only argument is reducing conflicts for simultaneous
edits, mostly when adding new headers. If everyone add at the end, you
get conflicts which could not happen if entries were ordered.

Another thing is that actual order allows easier to spot duplicates or
unneeded headers by looking. At least to me it's easier to read.

Best regards,
Krzysztof

