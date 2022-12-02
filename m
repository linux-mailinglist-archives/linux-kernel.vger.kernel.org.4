Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897E563FF47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiLBD6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLBD6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:58:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAA689AFF;
        Thu,  1 Dec 2022 19:58:19 -0800 (PST)
Received: from [192.168.0.29] (unknown [203.106.200.73])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5F9F6E0;
        Fri,  2 Dec 2022 04:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669953497;
        bh=yS9cTwHJYvLo1gR3yKIhCWRu5S0HptJhYFsRs7tRCiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EoVbDX7McJ1hygZRPYHcW14/B4RqEWQkeDTV7amQm7RUOJGuYPmETFi/45Eo2lJx5
         QzNe0M5St215q4RbQfnio+jfx7pihKS2tN0otuDcgfoIulHz7fl2QO0ZWnifXxjvQj
         cPSA1O1JR9mCIr4tdZh+u9ttOEkILJblEsTSEFJ8=
Message-ID: <910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonboard.com>
Date:   Fri, 2 Dec 2022 11:57:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com>
 <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
 <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com>
 <c73f7261-ec33-ec88-df3e-a34cf9b8015c@ideasonboard.com>
 <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 12/2/22 6:45 AM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 30.11.22 um 11:58 schrieb Umang Jain:
>> Hi Stefan,
>>
>> On 11/27/22 6:56 AM, Stefan Wahren wrote:
>>> Hi Umang,
>>>
>>> Am 26.11.22 um 17:26 schrieb Umang Jain:
>>>> Hi Stefan
>>>>
>>>> On 11/26/22 8:12 PM, Stefan Wahren wrote:
>>>>> Hi Umang,
>>>>>
>>>>> Am 21.11.22 um 22:47 schrieb Umang Jain:
>>>>>> This series aims to upport bcm2835-isp from the RPi kernel [1] 
>>>>>> and is a
>>>>>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
>>>>>> receiver IP core("Unicam) + the ISP driver found in BCM283x and 
>>>>>> compatible
>>>>>> SoCs (namely BCM2711). Unicam is still under active development 
>>>>>> to work
>>>>>> with multistream support to get into mainline. Hence only the ISP 
>>>>>> driver
>>>>>> will remain the primary area of this series.
>>>>>
>>>>> thanks for working on this. But honestly i would prefer that vchiq 
>>>>> comes out of staging before adding more features. As Greg said 
>>>>> some time ago staging is not a place to "dump code and run away". 
>>>>> These new files are in the same bad shape as the rest of vc04 
>>>>> before the clean-up here in staging started.
>>>>
>>>> Certainly, I am not here to do that - but I am still learning the 
>>>> ropes.
>>> no problem.
>>>>
>>>> If the staging issue is becoming a blocker for bcm2835-isp going 
>>>> upstream, I would be happy to help here! Though I must mention that 
>>>> I still have limited visibility so my aim would be to chart out a 
>>>> plan of things needed to be done to get vc04_services out of staging!
>>>
>>> The vchiq driver is in staging since 2016, so every step forwards is 
>>> good. Unfortunately all of the low hanging fruits has been gathered.
>>>
>>> For me the most important, but not to tricky steps to get vchiq out 
>>> of staging would be:
>>>
>>> * Cleanup logging mechanism
>>>
>>> * Get rid of custom function return values
>>>
>>> There was already an attempt for this [1]
>>>
>>> * Get rid of all non essential global structures and create a proper 
>>> per
>>> device structure
>>>
>>>>
>>>>>
>>>>> I agree that VCSM is on the TODO list for vchiq, but this driver 
>>>>> is not necessary for making bcm2835-audio & bcm2835-camera leave 
>>>>> staging. It just binds more resources on a new feature.
>>
>> bcm2835-camera is the legacy camera stack which probably need to be 
>> dropped from hereon...
> I don't not know if there any users left, so i would be careful here. 
> Can bcm2835-isp completely replace bcm2835-camera? Sorry, for this 
> dumb question but i'm not expert here.

I am careful too here and probably need Input from RaspberryPi in order 
to proceed to drop it. But from my perspective - bcm2835-camera is _not_ 
going out of staging - it'll either sit here (or probably dropped) as 
statied from [1]

```
+ * There are two camera drivers in the kernel for BCM283x - this one
+ * and bcm2835-camera (currently in staging).
```

The bcm2835-camera is meant to be replaced by unicam [1] , but the ISP 
(bcm2835-isp) is meant to be worked with unicam [1]. In fact, I have 
mentioned in my cover the testing of bcm2835-isp happened on top of 
unicam patches.

[1]: 
https://lore.kernel.org/linux-media/20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com/
>>>>
>>>> I see two TODO files in vc04_services:
>>>>     ./bcm2835-camera/TODO
>>>>     ./interface/TODO
>>>>
>>>> One of the bcm2835-camera TODO points to the vc-sm-cma driver 
>>>> itself. So that's address in the series. The other remaining one - 
>>>> I will need to take a deeper look before commenting on it.
>>>>
>>>> The main chunk of TODO are in vc04_services/interfaces/TODO. Doing 
>>>> a cursory reading of them suggests that these apply to *all* 
>>>> vc04_services components? Am I right?
>>> Actually these applies just for the interfaces directory. Some of 
>>> them could apply to the services, but this is no priority.
>>
>> By no priority, you mean this doesn't affect the criteria required to 
>> ful-fill to get these out of staging?
> Correct
>>>>
>>>> Are these are the specific bits of cleanup you are referring to in 
>>>> your comment?
>>>
>>> You mean about bcm2835-isp? There were too many changes to vchiq 
>>> that i don't remember them all. The first that come to my mind was 
>>> those fancy comment sections which is not kernel coding style. It 
>>> has been removed.
>>
>> No, I don't mean the bcm2835-isp changes (those are upcoming / 
>> out-of-tree still so...). I mean what are the specific bits / points 
>> that needs to be addressed to get vc04_services out of the staging.
> These were the points which i mentioned in my last email. They came 
> from interface/TODO.
>>
>> You have mentioned it above now, so I'll follow up on those.
> That would be great :)
>> The many vchiq changes you referred to above comment (that you don't 
>> remember) are from [1] as well or some other series ?
> Sorry, for the confusing. The many changes i refer were the dozens of 
> clean up patches for vc04_interfaces in mainline staging since the 
> last years. [1] was just a single patch which has been accepted yet.

Ah I see. There are many others that I've to dig out then. Thanks for 
clarifying!
>>
>>>
>>> [1] - 
>>> https://lore.kernel.org/linux-staging/20220712181928.17547-1-jslebodn@redhat.com/
>>>
>>>>
>>>>
>>>>>
>>>>> Unfortuntately i hadn't much time to work on vchiq by myself.
>>>>>
>>>>> Just my two cents
>>>>> Stefan
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

