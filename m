Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C542B6FB5E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjEHR00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEHR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:26:24 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E0526F;
        Mon,  8 May 2023 10:26:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5BEB660189;
        Mon,  8 May 2023 19:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1683566779; bh=B2QfO25Gzot6S0sPndd2xgHlr+IbNt2ib75yKweDZz0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I1apZMqK+Hs4XFwKv3koRqIO3QJbKq4Uy6YiwIwE8mpj9Sbhf+jNFtKyW0HsCQSOA
         xWplRJMdL0eoWA+8UBdlYiawG6+zB9yYL12FwAONB9onHZkZJ3lUQpIkNoENLb67o5
         5eW8E5JEtkNIsBHMEDqtfxrSUyDW/HkN560WXqs1EUarksrTBQok67AGb08k7NYbzm
         xs3dT1hDK9VfwZoqjpiaJ/xd+qLrIsx5kxcGdHNHuEi4+JVv7kgS6vLtpF7OOHyn89
         IfF9GMJqsPjhva4mg5Z24ynxVOVxOttmz/9gsJLINPiyUKnFntbSs0PykOFO/LFh3w
         49WIvHMneYQzw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id msNPEWbRQ8ua; Mon,  8 May 2023 19:26:16 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id E009E60187;
        Mon,  8 May 2023 19:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683566776; bh=B2QfO25Gzot6S0sPndd2xgHlr+IbNt2ib75yKweDZz0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YRYGamMquQHitXJZK2ELXhGFTgujiT0WduQLRL6TLhcwjG6/xNb+MoAyJHHSYADto
         C/cki6l5xzsM80gUZ5/u8zY8M/KPaTAtymHE0TG/f65cww9s86tPoETUJ4GIXQ/LRh
         Ym4FjVE7Hb99LxT2BPijF4YOER/jvVV6bF07cj+8Cejpin1hkxMGhQ9k7S7ifLG9rU
         NYE2Ange3yQvqIB/+/N9pXzAQee7HdlCIRMBr7m//Zwb3if/7IXbGvGamH12m3jYVI
         JIbSCvNbJcUDKbZElSRIGEw/JEQKZMATvJJvef9tsiceg+s/asFqk07nnkfFU6+R4P
         JS9Nt9yVcXpmg==
Message-ID: <34d52b94-6fb2-10d1-575e-df4eeaf54ca7@alu.unizg.hr>
Date:   Mon, 8 May 2023 19:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG] Kmemleak, possibly hiddev_connect(), in 6.3.0+ torvalds
 tree commit gfc4354c6e5c2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
References: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
 <2023050824-juiciness-catching-9290@gregkh>
 <2023050854-collage-dreamt-660c@gregkh>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
In-Reply-To: <2023050854-collage-dreamt-660c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 05. 2023. 16:01, Greg Kroah-Hartman wrote:

> On Mon, May 08, 2023 at 08:51:55AM +0200, Greg Kroah-Hartman wrote:
>> On Mon, May 08, 2023 at 08:30:07AM +0200, Mirsad Goran Todorovac wrote:
>>> Hi,
>>>
>>> There seems to be a kernel memory leak in the USB keyboard driver.
>>>
>>> The leaked memory allocs are 96 and 512 bytes.
>>>
>>> The platform is Ubuntu 22.04 LTS on a assembled AMD Ryzen 9 with X670E PG
>>> Lightning mobo,
>>> and Genius SlimStar i220 GK-080012 keyboard.
>>>
>>> (Logitech M100 HID mouse is not affected by the bug.)
>>>
>>> BIOS is:
>>>
>>>       *-firmware
>>>            description: BIOS
>>>            vendor: American Megatrends International, LLC.
>>>            physical id: 0
>>>            version: 1.21
>>>            date: 04/26/2023
>>>            size: 64KiB
>>>
>>> The kernel is 6.3.0-torvalds-<id>-13466-gfc4354c6e5c2.
>>>
>>> The keyboard is recognised as Chicony:
>>>
>>>                   *-usb
>>>                        description: Keyboard
>>>                        product: CHICONY USB Keyboard
>>>                        vendor: CHICONY
>>>                        physical id: 2
>>>                        bus info: usb@5:2
>>>                        logical name: input35
>>>                        logical name: /dev/input/event4
>>>                        logical name: input35::capslock
>>>                        logical name: input35::numlock
>>>                        logical name: input35::scrolllock
>>>                        logical name: input36
>>>                        logical name: /dev/input/event5
>>>                        logical name: input37
>>>                        logical name: /dev/input/event6
>>>                        logical name: input38
>>>                        logical name: /dev/input/event8
>>>                        version: 2.30
>>>                        capabilities: usb-2.00 usb
>>>                        configuration: driver=usbhid maxpower=100mA
>>> speed=1Mbit/s
>>>
>>> The bug is easily reproduced by unplugging the USB keyboard, waiting about a
>>> couple of seconds,
>>> and then reconnect and scan for memory leaks twice.
>>>
>>> The kmemleak log is as follows [edited privacy info]:
>>>
>>> root@hostname:/home/username# cat /sys/kernel/debug/kmemleak
>>> unreferenced object 0xffff8dd020037c00 (size 96):
>>>    comm "systemd-udevd", pid 435, jiffies 4294892550 (age 8909.356s)
>>>    hex dump (first 32 bytes):
>>>      5d 8e 4e b9 ff ff ff ff 00 00 00 00 00 00 00 00 ].N.............
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffffb81a74be>] __kmem_cache_alloc_node+0x22e/0x2b0
>>>      [<ffffffffb8127b6e>] kmalloc_trace+0x2e/0xa0
>>>      [<ffffffffb87543d9>] class_create+0x29/0x80
>>>      [<ffffffffb8880d24>] usb_register_dev+0x1d4/0x2e0
>> As the call to class_create() in this path is now gone in 6.4-rc1, can
>> you retry that release to see if this is still there or not?
> No, wait, it's still there, I was looking at a development branch of
> mine that isn't sent upstream yet.  And syzbot just reported the same
> thing:
> 	https://lore.kernel.org/r/00000000000058d15f05fb264013@google.com
>
> So something's wrong here, let me dig into it tomorrow when I get a
> chance...

Hi,

I can confirm that the leak is still present in 6.4-rc1:

root@host:/home/user# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff9e6b57bd8ea0 (size 96):
   comm "systemd-udevd", pid 322, jiffies 4294892584 (age 123.516s)
   hex dump (first 32 bytes):
     a4 90 ee b6 ff ff ff ff 00 00 00 00 00 00 00 00 ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
   backtrace:
     [<ffffffffb5ba74be>] __kmem_cache_alloc_node+0x22e/0x2b0
     [<ffffffffb5b27b6e>] kmalloc_trace+0x2e/0xa0
     [<ffffffffb6154959>] class_create+0x29/0x80
     [<ffffffffb62812a4>] usb_register_dev+0x1d4/0x2e0
     [<ffffffffc066ebab>] hiddev_connect+0x11b/0x1b0 [usbhid]
     [<ffffffffc0629d4e>] hid_connect+0xde/0x580 [hid]
     [<ffffffffc062a24c>] hid_hw_start+0x4c/0x70 [hid]
     [<ffffffffc05e8092>] hid_generic_probe+0x32/0x40 [hid_generic]
     [<ffffffffc062a450>] hid_device_probe+0x100/0x170 [hid]
     [<ffffffffb6152602>] really_probe+0x1b2/0x420
     [<ffffffffb61528fe>] __driver_probe_device+0x7e/0x170
     [<ffffffffb6152a23>] driver_probe_device+0x23/0xa0
     [<ffffffffb6152cc8>] __driver_attach+0xe8/0x1e0
     [<ffffffffb614fe6e>] bus_for_each_dev+0x7e/0xd0
     [<ffffffffb6151da2>] driver_attach+0x22/0x30
     [<ffffffffb61513f0>] bus_add_driver+0x120/0x220
unreferenced object 0xffff9e6b58d75800 (size 512):
   comm "systemd-udevd", pid 322, jiffies 4294892584 (age 123.516s)
   hex dump (first 32 bytes):
     00 58 d7 58 6b 9e ff ff 00 58 d7 58 6b 9e ff ff .X.Xk....X.Xk...
     00 00 00 00 00 00 00 00 a4 90 ee b6 ff ff ff ff ................
   backtrace:
     [<ffffffffb5ba74be>] __kmem_cache_alloc_node+0x22e/0x2b0
     [<ffffffffb5b27b6e>] kmalloc_trace+0x2e/0xa0
     [<ffffffffb6154812>] class_register+0x32/0x140
     [<ffffffffb6154974>] class_create+0x44/0x80
     [<ffffffffb62812a4>] usb_register_dev+0x1d4/0x2e0
     [<ffffffffc066ebab>] hiddev_connect+0x11b/0x1b0 [usbhid]
     [<ffffffffc0629d4e>] hid_connect+0xde/0x580 [hid]
     [<ffffffffc062a24c>] hid_hw_start+0x4c/0x70 [hid]
     [<ffffffffc05e8092>] hid_generic_probe+0x32/0x40 [hid_generic]
     [<ffffffffc062a450>] hid_device_probe+0x100/0x170 [hid]
     [<ffffffffb6152602>] really_probe+0x1b2/0x420
     [<ffffffffb61528fe>] __driver_probe_device+0x7e/0x170
     [<ffffffffb6152a23>] driver_probe_device+0x23/0xa0
     [<ffffffffb6152cc8>] __driver_attach+0xe8/0x1e0
     [<ffffffffb614fe6e>] bus_for_each_dev+0x7e/0xd0
     [<ffffffffb6151da2>] driver_attach+0x22/0x30
root@host:/home/user#

Would you need a bisect on this one? Maybe it would help.

Best regards,
Mirsad


