Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D788160BA47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJXUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJXUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:30:54 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 11:42:46 PDT
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E97E017;
        Mon, 24 Oct 2022 11:42:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3C178604E7;
        Mon, 24 Oct 2022 20:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666636481; bh=Uw5gaSbSu7XhJwkBClBqus7cuFL+RVHjC+Q1mmDKyF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ww7Fljx4mYjKjiuH1VWEV+gNhga/Cf8G0f4shpk/wf7zkfiY5ECMaL9v78nOgpJ0D
         Wh0lqvZIPfTwKqdldrD5fo/oCaf1rJWaxPM0j0ADgvwGThLAB0nHhETTVCmQJWRb4h
         j4UNTF1FO6ExCmZyMr40qaxEyhpFa6oK8oNhfuVOkT2XTJfytW2CyDVWwFWdzihkl8
         2cAkKnCjT6cHGgLZbWWg6VmEXvpQoNdNIqavk1iwVb/3oPx+StjvRReXwbG/p6mzDu
         ROb4155FObLId3OE3rjzVe8mYADKQp2FgGs4zr0CFaq4fqPMpz5Knf+brnhqYLJ1PC
         D/4BB4ZIDgk7g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VDDG_wwS3LqI; Mon, 24 Oct 2022 20:34:38 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.198.219])
        by domac.alu.hr (Postfix) with ESMTPSA id D90F7604F3;
        Mon, 24 Oct 2022 20:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666636474; bh=Uw5gaSbSu7XhJwkBClBqus7cuFL+RVHjC+Q1mmDKyF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NbZaETI3l5yIafvgzv+XKl8ofoMkywQNyDzytT+N7DGemAEnETpXHAWHGiz57L7Fi
         Miuo2pEZnRRASXFR75RU6v05bmSbjlvH8aEgyHZQY/mxmBi2G3JT+p3jX+kQBf5P4J
         jQ0e9RymSgY4QPE3Hq6q6dwnGJVx1qFhKP7bVmScx/bmioT6o6/1ML7vx5k5CpAf43
         vSpqoe7Uv0+SWUXMfpIQUMzhSyv0wy+LUvbXEMLUE+zxxZE4YvshJVTVvLFQa1NeiU
         03vCmnFqitqARxSr0ObUEMUpwIYEJVIgA+iCRk27l7oR7X2au7d5t5Is65V9/QVOnA
         Xm1b0PgWnrv9g==
Message-ID: <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr>
Date:   Mon, 24 Oct 2022 20:34:31 +0200
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
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
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

Hi Srinivas,

On 24. 10. 2022. 17:51, srinivas pandruvada wrote:
> Hi Mirsad,
>
> Thanks for the bisect.
>
> On Mon, 2022-10-24 at 15:13 +0200, Mirsad Goran Todorovac wrote:
>> Dear all,
>>
>> Around Sep 27th 2022 I've noticed in a mainline kernel built with
>> CONFIG_DEBUG_KMEMLEAK=y
>> that there actually is a leak:
>>
>>> sudo cat /sys/kernel/debug/kmemleak unreferenced object
>> 0xffff8881095f3ee0 (size 80): comm "thermald", pid 837, jiffies
>> 4294896698 (age 9867.428s) hex dump (first 32 bytes): 00 00 00 00 00
>> 00
>> 00 00 0d 01 2d 00 00 00 00 00 ..........-..... af 07 01 00 00 c9 ff
>> ff
>> 00 00 00 00 00 00 00 00 ................ backtrace:
>> [<00000000b50b9dd6>]
>> kmem_cache_alloc+0x184/0x380 [<00000000fa8428c0>]
>> acpi_os_acquire_object+0x2c/0x32 [<000000002cc0099f>]
>> acpi_ps_alloc_op+0x65/0xe6 [<00000000335faf1b>]
>> acpi_ps_get_next_arg+0x842/0x9ed [<000000007afa2dee>]
>> acpi_ps_parse_loop+0x718/0xee1 [<0000000010ce490e>]
>> acpi_ps_parse_aml+0x261/0x7b2 [<00000000278d4c5f>]
>> acpi_ps_execute_method+0x360/0x459 [<00000000ff7ad4ba>]
>> acpi_ns_evaluate+0x595/0x810 [<0000000037ce3488>]
>> acpi_evaluate_object+0x28b/0x5b2 [<000000001a800bbf>]
>> acpi_run_osc+0x209/0x3d0 [<00000000776fbd43>]
>> int3400_thermal_run_osc+0xed/0x180 [int3400_thermal]
>> [<00000000d6ec2302>] current_uuid_store+0x17c/0x1d0 [int3400_thermal]
>> [<00000000486cf3e6>] dev_attr_store+0x3e/0x60 [<00000000bf193027>]
>> sysfs_kf_write+0x88/0xa0 [<00000000820b5cce>]
>> kernfs_fop_write_iter+0x1c9/0x270 [<0000000062f8d35e>]
>> vfs_write+0x5a5/0x750 Mr. Pandruvada required a bug bisect from me,
>> so I
>> have eventually made one. # first bad commit:
>> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update
>> OS
> This will say this patch as this patch is calling acpi_run_osc in
> response to thermald calls for the first time.
>
> But looking at code, this is freeing the memory allocated by
> acpi_run_osc() call chain as any other caller.
>
> 	status = acpi_run_osc(handle, &context);
> 	if (ACPI_SUCCESS(status)) {
> 		ret = *((u32 *)(context.ret.pointer + 4));
> 		if (ret != *enable)
> 			result = -EPERM;
>
> 		kfree(context.ret.pointer);
> 	} else
> 		result = -EPERM;
>
> There is no kfree when call failed as at other places.
> I think you are failing, you can search for "_OSC" in dmesg.
> On some Dell systems this OSC setting fails because of some BIOS issue.
> May be you are hitting that case.
> Just for the sake of test, please apply the diff and see if the issue
> is gone.

Thank you for the patch. Unfortunately, when applied to v6.0.3 it didn't 
fix the issue.

marvin@marvin-IdeaPad-3-15ITL6:~$ uname -rms
Linux 6.0.3-18-fix01-mlk+ x86_64
marvin@marvin-IdeaPad-3-15ITL6:~$ sudo bash
[sudo] password for marvin:
root@marvin-IdeaPad-3-15ITL6:/home/marvin# cat /sys/kernel/debug/kmemleak
root@marvin-IdeaPad-3-15ITL6:/home/marvin# echo scan > 
/sys/kernel/debug/kmemleak
root@marvin-IdeaPad-3-15ITL6:/home/marvin# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff998b030c3370 (size 80):
   comm "thermald", pid 824, jiffies 4294893654 (age 67.080s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00 ..........-.....
     af 07 01 c0 6f bc ff ff 00 00 00 00 00 00 00 00 ....o...........
   backtrace:
     [<00000000490225c2>] slab_post_alloc_hook+0x80/0x2e0
     [<00000000dc142b33>] kmem_cache_alloc+0x166/0x2e0
     [<00000000168f1071>] acpi_os_acquire_object+0x2c/0x32
     [<00000000fcc615e1>] acpi_ps_alloc_op+0x4a/0x99
     [<00000000fb475bb4>] acpi_ps_get_next_arg+0x611/0x761
     [<000000009048d529>] acpi_ps_parse_loop+0x494/0x8d7
     [<000000005b0bf086>] acpi_ps_parse_aml+0x1bb/0x561
     [<000000007ab7e288>] acpi_ps_execute_method+0x20f/0x2d5
     [<00000000c12fa6b7>] acpi_ns_evaluate+0x34d/0x4f3
     [<000000001be94719>] acpi_evaluate_object+0x180/0x3ae
     [<00000000423a7ad5>] acpi_run_osc+0x128/0x250
     [<0000000040a72af8>] int3400_thermal_run_osc+0x6f/0xc0 
[int3400_thermal]
     [<00000000f8d59987>] current_uuid_store+0xe3/0x120 [int3400_thermal]
     [<000000007e2e2d17>] dev_attr_store+0x14/0x30
     [<00000000b824b589>] sysfs_kf_write+0x38/0x50
     [<00000000beae69c1>] kernfs_fop_write_iter+0x146/0x1d0
root@marvin-IdeaPad-3-15ITL6:/home/marvin#

The build process was as follows:

  1573  10/24/2022 06:41:53 PM  cd linux_stable
  1574  10/24/2022 06:42:03 PM  git checkout v6.0.3
  1575  10/24/2022 06:42:44 PM  cd ..
  1576  10/24/2022 06:42:50 PM  time rm -rf linux_stable_build; time cp 
-rp linux_stable linux_stable_build; \
                     time diff -ur linux_stable linux_stable_build; cd 
linux_stable_build
  1577  10/24/2022 06:46:19 PM  git apply ../thermald-20221024-01.diff
  1578  10/24/2022 06:46:28 PM  vi ../config-5.15.0-50-memleak
  1579  10/24/2022 06:47:08 PM  cp ../config-5.15.0-50-memleak .config
  1580  10/24/2022 06:47:16 PM  make olddefconfig
  1581  10/24/2022 06:48:42 PM  time nice make CC="ccache gcc" 
KBUILD_BUILD_TIMESTAMP="" -j10 deb-pkg; date

I think your patch definitively makes sense, but there's more to this 
than meets the eye :-/

Hope this helps.

Thanks
Mirsad

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

