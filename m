Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCE6A96D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCCL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCCL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:57:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21D5D888;
        Fri,  3 Mar 2023 03:57:41 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3KgE-1qXyHe2Eug-010O6H; Fri, 03 Mar 2023 12:57:32 +0100
Message-ID: <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
Date:   Fri, 3 Mar 2023 12:57:31 +0100
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
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6SqIBuwl4hgkQVUMYPkjR7InGlbwGbJFAsRR4hE8HFy/tAGGHFk
 Jgd5rAhKTcZEpIQV2wRk7zja7u0uyW/3jt8tDBammY9difig9xj4IhbjW1sruvglW8ZusAt
 g6G8GpkzBmK81UgOKjSEU+/CFAtYwnCRLdcviwT2mGKYmR/4aZVUr0YWVGvQUtUMjDLAWXF
 WF9ie6zTZ25HKGv/r2IUg==
UI-OutboundReport: notjunk:1;M01:P0:yWS7SgGM3NA=;CdlKhqu9pItUD2gKhGkw34MOtbA
 5dz7oSDUgteJy+6QAdh2O1H9LvVIdd1BDnkxC7LhxpjEZqV2UKvEPrMA+TWwl7+BgJfYi+Vgz
 Lc8SFIskUC30FpHWOb2dRqnx5dq2WCdegU4r7FOQ85WoPLHwPEDSuhDJdX3CuBNxZvdNGlAoC
 4ObcZ3KUyJxEE6qukjaKNZNCRi/fPVpXg6lGb8ArrGIu2JXsf8qzJcuIeERErii7OvZNPANPX
 OK34q6psSSaiNH/kkS/ZWg8Ys2a8IWsoi81L/SsjxR3OKHl64hD0v6hajxJDrlKimZ10zgTFA
 kr4feRYIZC+Q/pYUc5JZtG0E0m58Bh3jWkD/EUN/98eoTp6xVcckPRUfn+wW+ysCNXDdesWjL
 YmAJGuZe9BMk/9bKfqz401Qk6GGQUEpXswILkncr1XVv7HORbXvvIyu6tll6GPu3KCaCqQelZ
 1iMQTUf9kYHNUwJ0FO/cBdBcntBKm/hQAL6OzuOwmPUpKOKi0/P6tG0fkRrrkvqnnXYox4Gao
 6AxCIqjqiPnAHOlkMbcCafIWL67SPao/y2Zf0uxSbzUL0v1lQUgVMghM1L72G4mlJ/5fSzO5E
 qly7hF6no9XUJrUCJG8+ciFeRgt10t58St1hjyBocLJpWSIglQFts1/wsnKVKz7K5u70vNHaY
 AzRIXLRt8lZxL/6PxJkpy57KX7wE9aujaQhv3+dsAw==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 02.03.23 um 18:51 schrieb Florian Fainelli:
>
>
> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
>> On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren <stefan.wahren@i2se.com> 
>> wrote:
>>>
>>> Hi Saravana,
>>>
>>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
>>>> This allow fw_devlink to do dependency tracking for serdev devices.
>>>>
>>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Link: 
>>>> https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
>>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>
>>> since this fixes an issue on Raspberry Pi 4, shouldn't this be 
>>> mentioned
>>> in the commit message and providing a Fixes tag?
>>
>> So RPi 4 was never creating a device links between serdev devices and
>> their consumers. The error message was just a new one I added and we
>> are noticing and catching the fact that serdev wasn't setting fwnode
>> for a device.
>>
>> I'm also not sure if I can say this commit "Fixes" an issue in serdev
>> core because when serdev core was written, fw_devlink wasn't a thing.
>> Once I add Fixes, people will start pulling this into stable
>> branches/other trees where I don't think this should be pulled into
>> older stable branches.
>
> That is kind of the point of Fixes: tag, is not it? It is appropriate 
> to list a commit that is not specific to serdev, but maybe a 
> particular point into the fw_devlink history. Given this did not 
> appear to have a functional impact, we could go without one.

i was under the impression that this issue breaks at least Bluetooth on 
Raspberry Pi 4 because the driver is never probed. I cannot see the 
success output in Florian's trace. Something like this:

[    7.124879] hci_uart_bcm serial0-0: supply vbat not found, using 
dummy regulator
[    7.131743] hci_uart_bcm serial0-0: supply vddio not found, using 
dummy regulator
...
[    7.517249] Bluetooth: hci0: BCM: chip id 107
[    7.517499] Bluetooth: hci0: BCM: features 0x2f
[    7.519757] Bluetooth: hci0: BCM4345C0
[    7.519768] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
[    7.539495] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
...
[    8.348831] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
[    8.348845] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342

I just want to make sure that 6.2 doesn't have a regression.

