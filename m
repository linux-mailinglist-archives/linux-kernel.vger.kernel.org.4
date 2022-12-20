Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B4651F20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiLTKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiLTKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:43:25 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA11836D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:43:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9B76E604F2;
        Tue, 20 Dec 2022 11:43:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1671532994; bh=28aeNJcZhjH4Yc/hQCSZhSLXij8XcqFFnXNqh8P8y2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EBp4dCbynhsaxmTNbOQcgyE1FbKslOetKbsd5S9ZybFvV+jLNtnpaC/qYL1Ej0t2m
         mzGZimiLApSFx1XlUKIQvwRPQtAo8LOXtZSdsfsUCNSnz3eQ/qd7n2FNV7oYSfTpag
         3Iwf00b13aDedmWjmzWnifM3JIOAiOYc+et7ase82JG7O7Xul4G/vONb4nlkZb96ak
         HBZ052XKTJFjcHTSYbzhLvnOyRYVNqJBlYSEGilbyZbqw3Jq67jicBlPA3roVR8f+O
         qbUz8bFL8x+bVyxjIitysyzFdU72VnT8QLoSbwVto0c9/70OZM2DevtfdP7s/pBUkQ
         Ag8ikGkVOoOOg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jzd7WZzt8pYI; Tue, 20 Dec 2022 11:43:12 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 008E7604F1;
        Tue, 20 Dec 2022 11:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1671532992; bh=28aeNJcZhjH4Yc/hQCSZhSLXij8XcqFFnXNqh8P8y2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xSH9wgnl4FggF4bm0pn6Ga1tcTGMT+PU2F7lssMixIyr4osrxrOklflRBlsRwkuB3
         xlEqhENuFYkZ/BQrnkulLlA7SzO64EhS+4HiqnT0C/jpXIbd/g0acj+z6mxETc/VrJ
         LSRs5rr0FuFgMcUIXEtbi725e8Zyqwik8Nmqk2zLsCcf95eGFKcqm+4x+xx5tOjPoH
         1fzNHa8MNfsdkBi5w2OOO5ZuowqDCimRtwuDmT+NknCWKdw2NPcmBbRinhh05iCbT1
         zKG1aM7Dm5gBiTnyi06Ji/nLTr6iZUppj/v0zh8u5G46v9/xIgnTvBri4anhNvcJq/
         67FZopUYLWs5Q==
Message-ID: <d4a5ead8-9e9d-b6ac-d0f2-7d46b4f5e4c2@alu.unizg.hr>
Date:   Tue, 20 Dec 2022 11:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Content-Language: en-US, hr
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <MW5PR84MB1842F7A2DD9A9948A647AC5DAB099@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <MW5PR84MB1842F7A2DD9A9948A647AC5DAB099@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 17:51, Elliott, Robert (Servers) wrote:
> 
> 
>> -----Original Message-----
>> From: Phillip Lougher <phillip@squashfs.org.uk>
>> Sent: Friday, November 18, 2022 12:11 AM
>> To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>; LKML <linux-
>> kernel@vger.kernel.org>; Paul E. McKenney <paulmck@kernel.org>
>> Cc: phillip.lougher@gmail.com; Thorsten Leemhuis
>> <regressions@leemhuis.info>
>> Subject: Re: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
>> squashfs_readahead())
>>
>> On 17/11/2022 23:05, Mirsad Goran Todorovac wrote:
>>> Hi,
>>>
>>> While trying to bisect, I've found another bug that predated the
>>> introduction of squashfs_readahead(), but it has
>>> a common denominator in squashfs_decompress() and
>> squashfs_xz_uncompress().
>>
>> Wrong, the stall is happening in the XZ decompressor library, which
>> is *not* in Squashfs.
>>
>> This reported stall in the decompressor code is likely a symptom of you
>> deliberately thrashing your system.  When the system thrashes everything
>> starts to happen very slowly, and the system will spend a lot of
>> its time doing page I/O, and the CPU will spend a lot of time in
>> any CPU intensive code like the XZ decompressor library.
>>
>> So the fact the stall is being hit here is a symptom and not
>> a cause.  The decompressor code is likely running slowly due to
>> thrashing and waiting on paged-out buffers.  This is not indicative
>> of any bug, merely a system running slowly due to overload.
>>
>> As I said, this is not a Squashfs issue, because the code when the
>> stall takes place isn't in Squashfs.
>>
>> The people responsible for the rcu code should have a lot more insight
>> about what happens when the system is thrashing, and how this will
>> throw up false positives.  In this I believe this is an instance of
>> perfectly correct code running slowly due to thrashing incorrectly
>> being flagged as looping.
>>
>> CC'ing Paul E. McKenney <paulmck@kernel.org>
>>
>> Phillip
> 
> How big can these readahead sizes be? Should one of the loops include
> cond_resched() calls?

Please allow me to assert that 6.1.0+ kernel (this Berlin time 6 AM 
morning's build on on Torvalds' tree) built with CONFIG_KMEMLEAK=y, 
CONFIG_KASAN=y, CONFIG_LRU_GEN=y (multi-gen LRU) and
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 doesn't exhibit before seen RCU 
stalls even with such a low timeout as 20 ms.

So I guess kudos go to the MG-LRU developers, or has Mr. Lougher done 
something efficient in the meantime.

My $0.02!

Thank you,
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
