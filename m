Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FD6BC82E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCPIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCPIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:05:25 -0400
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 01:05:06 PDT
Received: from vsp02-out.oderland.com (vsp02-out.oderland.com [IPv6:2a02:28f0::27:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E1193E4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:05:06 -0700 (PDT)
X-Scanned-Cookie: f500bda16b244583931b552d2d35209f2e653c44
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
        by vsp-out.oderland.com (Halon) with ESMTPSA
        id d930500f-c3cf-11ed-b0b1-953cc26b59f3;
        Thu, 16 Mar 2023 08:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4sDqyLsKGwu6VCvEwuakJHaAxdK3Nq6qCvs+CWZkkiA=; b=rUwenm56+KATrWTxLJMffhz5rS
        PnU8wnTUchVbcSNsKMDRjS/k7aBfbNegD5/Dk42mkk4TLFxMcgJD80XCScjZbM7nYMcBKDcBeeAVD
        x9j28sY9BoUGw4F7En3mSilCjeS3QZYWnMl8brb+2kr6TFVovVyibHtjm7ohuKirmeCxov+joJgtM
        35UKXqo6uPIxRSlifyhFbHAORtBMr3g9BJetgVqwtu+s/8KMJIgb2/1yjSWPWM/9X3a6IaSd+v/fM
        Y5QpucKCAwJbNDw21EeAO8U8g1UJ1/e7rElUJEhefRifRQVxTsuCG0vF65hw4YzrXlOCcCqUk77Az
        3U8fY/fw==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:37640 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <josef@oderland.se>)
        id 1pciRx-000a00-9K;
        Thu, 16 Mar 2023 08:54:58 +0100
Message-ID: <2754848f-6c3c-5479-ea6f-1946c93f868e@oderland.se>
Date:   Thu, 16 Mar 2023 08:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:111.0) Gecko/20100101
 Thunderbird/111.0
Subject: Re: [PATCH 3/3] xen/acpi: upload power and performance related data
 from a PVH dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-4-roger.pau@citrix.com>
 <407b7c10-ad1f-b6d2-2976-2b297755b2b3@oderland.se>
 <ZBGuVjyDpuUZ3MnZ@Air-de-Roger>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <ZBGuVjyDpuUZ3MnZ@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-oderland-domain-valid: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 12:39, Roger Pau Monné wrote:
> On Mon, Jan 30, 2023 at 10:10:05AM +0100, Josef Johansson wrote:
>> On 11/21/22 11:21, Roger Pau Monne wrote:
>>> When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
>>> report the correct numbers of vCPUs that dom0 has, so the host MADT is
>>> not provided to dom0.  This creates issues when parsing the power and
>>> performance related data from ACPI dynamic tables, as the ACPI
>>> Processor UIDs found on the dynamic code are likely to not match the
>>> ones crafted by Xen in the dom0 MADT.
>>>
>>> Xen would rely on Linux having filled at least the power and
>>> performance related data of the vCPUs on the system, and would clone
>>> that information in order to setup the remaining pCPUs on the system
>>> if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
>>> that none of dom0 CPUs will have the power and performance data
>>> filled, and hence the Xen ACPI Processor driver needs to fetch that
>>> information by itself.
>>>
>>> In order to do so correctly, introduce a new helper to fetch the _CST
>>> data without taking into account the system capabilities from the
>>> CPUID output, as the capabilities reported to dom0 in CPUID might be
>>> different from the ones on the host.
>>>
>>>
>> Hi Roger,
>>
>> First of all, thanks for doing the grunt work here to clear up the ACPI
>> situation.
>>
>> A bit of background, I'm trying to get an AMD APU (CPUID 0x17 (23)) to work
>> properly
>> under Xen. It works fine otherwise but something is amiss under Xen.
> Hello,
>
> Sorry for the delay, I've been on paternity leave and just caching up
> on emails.
Hi Roger,

Congratulations! I hope you had time to really connect. It's the most 
important thing we can do here in life.

I came into this to understand each and every error in my boot-log, it 
turns out that the latest
kernel+xen+firmware fixes suspend/resume for me, thus is this not 
related. But as I pointed out,
the output does not make any sense (nor yours nor the upstream). I 
should check the debug
output with suspend working fine now to see if there are any changes, 
that would be quite
interesting.

Also, I should mention that your patch broke some things on my system 
and made it
unstable. I don't remember exactly and I know you said that this is more 
of a PoC. Just a
heads up.
>> Just to make sure that the patch is working as intended, what I found when
>> trying it out
>> is that the first 8 CPUs have C-States, but 0, 2, 4, 6, 8, 10, 12, 14 have
>> P-States, out of
>> 16 CPUs. Xen tells Linux that there are 8 CPUs since it's running with
>> nosmt.
>>
>> Regards
>> - Josef
>>
>> xen_acpi_processor: Max ACPI ID: 30
>> xen_acpi_processor: Uploading Xen processor PM info
>> xen_acpi_processor: ACPI CPU0 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU0 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU1 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU2 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU2 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU3 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU4 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU4 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU5 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU6 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU6 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU7 - C-states uploaded.
>> xen_acpi_processor:      C1: ACPI HLT 1 uS
>> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
>> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
>> xen_acpi_processor: ACPI CPU0 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU0 w/ PST:coord_type = 254 domain = 0
>> xen_acpi_processor: CPU with ACPI ID 1 is unavailable
> Hm, that's weird, do you think you could check why it reports the CPU
> is unavailable?
If you would give me a hint at how I could check?
Right now my guess is that C state and P state is not in sync, thus P 
state are for every other
CPU and C state is for the first 8. AFAIK AMD only have 
performance-cores (unlike Intel).
>
> Overall I don't like the situation of the ACPI handling when running
> as dom0. It's fragile to rely on the data for dom0 CPUs to be
> filled by the system (by adding some band aids here and there so that
> the PV vCPUs are matched against the MADT objects) and then cloning
> the data for any physical CPU exceeding the number of dom0 virtual
> CPUs.
That's my understanding from earlier implementation as well, nobody 
actually like it,
But the current solution is something working in a bad environment.
>
> IMO it would be much better to just do the handling of ACPI processor
> objects in a Xen specific driver (preventing the native driver from
> attaching) in order to fetch the data and upload it to Xen.  This is
> what I've attempted to do on FreeBSD, and resulted in a cleaner
> implementation:
>
> <link>
>
> I however don't have time to do this right now for Linux.

Maybe I can take a stab, I very much like the climate of the kernel but 
everything
seem so scary :) I've been trying to understand things better, how 
they're all
connected.
>
>> xen_acpi_processor: ACPI CPU2 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU2 w/ PST:coord_type = 254 domain = 1
>> xen_acpi_processor: CPU with ACPI ID 3 is unavailable
>> xen_acpi_processor: ACPI CPU4 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU4 w/ PST:coord_type = 254 domain = 2
>> xen_acpi_processor: CPU with ACPI ID 5 is unavailable
>> xen_acpi_processor: ACPI CPU6 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU6 w/ PST:coord_type = 254 domain = 3
>> xen_acpi_processor: CPU with ACPI ID 7 is unavailable
>> xen_acpi_processor: ACPI CPU8 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU8 w/ PST:coord_type = 254 domain = 4
>> xen_acpi_processor: CPU with ACPI ID 9 is unavailable
>> xen_acpi_processor: ACPI CPU10 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU10 w/ PST:coord_type = 254 domain = 5
>> xen_acpi_processor: CPU with ACPI ID 11 is unavailable
>> xen_acpi_processor: ACPI CPU12 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU12 w/ PST:coord_type = 254 domain = 6
>> xen_acpi_processor: CPU with ACPI ID 13 is unavailable
>> xen_acpi_processor: ACPI CPU14 w/ PBLK:0x0
>> xen_acpi_processor: ACPI CPU14 w/ PST:coord_type = 254 domain = 7
>> xen_acpi_processor: CPU with ACPI ID 15 is unavailable
>> xen_acpi_processor: ACPI CPU8 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU10 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU12 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>> xen_acpi_processor: ACPI CPU14 - P-states uploaded.
>> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
>> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
>> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
>>
>> As a bonus, here are the previous debug output on the same machine.
> I think the output below is with dom0 running as plain PV rather than
> PVH?
This is the upstream ACPI implementation vs yours. What would plain PV 
vs PVH be in dom0?

Regards
- Josef
> Thanks, Roger.

