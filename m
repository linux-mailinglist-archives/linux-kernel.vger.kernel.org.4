Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D567934E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjAXImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:42:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4A3BDB2;
        Tue, 24 Jan 2023 00:42:07 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVv8f-1pAAeI0bBd-00RmTC; Tue, 24 Jan 2023 09:41:51 +0100
Message-ID: <39f438f8-c41b-17e6-42ba-9d87098a1eee@i2se.com>
Date:   Tue, 24 Jan 2023 09:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <786df750-221e-82fc-a324-d30261296974@i2se.com>
 <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
 <Y85MOdAVh/fv5HRt@pendragon.ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Y85MOdAVh/fv5HRt@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VAFnV+DT+oBQC6pjDpGX9dQmrvSbaecnSJvqFwdLObeLF3U+WJ7
 0gUn0O7/7P5CwJRm3y/vXeQgycUtY1OmG5IWqcRCNGVUwSArjiME1FVHxBZhUVNrZE2eluP
 Vz/IiFSEP7nhTolp5GM9cIAPw8y/OavmlgSGwntJU59izGY0G1fQyUT4qkSfbpBPEgKR7E5
 res8tP6U7+5Vd6fohQmKQ==
UI-OutboundReport: notjunk:1;M01:P0:RKxdTa9q39w=;LWa7w9PjNO3g7L7iSLQsz3O0kI1
 4IzOwA/7vUdbbxMzw3ghvu8q96sTMIsC51r7AhyHA2IS82bHOzQXPH1O4cRLkAuTbfgg/5fp9
 QVBHrjnfKbo1fjan3ZU2Sio2G4yuB3yvcmPjFdMvCuAwZ56NDapQ/AIEEZbOoxk20yPae/frN
 6PqnKdWyLc/k7Yf3Rj45i5DjHDjk7bQ2CFvgoRuDY4X2epsbAFue0SI21HPuR0oWKLr+GlIqd
 anuLt7HC1IBRz1j8sIkeSRmUnVGSPe1hO7xK8fF7mzCB1mSaB9aRkfBQNx1u6/kMvrJZOr/GS
 tPKbc+nVCH4g46BEclVxk79b4TAj8tkXbBAciBmsyDMupFqoSpEwxEhjygBTOZnE3mJ4/bZ06
 pDGulgBuYgU8LK2dx6xJdilv7aPJlEv5YXtP5zYadPXiCmWu/EXAY13wtpOOJRB3SvOyCy/3W
 ez93k14lL5FM/KLGzNfyyckGKo1wb6CBc0xTn11P9EzRKNfJqeiVG64cWkOkHJhHLh0xNopIh
 eRBOgKUq9/fJu3w1dGZY9m3WlmmXqwUQhTxGwm4mJmo8h/v0sQogT1mDaS9KW//BZc39SEmUX
 WS/LhR2hvbN+Vx5qwr1jWuejScqNTiFK8j5rI7U+/IpcKsUnChGh5XesABs12jkiokh2SFDhX
 YpuEr1MBtOUyoLfGDWX3ZwIOrt8lGIqCotxW6Qh0ww==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Am 23.01.23 um 09:58 schrieb Laurent Pinchart:
> On Mon, Jan 23, 2023 at 01:18:30PM +0530, Umang Jain wrote:
>> Hi Stefan,
>>
>> Thank for the testing.
>>
>> On 1/23/23 5:04 AM, Stefan Wahren wrote:
>>> Hi Umang,
>>>
>>> Am 20.01.23 um 21:10 schrieb Umang Jain:
>>>> This series just introduces five extra patches for dropping include
>>>> directives from Makefiles (suggested by Greg KH) and rebased.
>>>>
>>>> The main patch (6/6) removes platform device/driver abuse and moves
>>>> things to standard device/driver model using a custom_bus. Specific
>>>> details are elaborated in the commit message.
>>>>
>>>> The patch series is based on top of d514392f17fd (tag: next-20230120)
>>>> of linux-next.
>>> applied this series on top of linux-next and build it with
>>> arm/multi_v7_defconfig plus the following:
>>>
>>> CONFIG_BCM_VIDEOCORE=y
>>> CONFIG_BCM2835_VCHIQ=m
>>> CONFIG_VCHIQ_CDEV=y
>>> CONFIG_SND_BCM2835=m
>>> CONFIG_VIDEO_BCM2835=m
>>> CONFIG_BCM2835_VCHIQ_MMAL=m
>>>
>>> and the devices doesn't register on Raspberry Pi 3 B Plus:
>>>
>>> [   25.523337] vchiq: module is from the staging directory, the quality is unknown, you have been warned.
>>> [   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register bcm2835_audio vchiq device
>>> [   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register bcm2835-camera vchiq device
>> I was able to reproduce and it seems the issue here is the change
>> mentioned in the cover
>>
>> - drop dma_set_mask_and_coherent
>>
>> in V6.
>>
>> (I usually test patches on RPi 4B with vcsm-cma and bcm2835-isp applied
>> so my branch has the DMA hunk included while I was testing V6)
>>
>> Below is the hunk which should resolve the issue.
>>
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> @@ -6,6 +6,7 @@
>>     */
>>
>>    #include <linux/device/bus.h>
>> +#include <linux/dma-mapping.h>
>>    #include <linux/slab.h>
>>    #include <linux/string.h>
>>
>> @@ -72,6 +73,12 @@ int vchiq_device_register(struct device *parent,
>> const char *name)
>>           device->dev.type = &vchiq_device_type;
>>           device->dev.release = vchiq_device_release;
>>
>> +       ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>> +       if (ret < 0) {
>> +               vchiq_device_release(&device->dev);
>> +               return ret;
>> +       }
>> +
>>           ret = device_register(&device->dev);
>>           if (ret) {
>>                   put_device(&device->dev);
>>
>> It seems we need to include the dma_set_mask_and_coherent() even if
>> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look into
>> why is that/

Do you have an answer for this?

Thanks

>>
>>    Laurent, any thoughts on this please?
> Nothing that immediately springs to my mind. Can you investigate ?
>
