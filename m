Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE035602404
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiJRFuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJRFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:50:01 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C73F51A3F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:49:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6509C604EF;
        Tue, 18 Oct 2022 07:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666072189; bh=NjZ5NivgK3QgvrD6YQwn4A0vxxSyHtxRC3G1VI1pft4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FHRUeKb/Y+tNeOB9g3SqwxfBgBzUEJ5Us/hbQl+noEVlokSQmDnpSXZCtKDffyeYh
         TtdX00BdyhY+2Mwt23qcJF3EgTPGgVLPoO3Iidn7x9hlTr3pSLhghrO5tMOKdbGv2D
         mPQj1zXCfyJVmGPqgX+gtB+NlFMXpFdgabS/XKj6VsnczaigyMzRH3h1PgPkBuaZIF
         FBIuimdge3h8CWxLgX5oYO4b08rELCg2aTQAlclWvoFhxjGj10FUpcUHs06UEtWatz
         jU43pu6/JsFvm4LfpeucAS6DVdZSCrV1az3h7oO53odfxjh+KrpgVSr+ZC26gTIU2k
         VmT4gcVJir8zw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i7My1VEd3Ja8; Tue, 18 Oct 2022 07:49:47 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id A57FC604E6;
        Tue, 18 Oct 2022 07:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666072187; bh=NjZ5NivgK3QgvrD6YQwn4A0vxxSyHtxRC3G1VI1pft4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1DHIkaZxKnrcx3v30LK2NbY7u74ORWUhH5IHyPBnBzNoafCtcmnxkJMeacjR/GxE6
         irK+K6Bey974Sq14F+SyyYvVK7ejEDc4kbQSMY6acm0ebiJ7VE2bZoEBL1gFrxeyEC
         jmyfKJrS439e2b2Y4Z8ICIfRsaNPNOIKPCXpuSteQ9sbbILAohh34J7Ih5SuYY6NZe
         NKKnTgjt7nJAcfKGb3sS34UJZM3O1Napbd1AKv54EwQOmqYUVq/+7xLslwt8Q2rP9f
         UOeAoxMt2jCs6Ee03/wP+jDv/TZM4eWBbIppU1KDQT3AMk1iypuUhCi4bKoB58/uh1
         VwEYZ1eZTHT7A==
Message-ID: <65a8985e-af62-e2e6-bffb-6256071edd74@alu.unizg.hr>
Date:   Tue, 18 Oct 2022 07:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@lists.linux.dev,
        srw@sladewatkins.net, phillip.lougher@gmail.com
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
 <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
 <cdf16572-1206-50b8-1ffe-48746cde00a4@alu.unizg.hr>
 <e6a42b36-aed0-88a0-4a9e-d042aa7f990a@squashfs.org.uk>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e6a42b36-aed0-88a0-4a9e-d042aa7f990a@squashfs.org.uk>
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

On 10/17/22 15:59, Phillip Lougher wrote:

> On 17/10/2022 14:22, Mirsad Goran Todorovac wrote:
>>
>> On 16.10.2022. 21:55, Phillip Lougher wrote:
>>> On 16/10/2022 16:55, Mirsad Goran Todorovac wrote:
>>>> On 15. 10. 2022. 22:59, Phillip Lougher wrote:
>>>
>>> Tracking down bugs of this sort is always a process of elimination,
>>> and gathering information to pinpoint the exact circumstances of why
>>> it is triggering.
>>>
>>> Next step is to download the exact snap(s) where the problems are 
>>> occurring, as this may provide some insights.
>>>
>>> I don't run Ubuntu, and I don't use snaps.  Can you provide the
>>> download link(s) of the snap(s) that cause problems?  If there's
>>> any firefox snaps that don't cause problems those will be useful
>>> too.
>>>
>>> You don't mention if there's any errors present in "dmesg" when
>>> this happens, and so I'm assuming there aren't any?
>>>
>>> Phillip
>>
>> Snaps are originated in Ubuntu, and they heavily rely on snapd, and 
>> squashfs for decompressing executables.
>> Naturally, this also affects Linux Mint as Ubuntu's fork.
>>
>> Those two comprise a large share of the Linux distros, and Firefox is 
>> exclusively distributed in snaps.
>
> I know you meant well, but, don't talk to me as if I'm the village
> idiot.
>
> I said I don't run snaps or Ubuntu, which is nothing to do with lack of
> understanding (*)
>
> I'll contact a couple of people in Canonical to obtain what I need.
>
> (*) I worked as a kernel maintainer for Canonical (Ubuntu) from 2007/8
> and I worked as a kernel maintainer for Redhat on RHEL (which Centos
> is a free version) from 2011 - 2019.  This is addition to writing and
> maintaining Squashfs in the upstream kernel.

Dear Phillip,

Thousand apologies. I had no intent to offend you.
The village idiot is actually meant to be me :)

I've already read on Wikipedia about all the uses of SquashFS, and I do 
not underestimate
your work by no means.

I apologise again if I sounded like that. I don't feel superior or 
gloating by bisecting
the code to your commit. By no means.

Still I somehow managed to underestimate your contribution to The Cause, 
and I am
new to this community, so please forgive me this error. I tried to sound 
diplomatic
rather than lecturing.

Obviously, I failed :(

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

