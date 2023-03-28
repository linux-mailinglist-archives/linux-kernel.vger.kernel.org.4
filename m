Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F496CCA69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjC1TGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1TGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:06:37 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A112690;
        Tue, 28 Mar 2023 12:06:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5F2D460508;
        Tue, 28 Mar 2023 21:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680030388; bh=1MsD5J2pqKl7rI0laX3wH8kTy92Y6jzZY3HplEgrvfI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=V1CF9K9GfnrfKJbnsTd6Qs5jp8qeS2UDIzWYdmNpiV0OwLPCL55C90qVndW06HTJr
         7tMNwSBBoEvFQvE7xxgzaDy2iLb4AKxkVdN4eGN2JSdf4US5MGreE3YxTyMq2cNQhO
         i99OuJNbYyulUnHMklGeci5zqIdRsr5sHX8Udy3+M7a/ytZFyoipXrkOy0gOvG72Jk
         fRHgxrkA1bB3gBjZtoyNbQzB37oSKWt8NNBRMl+2ZdDzJizS4laWDlEYU4uzxzry1J
         gEIP2W5ug0lMvDT7pfLMOrwklYNL1UUmZI8L8DKVV2jdEk+Np5zvUHCF9g7mSEBFDs
         /kn3QLtpEOIZw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qAeBq2yT13DD; Tue, 28 Mar 2023 21:06:25 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 0E09760507;
        Tue, 28 Mar 2023 21:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680030385; bh=1MsD5J2pqKl7rI0laX3wH8kTy92Y6jzZY3HplEgrvfI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=mEFYOj7OS4IDI7yzOtOhxrWDD5SJBhwcnbwIUE8nJKcMldSWWgEVJDdhn6tQ1LYmJ
         vKV1/FKy3rxOC0d02/JR63w6A7UXj/BrVILlFen/oNi3yIXiVpwd54smRU/4omFtT3
         j7SP2T6SSGelbuxJH26La26C4t/8a1OjGfGs5bsa+WBtNMQYbz2Q2GSz9dhknVKly4
         ktWbEBLnNpDPtaGnQ7EVuV/NwjOIRkbrJCTZnvTwAEYD2G39Wa9ifK7nMjoCYZJYFW
         r8hkUy14w8nypmsp1MJeBdpgdDG7pP9mPu85wtr8w/+Bdx3B9/Oc1obfpH4/BiHCGh
         B1pZxVp3pGoaw==
Message-ID: <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 21:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Armin Wolf <W_Armin@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <ZCLPaYGKHlFQGKYQ@kroah.com>
 <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr>
 <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr>
 <ZCLa3_HnLQA0GQKS@kroah.com>
 <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr>
 <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Organization: Academy of Fine Arts, University of Zagreb
Subject: Re: [BUG] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
In-Reply-To: <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2023 6:53 PM, Armin Wolf wrote:
> Am 28.03.23 um 14:44 schrieb Mirsad Todorovac:
> 
>> On 3/28/23 14:17, Greg Kroah-Hartman wrote:
>>> On Tue, Mar 28, 2023 at 02:08:06PM +0200, Mirsad Todorovac wrote:
>>>> On 3/28/23 13:59, Mirsad Todorovac wrote:
>>>>
>>>>> On 3/28/23 13:28, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Mar 28, 2023 at 01:13:33PM +0200, Mirsad Todorovac wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Here is another kernel memory leak report, just as I thought we have done with
>>>>>>> them by the xhci patch by Mathias.
>>>>>>>
>>>>>>> The memory leaks were caught on an AlmaLinux 8.7 (CentOS) fork system, running
>>>>>>> on a Lenovo desktop box (see lshw.txt) and the newest Linux kernel 6.3-rc4 commit
>>>>>>> g3a93e40326c8 with Mathias' patch for a xhci systemd-devd triggered leak.
>>>>>>>
>>>>>>>           See: <20230327095019.1017159-1-mathias.nyman@linux.intel.com> on LKML.
>>>>>>>
>>>>>>> This leak is also systemd-devd triggered, except for the memstick_check() leaks
>>>>>>> which I was unable to bisect due to the box not booting older kernels (work in
>>>>>>> progress).
>>>>>>>
>>>>>>> unreferenced object 0xffff88ad12392710 (size 96):
>>>>>>>     comm "systemd-udevd", pid 735, jiffies 4294896759 (age 2257.568s)
>>>>>>>     hex dump (first 32 bytes):
>>>>>>>       53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65 SerialPort1Addre
>>>>>>>       73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74 ss,3F8/IRQ4;[Opt
>>>>>>>     backtrace:
>>>>>>>       [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>>>       [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>>>       [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>>>       [<ffffffffae866a1a>] kstrdup+0x3a/0x70
>>>>>>>       [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
>>>>>>>       [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>>>       [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>>>       [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>>>
> Hi,
> 
> this "SerialPort1Address" string looks like a BIOS setup option, and indeed think_lmi allows for
> changing BIOS setup options over sysfs. While looking at current_value_show() in think-lmi.c, i noticed
> that "item" holds a string which is allocated with kstrdup(), so it has to be freed using kfree().
> This however does not happen if strbrk() fails, so maybe the memory leak is caused by this?
> 
> Armin Wolf

Hi Armin,

I tried your suggestion, and though it is an obvious improvement and a leak fix, this
was not the one we were searching for.

I tested the following patch:

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index c816646eb661..1e77ecb0cba8 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a

         /* validate and split from `item,value` -> `value` */
         value = strpbrk(item, ",");
-       if (!value || value == item || !strlen(value + 1))
+       if (!value || value == item || !strlen(value + 1)) {
+               kfree(item);
                 return -EINVAL;
+       }

         ret = sysfs_emit(buf, "%s\n", value + 1);
         kfree(item);

(I would also object to the use of strlen() here, for it is inherently insecure
against SEGFAULT in kernel space.)

I still get:
[root@pc-mtodorov marvin]# uname -rms
Linux 6.3.0-rc4-armin-patch-00025-g3a93e40326c8-dirty x86_64
[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak [edited]
unreferenced object 0xffff8eb008ef9260 (size 96):
   comm "systemd-udevd", pid 771, jiffies 4294896499 (age 74.880s)
   hex dump (first 32 bytes):
     53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65  SerialPort1Addre
     73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74  ss,3F8/IRQ4;[Opt
   backtrace:
     [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
     [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
     [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
     [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
     [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffff9f197c62>] driver_attach+0x22/0x30
     [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
     [<ffffffff9f19a0a2>] driver_register+0x62/0x120
unreferenced object 0xffff8eb018ddbb40 (size 64):
   comm "systemd-udevd", pid 771, jiffies 4294896528 (age 74.780s)
   hex dump (first 32 bytes):
     55 53 42 50 6f 72 74 41 63 63 65 73 73 2c 45 6e  USBPortAccess,En
     61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c 3a  abled;[Optional:
   backtrace:
     [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
     [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
     [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
     [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
     [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffff9f197c62>] driver_attach+0x22/0x30
     [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
     [<ffffffff9f19a0a2>] driver_register+0x62/0x120
unreferenced object 0xffff8eb006fe2b40 (size 64):
   comm "systemd-udevd", pid 771, jiffies 4294896542 (age 74.724s)
   hex dump (first 32 bytes):
     55 53 42 42 49 4f 53 53 75 70 70 6f 72 74 2c 45  USBBIOSSupport,E
     6e 61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c  nabled;[Optional
   backtrace:
     [<ffffffff9eafb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff9eb02b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff9ea773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffff9ea66a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0eef9aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0eefb64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0ef02c1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc0629c53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffff9f1987eb>] really_probe+0x17b/0x3d0
     [<ffffffff9f198ad4>] __driver_probe_device+0x84/0x190
     [<ffffffff9f198c14>] driver_probe_device+0x24/0xc0
     [<ffffffff9f198ed2>] __driver_attach+0xc2/0x190
     [<ffffffff9f195ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffff9f197c62>] driver_attach+0x22/0x30
     [<ffffffff9f197354>] bus_add_driver+0x1b4/0x240
     [<ffffffff9f19a0a2>] driver_register+0x62/0x120

There are currently 84 wmi_dev_probe leaks, sized mostly 64 bytes, and one 96 and two 192 bytes.

I also cannot figure out the mechanism by which current_value_show() is called, when it is static?

Any idea?

Thanks.

Best regards,
Mirsad

>>>>>> Why aren't you looking at the wmi.c driver?  That should be where the
>>>>>> issue is, not the driver core, right?
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> Hi, Mr. Greg,
>>>>>
>>>>> Thanks for the quick reply.
>>>>>
>>>>> I have added CC: for additional developers per drivers/platform/x86/wmi.c,
>>>>> however, this seems to me like hieroglyphs. There is nothing obvious, but
>>>>> I had not noticed it with v6.3-rc3?
>>>>>
>>>>> Maybe, there seems to be something off:
>>>>>
>>>>>       949 static int wmi_dev_probe(struct device *dev)
>>>>>       950 {
>>>>>       951         struct wmi_block *wblock = dev_to_wblock(dev);
>>>>>       952         struct wmi_driver *wdriver = drv_to_wdrv(dev->driver);
>>>>>       953         int ret = 0;
>>>>>       954         char *buf;
>>>>>       955
>>>>>       956         if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
>>>>>       957                 dev_warn(dev, "failed to enable device -- probing anyway\n");
>>>>>       958
>>>>>       959         if (wdriver->probe) {
>>>>>       960                 ret = wdriver->probe(dev_to_wdev(dev),
>>>>>       961 find_guid_context(wblock, wdriver));
>>>>>       962                 if (ret != 0)
>>>>>       963                         goto probe_failure;
>>>>>       964         }
>>>>>       965
>>>>>       966         /* driver wants a character device made */
>>>>>       967         if (wdriver->filter_callback) {
>>>>>       968                 /* check that required buffer size declared by driver or MOF */
>>>>>       969                 if (!wblock->req_buf_size) {
>>>>>       970 dev_err(&wblock->dev.dev,
>>>>>       971                                 "Required buffer size not set\n");
>>>>>       972                         ret = -EINVAL;
>>>>>       973                         goto probe_failure;
>>>>>       974                 }
>>>>>       975
>>>>>       976                 wblock->handler_data = kmalloc(wblock->req_buf_size,
>>>>>       977 GFP_KERNEL);
>>>>>       978                 if (!wblock->handler_data) {
>>>>>       979                         ret = -ENOMEM;
>>>>>       980                         goto probe_failure;
>>>>>       981                 }
>>>>>       982
>>>>>       983                 buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
>>>>>       984                 if (!buf) {
>>>>>       985                         ret = -ENOMEM;
>>>>>       986                         goto probe_string_failure;
>>>>>       987                 }
>>>>>       988                 wblock->char_dev.minor = MISC_DYNAMIC_MINOR;
>>>>>       989                 wblock->char_dev.name = buf;
>>>>>       990                 wblock->char_dev.fops = &wmi_fops;
>>>>>       991                 wblock->char_dev.mode = 0444;
>>>>>       992                 ret = misc_register(&wblock->char_dev);
>>>>>       993                 if (ret) {
>>>>>       994                         dev_warn(dev, "failed to register char dev: %d\n", ret);
>>>>>       995                         ret = -ENOMEM;
>>>>>       996                         goto probe_misc_failure;
>>>>>       997                 }
>>>>>       998         }
>>>>>       999
>>>>>      1000         set_bit(WMI_PROBED, &wblock->flags);
>>>>>      1001         return 0;
>>>>>      1002
>>>>>      1003 probe_misc_failure:
>>>>>      1004         kfree(buf);
>>>>>      1005 probe_string_failure:
>>>>>      1006         kfree(wblock->handler_data);
>>>>>      1007 probe_failure:
>>>>>      1008         if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
>>>>>      1009                 dev_warn(dev, "failed to disable device\n");
>>>>>
>>>>>
>>>>> char *buf is passed to kfree(buf) uninitialised if wdriver->filter_callback
>>>>> is not set.
>>>>>
>>>>> It seems like a logical error per se, but I don't believe this is the cause
>>>>> of the leak?
>>>>
>>>> CORRECTION:
>>>>
>>>> I overlooked the "return 0" in line 1001.
>>>
>>> Yeah, and the memory looks to be freed properly in the wmi_dev_remove()
>>> callback, right?
>>
>> It would appear so. To verify that:
>>
>> Alloc:
>> 976        wblock->handler_data = kmalloc(wblock->req_buf_size,
>>                            GFP_KERNEL);
>>         <check>
>>
>> 983        buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
>>         <check>
>> 989        wblock->char_dev.name = buf;
>>
>> In lines 1022-1023:
>>
>> 1022        kfree(wblock->char_dev.name);
>> 1023        kfree(wblock->handler_data);
>>
>>>> This is why I don't think things should be rushed, but analysed with clear and
>>>> cold head. And with as many eyes as possible :)
>>>>
>>>> The driver stuff is my long-term research interest. To state the obvious,
>>>> the printing and multimedia education and industry in general would benefit from
>>>> the open-source drivers for many instruments that still work, but are obsoleted
>>>> by the producer and require unsupported versions of the OS.
>>>>
>>>> Thank you again for reviewing the bug report, however, ATM I do not think I have
>>>> what it takes to hunt down the memleak. :-/
>>>
>>> Do you have a reproducer that you can use to show the problem better?
>>
>> Unfortunately, the problem doesn't seem to appear during the run of a particular
>> test, but immediately on startup of the OS. This makes it awkward to pinpoint the
>> exact service that triggered memory leaks. But they would appear to have to do
>> with the initialisation of the USB devices, wouldn't they?
>>
>> There seem to be strings:
>>
>> "USBPortAccess,Enabled;[Optional:"
>> "USBBIOSSupport,Enabled;[Optional"
>> "USBEnumerationDelay,Disabled;[Op"
>>
>> This seems to be happening during USB initialisation and before any services.
>> But I might as well be wrong.
>>
>>> Or can you test kernel patches to verify the problem is fixed or not if
>>> we send you patches to test?
>>
>> Certainly, Lord willing, I can test the patches in the same environment that
>> mainfeted the bug (or memleak).
>>
>> Best regards,
>> Mirsad
>>

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
