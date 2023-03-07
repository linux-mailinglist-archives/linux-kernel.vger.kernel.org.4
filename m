Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE46AD5EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCGD54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGD5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:57:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B155073;
        Mon,  6 Mar 2023 19:57:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso15269937pjr.5;
        Mon, 06 Mar 2023 19:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678161471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FPLOWaVxVCCBhzRV2S92byeSbIS0afy5smPLrPXfs4=;
        b=idkJNa3rn1lAAfpAtWvpYu7kiwO8xmURjpVzLJZc3j23n5kuRdt+KWfcYWYWbikFXt
         31sDlhB4LhRN618DtrtjIshj9IHdQY5q4Tncq2hqtmqZZC8ClJPCcfvCrUSjg4v5iOjk
         C18N5SxpYp51ad+8amio/1pXAdvyE5yk2KC8gZHhqKcgNOpsmat/rwPFLanFzeOMB2sL
         diu35vC9m1RPgxYsoVLpubmZioxMvzdtGgU4kKVIrP30SxIS2Us/AY1dCGtPylDHHOVW
         fSUCcvJq5pJXWJePG5kdTY5VvXP2KbV7/qFcLLIIJqukRl4W3c4aJc2RNFe9e3NME06U
         imcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678161471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FPLOWaVxVCCBhzRV2S92byeSbIS0afy5smPLrPXfs4=;
        b=cfrDeU0GBVv0qK0yqFZ8FVz8eI9ahwUW4A2Kv5i+v8aCDSJNuvh3eC8T5DB2h9n7BT
         B5LENYx6AmikoFtar3UTB4rIgdJ6CKBb/yEm6rvQoyHau/vqIExI3mZZML+FRug3cF8T
         JxVt6OCiAt1fx/oZSYViqbUTIDEMWIaYZXaaRPg5nOa5ltPpq1BLdp0zV7V9x99jt+qL
         bUNHm+whmI5jL5nJO4LLbfMpAbUoUev/JOxvszdhQyT8Wsn6Qi23ajo6Xxnr9VB+eAqy
         Uvy3nOQKOLYzHgA0D0eHd0U510v/peJroQxcar49yGKkSVji92WIyHhmK7/X1XeTQ5Vh
         7RHA==
X-Gm-Message-State: AO0yUKUuhu0iVZ3WaW66Iw5SArE+S4wl7Psvv3y4o38R28150iPHm/Yu
        XtOdIeF5uCdgXpe76BBcwqbs3tZfePg=
X-Google-Smtp-Source: AK7set9Tr6vGajFHWlit6Qu/oQACQDuh4CWO3E96yK6CnVUGffWfw5kAML1oHdxPWtfPHi3yro9uFA==
X-Received: by 2002:a17:902:8a82:b0:19e:874e:7275 with SMTP id p2-20020a1709028a8200b0019e874e7275mr11115540plo.23.1678161471162;
        Mon, 06 Mar 2023 19:57:51 -0800 (PST)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019e88453492sm7451416plc.4.2023.03.06.19.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 19:57:50 -0800 (PST)
Message-ID: <c4669a04-ed3c-da7e-b04c-813122385e1c@gmail.com>
Date:   Mon, 6 Mar 2023 19:57:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
 <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
 <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
 <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
 <05bc8f6e-b0cc-2ae6-db7a-ad90b3e69778@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <05bc8f6e-b0cc-2ae6-db7a-ad90b3e69778@i2se.com>
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



On 3/5/2023 7:00 AM, Stefan Wahren wrote:
> Hi,
> 
> Am 03.03.23 um 18:22 schrieb Florian Fainelli:
>> On 3/3/23 03:57, Stefan Wahren wrote:
>>> Hi,
>>>
>>> Am 02.03.23 um 18:51 schrieb Florian Fainelli:
>>>>
>>>>
>>>> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
>>>>> On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren 
>>>>> <stefan.wahren@i2se.com> wrote:
>>>>>>
>>>>>> Hi Saravana,
>>>>>>
>>>>>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
>>>>>>> This allow fw_devlink to do dependency tracking for serdev devices.
>>>>>>>
>>>>>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>>> Link: 
>>>>>>> https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
>>>>>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>>
>>>>>> since this fixes an issue on Raspberry Pi 4, shouldn't this be 
>>>>>> mentioned
>>>>>> in the commit message and providing a Fixes tag?
>>>>>
>>>>> So RPi 4 was never creating a device links between serdev devices and
>>>>> their consumers. The error message was just a new one I added and we
>>>>> are noticing and catching the fact that serdev wasn't setting fwnode
>>>>> for a device.
>>>>>
>>>>> I'm also not sure if I can say this commit "Fixes" an issue in serdev
>>>>> core because when serdev core was written, fw_devlink wasn't a thing.
>>>>> Once I add Fixes, people will start pulling this into stable
>>>>> branches/other trees where I don't think this should be pulled into
>>>>> older stable branches.
>>>>
>>>> That is kind of the point of Fixes: tag, is not it? It is 
>>>> appropriate to list a commit that is not specific to serdev, but 
>>>> maybe a particular point into the fw_devlink history. Given this did 
>>>> not appear to have a functional impact, we could go without one.
>>>
>>> i was under the impression that this issue breaks at least Bluetooth 
>>> on Raspberry Pi 4 because the driver is never probed. I cannot see 
>>> the success output in Florian's trace. Something like this:
>>>
>>> [    7.124879] hci_uart_bcm serial0-0: supply vbat not found, using 
>>> dummy regulator
>>> [    7.131743] hci_uart_bcm serial0-0: supply vddio not found, using 
>>> dummy regulator
>>> ...
>>> [    7.517249] Bluetooth: hci0: BCM: chip id 107
>>> [    7.517499] Bluetooth: hci0: BCM: features 0x2f
>>> [    7.519757] Bluetooth: hci0: BCM4345C0
>>> [    7.519768] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
>>> [    7.539495] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
>>> ...
>>> [    8.348831] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
>>> [    8.348845] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
>>>
>>> I just want to make sure that 6.2 doesn't have a regression.
>>
>> My configuration uses hci_uart as a module, and it would always load 
>> fine, but I suppose I can make sure that even built-in this works 
>> properly. Give me a day or two to test that.
> 
> okay, this is fine. From my point of view this is not necessary to test 
> built-in.
> 
> I tested latest mainline with Raspberry Pi 4 (multi_v7_defconfig + 
> ARM_LPAE) and there is no regression:
> 
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Tested with making the BT drivers built-in with and without the patch 
and it still worked OK in both cases.
-- 
Florian
