Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031B624C06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKJUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:38:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7DBF5F;
        Thu, 10 Nov 2022 12:38:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 21so4968638edv.3;
        Thu, 10 Nov 2022 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axqvwts+RXOQrxi0yBwj7CuDiinCy4GhvQvXh0tepmc=;
        b=YT9oNPi8V7HlLMkveUSYgupjg3OotUw/B3+QR21ueZfUyTfZt0gS8/Ox0OuHCtP4nW
         jkxC0WkJWzp8v8rJEPNqeYa+XprAF6TmTuFY4tuHAvu9Wqf6qSyHwhsVIxm6Qj1Nao1o
         G2rQQFE0AJGWR5MRO7LZ8qK/rHAd4sX56oZEf1PHsGQ3G9PL+gz6L43O9C5JNBEk/iAz
         x05cr9W4wx2Za+XOArmEV20IG2BNI7XFNW0x3RHF0kIIxsL9Mw+Auyty2L65vZRtaHDf
         wHdL7XLZNsL2QSevnEp2y95W/4rj/nyDZjKsKWBvArw6WNEJZhPH514zcv6GpA3XY9Ts
         DI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axqvwts+RXOQrxi0yBwj7CuDiinCy4GhvQvXh0tepmc=;
        b=KXx860NiFXiOf2fHYl92piPGSfNlSHcwHR8Oop1b/9Rx5RJO14LymXiXN0feiMf+PN
         QWhydgJXrDLGadzFdmUa5Gx1J4/K0+Q9CeaVUC9PH2MQYk843XM63pJ1M+w8Hpw9Ib5F
         2DYDKSvguQoarR+M0wy54lnjo53Un89cmRx7BOTxZ9eh8cWWIM5me7xEbtvOBp9EzgyH
         lh/s1iOFJSKOPwJCmeaHm0C8QeoyYojW2gyZkl8NNuX4bEHF0BfFkm32Mf4Kwp/h/yqC
         p8Jpum1wsHrvq55SIce6zDTHMpbqej+DALUmSefYNlpD0q/lhvCjCMVc7DBYEoHb3rre
         6ecQ==
X-Gm-Message-State: ACrzQf2KuXF34ULne7tkxiU1OVTjuv83A4G6BsUrABYU5U1sekHBFDIt
        gkpFcUAVLkFvTOa+kn7ec0k=
X-Google-Smtp-Source: AMsMyM7cHs8tfyfg99cNq1EPeMmVIb+aw/A5V3pUfoX1JSFDwwhadvciIfOuYQS70zrdxxSFhMhEPQ==
X-Received: by 2002:a05:6402:b34:b0:461:a7e0:4684 with SMTP id bo20-20020a0564020b3400b00461a7e04684mr3473578edb.267.1668112720289;
        Thu, 10 Nov 2022 12:38:40 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:7ff6:3899:7171:85b5? (2a02-a466-68ed-1-7ff6-3899-7171-85b5.fixed6.kpn.net. [2a02:a466:68ed:1:7ff6:3899:7171:85b5])
        by smtp.gmail.com with ESMTPSA id u24-20020aa7db98000000b0046267f8150csm276070edt.19.2022.11.10.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 12:38:39 -0800 (PST)
Message-ID: <48e7b906-d7e3-46e3-e2bc-71512a1e64aa@gmail.com>
Date:   Thu, 10 Nov 2022 21:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
 <20221110000643.xdoav4c4653x3tjd@synopsys.com>
 <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
In-Reply-To: <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Op 10-11-2022 om 13:45 schreef Ferry Toth:
> (sorry sent html with previous attempt)
> 
> On 10-11-2022 01:06, Thinh Nguyen wrote:
>> Hi Ferry,
>>
>> On Wed, Nov 09, 2022, Ferry Toth wrote:
>>> Since commit 0f010171
>>> Dual Role support on Intel Merrifield platform broke due to rearranging
>>> the call to dwc3_get_extcon().
>>>
>>> It appears to be caused by ulpi_read_id() on the first test write 
>>> failing
>>> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy 
>>> via
>>> DT when the test write fails and returns 0 in that case even if DT 
>>> does not
>>> provide the phy. Due to the timeout being masked dwc3 probe continues by
>>> calling dwc3_core_soft_reset() followed by dwc3_get_extcon() which 
>>> happens
>>> to return -EPROBE_DEFER. On deferred probe ulpi_read_id() finally 
>>> succeeds.
>>>
>>> This patch changes ulpi_read_id() to return -ETIMEDOUT when it occurs 
>>> and
>>> catches the error in dwc3_core_init(). It handles the error by calling
>>> dwc3_core_soft_reset() after which it requests -EPROBE_DEFER. On 
>>> deferred
>>> probe ulpi_read_id() again succeeds.
>>>
>>> Signed-off-by: Ferry Toth<ftoth@exalondelft.nl>
>>> ---
>>>   drivers/usb/common/ulpi.c | 5 +++--
>>>   drivers/usb/dwc3/core.c   | 5 ++++-
>>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>> Can you split the dwc3 change and ulpi change to separate patches?
> 
> Thanks for your comments.
> 
> I will send v2
> 
>>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>>> index d7c8461976ce..d8f22bc2f9d0 100644
>>> --- a/drivers/usb/common/ulpi.c
>>> +++ b/drivers/usb/common/ulpi.c
>>> @@ -206,8 +206,9 @@ static int ulpi_read_id(struct ulpi *ulpi)
>>>       /* Test the interface */
>>>       ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
>>> -    if (ret < 0)
>>> -        goto err;
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>>       ret = ulpi_read(ulpi, ULPI_SCRATCH);
>>>       if (ret < 0)
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 648f1c570021..e293ef70039b 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1106,8 +1106,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>>       if (!dwc->ulpi_ready) {
>>>           ret = dwc3_core_ulpi_init(dwc);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            dwc3_core_soft_reset(dwc);
>> We shouldn't need to do soft reset here. The controller shouldn't be at
>> a bad/incorrect state at this point to warrant a soft-reset. There will
>> be a soft-reset when it goes through the initialization again.
> 
> It doesn't go through the initialization again unless we set 
> -EPROBE_DEFER. And when we make ulpi_read_id() return -EPROBE_DEFER it 
> will goto err0 here, so skips dwc3_core_soft_reset.
> 
> Do you mean you prefer something like:
> 
> if (ret) {
> 
>      if (ret == -ETIMEDOUT) ret = -EPROBE_DEFER;
> 
>      else goto err0;
> 
> }

I just tested, and calling dwc3_core_soft_reset() proves to be necessary 
as we need to goto err0 directly after. Else ret is overwritten and 
-EPROBE_DEFER lost.

>>> +            ret = -EPROBE_DEFER;
>> We shouldn't automatically set every error status to correspond to
>> -EPROBE_DEFER. Check only the approapriate error codes (-ETIMEDOUT +
>> any other?).
> Other could be -ENOMEM. I think no need to do any new handling for that.
>>>               goto err0;
>>> +        }
>>>           dwc->ulpi_ready = true;
>>>       }
>>> -- 
>>> 2.34.1
>>>
>> Thanks,
>> Thinh
