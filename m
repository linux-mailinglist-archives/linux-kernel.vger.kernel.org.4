Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55A679345
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAXIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:39:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160093A84E;
        Tue, 24 Jan 2023 00:39:37 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MORN0-1p3Esd3b3e-00Ptcg; Tue, 24 Jan 2023 09:39:17 +0100
Message-ID: <86e02148-c258-3362-90f3-827e7654775e@i2se.com>
Date:   Tue, 24 Jan 2023 09:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <786df750-221e-82fc-a324-d30261296974@i2se.com>
 <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
 <53a8f159-22ab-b280-17b2-b80f59256342@i2se.com>
 <0a00331f-4107-2028-a54b-d600df4e9a68@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <0a00331f-4107-2028-a54b-d600df4e9a68@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OZm4gjq+Oyq8yQpJCH0PJJyTzwGDKUm5wsYb0A7O2LHi9+3J28p
 F3IydMeeKl33mavE4ir4UWy+3c8D/Om/BD9Ay+j69dxcv213o6RknjEggSGz9G0DyVkRl/c
 qxz23sx4jzM4b+4203g38H1NVxD/bwgKgXUjqENpsNcBq4CIeVkbW9QoM2o1tI7GbOwptej
 NPgBRVg/wcVSgErtLPVrg==
UI-OutboundReport: notjunk:1;M01:P0:Q/eL5at20+Q=;eV71iFdyziP9hS9run7pFgCt8cx
 mViK6rFmglMmSU1KNL2GQEoE8sbyP9Cj/XsRvPSDDN8UDEWsWELZKSkobtuGGKZu+eL5civqQ
 pcV2HvXPs7d4WFtKFEg5WNbYxdB3WaKm+vZQuEyaFH2kSUmjnWY1pFkVVS65u11cgUpffks/V
 lPhn/jN+0sotfi0toVs9NA3XdlB7mi9Sa28S+xgV9xZbRpNhRvNP9NLyZ+/o0tT/WYlDN//h2
 Uv9LRBXiKujZWZKPDYcIAxJYrNxjwhN3GSNlW/vNbub4ds9FMTaJ3LGLpLy7qfSTbu19Y41gp
 uVXKdoBmr/4bmq2n0vfAA0gI9GZf/0toEN635ieWzypG+dwRS2o2qSNiJpYbdVdD+0iWxlozK
 MSGtfDOls5GtEAgb69QuvugRZS/WcU5PTW6gbgSVhrXJy7RG98Pt0Rg+RYEP5BOLGd/gRmHaK
 CQ41EImdgnNDt9JtfD8xE5ecixyXrByuPgClU6Ipr7mAUAJcwCSMXRn9/e10AJqz1pkZOaqzc
 j4NPcTjp7iP2UWTmUBhjiX2ZStlgwXHr2Mdm11SmWGyz3RnUVMgydbTJKFhzb6UmJ/ooX6JwP
 kBANNN8QVhFZyqj8oK3+fSOfDNFV1bkqUt/AvrndFkEpaiu5D77fJkmBWvuGiyGMTRUOiUyWr
 H4uSnBhpXFU8KhFnjsstQH5p5vFG7MLhdk9vjumDwA==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 24.01.23 um 06:39 schrieb Umang Jain:
> Hi Stefan
>
> On 1/23/23 10:58 PM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 23.01.23 um 08:48 schrieb Umang Jain:
>>> Hi Stefan,
>>>
>>> Thank for the testing.
>>>
>>> On 1/23/23 5:04 AM, Stefan Wahren wrote:
>>>> Hi Umang,
>>>>
>>>> Am 20.01.23 um 21:10 schrieb Umang Jain:
>>>>> This series just introduces five extra patches for dropping include
>>>>> directives from Makefiles (suggested by Greg KH) and rebased.
>>>>>
>>>>> The main patch (6/6) removes platform device/driver abuse and moves
>>>>> things to standard device/driver model using a custom_bus. Specific
>>>>> details are elaborated in the commit message.
>>>>>
>>>>> The patch series is based on top of d514392f17fd (tag: next-20230120)
>>>>> of linux-next.
>>>>
>>>> applied this series on top of linux-next and build it with 
>>>> arm/multi_v7_defconfig plus the following:
>>>>
>>>> CONFIG_BCM_VIDEOCORE=y
>>>> CONFIG_BCM2835_VCHIQ=m
>>>> CONFIG_VCHIQ_CDEV=y
>>>> CONFIG_SND_BCM2835=m
>>>> CONFIG_VIDEO_BCM2835=m
>>>> CONFIG_BCM2835_VCHIQ_MMAL=m
>>>>
>>>> and the devices doesn't register on Raspberry Pi 3 B Plus:
>>>>
>>>> [   25.523337] vchiq: module is from the staging directory, the 
>>>> quality is unknown, you have been warned.
>>>> [   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>>>> bcm2835_audio vchiq device
>>>> [   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>>>> bcm2835-camera vchiq device
>>>
>>> I was able to reproduce and it seems the issue here is the change 
>>> mentioned in the cover
>>>
>>> - drop dma_set_mask_and_coherent
>>>
>>> in V6.
>>>
>>> (I usually test patches on RPi 4B with vcsm-cma and bcm2835-isp 
>>> applied so my branch has the DMA hunk included while I was testing V6)
>>>
>>> Below is the hunk which should resolve the issue.
>>>
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>> @@ -6,6 +6,7 @@
>>>   */
>>>
>>>  #include <linux/device/bus.h>
>>> +#include <linux/dma-mapping.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/string.h>
>>>
>>> @@ -72,6 +73,12 @@ int vchiq_device_register(struct device *parent, 
>>> const char *name)
>>>         device->dev.type = &vchiq_device_type;
>>>         device->dev.release = vchiq_device_release;
>>>
>>> +       ret = dma_set_mask_and_coherent(&device->dev, 
>>> DMA_BIT_MASK(32));
>>> +       if (ret < 0) {
>>> +               vchiq_device_release(&device->dev);
>>> +               return ret;
>>> +       }
>>> +
>>>         ret = device_register(&device->dev);
>>>         if (ret) {
>>>                 put_device(&device->dev);
>> Yes, this patch fixes the errors above. But i noticed that the series 
>> also break autoprobing of bcm2835-audio and bcm2835-camera.
>
> For the diff concerned, I am still looking into why is this needed.
>
> Regarding the autoprobing, I have noticed that as well. It seems the 
> probing is automatic for platform driver/devices and we are moving 
> away from the platform driver/devices. So, this is expected I suppose?
>
> Reading from Documentation/driver-api/driver-model/platform.rst
>
> """
> Driver binding is performed automatically by the driver core, invoking 
> driver probe() after finding a match between device and driver. If the 
> probe() succeeds, the driver and device are bound as usual
> """
>
> Should we retain this behavior ?
 From user perspective this behavior change is a regression. So we need 
automatic probing to convince user to use the mainline kernel.
>>>
>>> It seems we need to include the dma_set_mask_and_coherent() even if 
>>> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look 
>>> into why is that/
>>>
>>>  Laurent, any thoughts on this please?
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
