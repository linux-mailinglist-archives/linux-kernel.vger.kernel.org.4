Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9426E3887
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDPNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDPNLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:11:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520EC1FE7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 06:11:20 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGygv-1pZxGG0JSV-00E9pG; Sun, 16 Apr 2023 15:11:03 +0200
Message-ID: <02a4ebb4-7652-fb1f-ae56-920648470c67@i2se.com>
Date:   Sun, 16 Apr 2023 15:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>
References: <20230413085206.149730-1-iivanov@suse.de>
 <20230413085206.149730-3-iivanov@suse.de>
 <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
 <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
 <9de62851-73a6-0070-4e64-94b6614c11fd@i2se.com>
 <CAAvKZ64KyXJ2QPjRnj3i-8AKh7jGCUw=HNi76XG-a9K-+_JiYQ@mail.gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CAAvKZ64KyXJ2QPjRnj3i-8AKh7jGCUw=HNi76XG-a9K-+_JiYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5wcXr52ePQwSwOgD6SW2LO0ywqyOYwLwfY5+lU/Z766kePNy0hd
 RzTW9VAdiu5rne2envmBlceSnXUMRlTXqMX92tHIb9mxDju+b0EUpz7cWLWSZoM5fEUANiB
 K2GHHy5vXmN6yOZRdKm0kM3Pro3I5e9GyxaYB8jdGvYLSPlcF/bYbp0y29zRzgNzBVPCli/
 IDl1NPpQzGB/B7AkOboUg==
UI-OutboundReport: notjunk:1;M01:P0:mSbi3KU6BPs=;NGWcCVS+iN0hiOR4UsxHWiuLqDt
 xHyIgrmAMXNW18TpA9ertaHkMRM84nwLUmzGall7mWck+IrViBMvFooNYc0ZOp7/DQWKRpZBL
 eMhOxYNwt+fm8C2juJ7anRLNzvl8dlSN61oiyfjDc/Havh40eH+i7aDQnqQDxWNuRXBwQAzhk
 BE3p75HqFowAhWtaqqD5uu/E/qOAvgydvGCAjIxIFiVSJ1Bcy4fiKTWInyA6+yI/4Bk0dClB7
 5o2shN35ZAEmVLQ3ns/+sY3fRdD4vEOSRzSDyB1vYtVcbyck5nDJff/nXhQtiJHZlGsVfbu00
 CeBCEpr4n+7YlBbml1s8O2aNipH9YHNNavyWEiMkDmLOW5ZI2CeCjYSuWhJFBgQrxneV3bhTa
 i+bLNBcBJx4V6F3mdXL1oUAszC7JSeHq2x/OqxSu/l8k4n8OQpI+lZTjnAM5UnAyHBHvC3VvH
 PUODrIzt2tdhCwfGrM9jtS4wb3Ie2LTzD8Nfar4xSlkUdxRvtz7KG0Z+yQfW3kS8GfnzH8kqY
 M6R2TmcTvDUCufyjEcqqx0aWhmo8UH8RzP9gvPwT8RV3bxrcwNsllTWY2hEbS1u0X3oryTV5j
 dP8AtF1VmbWWvHlAE4c8R19jJryky9Ky4izx65dghxLsbHDMfWrICwWhcMrQcPcQjrJxwOEh7
 3FyOyNK7ge3bdiSt/eGD9ETs7kYWiZIavGSJXiQTRw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 13.04.23 um 21:28 schrieb Tim Gover:
> On Thu, 13 Apr 2023 at 19:44, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>> Hi Ivan,
>>
>> Am 13.04.23 um 20:18 schrieb Ivan T. Ivanov:
>>> On 04-13 18:15, Stefan Wahren wrote:
>>>>
>>>> Hi Ivan,
>>>>
>>>> Am 13.04.23 um 10:52 schrieb Ivan T. Ivanov:
>>>>> From: Tim Gover <tim.gover@raspberrypi.com>
>>>>>
>>>>> Make a copy of the bootloader secure-boot public key available to the OS
>>>>> via an nvmem node. The placement information is populated by the
>>>>> Raspberry Pi firmware if a public key is present in the BCM2711
>>>>> bootloader EEPROM.
>>>>
>>>> It would be nice to have a helpful link like:
>>>> https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes
>>>
>>> Yep, make sense.
>>>
>>>>> +
>>>>> +   /*
>>>>> +    * RPi4 will copy the binary public key blob (if present) from the bootloader
>>>>> +    * into memory for use by the OS.
>>>>> +    */
>>>>> +   blpubkey: nvram@1 {
>>>>> +           compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
>>>>
>>>> Yes this looks better, but this introduce a new dtbs_check issue. The new
>>>
>>> Oops, yes, I forgot to make this check.
>>>
>>>> compatible must be documented in
>>>> Documentation/devicetree/bindings/nvmem/rmem.yaml in a separate patch and
>>>> reviewed by the DT guys.
>>>
>>> Or I can drop the new compatible string altogether? It looks like
>>> only alias is strictly required?! Tim Gover is this correct?
>>
>> i cannot speak for the firmware side, but i think we should try to keep
>> it compatible with the vendor DTB here.
>>
> 
> The firmware doesn't look at the compatible string. It locates the
> nodes to update using the 'blconfig' and 'blpubkey' aliases. Userspace
> scripts (including the documentation example) should also use these
> aliases.
> Therefore, I don't think it matters if the compatible strings is
> modified, but I won't pretend to know what the correct DT style is
> here :)

okay, regardless of the compatible string the patch must be send to the 
DT maintainers and the devicetree mailing list otherwise they don't have 
any chance to review.

Thanks

> 
> Tim
