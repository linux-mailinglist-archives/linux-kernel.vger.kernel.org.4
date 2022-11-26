Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744063988C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiKZW5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKZW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F71583E;
        Sat, 26 Nov 2022 14:56:51 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.27]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCbZL-1p7cnv0cV9-009el7; Sat, 26 Nov 2022 23:56:36 +0100
Message-ID: <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com>
Date:   Sat, 26 Nov 2022 23:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Umang Jain <umang.jain@ideasonboard.com>,
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
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mOh+jfsovNViNNFGnkXKYR6uFOi0sqfG0SFzTs1OIoe0785Y1c8
 MscO7c9Q1LnicN1ocUBaPyw3swJ9vwTHF13uUdWGVDIRuZXt7ENejNpiqbi4wqzirD154eJ
 2UNEb3o/CgOtr9nin5UnAXPx0JO5g3zeSP2SzG/odYL7ubwXPbRP7z9KgHS0SyYrHcRH+Yl
 sX33AMEeVluzOtY5kC0Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wa2tfLXpUeg=:KH3HVowP0x6IOJs0dfQ3Fd
 EAMKGhQXwBvLVWOXoRMnGLKpKiffQ/sydVQ55W6wiEo8i3PJ8qIwPXG9ikqp7xKVyZ3bZ3LQl
 Z7S3Lg7ljRyYABImyPTar+q/pgNtPdMdAoGbMIvh+kLvUcev96LFRe+XlSEXRpOL/w8vSW3c5
 SF7wklR2L8RckQq1GBXZGDh6y5rxpFm4QPMoyFVDtWB1yy7WD1UXx/UsGD/t/jXUKVNdhSnaN
 Wr6H/pzFVgxVF9GE/mpBw7pqinWojF98pLXLOfZPmoKV8slzN2/L+jhujP/bOnBUNgZ2AzJQN
 ZMcsDwt/wKMmjumPAqHi3et6eN2kDLUeIx2lpfscXalYu16ADMjwiQlgogZE90Xs7WvbfKpDx
 yO5HywHqtXpAyFyMhxX68hKponPBkYDNhCLiFftaowlEzqLCA5eVqIIDe/qmXjolmwlwRsBAM
 M37cOGQOBQ+gQzixhhoAz8fqtj/FPknmukvkom162pgxoJ6lDtGnR6tM4ouqKODwa/U0zZpEP
 +yAFn/xTfRDINTJcbtOsHJAehhSIOasldotnfuCNGFjdutcG23AOkehuognrPRFKq3CU1+gTk
 r45YomqYkZIkYj1vyHENJlsJ7SnnF7M6xVOmo0sKy/7we5tpnFHNk7CmN0wYGTZeIl5vykxyQ
 SWM3z5OifaWCsaLDA+rdAhidJIgxEsQvz858ydVM2ydiQsfJUsrl+Q665i/P5SomlDPY1DiDF
 mSUQVdeT5pwdI3s2f2bL6LtHl+G56lpnfZWIW9d0jg7dkBfOmQX/3qTNpGYiwJLbarqL8+U8k
 i7UiyRUZWHdLzLycL6dzi8bUEOY4w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 26.11.22 um 17:26 schrieb Umang Jain:
> Hi Stefan
>
> On 11/26/22 8:12 PM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 21.11.22 um 22:47 schrieb Umang Jain:
>>> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
>>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
>>> receiver IP core("Unicam) + the ISP driver found in BCM283x and 
>>> compatible
>>> SoCs (namely BCM2711). Unicam is still under active development to work
>>> with multistream support to get into mainline. Hence only the ISP 
>>> driver
>>> will remain the primary area of this series.
>>
>> thanks for working on this. But honestly i would prefer that vchiq 
>> comes out of staging before adding more features. As Greg said some 
>> time ago staging is not a place to "dump code and run away". These 
>> new files are in the same bad shape as the rest of vc04 before the 
>> clean-up here in staging started.
>
> Certainly, I am not here to do that - but I am still learning the ropes.
no problem.
>
> If the staging issue is becoming a blocker for bcm2835-isp going 
> upstream, I would be happy to help here! Though I must mention that I 
> still have limited visibility so my aim would be to chart out a plan 
> of things needed to be done to get vc04_services out of staging!

The vchiq driver is in staging since 2016, so every step forwards is 
good. Unfortunately all of the low hanging fruits has been gathered.

For me the most important, but not to tricky steps to get vchiq out of 
staging would be:

* Cleanup logging mechanism

* Get rid of custom function return values

There was already an attempt for this [1]

* Get rid of all non essential global structures and create a proper per
device structure

>
>>
>> I agree that VCSM is on the TODO list for vchiq, but this driver is 
>> not necessary for making bcm2835-audio & bcm2835-camera leave 
>> staging. It just binds more resources on a new feature.
>
> I see two TODO files in vc04_services:
>     ./bcm2835-camera/TODO
>     ./interface/TODO
>
> One of the bcm2835-camera TODO points to the vc-sm-cma driver itself. 
> So that's address in the series. The other remaining one - I will need 
> to take a deeper look before commenting on it.
>
> The main chunk of TODO are in vc04_services/interfaces/TODO. Doing a 
> cursory reading of them suggests that these apply to *all* 
> vc04_services components? Am I right?
Actually these applies just for the interfaces directory. Some of them 
could apply to the services, but this is no priority.
>
> Are these are the specific bits of cleanup you are referring to in 
> your comment?

You mean about bcm2835-isp? There were too many changes to vchiq that i 
don't remember them all. The first that come to my mind was those fancy 
comment sections which is not kernel coding style. It has been removed.

[1] - 
https://lore.kernel.org/linux-staging/20220712181928.17547-1-jslebodn@redhat.com/

>
>
>>
>> Unfortuntately i hadn't much time to work on vchiq by myself.
>>
>> Just my two cents
>> Stefan
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
