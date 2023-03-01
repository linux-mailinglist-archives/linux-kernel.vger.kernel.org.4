Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FAB6A71C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCARDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCARDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:03:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2CD51A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:03:02 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIxBc-1pD96F2Q3u-00KQAi; Wed, 01 Mar 2023 17:57:41 +0100
Message-ID: <465a444d-3edb-e6ae-3505-59be9f7509c2@i2se.com>
Date:   Wed, 1 Mar 2023 17:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Raspberry Pi 4B: Failed to create device link with
 soc:firmware:gpio
To:     Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
 <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
 <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com>
 <f13906c0-1a0c-dfa4-dcd3-96ebc82aabd8@gmail.com>
 <CAGETcx-0EKYBL_fQbZSUra3LrzOnV4LABUBZ_jEBmW3sdUzZPA@mail.gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CAGETcx-0EKYBL_fQbZSUra3LrzOnV4LABUBZ_jEBmW3sdUzZPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vd0EzWCQNxqo25v208XHwB05xxZ6IG314u1g5D8ZXjrLeXlLok1
 wrBwqz2RzL+EmY7HR7YImwqWu6vjJ600ZnGOBuoJz3j3TEeyMmUtziKYsP6lAfZuXERn1Tx
 l+Cvm39vs7BNId/wgymcL2nkjz1vttM+4Fm9RquI/Nrw/4N7xn35meCXnitXLNd+AcDQHPR
 fxMa1K+DX4Tyu85Ue5zIA==
UI-OutboundReport: notjunk:1;M01:P0:kqDBFLOdns0=;u8UJiky++p58CItqq2VK+y7mXkA
 cU1tGSXWCdNBklAAq7NsTqBhiMqYaLYPZpMMrqttjMdmyTIlMX4lStbraPFG347nAE3Ji9CfS
 tWq/5HRlniridYsquydzdSdwBTMLvPc3ghtavCBUpyp6ePac0xWwlAi6WlmOMR4F2zvofImEX
 VbftM1OYVMTTuJHskgB9VuMw1jw+FvSALDwsCHdoca+2NZH9Fbo3/zHyWo0Tl4l9jkp9/Nv6O
 TS3Uw3sPiQ6NHn70Srbe36SsLfStwBW7fD4oczijmmLam256gOBfsqEh2bTBNjYk3/H90fasw
 M197ZV2Hcu6KUatQe5iZhpw3xd0m2OGDyxIi8DKPJwqFfOPeO6PhnYDdoRMCtzHvBI5bx20iN
 2IrT8wfQEQr5W4n6q/l0l8NT5JLS2XpN9si1c/YtdeHl2Yb+cgXFIFqLcugqtv4VLBheJGmZz
 CDQeO48Mbc9p7smDeEe0yZuI9vT/4OOG+oFNdB+eBw3rsmGfu+WMhz7BUPoNX6wgyhSasX9mU
 YRY7quRFTvYq0OHms/wWJhRqXpiQT09oCZ5LpmqzJ0G1pQHQJ54hTfdImmZUe8d19Vr3iBr1T
 T6jZxn64cC9tyWf9uUsdgqaJv9dy6F/D8HMepxF5PUsZMl81ZlUDye1yKHcXLhnxWkv6ciMUR
 jBuFxZysoI9t5zN6X5Rfvpbum5VGDwFnUNrk8gv0lA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Am 01.03.23 um 08:49 schrieb Saravana Kannan:
> On Sun, Feb 26, 2023 at 11:14 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>> On 2/25/2023 5:58 PM, Florian Fainelli wrote:
>>>
>>> On 2/25/2023 4:01 PM, Saravana Kannan wrote:
>>>> On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli
>>>> <f.fainelli@gmail.com> wrote:
>>>>> Hi Saravana,
>>>>>
>>>>> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the following
>>>>> for the "extended GPIO" provider:
>>>>>
>>>>> [    5.969855] uart-pl011 fe201000.serial: Failed to create device link
>>>>> with soc:firmware:gpio
>>>> Outside of this error, is it actually breaking anything?
>>> There is just this warning, there does not appear to be a functional issue.
>>>
>>>> Also, can you
>>>> pull in this patch and tell me what it says? I want to know what the
>>>> flags are.
>>>> https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@google.com/
>> Pulling in this patch results in the following being printed:
>>
>> [   14.866835] uart-pl011 fe201000.serial: Failed to create device link
>> (0x180) with soc:firmware:gpio
> I spent at least 2 hours looking at the logs and the DT files and I'm
> still kinda lost.
>
> The 0x180 means it's a DL_FLAG_INFERRED | DL_FLAG_SYNC_STATE_ONLY.
> That's just fw_devlink trying to create a "proxy" link where an
> ancestor of a consumer (can be several levels above consumer) creates
> a SYNC_STATE_ONLY link to the supplier while we wait for the consumer
> device to get added. This prevents sync_state() from being called too
> early on the supplier.
>
> There are so many includes in the dts/dtsi files that my head is
> spinning. I finally found out where the soc:firmware:gpio device was
> coming from (after confusing myself with gpio@7e200000 for a bit) and
> where fe201000.serial was coming from. I still couldn't figure out how
> the address got mapped to fe201000 in fe201000.serial -- that
> generally means the parent has some address offset, but I don't see
> that in DT (but it is not important for this discussion, so we can
> ignore that).
This is uart0 which is at first defined in bcm283x.dtsi. On the 
Raspberry Pi 4 this UART is connected to the Bluetooth IC. On Linux 
probing of the serial communication via DT is done via serial device bus 
(see bcm283x-rpi-wifi-bt.dtsi).
> Anyway, I see no supplier-consumer link between serial@7e201000 (or
> any of its zero descendants) and soc:firmware:gpio (which is the node
> expgpio:). So I'm very confused why we might even try to create this
> sync state only device link between these two.
>
> There are actually two times where we try to create such a link:
>
> First attempt that actually succeeds -- but I have no idea why we even do this:
> [    0.100047] device:
> 'platform:soc:firmware:gpio--amba:fe201000.serial': device_add
> [    0.100232] amba fe201000.serial: Linked as a sync state only
> consumer to soc:firmware:gpio

I assume the link is established by raspberry,firmware-gpio which 
provides the necessary BT shutdown-gpios defined in bcm2711-rpi-4-b.dts. 
Seems to me that the problem is, that necessary underlying firmware 
driver is probed "too late":

[ 15.456506] raspberrypi-firmware soc:firmware: Attached to firmware 
from 2020-02-12T12:36:21

Hope this helps a little bit

> the "amba" prefix tells us a driver hasn't been bound to fe201000.serial yet.
>
> Second attempt is the one that fails.
> [   15.516166] uart-pl011 fe201000.serial: Failed to create device
> link (0x180) with soc:firmware:gpio
> The uart-pl011 tells us that the driver has bound to fe201000.serial.
>
> And it fails because of this sensible check I had put up a while ago
> inside device_link_add():
>          /*
>           * SYNC_STATE_ONLY links are useless once a consumer device
> has probed.
>           * So, only create it if the consumer hasn't probed yet.
>           */
>          if (flags & DL_FLAG_SYNC_STATE_ONLY &&
>              consumer->links.status != DL_DEV_NO_DRIVER &&
>              consumer->links.status != DL_DEV_PROBING) {
>                  link = NULL;
>                  goto out;
>          }
>
> So the real question is still to figure out why fw_devlink is trying
> to create this device link.
>
> So to debug this further the following would help a lot:
> 1. Pull the dtb from the device and then decompile it and provide me
> the result. This way, I can be sure I'm not missing something and
> don't have to dig through all the includes -- I forgot the exact
> commands for it, but it's been shared in LKML before. Let me know if
> you need me to dig this up.
>
> 2. I think a stack backtrace when these two device link attempts are
> made might help me figure out why they are being created. To get these
> backtraces, can you do the following please?
> a. Put a WARN_ON() inside device_add() for when the device name matches:
> platform:soc:firmware:gpio--amba:fe201000.serial
> b. Put a WARN_ON(1) where we print "Failed to create device link..."
>
> Feel free to dig more into 2a and 2b if you find that the stack trace
> doesn't tell much -- one problem with the stack trace is that it
> doesn't show the params being passed to
> __fw_devlink_link_to_consumers() and __fw_devlink_link_to_suppliers()
>
> Thanks,
> Saravana
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
