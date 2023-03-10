Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B916B33A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCJB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:27:12 -0500
Received: from libero.it (smtp-18-i2.italiaonline.it [213.209.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FBF8E4F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:27:03 -0800 (PST)
Received: from [192.168.1.176] ([79.35.132.58])
        by smtp-18.iol.local with ESMTPA
        id aRX8p4eSgeyjYaRX8pRAk1; Fri, 10 Mar 2023 02:26:58 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1678411619; bh=ZuzIvlz//C84U0pHEkGjDv6UyfVkL9ghx5tsjxOqnEc=;
        h=From;
        b=OHDaNsrQr5LtEWWtzxcmTTjO3L3rvIrh3/VI6H4ARewOoS/R05kxIr4McRpJi6y1u
         xtdJ+59mYwJDoP9tC7pz9oDr4m5vUCtW3YE+ciYx/jkjmGLlaM1n6puJd8jRrr7Pur
         dw8wKbnmM9M8X7u5953V/NENgaE/nrF4RTUWSdg7f2NxzkGQb62IMov3fXU4+1cvDv
         1xTT4LK/jEzdVwMvq5R9zNiCpxMzUNorjCazVvjr0ve46o41myouiSrT1ATneW8N5Z
         ZF2DQSdKyqxLRhQeeGiZulmJP2GVrj8Nb4KDNKcy/xm62AMrz0om3d7Els/vYVpKJe
         bvMoBeeRv5cBg==
X-CNFS-Analysis: v=2.4 cv=bIjQYtyZ c=1 sm=1 tr=0 ts=640a8762 cx=a_exe
 a=HrXNelnF3IDyoBa3MXWlnA==:117 a=HrXNelnF3IDyoBa3MXWlnA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=Clg0mrsENQxtxUuzJtMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <6b65e5dd-a940-a176-fa86-5c2babac805c@inwind.it>
Date:   Fri, 10 Mar 2023 02:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Bugzilla 217083
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     linux-kernel@vger.kernel.org
References: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
 <Y/j1qPOZm90d7Oi1@1wt.eu> <e49d167f-f418-f2a5-ffb0-6c7f7ea5b74f@inwind.it>
 <CA+pv=HNUMqtFGEdcsgxEq6+UpqVj95o89rc4D7zSJyGnvHLHNw@mail.gmail.com>
From:   Valerio Vanni <valerio.vanni@inwind.it>
In-Reply-To: <CA+pv=HNUMqtFGEdcsgxEq6+UpqVj95o89rc4D7zSJyGnvHLHNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230309-10, 9/3/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfDttWKEs0mhyWZVL9ht2GJ8E6p9bsOROPOmwtgU/ueTlqKf9O8Y97GcGyBfzR7nmurm+NgqyV2zwksQKhSYlcTUryGnTw60tBG6zOVXJinjb2IwUXiys
 KwcSUX61CM4wBwPgO8odwosEnO5E0WK8AVfTbo0a7ydNRI2XOpcODsIbFcEYLDnXGeNF90jrAXUOjmNHlZefDRJ3FxXQOrC1HvM1o6F+R1cUAxId6dgn4CS1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/02/2023 19:06, Slade Watkins ha scritto:
 >> https://bugzilla.kernel.org/show_bug.cgi?id=217083
 >>
 >> I got this error after upgrading a Debian machine (x86-64) from Stretch
 >> to Buster. Upgrade is successful, but the next boot it crashes.
 >
 > Thanks for the details. What was the last known good kernel version
 > that did not exhibit this issue on your system?

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

