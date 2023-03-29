Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E526CF305
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjC2TUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC2TUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:20:35 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E91BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8pbGV+Pit4mlON4UjRpeZJgYtqVP3pcDx6q0DmLRYwU=; b=K2adBP3PzJrP5OF/MBaS7CLGw0
        QxhRkr2iR2/izFwIvb0BKJW6z8l5hoYdMkXEsEGOCPNXvZZmj1nCQwxSXfcejkJF0h3YSYrYGGQhP
        Metl2d6wQFS0XXSlaSs8TXnNrqHFiEqxRfb9GmI/Xh13AM3qI6NerjMZ1CXMw6XJce825l38+5uq4
        yBDxq8Na1OteJhKUbrv/c5rD2FeEdKiyPbVSAmg5ixe0prs8n1mB3sRpT3LqGVbud46PO3EhmP8mC
        HhLJq9EMzU/9WvJ09wO8dpPd6Kh3hDZO0KzBjzwWcJo0iwGIvvWP0ThZlf+ALENH5RRD3UxMl5O4x
        SlfRPUig==;
Message-ID: <7218e006-9f4f-a9bc-cdd2-a595a8e64ede@unsolicited.net>
Date:   Wed, 29 Mar 2023 20:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>,
        eric.devolder@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
 <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
 <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
 <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
 <e8fd7cdf-b6a5-1c7d-bd08-0d60a1c10495@amd.com>
 <eaa97a25-27b2-187c-1db2-9c56e35d3463@unsolicited.net>
 <b65c4f1f-4990-f7ce-e4c0-85912d187eaf@amd.com>
 <a0ca1e4e-891c-273d-e2d8-eeb9fc4d0c77@unsolicited.net>
 <e4a6e5bb-d014-aa55-5eee-65f1c5f59875@amd.com>
From:   David R <david@unsolicited.net>
In-Reply-To: <e4a6e5bb-d014-aa55-5eee-65f1c5f59875@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 20:17, Limonciello, Mario wrote:
> On 3/29/2023 14:14, David R wrote:
>> I note that 6.2.8 still has:
>>
>> static bool __init acpi_is_processor_usable(u32 lapic_flags)
>> {
>>          if (lapic_flags & ACPI_MADT_ENABLED)
>>                  return true;
>>
>>          if (acpi_support_online_capable && (lapic_flags & 
>> ACPI_MADT_ONLINE_CAPABLE))
>>                  return true;
>>
>>          return false;
>> }
>>
>> The flag getting set to false won't help unless the patch I tried 
>> previously is applied ?
>>
>> diff 
>> <https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/#iZ31arch:x86:kernel:acpi:boot.c> 
>> --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c 
>> index 1c38174b5f01..7b5b8ed018b0 100644 --- 
>> a/arch/x86/kernel/acpi/boot.c +++ b/arch/x86/kernel/acpi/boot.c @@ 
>> -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 
>> lapic_flags)       if (lapic_flags & ACPI_MADT_ENABLED)
>>           return true;
>>   - if (acpi_support_online_capable && (lapic_flags & 
>> ACPI_MADT_ONLINE_CAPABLE)) + /* + * Prior to MADT.revision 5, the 
>> presence of the Local x2/APIC + * structure _implicitly_ noted a 
>> possible hotpluggable cpu. + * Starting with MADT.revision 5, the 
>> Online Capable bit + * _explicitly_ indicates a hotpluggable cpu. + 
>> */ + if (!acpi_support_online_capable || (lapic_flags & 
>> ACPI_MADT_ONLINE_CAPABLE))           return true;
>>         return false;
>> -- 
>>
>
> You mean specifically this change:
> https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/ 
>
>
> Yes; I suppose that still makes sense.
>
Yes, that's the one.

But the fact that  that one worked own its own implies that my system 
never had the flag set in the first place?

David
