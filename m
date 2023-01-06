Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067C65FE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjAFJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAFJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:49:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4343E4E;
        Fri,  6 Jan 2023 01:49:51 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDjMD-0006dY-Az; Fri, 06 Jan 2023 10:49:49 +0100
Message-ID: <a1081b61-c066-153d-2ec3-1f86ce68c0e6@leemhuis.info>
Date:   Fri, 6 Jan 2023 10:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Steve French <sfrench@samba.org>
Cc:     Kim Scarborough <kim@scarborough.kim>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: =?UTF-8?Q?=5bRegression=5d_Bug=c2=a0216881_-_CIFS_1=2e0_mounts_fail?=
 =?UTF-8?Q?_with_=22VFS=3a_bogus_file_nlink_value_0=22?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672998591;3d316d92;
X-HE-SMSGID: 1pDjMD-0006dY-Az
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216881 :

>  Kim Scarborough 2023-01-04 07:00:50 UTC
> 
> An SMB mount to a Windows XP machine in my fstab no longer works. It last worked with 6.0.9. fstab line:
> 
> //server/D /remote/server/D cifs noauto,_netdev,username=example,password=example,uid=1000,vers=1.0,nomultichannel 0 0
> 
> When I attempt to mount this now, I get the following error:
> 
> mount error(20): Not a directory
> 
> dmesg shows:
> 
> CIFS: VFS: bogus file nlink value 0

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=216881
#regzbot title: cifs: cifs 1.0 mounts fail with "VFS: bogus file nlink
value 0"
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
