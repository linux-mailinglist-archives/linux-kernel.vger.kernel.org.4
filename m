Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE480741A09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF1VIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjF1VI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:08:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D671FE4;
        Wed, 28 Jun 2023 14:08:26 -0700 (PDT)
Received: from [192.168.0.136] (85-160-58-109.reb.o2.cz [85.160.58.109])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E1D99CA;
        Wed, 28 Jun 2023 23:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687986463;
        bh=fswXHoRwKQMY/lVAgOQAgGj1xqVcfYILCuZoWk6AESs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZbyHoXHmH47wE1rI/T1W7bCNPC5AizKYQdRHE1GhzAm2TNax6jrAIZgZz2MUx4gEK
         oWqEkJgOZt7l8w9gEoCv1AB0LMb4EYEd+dMgZ+HS6U7HqD7xPmwX1LYJgv7phgM5c6
         OuO+XGkrWMNTNh//Se+2hLQuLQQv6PIWmLcrm0G8=
Message-ID: <07fb61ff-59e3-42af-8930-26674d3dd402@ideasonboard.com>
Date:   Wed, 28 Jun 2023 23:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 2/5] staging: vc04_services: vchiq_arm: Register
 vchiq_bus_type
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-3-umang.jain@ideasonboard.com>
 <168795128917.2878450.12280941046284606847@Monstersaurus>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <168795128917.2878450.12280941046284606847@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 6/28/23 1:21 PM, Kieran Bingham wrote:
> Quoting Umang Jain (2023-06-27 21:16:25)
>> Register the vchiq_bus_type bus with the vchiq interface.
>> The bcm2835-camera nad bcm2835_audio will be registered to this bus type
> s/nad/and/

Oops,  v9 probably?
>
> Is it possible to rename bcm2835_audio to bcm2835-audio for consistency?
> Or is that baked into existing usage/abi already?

well, there are more (bcm2835_hdmi, bcm2835_headphones) so, I don't 
think I will address in this series.
>
> If it can be changed, I think it's probably something to do in an
> independent patch at the end of the series anyway.
>
> I suspect this patch could be merged with 1/5 but I think it's ok
> separate too.
>
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
>> going ahead.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c        | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index aa2313f3bcab..e8d40f891449 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/cdev.h>
>>   #include <linux/fs.h>
>>   #include <linux/device.h>
>> +#include <linux/device/bus.h>
>>   #include <linux/mm.h>
>>   #include <linux/highmem.h>
>>   #include <linux/pagemap.h>
>> @@ -34,6 +35,7 @@
>>   #include "vchiq_ioctl.h"
>>   #include "vchiq_arm.h"
>>   #include "vchiq_debugfs.h"
>> +#include "vchiq_device.h"
>>   #include "vchiq_connected.h"
>>   #include "vchiq_pagelist.h"
>>   
>> @@ -1870,6 +1872,12 @@ static int __init vchiq_driver_init(void)
>>   {
>>          int ret;
>>   
>> +       ret = bus_register(&vchiq_bus_type);
>> +       if (ret) {
>> +               pr_err("Failed to register %s\n", vchiq_bus_type.name);
>> +               return ret;
>> +       }
>> +
>>          ret = platform_driver_register(&vchiq_driver);
>>          if (ret)
>>                  pr_err("Failed to register vchiq driver\n");
>> @@ -1880,6 +1888,7 @@ module_init(vchiq_driver_init);
>>   
>>   static void __exit vchiq_driver_exit(void)
>>   {
>> +       bus_unregister(&vchiq_bus_type);
>>          platform_driver_unregister(&vchiq_driver);
>>   }
>>   module_exit(vchiq_driver_exit);
>> -- 
>> 2.39.1
>>

