Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D956DF960
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjDLPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDLPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:11:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6EB4489
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:10:58 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9W78-1ph8T806Oi-005VRr; Wed, 12 Apr 2023 17:10:42 +0200
Message-ID: <43effe7f-9b2f-52d7-2570-decf2940a58c@i2se.com>
Date:   Wed, 12 Apr 2023 17:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230411135035.106725-1-iivanov@suse.de>
 <437e9983-55e9-3f9d-a94b-c746922973da@i2se.com>
 <r3x3b6fyejqg3ftcgigdrevsnlhbfrae2gztejsa3cnduaebf4@z3reu7bj6b6n>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <r3x3b6fyejqg3ftcgigdrevsnlhbfrae2gztejsa3cnduaebf4@z3reu7bj6b6n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wFA49aUt4OPj9B6QbDO0GpAE8oTQiCgZyJUujdUy8rKBB7NJs5n
 qxgr1GDiJAPMZdGdFuNwIODwHArEM6tZ3F5QopcgS7LHlV7tu48mYkbNNOz9M/ZzZJNCidt
 xujfp/V+wewbP3fgkInsPIaLThGrSxa/2e2GKaCmMqikWe2koqwc50xsHrY7EpnJhvSDlp0
 RPZJoV+qVgy2KGZ2VNsAg==
UI-OutboundReport: notjunk:1;M01:P0:jG3XMF52aAY=;2fPXEN17VHdG97NxHprfroKXOI0
 V9xDjcDIe9yJpTa410DBKZ1C0/Qp7b6uuKSfVXlohy1x0tx4ktVOsIklnkJosJZfxs9gUcsis
 +/M/ZiHswPZ2aa62wf4Ipxsfp3RVEwAjdwPQgPsPhXxhjxKTzot3JVW0r7UpOuIBvr/66b2/0
 alEhenUg6PfFlrpubVWigLuNucnowos+tfZ4vuPznj1zia3YaUpXySmNA8SXU3R9MjxdgLTFM
 b16bAOHmPCEhWQwQvP0t46cgop80F3j9Z078awPdxMH+o4PIRWUSBN5SVTBe3WCDOkInve7/a
 g80Wi4uNaST/COLZ/+lJWk9wRoa3AxZxbs4tLNV5r0a3U5q9d/csxYprCDtDDBAmWIJj2fEIF
 lVJutDbeWQJiExw7wj0AEklKOr/hvOBFaR3ZDZkkFZI3a2WV2FspJb5zsm6ZjO+nb+fthabQT
 +3ou9+cOfFIqjC7sieQRD4WEjCmwN2ZPlb/QsSSEiZI9zGp1GcvX6oh9ZkYtRBh4tu2EUwj4F
 Xa/REri/WdKHMCHyt7qjnfWmL8Fuz0bJXWzAXK+ej70SkySPnYoR25J4pv7syVQhhIQy3Qydh
 Gw6npt5mvctHrWPMcLSkHaFt7h3mV+U5o+2cOUnr8lk67PjcsZ8+SHckNAe4ahRtPNX75gxX1
 ksn787YFFz503AygufLyZoZzeBrw6Du2nujxvZH/kQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.04.23 um 09:26 schrieb Ivan T. Ivanov:
> Hi Stefan,
> 
> On 04-11 18:53, Stefan Wahren wrote:
>>
>> Am 11.04.23 um 15:50 schrieb Ivan T. Ivanov:
>>> They could be multiple reserved memory regions,
>>> so let's make their names unique.
>>>
>>> This fixes following kernel error:
>>>
>>> [    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'
>>
>> could you please provide more background information:
>>
>> - are two instances of rmem trying to create this file?
>> - which exact platform is affect (Raspberry Pi 4), because the Hardware name
>> from the trace is useless?
>> - could you provide some reliable scenario/config to reproduce this issue?
> 
> I was sure your will be asking. :-)
> 
> I am using RPi4[0] for testing this. Device tree is based on sources
> from here [1]. From this devicetree it is  obvious what is happening.

Thanks for clarifying. Unfortunately this file is not identical to the 
mainline file, so the issue can only be triggered with the vendor DTB?

> 
> Unfortunately right now SUSE Bugzilla is under maintenance, so perhaps you
> can't see the bug report [2]. In brief I am using latest Tumbleweed on this
> device and you can imagine that error is happening always.
> 
> Regards,
> Ivan
> 
> [0] Raspberry Pi 4 Model B Rev 1.1
> [1] https://github.com/raspberrypi/linux/blob/rpi-6.2.y/arch/arm/boot/dts/bcm2711-rpi.dtsi#L57
> [2] https://bugzilla.suse.com/show_bug.cgi?id=1206846
