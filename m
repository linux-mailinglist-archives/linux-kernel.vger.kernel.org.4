Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8D6AB121
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCEPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCEPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:00:48 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0310403;
        Sun,  5 Mar 2023 07:00:46 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUpW-1qMAEt0jOu-00pqbz; Sun, 05 Mar 2023 16:00:31 +0100
Message-ID: <05bc8f6e-b0cc-2ae6-db7a-ad90b3e69778@i2se.com>
Date:   Sun, 5 Mar 2023 16:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
 <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
 <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
 <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rbVzumpqnIti5BN1cNnsoj8HXxEsoaEaPuUBVCzHUU80ur7twyo
 4HajNfcjEKOuow+d7ns+k1fu3x3GD0JgvYaBd1LPvSJE3xTZP14kkrtZDZLb2SNZ3dEecAY
 OpvDvab7hFIxykPfCXoFyk3VDAKK4fQBfy1WbmH7TQ3T9gulxL7GppXxSXWhWG0jwijGQLd
 DUz8yoCg5JcJ7zautIljQ==
UI-OutboundReport: notjunk:1;M01:P0:3Ibv/ixqOV4=;es4tMNxdvNCu3yjkBmuW5I+n7ng
 uTyYfRZI+kdN+bAJfgLUxN/E6HB30KKniweuXHTkFM+miINmXPYldfI7Bj1rXvdsNopLJz+d3
 7CBaUp1AZPO7mqcdtqwvBU/fCvqeeAaZyDSQjitBA8VeF66lArskkP+5Xsrvp2LLon2k5meUc
 giR9pRf9TLz8CtsiG9U3qXEFDTHaCpyXa7epjxwuRdPBZae1o60KrbDjc9afXwpp91sobdsTx
 8iMCIBX0m5VMX2EFwxHWLOY2ABWtJovis+IQqbt+RmmX7YiPKlSeqpuWa5sacU0SSzWN0L1Ps
 z/Iqu786LSC/+NtGJ11hC5g96XqV8btubzvAw7p832vxrRNJc1w1OZTvSTeqSYlxPezWhzPRD
 6BL8O5PmTABQ8UGJreot3gYQeOUYHgDl9A1V7wfN6QlGfCeecZ3aZyfUnz6a85JC7pC9tveNT
 12Jm8QysW/t6b8JCHy0GMoSiNqj0wkJ8BNuoFkOfVCPkCrttUpdhl8ddgBCG4UXI0cq0/ATEx
 ON9alkjdy3KA4O2lAPFtDsIuU7wmrgTrietLmyIFht+xGeUp3Ft6wYz5N77ejJe9z3/d0DqBm
 hzjAQc70IH6n7U/8X7y+UxTAw3i0ZX3xdxp/GQAcdwDUIj4rugVUv/1IOFFFZlvsf/nPOgRjD
 0sM8JDCrrf3CAxrminf7zp8nRWl++QBcwNrBiqew4w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 03.03.23 um 18:22 schrieb Florian Fainelli:
> On 3/3/23 03:57, Stefan Wahren wrote:
>> Hi,
>>
>> Am 02.03.23 um 18:51 schrieb Florian Fainelli:
>>>
>>>
>>> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
>>>> On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren 
>>>> <stefan.wahren@i2se.com> wrote:
>>>>>
>>>>> Hi Saravana,
>>>>>
>>>>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
>>>>>> This allow fw_devlink to do dependency tracking for serdev devices.
>>>>>>
>>>>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>> Link: 
>>>>>> https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
>>>>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>
>>>>> since this fixes an issue on Raspberry Pi 4, shouldn't this be 
>>>>> mentioned
>>>>> in the commit message and providing a Fixes tag?
>>>>
>>>> So RPi 4 was never creating a device links between serdev devices and
>>>> their consumers. The error message was just a new one I added and we
>>>> are noticing and catching the fact that serdev wasn't setting fwnode
>>>> for a device.
>>>>
>>>> I'm also not sure if I can say this commit "Fixes" an issue in serdev
>>>> core because when serdev core was written, fw_devlink wasn't a thing.
>>>> Once I add Fixes, people will start pulling this into stable
>>>> branches/other trees where I don't think this should be pulled into
>>>> older stable branches.
>>>
>>> That is kind of the point of Fixes: tag, is not it? It is 
>>> appropriate to list a commit that is not specific to serdev, but 
>>> maybe a particular point into the fw_devlink history. Given this did 
>>> not appear to have a functional impact, we could go without one.
>>
>> i was under the impression that this issue breaks at least Bluetooth 
>> on Raspberry Pi 4 because the driver is never probed. I cannot see 
>> the success output in Florian's trace. Something like this:
>>
>> [    7.124879] hci_uart_bcm serial0-0: supply vbat not found, using 
>> dummy regulator
>> [    7.131743] hci_uart_bcm serial0-0: supply vddio not found, using 
>> dummy regulator
>> ...
>> [    7.517249] Bluetooth: hci0: BCM: chip id 107
>> [    7.517499] Bluetooth: hci0: BCM: features 0x2f
>> [    7.519757] Bluetooth: hci0: BCM4345C0
>> [    7.519768] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
>> [    7.539495] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
>> ...
>> [    8.348831] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
>> [    8.348845] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
>>
>> I just want to make sure that 6.2 doesn't have a regression.
>
> My configuration uses hci_uart as a module, and it would always load 
> fine, but I suppose I can make sure that even built-in this works 
> properly. Give me a day or two to test that.

okay, this is fine. From my point of view this is not necessary to test 
built-in.

I tested latest mainline with Raspberry Pi 4 (multi_v7_defconfig + 
ARM_LPAE) and there is no regression:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

