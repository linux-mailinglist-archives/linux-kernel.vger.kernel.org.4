Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A792B67831D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAWR3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjAWR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:29:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC922D16F;
        Mon, 23 Jan 2023 09:29:04 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McpW8-1ok7ZX04pO-00ZuiV; Mon, 23 Jan 2023 18:28:37 +0100
Message-ID: <53a8f159-22ab-b280-17b2-b80f59256342@i2se.com>
Date:   Mon, 23 Jan 2023 18:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Content-Language: en-US
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7nTGGc5lX0c+L6/nAxWYVWYD4u9G64oQU2WhKE98wTjP7dTDi7r
 kdmhtVJ8fB1A9KCpRupZP2fS4gelboHYpq4Ckzs98JDMHgyfTjWgNkNjACSKq6vZl6sptAz
 +IcH0T3VrsIsyXNTwM+dmjTg1C/NazaD1N4uBQSnT0pTTWRWIxdWq/DhKMnHQcNvYwCFxzU
 HlkFXi2OHCgZAt4quBAsQ==
UI-OutboundReport: notjunk:1;M01:P0:EVGuaTAFbUA=;KFEjkEtKNrpv8H13g0IwuLkXzUN
 NaficCkLufcSy63olrRh2X6wo12VDYIls42pH0dnIlbXgyW/yz3vq+M78+rG/fXc6U1HrtLb9
 i0huFGuCKngc9MQUyd42vZEMfKWkvchLE9BBDom1iPnEmYR+nMg5mjk7BGRhrF1Phvd8h1uh3
 LhNgW0eMaYp0WSsFsCeKFdga4HEwRD/8itxAmvTe9CYn22ZkgGNeNrXe0/Tfee2VRZhQBoXL4
 RFFbx9Smw6Oo91baDDnsdVG5EZq5ZmdUDFith/deIzQdXUIaxXPZdveD+bqYDKYioe8kI+YNu
 zfWdviQPZc3jCEbuX8vdVaoYB/+Iiu+mHU1fr48wkLSl+V5+gBCHGCcs0uhiO9rWBa6m3QA71
 ocsuUh5NSXf4gxcIPDzTC/0Ma47/r2hKqszMU/a5r14UtLkvbMaEXN95qgKSGLbYUEII4of2R
 rJUDAKkCW8bzCnBKv7/JsMJ/Bi9y95hPl9q65ev84Q8Oj4V8EFVZ6YyA3vVRB5VpxJEi317v4
 Xt9eW3hU7ow6djMr+4gyKTbsXtxKbndMh3phuCO4PPuGpf0P3zI3oXjdBF1WlLyxMDbfndfbR
 G7IQ5MVI62vZra6wajKiWVhrtw6c9/TcTHCioGCEg2WgfXl+0WY+b9UVaOSHF3l9fv4OQy8vW
 zWhnum4nmbNijxX+88SzQLPurJnU6LyuxFlNmaZ0JA==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 23.01.23 um 08:48 schrieb Umang Jain:
> Hi Stefan,
>
> Thank for the testing.
>
> On 1/23/23 5:04 AM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 20.01.23 um 21:10 schrieb Umang Jain:
>>> This series just introduces five extra patches for dropping include
>>> directives from Makefiles (suggested by Greg KH) and rebased.
>>>
>>> The main patch (6/6) removes platform device/driver abuse and moves
>>> things to standard device/driver model using a custom_bus. Specific
>>> details are elaborated in the commit message.
>>>
>>> The patch series is based on top of d514392f17fd (tag: next-20230120)
>>> of linux-next.
>>
>> applied this series on top of linux-next and build it with 
>> arm/multi_v7_defconfig plus the following:
>>
>> CONFIG_BCM_VIDEOCORE=y
>> CONFIG_BCM2835_VCHIQ=m
>> CONFIG_VCHIQ_CDEV=y
>> CONFIG_SND_BCM2835=m
>> CONFIG_VIDEO_BCM2835=m
>> CONFIG_BCM2835_VCHIQ_MMAL=m
>>
>> and the devices doesn't register on Raspberry Pi 3 B Plus:
>>
>> [   25.523337] vchiq: module is from the staging directory, the 
>> quality is unknown, you have been warned.
>> [   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>> bcm2835_audio vchiq device
>> [   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>> bcm2835-camera vchiq device
>
> I was able to reproduce and it seems the issue here is the change 
> mentioned in the cover
>
> - drop dma_set_mask_and_coherent
>
> in V6.
>
> (I usually test patches on RPi 4B with vcsm-cma and bcm2835-isp 
> applied so my branch has the DMA hunk included while I was testing V6)
>
> Below is the hunk which should resolve the issue.
>
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/device/bus.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>
> @@ -72,6 +73,12 @@ int vchiq_device_register(struct device *parent, 
> const char *name)
>         device->dev.type = &vchiq_device_type;
>         device->dev.release = vchiq_device_release;
>
> +       ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> +       if (ret < 0) {
> +               vchiq_device_release(&device->dev);
> +               return ret;
> +       }
> +
>         ret = device_register(&device->dev);
>         if (ret) {
>                 put_device(&device->dev);
Yes, this patch fixes the errors above. But i noticed that the series 
also break autoprobing of bcm2835-audio and bcm2835-camera.
>
> It seems we need to include the dma_set_mask_and_coherent() even if 
> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look 
> into why is that/
>
>  Laurent, any thoughts on this please?
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
