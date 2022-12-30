Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586176599C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiL3PgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiL3Pf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:35:58 -0500
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22F8C5FB4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:35:55 -0800 (PST)
Received: from [192.168.178.50] ([87.2.89.108])
        by santino.mail.tiscali.it with 
        id 2fbs2900G2LFcqX01fbs16; Fri, 30 Dec 2022 15:35:53 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <19375d92-e9a0-ae11-4e3c-f24f032922b4@tiscali.it>
Date:   Fri, 30 Dec 2022 16:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2 03/21] documentation, capability: fix Generic Block
 Device Capability
From:   Fabio Fantoni <fantonifabio@tiscali.it>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        corbet@lwn.net, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-4-sergei.shtepa@veeam.com>
 <e42dd6c7-6365-75be-0fcd-3329b8f8ba35@tiscali.it>
In-Reply-To: <e42dd6c7-6365-75be-0fcd-3329b8f8ba35@tiscali.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 221230-0, 30/12/2022), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1672414553; bh=UFIXQlWkz3kvqXadUrHh4OwE5XvC6aIIfAyzCHk6uMk=;
        h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To;
        b=sJSyXdfb7WjQ4Nhf2fTM9cZJ+goFvLhyia36jbt6x5XM1jP9/LUQ9sFWT051qFotu
         MrzJvlcuZ/RM1mQwjTXJ0Mh2TcZ+pQJObUNXkFgpm5aW8DHNw/MQj2Og2w/v0yYV5r
         qoYAyHlHAU+8B7F8unHRXzuMwAdmyg5Tkeb8OsXc=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/12/2022 13:13, Fabio Fantoni ha scritto:
> Il 09/12/2022 15:23, Sergei Shtepa ha scritto:
>> When adding documentation for blkfilter, new lines of documentation
>> appeared in the file include/linux/blkdev.h. To preserve the appearance
>> of this document, the required sections and function descriptions were
>> explicitly specified.
>>
>> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
>> ---
>>   Documentation/block/capability.rst | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/block/capability.rst 
>> b/Documentation/block/capability.rst
>> index 2ae7f064736a..8fad791980bb 100644
>> --- a/Documentation/block/capability.rst
>> +++ b/Documentation/block/capability.rst
>> @@ -8,3 +8,6 @@ This file documents the sysfs file 
>> ``block/<disk>/capability``.
>>   capabilities a specific block device supports:
>>     .. kernel-doc:: include/linux/blkdev.h
>> +    :DOC: genhd capability flags
>> +.. kernel-doc:: include/linux/blkdev.h
>> +    :functions: disk_openers blk_alloc_disk bio_end_io_acct
> Thanks for spotting this, I think this is not related to blkfilter 
> patch but was already wrong/broken before and should be posted in a 
> single patch out of the blksnap serie (also fixing title, as reported 
> by Bagas Sanjaya, like "documentation: fix Generic Block Device 
> Capability")
>
> from a fast look seems to me should have only:
>
> +    :DOC: genhd capability flags
>
> and out of that looking older version of doc 
> (https://www.kernel.org/doc/html/v5.10/block/capability.html) seems to 
> me that this DOC in blkdev.h need improvement as it seems to me it was 
> better in the past, for example also reporting the corresponding 
> hexadecimal value in parentheses

Hi, after a fast look to the git history the "genhd capability flags" 
DOC was changed in commit 430cc5d3ab4d0ba0bd011cfbb0035e46ba92920c 
(block: cleanup the GENHD_FL_* definitions) as part of 
https://lore.kernel.org/all/20211122130625.1136848-1-hch@lst.de/ and 
after that in Documentation/block/capability.rst is not possible 
"decode" /sys/block/<disk>/capability reading it 
(https://www.kernel.org/doc/html/v6.1/block/capability.html) without 
having to read also include/linux/blkdev.h code, or I'm wrong?

is correct readd the hexadecimal value from bitfield?

GENHD_FL_REMOVABLE (0x01): ...

GENHD_FL_HIDDEN (0x02): ...

GENHD_FL_NO_PART (0x04): ...

Thanks for any reply and sorry for my bad english

