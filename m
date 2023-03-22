Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C896C41B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVEwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVEwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:52:44 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 21:52:42 PDT
Received: from vimdzmsp-sfwd04.bluewin.ch (vimdzmsp-sfwd04.bluewin.ch [195.186.227.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1025E0D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:52:42 -0700 (PDT)
Received: from [192.168.2.206] ([178.193.94.8])
        by vimdzmsp-sfwd04.bluewin.ch Swisscom AG with ESMTPA
        id eqQop8vosSGmMeqQopHnhz; Wed, 22 Mar 2023 05:50:38 +0100
X-Bluewin-Spam-Analysis: v=2.4 cv=AqmNYMxP c=1 sm=1 tr=0 ts=641a891e
 a=HspnF00aK8asgizx1TveVQ==:117 a=HspnF00aK8asgizx1TveVQ==:17
 a=IkcTkHD0fZMA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=ErgUOLliWilC1Brv_bMA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-Bluewin-Spam-Score: 0.00
X-FXIT-IP: IPv4[178.193.94.8] Epoch[1679460638]
X-Bluewin-AuthAs: traian.teodorescu@bluewin.ch
Message-ID: <fbf48030-c702-8964-7614-365bbcb4faee@bluewin.ch>
Date:   Wed, 22 Mar 2023 05:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Traian Teodorescu <traian.teodorescu@bluewin.ch>
Subject: Fwd: Linux entropy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNiPGdTdYqkq9qQsOs9+1AR0aBUsFUy/nUu/weNgi1/lD/M618XUSzZ/ztfsO+5SRPCr53zqK1xj0ezG68FzIgUoTbOTnIplLGTBuI4UXJ23JNvrLwUz
 4pEiv6s/WZ+IhJZ0KxEDarq6dNDHAcN03wDC2GHlLLeZ2LI9+APxcQ49jixfK5A3mKRvYSgCVPF+tbAcMz+3ESTA5vBR2zeVLOo=
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

