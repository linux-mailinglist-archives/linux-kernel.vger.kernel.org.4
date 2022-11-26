Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8E639739
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKZQ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:27:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6A26A;
        Sat, 26 Nov 2022 08:27:16 -0800 (PST)
Received: from [192.168.1.104] (unknown [103.238.109.19])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 600A1471;
        Sat, 26 Nov 2022 17:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669480033;
        bh=9JgwMYaMqW628l2Ol/scePAZkaal2MIBpF9/7ieZUYU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NyL1IUSIS9+5gvfkmBxMMqCbVEiIpkAT8Q+t9SFRNRchj2SyoOTkT0t4fGhSY+YP7
         uPi/myeHxO09kbL0LUFo0QSYA4If9VTQn+mygQrIQDtJxIiwXiHw/OM5/jLFrtpEwf
         THnXDhut39B7Bd7CPd0zmdT63lsZ1qNMfjj35iDk=
Message-ID: <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
Date:   Sat, 26 Nov 2022 21:56:12 +0530
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
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On 11/26/22 8:12 PM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 21.11.22 um 22:47 schrieb Umang Jain:
>> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
>> receiver IP core("Unicam) + the ISP driver found in BCM283x and 
>> compatible
>> SoCs (namely BCM2711). Unicam is still under active development to work
>> with multistream support to get into mainline. Hence only the ISP driver
>> will remain the primary area of this series.
>
> thanks for working on this. But honestly i would prefer that vchiq 
> comes out of staging before adding more features. As Greg said some 
> time ago staging is not a place to "dump code and run away". These new 
> files are in the same bad shape as the rest of vc04 before the 
> clean-up here in staging started.

Certainly, I am not here to do that - but I am still learning the ropes.

If the staging issue is becoming a blocker for bcm2835-isp going 
upstream, I would be happy to help here! Though I must mention that I 
still have limited visibility so my aim would be to chart out a plan of 
things needed to be done to get vc04_services out of staging!

>
> I agree that VCSM is on the TODO list for vchiq, but this driver is 
> not necessary for making bcm2835-audio & bcm2835-camera leave staging. 
> It just binds more resources on a new feature.

I see two TODO files in vc04_services:
     ./bcm2835-camera/TODO
     ./interface/TODO

One of the bcm2835-camera TODO points to the vc-sm-cma driver itself. So 
that's address in the series. The other remaining one - I will need to 
take a deeper look before commenting on it.

The main chunk of TODO are in vc04_services/interfaces/TODO.  Doing a 
cursory reading of them suggests that these apply to *all* vc04_services 
components? Am I right?

Are these are the specific bits of cleanup you are referring to in your 
comment?


>
> Unfortuntately i hadn't much time to work on vchiq by myself.
>
> Just my two cents
> Stefan
>

