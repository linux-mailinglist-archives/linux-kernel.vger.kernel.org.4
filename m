Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF86C91A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 00:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCYXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCYXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 19:03:25 -0400
Received: from vimdzmsp-sfwd02.bluewin.ch (vimdzmsp-sfwd02.bluewin.ch [195.186.227.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D912B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 16:03:22 -0700 (PDT)
Received: from [192.168.2.206] ([178.193.94.8])
        by vimdzmsp-sfwd02.bluewin.ch Swisscom AG with ESMTPA
        id gCuupaT68vP1igCuupXcin; Sun, 26 Mar 2023 00:03:20 +0100
X-Bluewin-Spam-Analysis: v=2.4 cv=COZJ4TnD c=1 sm=1 tr=0 ts=641f7db8
 a=HspnF00aK8asgizx1TveVQ==:117 a=HspnF00aK8asgizx1TveVQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=9d9qFc9g903rTTIGX3cA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Bluewin-Spam-Score: 0.00
X-FXIT-IP: IPv4[178.193.94.8] Epoch[1679785400]
X-Bluewin-AuthAs: traian.teodorescu@bluewin.ch
Message-ID: <3dc7e744-dcfd-8da3-ed73-8f222d68031c@bluewin.ch>
Date:   Sun, 26 Mar 2023 00:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Fwd: Fwd: Linux entropy
Content-Language: en-US
References: <fbf48030-c702-8964-7614-365bbcb4faee@bluewin.ch>
To:     linux-kernel@vger.kernel.org
From:   Traian Teodorescu <traian.teodorescu@bluewin.ch>
In-Reply-To: <fbf48030-c702-8964-7614-365bbcb4faee@bluewin.ch>
X-Forwarded-Message-Id: <fbf48030-c702-8964-7614-365bbcb4faee@bluewin.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHMe9spi3Yil0WdPLBjNivYFeUWs7oSIQje5dby3Cu9PE7Oa/2hOJ2gnbAQIu6ZiBhuF/G6hNF1BaCVulVob3hz7D/tEDN1lFy4XUtB7E3JUx94an55M
 si7TsLE3t9of/VshQPva6rLICV993Ie/hg1vZdAVe2D3UtX3NQSeBGJQv4k/9Sg3kroluljbF/ix6A8PSF9hPe1JUsm33NnZ74A=
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, can you please answer to my question below ? It's about the 
"/proc/sys/kernel/random/entropy_avail" variable which doesn't show 
anymore a credible value.
Thank you,
Traian

-------- Forwarded Message --------
Subject: 	Fwd: Linux entropy
Date: 	Wed, 22 Mar 2023 05:51:10 +0100
From: 	Traian Teodorescu <traian.teodorescu@bluewin.ch>
To: 	linux-kernel@vger.kernel.org



Hello,

I've been redirected by  the "friendly bot" to you (I've already looked 
into "kernelnewbies" but I didn't find a linked topic). I would want to 
know more about the subject below. Is there another possibility to read 
the value of current entropy in new versions of kernel ? Are the old 
services (as for instance haveged) still compatible ?

Thank you and have a nice evening,

Traian


-------- Forwarded Message --------
Subject:     Linux entropy
Date:     Tue, 21 Mar 2023 17:03:36 +0100
From:     Traian Teodorescu <traian.teodorescu@bluewin.ch>
To:     gregkh@linuxfoundation.org


Mr Kroah-Hartmann,

I've recently discovered that the value containing the machine's entropy 
(in /proc/sys/kernel/random/entropy_avail ) isn't updated anymore on one 
of my machines. I found some articles on the Internet about this change, 
but nothing very "official".

There is also an explanation at 
"https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.15.y&id=e7e196e1ae2603a2c5f1894f1868a7a5b5a2c5e0" 
about keeping forward secrecy, etc, that I didn't really understood.

I began using Linux since less than 10 years and I am not what you can 
call an experienced user, but from my point of view this change doesn't 
make sense. If I understand well some basic principles, Linux kernel is 
the only one meant to be accessible to everybody wanting to understand 
deeply how a modern OS works, so what's the gain in this "obfuscation" 
?  From my point of view, a sysadmin should know how much entropy they 
have on their machines.

So, please, can you please make some comments about this change ? (of 
eventually send me a link to an article that I can trust ?)

I really enjoyed Linux a lot those years and I learned to appreciate it, 
so from this point of view I am grateful to the teams maintaining free 
software, so ... thank you !

Thanks for an eventual answer and have a nice evening,

Traian

