Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9F6FA274
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjEHIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjEHIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:39:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE518DC8;
        Mon,  8 May 2023 01:39:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pvwP6-0007CA-K0; Mon, 08 May 2023 10:39:32 +0200
Message-ID: <9d1022a5-847b-13f0-84d3-5b7d81355d59@leemhuis.info>
Date:   Mon, 8 May 2023 10:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: PROBLEM: ThinkPad T430 (BCM20702) Can't Detect Bluetooth Devices
 Starting from Kernel v6.1.0 Until Now v6.3.1
Content-Language: en-US, de-DE
To:     Moh Oktavi Aziz Nugraha <moktavizzen@gmail.com>,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        avisaziz123@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAHCNbp3ztCcp31JdVYuxy+s1qXaa+Zy74eGJmfPmyrx_6Wjhhw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAHCNbp3ztCcp31JdVYuxy+s1qXaa+Zy74eGJmfPmyrx_6Wjhhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683535174;acdecd99;
X-HE-SMSGID: 1pvwP6-0007CA-K0
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 06.05.23 13:33, Moh Oktavi Aziz Nugraha wrote:
> [1.] One line summary of the problem:
> ThinkPad T430 (BCM20702) Can't Detect Bluetooth Devices Starting from
> Kernel v6.1.0 Until Now v6.3.1
> 
> [2.] Full description of the problem/report:
> Last week I installed Ubuntu, but my bluetooth can't detect devices
> when I use kernel 6.1 and above. My bluetooth was fine when I used
> kernel 6.0 and before. I'm filing this bug on the kernel because when
> I tested this bug on Fedora and Ubuntu, the same problem appeared when
> I used kernel version 6.1 and above.
> The workaround for version 6.1 and above is to run "hcitool scan" on
> the terminal if I want to detect bluetooth devices.
> There are similar problem in earlier kernel version, but it was fixed
> according to this post https://askubuntu.com/a/1169415
> Here is the video i made to reproduce the issue https://youtu.be/pHjOIAk90Zc
> Here is the information about my Bluetooth card:
> Bus 001 Device 007: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0
> [ThinkPad]
> What I have tried:
> - Installed Fedora 38 and then Install bluetooth firmware
> https://github.com/winterheart/broadcom-bt-firmware, and then
> downgrade bluez (bluetooth cant detect devices)
> - Installed Fedora 37 (no problem, because the default kernel is 6.0)
> - installed Ubuntu 23.04 and then  install bluetooth firmware
> https://github.com/winterheart/broadcom-bt-firmware (bluetooth cant
> detect devices)
> - Installed Ubuntu 22.10 (no problem, because the default kernel is 5.19)
> - Installed Ubuntu 22.04 (no problem, because the default kernel is 5.19)
> - Go back to Ubuntu 23.04 and then try these kernel:
> v5.15.110 (good)
> v5.19.17 (good)
> v6.0.12 (good)
> v6.0.19 (good)
> v6.1.27 (bad)
> v6.2.14 (bad)
> v6.3.1 (bad)
> After trying all of that I came to conclusion that this bug is caused
> by the kernel.
> I want to try git bisect to find the commit that caused the regression
> between kernel versions 6.0 and 6.1, but it might take me a while
> since it’s my first time using it. Plus, I’ve got a bunch of college
> assignments to finish up this week, so I’m a bit strapped for time.

FWIW, the following guide recently added might help you (a similar
document to also cover bisection is planned, but I haven't started on it
yet...):
https://docs.kernel.org/admin-guide/quickly-build-trimmed-linux.html

> [3.] Keywords (i.e., modules, networking, kernel):
> bluetooth, networking, broadcom, bcm20702, thinkpad, t430
>
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
> Linux version 6.3.1-060301-generic (kernel@kathleen)
>
> (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-17ubuntu1) 12.2.0, GNU ld (GNU
> Binutils for Ubuntu) 2.40) #202304302031 SMP PREEMPT_DYNAMIC Mon May
> 1 00:41:22 UTC 2023
> [4.2.] Kernel .config file:
> <attachment1-KernelConfig.txt>
> 
> [5.] Most recent kernel version which did not have the bug:
> 6.0.19
> 
> [6.] Output of Oops.. message (if applicable) with symbolic
> information resolved (see Documentation/admin-guide/bug-hunting.rst)
> I can't find the Oops message when i use "journalctl | grep Oops"
> 
> [7.] A small shell script or example program which triggers the
> problem (if possible)
> I cant write a shell script yet, but i have made a video to show the
> trigger and how to reproduce the issue https://youtu.be/pHjOIAk90Zc
> 
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here)
> <attachment2-Software.txt>
> [8.2.] Processor information (from /proc/cpuinfo):
> <attachment3-Processor.txt>
> [8.3.] Module information (from /proc/modules):
> <attachment4-Module.txt>
> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> <attachment5-DriverHW.txt>
> [8.5.] PCI information ('lspci -vvv' as root)
> <attachment6-PCI.txt>
> [8.6.] SCSI information (from /proc/scsi/scsi)
> <attachment7-SCSI.txt>
> [8.7.] Other information that might be relevant to the problem (please
> look in /proc and include all information that you think to be
> relevant):
> <attachment9-lsusb.txt>
> 
> [X.] Other notes, patches, fixes, workarounds:
> The workaround for version 6.1 and above is to run "hcitool scan" on
> the terminal if I want to detect bluetooth devices.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.0..v6.1
#regzbot title bluetooth: ThinkPad T430 (BCM20702) does not  Detect
Bluetooth Devices anymore
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
