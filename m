Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE65654FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiLWLY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiLWLY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:24:56 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF84083C;
        Fri, 23 Dec 2022 03:24:53 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2Unv-1ojbWK1i19-013x31; Fri, 23 Dec 2022 12:24:31 +0100
Message-ID: <629b3f63-74e4-5cb5-29d1-6d2846bc24c7@i2se.com>
Date:   Fri, 23 Dec 2022 12:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Create platform_device
 per device
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20221220084404.19280-1-umang.jain@ideasonboard.com>
 <Y6Lqs8RUiyi452gM@pendragon.ideasonboard.com> <Y6MF3l40WM3onmyO@kroah.com>
 <d48462f6-de4c-2816-0a7a-b3b13993604c@ideasonboard.com>
 <Y6SVegtHvwQ3p+3K@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Y6SVegtHvwQ3p+3K@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5/IewrfwXtk/j85Fq2Ox0OuZvUU0b4wFBaVQ57vJt0+ATm7usZc
 MiDsThNLAs5ZqFSedxRDKXRPFON+l56M0GnH0QMx3grEzcV7jdTqZk4AsZMDL3wPXUC7Y6S
 GCQcLce58l7AEnSq1aobqtY/EnkcR71WIlYs98dkz2IAUBlSGPFkWKoMiqmrB20Qi5IZvOT
 mM17/vj1BAtqbivnIrWUg==
UI-OutboundReport: notjunk:1;M01:P0:CBgWySE112E=;kRuv5R7OLdLLhW+soww8Xgsl7y2
 mKoEvGY4a0/tjFa5NtQTmINEU7RZBqF3rCDzLsDBe8+deY4WUYxmSk6ADtPylN6j7u39GFORQ
 SisPrBnlnRp0wu3UzNKz37NrhrMqrr0gYLUkCJurdaRkryHMCkDH1KcHUjt/OA6yRw3KF5WYt
 Ne2FB2OAdTjJ2gxUkC5U6lsYWygwkD1lUzFg697TuUZUpLuPoej0LEVTYvbDIQ4A5zj6T0dMt
 5BDb9Coc4HArTQDDf0D2rX5hTbHFke+Js00PRp8cgpwnHGsFVMNG1je2G7KB5M/Fnt8WtZCAn
 qK1RekOtMZWcdZHmBXWZXMypzntyMrWcGgV99WVC+7DuDQe8FpEZ2zkAnneklVdEjhJOaNPcx
 rWbguT4GqJjFCMQc7B0OT8zTGltBrrj7d/Mk5gmPOVT4K5Cv8rdyL1Zu3tNax8mSgchYpjwD/
 sEtkQyZ4YcpbalhrkZ7TdTF0gFyLRxL4FePwgR82p+DLUFUjtCH3YFsoJL3pb8gyxAMb5Xhqd
 XmrMnGE5cyvBlDabbRkA1swmkweYZ5oz6Dt/Bl0aH/PbnRovxJS1ZQKczFR3txQnzOW2QY2Em
 vSWSWBXgGpdN260SF3gQgexpoOnyvlArfEI3tuRgVORdYkVP0UmmUso30/EaeUAlAHKpbbmYf
 8JggzRnYMzFiHhDgQRF6HMHr1fSWejrD4xVStcJJqw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,
hi Umang,

Am 22.12.22 um 18:35 schrieb Laurent Pinchart:
> Hi Umang,
>
> On Thu, Dec 22, 2022 at 01:59:28PM +0530, Umang Jain wrote:
>> On 12/21/22 6:40 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Dec 21, 2022 at 01:14:59PM +0200, Laurent Pinchart wrote:
>>>> On Tue, Dec 20, 2022 at 02:14:04PM +0530, Umang Jain wrote:
>>>>> Create a proper per device platorm_device structure for all the child
>>>>> devices that needs to be registered by vchiq platform driver. Replace
>>>>> the vchiq_register_child() with platform_add_devices() to register the
>>>>> child devices.
>>>> This explains what the patch does, but not why.
>>>>
>>>>> This is part of an effort to address TODO item "Get rid of all non
>>>>> essential global structures and create a proper per device structure"
>>>> And this explains part of the reason only. Could you please expand the
>>>> commit message with the reasoning behind this change ? It's not clear
>>>> from the change below why this is needed and good.
>> Ok, I thought the TODO reference was sufficient but I'll expand on it.
>>
>>>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>>>>> ---
>>>>>    .../interface/vchiq_arm/vchiq_arm.c           | 59 ++++++++++---------
>>>>>    1 file changed, 31 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>>>> index 22de23f3af02..fa42ea3791a7 100644
>>>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>>>> @@ -65,8 +65,29 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
>>>>>    DEFINE_SPINLOCK(msg_queue_spinlock);
>>>>>    struct vchiq_state g_state;
>>>>>    
>>>>> -static struct platform_device *bcm2835_camera;
>>>>> -static struct platform_device *bcm2835_audio;
>>>>> +static u64 vchiq_device_dmamask = DMA_BIT_MASK(32);
>>>> The fact that this isn't const and is used by two different
>>>> platform_device instances is worrying. Either it can be made const, or
>>>> it's wrong.
>> ack.
>>
>>>>> +
>>>>> +static struct platform_device bcm2835_camera = {
>>>>> +	.name		= "bcm2835-camera",
>>>>> +	.id		= PLATFORM_DEVID_NONE,
>>>>> +	.dev		= {
>>>>> +		.dma_mask	= &vchiq_device_dmamask,
>>>>> +	}
>>>>> +};
>>>>> +
>>>>> +static struct platform_device bcm2835_audio = {
>>>>> +	.name		= "bcm2835_audio",
>>>>> +	.id		= PLATFORM_DEVID_NONE,
>>>>> +	.dev		= {
>>>>> +		.dma_mask	= &vchiq_device_dmamask,
>>>>> +	}
>>>>> +
>>>> Extra blank line.
>> oops, checkpatch.pl didn't catch this :-/
>>
>>>>> +};
>>>>> +
>>>>> +static struct platform_device *vchiq_devices[] __initdata = {
>>>> Make it const.
>>>>
>>>>> +	&bcm2835_camera,
>>>>> +	&bcm2835_audio,
>>>>> +};
>>>>>    
>>>>>    struct vchiq_drvdata {
>>>>>    	const unsigned int cache_line_size;
>>>>> @@ -1763,28 +1784,6 @@ static const struct of_device_id vchiq_of_match[] = {
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(of, vchiq_of_match);
>>>>>    
>>>>> -static struct platform_device *
>>>>> -vchiq_register_child(struct platform_device *pdev, const char *name)
>>>>> -{
>>>>> -	struct platform_device_info pdevinfo;
>>>>> -	struct platform_device *child;
>>>>> -
>>>>> -	memset(&pdevinfo, 0, sizeof(pdevinfo));
>>>>> -
>>>>> -	pdevinfo.parent = &pdev->dev;
>>>>> -	pdevinfo.name = name;
>>>>> -	pdevinfo.id = PLATFORM_DEVID_NONE;
>>>>> -	pdevinfo.dma_mask = DMA_BIT_MASK(32);
>>>>> -
>>>>> -	child = platform_device_register_full(&pdevinfo);
>>>>> -	if (IS_ERR(child)) {
>>>>> -		dev_warn(&pdev->dev, "%s not registered\n", name);
>>>>> -		child = NULL;
>>>>> -	}
>>>>> -
>>>>> -	return child;
>>>>> -}
>>>>> -
>>>>>    static int vchiq_probe(struct platform_device *pdev)
>>>>>    {
>>>>>    	struct device_node *fw_node;
>>>>> @@ -1832,8 +1831,11 @@ static int vchiq_probe(struct platform_device *pdev)
>>>>>    		goto error_exit;
>>>>>    	}
>>>>>    
>>>>> -	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
>>>>> -	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
>>>>> +	err = platform_add_devices(vchiq_devices, ARRAY_SIZE(vchiq_devices));
>>>>> +	if (err) {
>>>>> +		dev_warn(&pdev->dev, "Failed to add vchiq child devices");
>>>>> +		goto error_exit;
>>>>> +	}
>>>> If you unbind and rebind this driver, the platform_device instances
>>>> defined as global variables will be reused, and I'm pretty sure that
>>>> will cause issues, for instance with the kobj->state_initialized check
>>>> in kobject_init() (called from device_initialize(), itself called from
>>>> platform_device_register(), from platform_add_devices()). I'm not sure
>>>> static instances of platform_device are a very good idea in general.
>>> static instances of any device are a horrible idea, but it seems that
>>> many drivers do this and abuse platform devices this way :(
>> It seems  I have been a victim of the abuse usage while looking for
>> platform_device references in the codebase. I'm working on a new
>> approach for this.
>>
>> Currently (as per the linux-next branch), the vchiq driver will happily
>> carry on if any of the child  platform device registration fails. That
>> means if bcm2835-audio fails to register, bcm2835-camera will  still
>> kept registered I suppose.
>>
>> However with usage of platform_add_devices() in this patch, I introduced
>> a functionality change (I'm realizing this now) - any failure of child
>> platform device registeration will -unregister- all the other platform
>> devices i.e. if bcm2835-audio fails, bcm2835-camera will also get
>> unregistered.
>>
>> Should I be working towards the status-quo behavior ? Or it's sane to
>> unregistered other platform devices if one of the fails like
>> platform_add_devices() does ? (This affects my new approach as well,
>> hence the question)
> If it doesn't cause too much extra complexity, it would be nice to skip
> devices that can't be registered successfully, and still support the
> other ones. I don't expect registration failures to be a occuring
> normally, so if this causes too much completely, I think it would still
> be fine to fail more harshly.
>
>>> Ideally this should be done properly, with the correct devices created
>>> automatically based on the device tree structure, NOT hard-coded into a
>>> .c file like this.
>>>
>>> So I too really do not like this change, why are these not being created
>>> by the firware layer automatically?
>> Not sure if this is a helpful comment, but as far I know, there can be
>> vchiq child platform devices which probably don't have a Device tree
>> entry. like the bcm2835-isp [1] I posted earlier.
>>
>> [1] https://lore.kernel.org/lkml/20221121214722.22563-1-umang.jain@ideasonboard.com/
> Those devices are implemented and exposed by the firmware running on the
> VC4. The device tree describes the VC4 itself with the resources
> required to communicate with it through a mailbox interface. I was going
> to say that the platform devices are then created based on what the
> firmware exposes, but that's not right, they're indeed hardcoded in the
> vchiq driver. Adding corresponding DT nodes (as children of the vchiq DT
> node) could make sense. Dave, do you have any opinion on this ?

i vaguely remember the discussion how to represent audio and camera 
interface in the device tree. Representing as child nodes of the VC4 has 
been rejected on the device tree mailing some years ago, because this 
doesn't represent the physical (hardware) wiring. It's still possible to 
access e.g. the camera interface from the ARM.

The whole approach with using a separate binding for all the firmware 
stuff lead to a lot of trouble on the Raspberry Pi platform (ugly 
dependencies between firmware, DT and kernel). So i would like to avoid 
this here. In case the current implementation is a no go, how about 
letting the ARM core discover the available interfaces e.g. via mailbox 
interface?

For more inspiration take a look at this old thread [1]

But i agree DT binding for vchiq itself is also a TODO

and any help is appreciated.

[1] - 
http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-February/005541.html

>
