Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F96CD86B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjC2L0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjC2L0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:26:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A972A211C;
        Wed, 29 Mar 2023 04:25:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1phTwC-0005Ou-SA; Wed, 29 Mar 2023 13:25:56 +0200
Message-ID: <dc8e5276-ef88-648f-9f0d-10151ea62c90@leemhuis.info>
Date:   Wed, 29 Mar 2023 13:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217252 - warning: v4l_enum_fmt+0x125a/0x1c20 -
 Unknown pixelformat 0x00000000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680089158;40ffb739;
X-HE-SMSGID: 1phTwC-0005Ou-SA
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them to mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217252 :

>  sander44 2023-03-27 12:50:47 UTC
> 
> Hi Kernel Team,
> 
> I try today to rebuild kernel 6.1.21, but i notice error with: v4l2-core.
> 
> [    3.722510] loop17: detected capacity change from 0 to 8
> [    3.920014] ------------[ cut here ]------------
> [    3.920016] Unknown pixelformat 0x00000000
> [    3.920024] WARNING: CPU: 2 PID: 1558 at drivers/media/v4l2-core/v4l2-ioctl.c:1503 v4l_enum_fmt+0x125a/0x1c20
> [    3.920030] Modules linked in: [...]
> [    3.920097] CPU: 2 PID: 1558 Comm: pipewire Tainted: G     U             6.1.21-1-lowlatency #2
> [    3.920099] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0073.2022.0302.1157 03/02/2022
> [    3.920100] RIP: 0010:v4l_enum_fmt+0x125a/0x1c20
> [    3.920102] Code: 48 c7 c3 53 29 ca 83 81 fe 64 76 73 64 0f 84 d7 ef ff ff 41 80 7d 0c 00 0f 85 9e ee ff ff 48 c7 c7 5a 37 ca 83 e8 36 9c 48 ff <0f> 0b 48 c7 c2 76 37 ca 83 49 8d 4d 2c 49 8d 7d 0c be 20 00 00 00
> [    3.920103] RSP: 0018:ffffa60086907bd8 EFLAGS: 00010246
> [    3.920104] RAX: 0000000000000000 RBX: ffffffff83ca33fb RCX: 0000000000000000
> [    3.920105] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    3.920106] RBP: ffffa60086907c08 R08: 0000000000000000 R09: 0000000000000000
> [    3.920106] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    3.920107] R13: ffffa60086907d00 R14: 0000000000000000 R15: ffff98efc87d0018
> [    3.920107] FS:  00007f7f99022740(0000) GS:ffff98f347680000(0000) knlGS:0000000000000000
> [    3.920108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.920109] CR2: 00007ffc3f1c3ff8 CR3: 0000000121ab8006 CR4: 0000000000770ee0
> [    3.920110] PKRU: 55555554
> [    3.920110] Call Trace:
> [    3.920111]  <TASK>
> [    3.920114]  __video_do_ioctl+0x1e7/0x590
> [    3.920116]  ? __video_do_ioctl+0x1e7/0x590
> [    3.920118]  video_usercopy+0x25d/0x820
> [    3.920119]  ? v4l_print_control+0x30/0x30
> [    3.920121]  video_ioctl2+0x15/0x30
> [    3.920122]  v4l2_ioctl+0x69/0xb0
> [    3.920124]  __x64_sys_ioctl+0x9f/0xe0
> [    3.920126]  do_syscall_64+0x58/0x90
> [    3.920128]  ? video_ioctl2+0x15/0x30
> [    3.920129]  ? v4l2_ioctl+0x69/0xb0
> [    3.920131]  ? exit_to_user_mode_prepare+0x39/0x190
> [    3.920133]  ? syscall_exit_to_user_mode+0x29/0x50
> [    3.920135]  ? do_syscall_64+0x67/0x90
> [    3.920136]  ? syscall_exit_to_user_mode+0x29/0x50
> [    3.920137]  ? do_syscall_64+0x67/0x90
> [    3.920138]  ? do_syscall_64+0x67/0x90
> [    3.920139]  ? do_syscall_64+0x67/0x90
> [    3.920140]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    3.920142] RIP: 0033:0x7f7f98d1aaff
> [    3.920143] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> [    3.920144] RSP: 002b:00007ffe6fcb2810 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [    3.920145] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 00007f7f98d1aaff
> [    3.920146] RDX: 000055f9945f309c RSI: ffffffffc0405602 RDI: 0000000000000023
> [    3.920147] RBP: 000055f9945f309c R08: 0000000000000000 R09: 0000000000000001
> [    3.920147] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000ffffffff
> [    3.920148] R13: 0000000000000000 R14: 000000004000015c R15: 000055f9945f2ec8
> [    3.920149]  </TASK>
> [    3.920150] ---[ end trace 0000000000000000 ]---
>
> [...]

See the ticket for more details.

Note, to my untrained eyes this looked like something that is caused by
the driver, which afaics is uvcvideo. Hope that wasn't a mistake.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.15..v6.1.21
https://bugzilla.kernel.org/show_bug.cgi?id=217252
#regzbot title: media: Unknown pixelformat 0x00000000
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
