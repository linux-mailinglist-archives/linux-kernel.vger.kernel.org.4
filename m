Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FDC677156
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAVSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjAVSHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:07:25 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36EB18A9F;
        Sun, 22 Jan 2023 10:07:19 -0800 (PST)
Received: from [192.168.1.140] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCbZL-1pSh2J2Lr9-009h6S; Sun, 22 Jan 2023 19:07:04 +0100
Message-ID: <d4867882-4eff-e926-e1eb-3217e608f091@i2se.com>
Date:   Sun, 22 Jan 2023 19:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <d5363f85-44e1-eee1-f7a5-61102637ef53@i2se.com>
 <167440481093.3533645.5465896340839457121@Monstersaurus>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <167440481093.3533645.5465896340839457121@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3LoHo9gwT8fEKNlygma/ZKXx+M0p0Msa87/rCMrJWR2nOAMsnFj
 kpv26zOg2019DjFdnNbqXVwOU/FE36Daqkm6klbrqr01/uqS2JqWeyew4008xxGgDaicyLn
 py948NXoDqWDoJijgM9zA0ZHlJlr2sknEdgz/z0punD+byCwo3D3Usv0MH9Vwut6R7tHx9m
 HeMYMYOkDYwHNsSvf6nkw==
UI-OutboundReport: notjunk:1;M01:P0:DmJxfvGQ3b8=;0h25chXEKwuSz9LG60C6pfR5XX7
 /67lhnZG600Mof7qx+8AJc2bqITkyyxWQYYq0PAgAZKyjwQ4MZkQn2mpxYU0eqcEYdFgzmzW6
 SJmjlW/4hqeGVnYdiq4VOJ2+HlFx0wcZ0KrcQ7J4fFlrc+44Xm3q25PHWOgeTxoCiwTFjb1fN
 8XK15t1RVyg+vzq5Hk5gAeesy5/Tz4iuPoUH28RV85E3K3kFRIkVqZiWwBQPZfoSC6pQAGzUP
 ghkMM+2Q7yS93+oDI4Jk4C3Dk3+/CoU7ejUwYFa/EfAsyEd15iIEMQS8xBsco6odUG6uJeMR5
 ZgALARGj5GO1XXKnkkYTNlOolpWHqGUQbZF/Nf1/854/6EGDw9dslRAeOpdW0DLEM35EFw+fx
 2BSa0M3LftzTOL9M8+V1YAMx6B9L60pgWXrB5RchPOGLI1Nkucn7LO+JKyVE2Yjjw9O5hGEKh
 u5ZMJD5UliiAD9S0/+3YH2bSrMhbK9nAolVJhlsZMhnT/V2UEd1p+EEjmDBe6hn8zOX/mss36
 nkg27j1f/BllBCpa1arx1uBUkf8u2FiquzP253KgEWD/lOJmtPitI0SGTxkvN4jWAOnx3Ps90
 y3IV9XAQqmojEdPorGtcTStcFNBwyQpv7y6NO/HFFhqjuzIgdTJbaYZo9dZazGUjeq0+StlzO
 FFM4ysKS/dib30gQYz1S9W4l63FbujUe39g45YEBRQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Am 22.01.23 um 17:26 schrieb Kieran Bingham:
> Hi Stefan,
>
> Quoting Stefan Wahren (2023-01-22 14:21:05)
>> Hi Umang,
>>
>> Am 18.01.23 um 12:58 schrieb Umang Jain:
>>> Drop custom logging from the vchiq interface.
>>> Mostly of them are replaced with dev_dbg and friends
>>> and/or pr_info and friends.
>>>
>>> The debugfs log levels (in 4/4) are mapped to kernel
>>> logs levels (coming from include/linux/kern_levels.h)
>>> Would like some thoughts on it as I am not sure (hence
>>> marking this is RFC)
>>>
>>>   From drivers/staging/vc04_services/interface/TODO:
>>>
>>> """
>>> * Cleanup logging mechanism
>>>
>>> The driver should probably be using the standard kernel logging mechanisms
>>> such as dev_info, dev_dbg, and friends.
>>> """
>> at first i want to thank you for the work on vchiq so far.
>>
>> There is something which is not directly related to this series, but it
>> is also about debugging. The driver has a buffer which is accessed by
>> it's own DEBUG_* macros. The content of this debug buffer can be dumped
>> via the /dev/vchiq which is also used by ioctl. I would appreciate to
>> move this dump feature into a new debugfs entry.
> Do you have a full list of the tasks you'd like to see completed ?
> (including/or above drivers/staging/vc04_services/interface/TODO)

i consider every point except of point 1 (importing new drivers) as 
necessary to leave staging.

Additionally there is the additional point (i can add them to the TODO) 
above. Unfortunately i don't have a complete insight, how vchiq should 
be to be acceptable. Sorry, if i can't help you further with possible 
resource planning.

Are some points on the TODO list unclear?

Thanks

>
> It would help to have a clear picture of tasks needed to get this driver
> destaged, so that we can support the ISP upstream.
>
> Regards
> --
> Kieran
