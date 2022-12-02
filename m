Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3120640702
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiLBMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiLBMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:42:10 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08555D4AD7;
        Fri,  2 Dec 2022 04:42:08 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.27]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9dkB-1oxG471d5h-015ajP; Fri, 02 Dec 2022 13:41:54 +0100
Message-ID: <845957f9-46fc-d264-977e-7c3339c4d5c9@i2se.com>
Date:   Fri, 2 Dec 2022 13:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
Content-Language: en-US
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com>
 <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
 <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com>
 <c73f7261-ec33-ec88-df3e-a34cf9b8015c@ideasonboard.com>
 <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com>
 <910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonboard.com>
 <Y4nCnEwqs69QezPn@pendragon.ideasonboard.com>
 <CAPY8ntAK9yh6ZQkuOrZqUn2GC2=qGaJrcxEjWyGep7KcWvxkhQ@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CAPY8ntAK9yh6ZQkuOrZqUn2GC2=qGaJrcxEjWyGep7KcWvxkhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w7cbRFiuQ7ESWHggXOZ6OFp0NpMSvLOkpmddNzQrRZlFeltTkNb
 90atBuC80RgeSIFNLs1J+PrGAFDMFTpf67HcWUizPzCa1eaGCUrXxzw+ZVYHExYKwmYUYL2
 MHWzC79iQ82mUrNYhbV/ov12YVeGOos+rMnYYoZw/L19WUox6FOftJdc3gxrwX37VkA86+J
 ji+eKMcu91xbE//BFW92g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ohjx5ZX6tjw=:1xrVlpB2f2i7znKu7Oav15
 4PzQTIwq16s0qjEaamR1SXmg77Y2XGf4gu6Pz5H3xjyQlRCqtPl1hlPXZP8iePjFghizqx1ou
 WTDbzc7R3t0cShDrvxxIfa7leVBP9g/R17jrzsA7OSyl8ELxuMP7KSfJxmvL39iV5bLJxAdPb
 l3LfPLL6Q71ZKMzAiw8U24MyUKcuOid5Izqx9IxMJ1Q/kCTN2mzBQxmNsqKbeJhtGyzMjIaP5
 MmnQwSfLlx63QnD7/5FdYKZo1BmNDP8n/Yvk9plq8eiOFfYkncZHGmQt/PeY30seZLF2s1hxf
 eHbBJdkGmsH4AYJ00C3ASzaSIbNy1uxwTIAPFbfMx/YoPlY1u9yvjxkT3G5cNjgsUgeQ5H/gj
 XA7OBlYep4DV2dKoRRXLYsd4MstESEMVigRTu15KR3yiDqoiGtk5RDPuBmuAe9g6OtuQn2l4n
 yOCVNNB8IkCpr23UYhy9euaDqY7T18VMz+S5zrHBjcnITcVLk1nZEIMr43DwcOzBjm+lM1loI
 YCclJyljNDBhpPShRLleAxne5/25N3MTKmttRCa13C7rqW2Py3GQgtGb/WUPEV7vZKibcIgGO
 jlQ6IGal3FgYuMtHdL49TvVKLBQBx/DFY7mlRxGOWoont9XjdJV8NnpPm9Rr2hTZwKn/jIRHK
 RoqlGX4ktYL/XdR5hTk9ZE01lnPUfHZ/iQnWXrCmoOKTGLc+TmfVYmrebPg7Su85d2TE4Ash/
 4O1y1cveAxJ6/uWq76YLRG8XeN+VQmIfomDMYJ6jg35dlxCqIC/szo9eQNm0Ii3BiX7g5Mxwt
 Bc+qA/c/hT3ZNjQOzxXsg6S+sNfxQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Am 02.12.22 um 12:23 schrieb Dave Stevenson:
> Hi Laurent, Umang, and Stefan.
>
> On Fri, 2 Dec 2022 at 09:17, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Umang,
>>
>> On Fri, Dec 02, 2022 at 11:57:18AM +0800, Umang Jain wrote:
>>> On 12/2/22 6:45 AM, Stefan Wahren wrote:
>>>> Am 30.11.22 um 11:58 schrieb Umang Jain:
>>>>> On 11/27/22 6:56 AM, Stefan Wahren wrote:
>>>>>> Am 26.11.22 um 17:26 schrieb Umang Jain:
>>>>>>> On 11/26/22 8:12 PM, Stefan Wahren wrote:
>>>>>>>> Am 21.11.22 um 22:47 schrieb Umang Jain:
>>>>>>>>> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
>>>>>>>>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
>>>>>>>>> receiver IP core("Unicam) + the ISP driver found in BCM283x and compatible
>>>>>>>>> SoCs (namely BCM2711). Unicam is still under active development to work
>>>>>>>>> with multistream support to get into mainline. Hence only the ISP driver
>>>>>>>>> will remain the primary area of this series.
>>>>>>>> thanks for working on this. But honestly i would prefer that vchiq
>>>>>>>> comes out of staging before adding more features. As Greg said
>>>>>>>> some time ago staging is not a place to "dump code and run away".
>>>>>>>> These new files are in the same bad shape as the rest of vc04
>>>>>>>> before the clean-up here in staging started.
>>>>>>> Certainly, I am not here to do that - but I am still learning the ropes.
>>>>>> no problem.
>>>>>>
>>>>>>> If the staging issue is becoming a blocker for bcm2835-isp going
>>>>>>> upstream, I would be happy to help here! Though I must mention that
>>>>>>> I still have limited visibility so my aim would be to chart out a
>>>>>>> plan of things needed to be done to get vc04_services out of staging!
>>>>>> The vchiq driver is in staging since 2016, so every step forwards is
>>>>>> good. Unfortunately all of the low hanging fruits has been gathered.
>>>>>>
>>>>>> For me the most important, but not to tricky steps to get vchiq out
>>>>>> of staging would be:
>>>>>>
>>>>>> * Cleanup logging mechanism
>>>>>>
>>>>>> * Get rid of custom function return values
>>>>>>
>>>>>> There was already an attempt for this [1]
>>>>>>
>>>>>> * Get rid of all non essential global structures and create a proper per
>>>>>> device structure
>>>>>>
>>>>>>>> I agree that VCSM is on the TODO list for vchiq, but this driver
>>>>>>>> is not necessary for making bcm2835-audio & bcm2835-camera leave
>>>>>>>> staging. It just binds more resources on a new feature.
>>>>> bcm2835-camera is the legacy camera stack which probably need to be
>>>>> dropped from hereon...
>>>> I don't not know if there any users left, so i would be careful here.
>>>> Can bcm2835-isp completely replace bcm2835-camera? Sorry, for this
>>>> dumb question but i'm not expert here.
>>> I am careful too here and probably need Input from RaspberryPi in order
>>> to proceed to drop it. But from my perspective - bcm2835-camera is _not_
>>> going out of staging - it'll either sit here (or probably dropped) as
>>> statied from [1]
>>>
>>> ```
>>> + * There are two camera drivers in the kernel for BCM283x - this one
>>> + * and bcm2835-camera (currently in staging).
>>> ```
>>>
>>> The bcm2835-camera is meant to be replaced by unicam [1] , but the ISP
>>> (bcm2835-isp) is meant to be worked with unicam [1]. In fact, I have
>>> mentioned in my cover the testing of bcm2835-isp happened on top of
>>> unicam patches.
>> To be accurate, the bcm2835-camera driver supports the VC4
>> firmware-based camera stack. In that setup, the camera sensors (OV5647
>> or IMX219), CSI-2 receiver (Unicam) and ISP are all controlled by the
>> firmware, which provides a high-level interface towards the kernel. This
>> architecture has been replaced by Linux-side control of the camera
>> sensors (through existing drivers in drivers/media/i2c/), Unicam
>> (through the driver from [1]) and ISP (through this driver). Moving
>> control to the Linux side requires complex processing in userspace,
>> handled by libcamera.
>>
>> bcm2835-camera is thus replaced by multiple drivers combined with
>> libcamera, and that is the camera stack that is shipped by Raspberry Pi
>> these days. While this may affect some userspace use cases), we will not
>> work on destaging bcm2835-camera, and as far as I'm aware, nobody else
>> is planning to do so either. I don't mind much if the driver stays in
>> staging for some more time, but I'd rather drop it if possible.
Thanks for clarification. Okay, so Unicam + bcm2835-isp are able to 
handle the old camera (OV5647)?
> It would be reasonable to drop it at the point that Libcamera can work
> to a similar level with at least the following list of applications:
> - FFmpeg
> - Gstreamer
> - Chromium
> - Firefox
> - Motion
> And that still leaves a huge number of existing V4L2 apps out in the cold.
>
> Do you wish to make any predictions as to when that would be
> achievable? Or even when a v1.0 release of libcamera is going to
> happen?
> Dropping anything prior to those points would be rather premature in my book.
>
>
> The TODOs on bcm2835-camera are:
> 1) Zero copy. That comes almost for free as bcm2835-isp already does
> this, but it does rely on vcsm-cma.
> The main reason I haven't pushed it is that it then requires
> reasonable amounts of CMA heap for all the buffers, which until
> recently haven't been present in the default configurations. With the
> vc4 DRM driver now being default (at least for the vendor kernel) and
> also requiring CMA, making the change makes more sense.
> AFAIK there is no easy way to have one driver choosing between using
> vb2_vmalloc_memops and vb2_dma_contig_memops at runtime, but I may be
> wrong.
> Actually bcm2835_defconfig appears to only allocate a 32MB CMA heap,
> so perhaps we don't get very far.
CMA configuration should actually happen in device tree or kernel 
cmdline. The bcm2835_defconfig is limited to make it work even with the 
original Pi.
>
> 2) This isn't workable within the current V4L2 frameworks. The
> multi-planar V4L2 pixel formats are currently allocated as independent
> buffers for each plane, whereas the firmware needs a single buffer
> with (currently) specific offsets for the chroma planes. The
> V4L2/videobuf2 core changes required to implement that are going to be
> significant, and have minimal gain.
> The specific stride handling is already dealt with (set bytesperline
> appropriately), it's the padding of the height to a multiple of 16
> before the chroma planes on YUV420 and NV12 formats that require the
> firmware to do a small amount of repacking. The performance hit is
> actually minimal anyway.
>
> If bcm2835-camera is the only thing holding back vc04_services, then I
> can have a look at it.

No, it's the vchiq interface which needs the work.

Thanks Stefan

>
>    Dave
>
>>> [1]: https://lore.kernel.org/linux-media/20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com/
>>>
>>>>>>> I see two TODO files in vc04_services:
>>>>>>>      ./bcm2835-camera/TODO
>>>>>>>      ./interface/TODO
>>>>>>>
>>>>>>> One of the bcm2835-camera TODO points to the vc-sm-cma driver
>>>>>>> itself. So that's address in the series. The other remaining one -
>>>>>>> I will need to take a deeper look before commenting on it.
>>>>>>>
>>>>>>> The main chunk of TODO are in vc04_services/interfaces/TODO. Doing
>>>>>>> a cursory reading of them suggests that these apply to *all*
>>>>>>> vc04_services components? Am I right?
>>>>>> Actually these applies just for the interfaces directory. Some of
>>>>>> them could apply to the services, but this is no priority.
>>>>> By no priority, you mean this doesn't affect the criteria required to
>>>>> ful-fill to get these out of staging?
>>>> Correct
>>>>
>>>>>>> Are these are the specific bits of cleanup you are referring to in
>>>>>>> your comment?
>>>>>> You mean about bcm2835-isp? There were too many changes to vchiq
>>>>>> that i don't remember them all. The first that come to my mind was
>>>>>> those fancy comment sections which is not kernel coding style. It
>>>>>> has been removed.
>>>>> No, I don't mean the bcm2835-isp changes (those are upcoming /
>>>>> out-of-tree still so...). I mean what are the specific bits / points
>>>>> that needs to be addressed to get vc04_services out of the staging.
>>>> These were the points which i mentioned in my last email. They came
>>>> from interface/TODO.
>>>>
>>>>> You have mentioned it above now, so I'll follow up on those.
>>>> That would be great :)
>>>>
>>>>> The many vchiq changes you referred to above comment (that you don't
>>>>> remember) are from [1] as well or some other series ?
>>>> Sorry, for the confusing. The many changes i refer were the dozens of
>>>> clean up patches for vc04_interfaces in mainline staging since the
>>>> last years. [1] was just a single patch which has been accepted yet.
>>> Ah I see. There are many others that I've to dig out then. Thanks for
>>> clarifying!
>>>
>>>>>> [1] -
>>>>>> https://lore.kernel.org/linux-staging/20220712181928.17547-1-jslebodn@redhat.com/
>>>>>>
>>>>>>>> Unfortuntately i hadn't much time to work on vchiq by myself.
>>>>>>>>
>>>>>>>> Just my two cents
>>>>>>>> Stefan
>> --
>> Regards,
>>
>> Laurent Pinchart
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
