Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE9678032
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjAWPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjAWPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:42:52 -0500
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 07:42:34 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EB2BEE1;
        Mon, 23 Jan 2023 07:42:34 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5W0q-1odYGM3rcA-016zDA; Mon, 23 Jan 2023 16:29:01 +0100
Message-ID: <40196216-79bc-0dff-d7d2-dee3bc53a38d@i2se.com>
Date:   Mon, 23 Jan 2023 16:28:58 +0100
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
 <912601ba-c60d-8d69-f061-62b854c5d9ce@i2se.com>
 <4e4215a7-c733-9ea6-dad8-9bf53dc9e891@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <4e4215a7-c733-9ea6-dad8-9bf53dc9e891@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nwv1a9eVEttVMa+Xetvukvdky5ojIjEy6AquHuhtGboW48xcu8l
 3VQHVQlEdDd+Vg8yaFi7X+CNX5L2+z6wfLPLRcfYQNtapy4DYgl2d62MPFuq2d03sdJEq5b
 nTE0QMYUAkA/8KyWQeEW101uizo9dIJD3bus8TBUjvBfwipwdXr3VzcLni4YHyRE/ot7tfB
 z11S8n1XOEi1GxImLlaaQ==
UI-OutboundReport: notjunk:1;M01:P0:hxl28o865m0=;SBm4v7KbfyiekMbUvL5IWQLYbv8
 nfi/HLyPxlYoCq52ziiPpMAOtNEY7KU0wEppwdCUctIJSOH6PEt4DHn47qFXAe/b8Jz3YbDA2
 Q7oPYur+T3sdR4g6VixuPDu70to1Eh8uiL39GFR6M6sYdlQEyCcpH/c2wOcbbuwWGkNeMpTON
 AT/Z7YOiXjNOjMAaw837L70BgxV5cOoP8EpmXOhorT2GxTex5lWxquIsBC47mmcCFL0jCZ7NO
 isqYqqiTlIo4fnpgvc6Fe5da98Z7lWApm5BIE73xGSRwtDxDEfvZ+/z94jKdHgP/swSbk76S8
 C4JY3WnKqIU6MBTL+vvOFBMFiW+rwS+Jd8RdfTQDpOrcg41UL5RmGpHKcBgJOL1vjdyTBcsqa
 H1baNF3vl3LiY4WAL1OGLr6tBmAeEghGtcvsusDBN01fkjgOKZvh6nSmsxY/5XqAN7NMx7i1I
 YomlvBrozipGY84SdgUM5wrfFbFT0m850tTDz4LnMwvFNH5UbkI/ayukr3Hvd9dn6fJXzw6Np
 G9D1bFn1mcpQBOm2uNrpq0FtjIeWNeFka4cy4CXBgQC9GYGjAVl4yWpBCLVZ4/kKu1v7l+6PI
 sMazgd7ziHkhi9FjaDGyAQnKWgLpsgNv9e8WorLZFIzijZFDrbDHgYN3x4ufCHOmNy5UIddyB
 4enEzqohw0y2nWsb4rgJHDpmtIWL5SZcBZLCsCzXsA==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 23.01.23 um 15:12 schrieb Umang Jain:
> Hi Stefan
>
> On 1/23/23 5:16 PM, Stefan Wahren wrote:
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
>>
>> just to avoid misunderstandings, did you read 
>> drivers/staging/vc04_services/interface/TESTING ?
>
> Yes, but it's not geared towards the hardware I have (Rpi Model 4B)
>>
>> The Raspberry Pi 4 is currently not fully supported for VCHIQ in 
>> mainline. From my limited understanding the DMA controller driver 
>> needs 40 bit support, so VCHIQ on BCM2711 can use it. This part is 
>> currently only available in the vendor tree. The reason why the 
>> driver is unexpectedly probing is a historical issue in the 
>> devicetree :-(
>>
>> Raspberry Pi 4 support is not considered as necessary for moving out 
>> of staging.
>>
>
> While I am looking into what's the reason behind the hunk, without 
> which the devices cannot get registered... This is not related to the 
> 40bit support for DMA. I remember that it worked without it during the 
> bcm2835-isp development.
>
> Are you implying that I should not use RPi Model 4B for testing ? 
> Because that's the only RPi hardware I own.

No, i didn't want to imply this. It's just a warning that's currently 
not the best platform for testing. But i also understand that nowadays 
users have a BCM2711 based Raspberry Pi.

This leads to another question which device tree do you use for testing, 
since the mainline one doesn't have the right compatible for BCM2711?

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
>>>
>>> It seems we need to include the dma_set_mask_and_coherent() even if 
>>> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look 
>>> into why is that/
>>>
>>>  Laurent, any thoughts on this please?
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
