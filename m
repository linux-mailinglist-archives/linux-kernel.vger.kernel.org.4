Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D06F79CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjEDXqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEDXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:46:11 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DB120A1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 16:46:10 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 10924A8005A;
        Thu,  4 May 2023 23:46:08 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 763CC13C2B0;
        Thu,  4 May 2023 16:46:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 763CC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683243967;
        bh=SR1DoU+w1FCC/ouCviUucgYuqEXWiLyVT9i1MOoTWU4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=lzT/UU4FnMzeczH4TzuK+JUR6DXXTfwUS7p8zfSfRAGuGwHXu/k0cg8sc3R4/zXAv
         DtqaYCJgWn/Cabm4U8y82/nqDnXhyNiwww38xVJCuYNDWFhKhfbRZOsO5WYCLB/6L4
         g0xz8Fz2MWpfSrUdwEMimPzI0Hvi18y5O0mwDUso=
Message-ID: <745e1e38-85ed-76dc-9cbb-2c3d71d70d97@candelatech.com>
Date:   Thu, 4 May 2023 16:46:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <a227583c-ef41-e954-fd4c-0cdb23c77222@candelatech.com>
 <BYAPR21MB168889708435D073352C4A46D76D9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <BYAPR21MB168889708435D073352C4A46D76D9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1683243969-2g9E5Hwt7mVz
X-MDID-O: us5;ut7;1683243969;2g9E5Hwt7mVz;<greearb@candelatech.com>;dee2029893dd26ce54075db23528cf74
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 10:59, Michael Kelley (LINUX) wrote:
> From: Ben Greear <greearb@candelatech.com> Sent: Thursday, May 4, 2023 10:23 AM
>>
>> On 5/3/23 16:49, Ben Greear wrote:
>>> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>>>
>>>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>>>
>>>> Just to understand this properly: you mean after the boot loader said it
>>>> loaded the initramfs, not when the kernel starts using it?
>>>
>>> I am bisecting...it appears to be .config related.  If I skip enabling things
>>> during bisect, then I do not see the problem.  But I copied my original buggy .config
>>> into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
>>> the .config settings....
>>
>> I had enabled this option:  CONFIG_HYPERV_VTL_MODE
>>
>> And that makes it not boot.  Not sure that is expected or not, but
>> I will simply un-select it and continue on, as I do not actually need that feature.
>>
> 
> What you observed is expected when CONFIG_HYPERV_VTL_MODE is selected,
> which is why it defaults to N.  The comment for that option in the Kconfig file says:
> 
> 	  Select this option to build a Linux kernel to run at a VTL other than
> 	  the normal VTL0, which currently is only VTL2.  This option
> 	  initializes the x86 platform for VTL2, and adds the ability to boot
> 	  secondary CPUs directly into 64-bit context as required for VTLs other
> 	  than 0.  A kernel built with this option must run at VTL2, and will
> 	  not run as a normal guest.

I didn't read it close enough, but that is my fault.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


