Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A160BB36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiJXUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiJXUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:51:13 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262316EA37;
        Mon, 24 Oct 2022 11:58:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 09A4B604EC;
        Mon, 24 Oct 2022 20:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666637806; bh=AcIPielNLpKnVsat7zTkYDaUsFursqeUBqR3yoMf+yY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SvcBgndn8By+L8BsTjBXX7m489jLfQvIRcHzu3poikSXMNzikPgyN9+T7fxlL6jIM
         abzbhIdeEeHM02fh3lvL/PSMB04G2WQ99WkHbok+xwHDkqDtbLafWgmoKFw13unLW8
         TATzi13Kw2QhHZvqokU/Z6PNd1gIsyLD4aGfTMVjnt9Msw3XYpyxkgP1Xv+GSPF9Yg
         WPnIP9HIz0XmN3rHYIhL721b0Zlo/zgm9u9Bxqe8La1jkdI7v+r9G8htDk392aOCKa
         6s+wJlQmWFGuGYT+hLWHjdmHib5I624TVidcUXBCRO9uZ9KYC1QIq5vxrWXMjisp9I
         OMKLRU3tgEemg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YXZMkYR2gjQc; Mon, 24 Oct 2022 20:56:43 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.198.219])
        by domac.alu.hr (Postfix) with ESMTPSA id ECDB2604E7;
        Mon, 24 Oct 2022 20:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666637803; bh=AcIPielNLpKnVsat7zTkYDaUsFursqeUBqR3yoMf+yY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XooIBdtTnlx9z9vJ8CT1afYzEDuRfLThvIt/k+FiqYM7WOz4Vj8cmySI8hPH2I3vw
         JB9i1Wigpx56jz8yVfG150mnjt16O/JCRJhH1X27ch+Qaifg4SA3Ad84cJWAG/lp5E
         6RvLXFiX2utVSvV9k2lOi1Ioek5DJTcOcw017SrE/7Ly39oBz4gz/kjtv331R4yrwp
         t+09kabuQl336fLx/KQRC4Q4P+4ugR2UC7Vffu9d710cM/EPsFAWZ8MIipQ3mqRksG
         I5Iw47OMqIT7IOJdCJ780JVBmzrkGrbHX52CGEPU1cw8WDI/0TJzYkVQ/w7Jl/oy/A
         veL6Ly+DUP7IA==
Message-ID: <d034dbbc-613c-1a5e-df64-d0251453c8eb@alu.unizg.hr>
Date:   Mon, 24 Oct 2022 20:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net
Cc:     regressions@lists.linux.dev, regressions@leemhuis.info,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>, devel@acpica.org
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
 <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
 <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr>
 <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 10. 2022. 20:39, srinivas pandruvada wrote:

>> Thank you for the patch. Unfortunately, when applied to v6.0.3 it
>> didn't
>> fix the issue.
> Thanks for the test. I copied to acpi and acpica mailing list. Someone
> can tell us what is this call doing wrong here.
Seems like a prudent thing to do. It must be heavy to provide support 
for all of the
hardware on the market ...

Maybe this will help (however, this dmesg -l err was the same in "git 
bisect good" and "git bisect bad" kernels!):

root@marvin-IdeaPad-3-15ITL6:~# dmesg -l err
[    0.121673] ACPI BIOS Error (bug): Could not resolve symbol 
[\_SB.PCI0], AE_NOT_FOUND (20220331/dswload2-163)
[    0.121688] ACPI Error: AE_NOT_FOUND, During name lookup/catalog 
(20220331/psobject-221)
[    0.142742] ACPI BIOS Error (bug): Could not resolve symbol 
[\_SB.PC00.DGPV], AE_NOT_FOUND (20220331/psargs-330)
[    0.142751] ACPI Error: Aborting method \_SB.PC00.PEG0.PCRP._ON due 
to previous error (AE_NOT_FOUND) (20220331/psparse-531)
[    0.308625] integrity: Problem loading X.509 certificate -65
[    2.731846] mtd device must be supplied (device name is empty)
[    3.226997] i801_smbus 0000:00:1f.4: Transaction timeout
[    3.229085] i801_smbus 0000:00:1f.4: Failed terminating the transaction
[    3.229194] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    3.515909] mtd device must be supplied (device name is empty)
[    4.600624] ACPI BIOS Error (bug): Could not resolve symbol 
[\_TZ.ETMD], AE_NOT_FOUND (20220331/psargs-330)
[    4.600741] ACPI Error: Aborting method \_SB.IETM._OSC due to 
previous error (AE_NOT_FOUND) (20220331/psparse-531)
[    5.110999] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    5.173006] Bluetooth: hci0: HCI_REQ-0xfc1e
root@marvin-IdeaPad-3-15ITL6:~# dmesg | grep _OSC
[    0.131652] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.167416] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.169119] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.172500] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug 
SHPCHotplug PME PCIeCapability LTR DPC]
[    4.600655] No Local Variables are initialized for Method [_OSC]
[    4.600660] Initialized Arguments for Method [_OSC]:  (4 arguments 
defined for method invocation)
[    4.600741] ACPI Error: Aborting method \_SB.IETM._OSC due to 
previous error (AE_NOT_FOUND) (20220331/psparse-531)
root@marvin-IdeaPad-3-15ITL6:~#

>> marvin@marvin-IdeaPad-3-15ITL6:~$ uname -rms
>> Linux 6.0.3-18-fix01-mlk+ x86_64
>> marvin@marvin-IdeaPad-3-15ITL6:~$ sudo bash
>> [sudo] password for marvin:
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin# cat
>> /sys/kernel/debug/kmemleak
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin# echo scan >
>> /sys/kernel/debug/kmemleak
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin# cat
>> /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff998b030c3370 (size 80):
>>     comm "thermald", pid 824, jiffies 4294893654 (age 67.080s)
>>     hex dump (first 32 bytes):
>>       00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00 ..........-.....
>>       af 07 01 c0 6f bc ff ff 00 00 00 00 00 00 00 00 ....o...........
>>     backtrace:
>>       [<00000000490225c2>] slab_post_alloc_hook+0x80/0x2e0
>>       [<00000000dc142b33>] kmem_cache_alloc+0x166/0x2e0
>>       [<00000000168f1071>] acpi_os_acquire_object+0x2c/0x32
>>       [<00000000fcc615e1>] acpi_ps_alloc_op+0x4a/0x99
>>       [<00000000fb475bb4>] acpi_ps_get_next_arg+0x611/0x761
>>       [<000000009048d529>] acpi_ps_parse_loop+0x494/0x8d7
>>       [<000000005b0bf086>] acpi_ps_parse_aml+0x1bb/0x561
>>       [<000000007ab7e288>] acpi_ps_execute_method+0x20f/0x2d5
>>       [<00000000c12fa6b7>] acpi_ns_evaluate+0x34d/0x4f3
>>       [<000000001be94719>] acpi_evaluate_object+0x180/0x3ae
>>       [<00000000423a7ad5>] acpi_run_osc+0x128/0x250
>>       [<0000000040a72af8>] int3400_thermal_run_osc+0x6f/0xc0
>> [int3400_thermal]
>>       [<00000000f8d59987>] current_uuid_store+0xe3/0x120
>> [int3400_thermal]
>>       [<000000007e2e2d17>] dev_attr_store+0x14/0x30
>>       [<00000000b824b589>] sysfs_kf_write+0x38/0x50
>>       [<00000000beae69c1>] kernfs_fop_write_iter+0x146/0x1d0
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin#
>>
>> The build process was as follows:
>>
>>    1573  10/24/2022 06:41:53 PM  cd linux_stable
>>    1574  10/24/2022 06:42:03 PM  git checkout v6.0.3
>>    1575  10/24/2022 06:42:44 PM  cd ..
>>    1576  10/24/2022 06:42:50 PM  time rm -rf linux_stable_build; time
>> cp
>> -rp linux_stable linux_stable_build; \
>>                       time diff -ur linux_stable linux_stable_build;
>> cd
>> linux_stable_build
>>    1577  10/24/2022 06:46:19 PM  git apply ../thermald-20221024-
>> 01.diff
>>    1578  10/24/2022 06:46:28 PM  vi ../config-5.15.0-50-memleak
>>    1579  10/24/2022 06:47:08 PM  cp ../config-5.15.0-50-memleak
>> .config
>>    1580  10/24/2022 06:47:16 PM  make olddefconfig
>>    1581  10/24/2022 06:48:42 PM  time nice make CC="ccache gcc"
>> KBUILD_BUILD_TIMESTAMP="" -j10 deb-pkg; date
>>
>> I think your patch definitively makes sense, but there's more to this
>> than meets the eye :-/
>>
>> Hope this helps.
>>
>> Thanks
>> Mirsad
>>
>> --
>> Mirsad Goran Todorovac
>> Sistem inženjer
>> Grafički fakultet | Akademija likovnih umjetnosti
>> Sveučilište u Zagrebu

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

