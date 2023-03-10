Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFF6B3A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCJJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCJJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:25:08 -0500
Received: from libero.it (smtp-18-i2.italiaonline.it [213.209.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884617DF90
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:21:06 -0800 (PST)
Received: from [192.168.1.176] ([79.35.132.58])
        by smtp-18.iol.local with ESMTPA
        id aYszp9ajReyjYaYt0pUuxS; Fri, 10 Mar 2023 10:18:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1678439882; bh=FnMc+9gMDALpDU5lmT8TmSwnKqa6D1GypUawpPyEDDo=;
        h=From;
        b=bGK3R0SJHEPVEJvXM93PI3EHCtXxzF7eKr64j1Pm5ucfsgKMt9LXqTTO3ez03v3hq
         GsWQ32OGAPDTMyC4y9Mdbh4zI2up5KDmGvLQNK23jGbhU4tyquebn/Gj/U3zbogerz
         leIRk0zc6nLUM7bjAb0eAcCcAU/0GXa9LPL1GCNUo0Ov+8lihtEvZDKYSyNJPr+Z8s
         nNFGC1uWl4ttbzKP/cwB4ERRYqPdO+g8bkoiwlfYCVzE3ARJcY1J3GGgTrcHSs1N4W
         xCxuuGwne2YZ+ceADJrFxRZGCy/kbhMO1WOMqTQvAIksub8chtnO6opNlhGxBOT+4U
         XGHu1Ve/lTB/g==
X-CNFS-Analysis: v=2.4 cv=bIjQYtyZ c=1 sm=1 tr=0 ts=640af5ca cx=a_exe
 a=HrXNelnF3IDyoBa3MXWlnA==:117 a=HrXNelnF3IDyoBa3MXWlnA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=OKq4cFKFdVVfbenFr7sA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <f09763e4-5c1e-9293-8366-91575e0ef037@inwind.it>
Date:   Fri, 10 Mar 2023 10:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00
From:   Valerio Vanni <valerio.vanni@inwind.it>
To:     linux-kernel@vger.kernel.org
Cc:     Slade Watkins <srw@sladewatkins.net>
References: <87f7b3f4-8586-4c10-d4f4-643ff5f0cf62@inwind.it>
 <CA+pv=HOSysost0YYeq4pw9VKjhtQDH6MvERrYpWyisme19b7dA@mail.gmail.com>
 <5fa13893-c26f-110a-d3db-220fcedd0c87@inwind.it>
In-Reply-To: <5fa13893-c26f-110a-d3db-220fcedd0c87@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230310-0, 10/3/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfHEgrg6hel6F5cT+X6ykmw/4d8mKAQJFWBLxx6DG5fUfrPqNQ51BzyboZqxzv+awTHg85npQWq9waoJDdopfBNBKrc0Z7taDzmU3LBKvhlp+GSEdRISS
 zW0V+K3/Jzcdp3PI2b0GNRRO0l0vBV7zKI6C8aJQxpCu0xVjbSJjjdGa+mUwcm44uNf3NOWUnHETjcWYcDWkNdOVJnZ7RoyyrUuudcJYoA/5jqqRz8/A4mdg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/02/2023 13:28, Valerio Vanni ha scritto:
> Il 24/02/2023 19:06, Slade Watkins ha scritto:
> 
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217083
>>>
>>> I got this error after upgrading a Debian machine (x86-64) from Stretch
>>> to Buster. Upgrade is successful, but the next boot it crashes.
>>
>> Thanks for the details. What was the last known good kernel version
>> that did not exhibit this issue on your system?
> 
> There isn't a last known good version. As I said, the issue appeared 
> after an OS upgrade, not after a kernel one.
I updated bugzilla and I update also here.

I use serial console to collect diagnostic data, but now I've found that 
it misses lines.
In kernel boot line I put "console=ttyS0 console=tty0" so I get both 
local and serial console.

But the issue is: tty0 shows more messages. Is there a way to get 
everything also on ttyS0? It would be useful, since you cant' scroll 
tty0 after a kernel panic.

When kernel loads, tty0 scrolls very fast. I could see some more line 
but wasn't able to read them.
The only way I found was adding a (slow) speed to ttyS0, 
"console=ttyS0,1200" on kernel boot line.
This slowed down ttyS0, and tty0 was forced to go at the same pace.

So I could read a line (only on tty0), between "Run /sbin/init as init 
process" and start of kernel panic.
That line complained that it could not find something in /usr/lib/.... 
At that stage, /usr was not mounted yet.

Then I restored full disk image on the machine, an before upgrading from 
stretch to buster I merged / and /usr, so that /usr/lib/... was 
available from / mount.

After that, kernel panic did not show anymore.

