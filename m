Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4015F6632
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiJFMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJFMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:38:23 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E41A87F82
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:38:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 28E6260509;
        Thu,  6 Oct 2022 14:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665059896; bh=tPjGqiWHTzLMgZj8/hHtCt7d2xe0tk94ui0gCVsCqCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eVGlZfpqEeVGoXXcJHWgdUUwG4PBZnn+WF3cJ8Tfd5QoI+0ZjPVVHfowFK2SjsSWO
         j4E80WjOO4wnlE24wcY66ZU/hz/3QLnj5AEbVhbaic0qcwpCTPsS+Td2DpeW5ovwpx
         005UbkXFRC325pRjlhbnUKJ86c47aXN0ScJJ4VCmHLPBaByetchScln2KlJ729OAn+
         tXIrXwIlggBS/3lj7hrcpPX23QG2jmchzedZ6un7gk6MF9rCLPnUZ1EW//Dq9WOhs2
         7itJjdwlUMqit4MSKVu5LyBL68CME0GaEv77qyf2P6Fkoogixju/7D8R/Qc0fR6yjh
         NG7dKDzr3D/fg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1-MFvXDdeLYU; Thu,  6 Oct 2022 14:38:12 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id C0EED604F9;
        Thu,  6 Oct 2022 14:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665059892; bh=tPjGqiWHTzLMgZj8/hHtCt7d2xe0tk94ui0gCVsCqCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XuBVo9sjNKWlt6R51ILI4DQWdSma6uA9Qxic9XDOPix9eMhzF7PyC6zcSIv1r+KWL
         nTYiHxhAcRqfixuJ9Fbvm9GMDjeH7t/CwHZ332O6zoSCLQyNkAfY+uGPGepezfvCwz
         seKCg6ZHmq7w7dA2QX4Ub0WVGTMPIPRUnZ5tawYL/MCRt6PNY3Qf2hPLxzcqzL0UT4
         sXLdIJeMCEz2ritnx7tG4WoRSkU/nYHV7vPuu4aMJWAx4tDKHYpzdg1H0HWYqFvgzA
         NEVUP1EqGmyV/JeGClnjX+jdGv7eVj03QwpqIPGC7Ll9EDViyAQIU43pru44gmFaHf
         vBDUBoGu38jww==
Message-ID: <c3a8771e-3d8f-e923-7627-e2937488c783@alu.unizg.hr>
Date:   Thu, 6 Oct 2022 14:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/22 14:00, Thorsten Leemhuis wrote:

On 27.09.22 19:57, Mirsad Goran Todorovac wrote:
>> This is my first kernel BUG report,
> Many thx for your report!
Not at all! I am glad I could contribute to the Cause :)
>> so please bear with me for a while
>> if I'm doing something wrong or otherwise awkward.
>> I've noticed it in the 6.0.0-rc3 kernel
>> So rc2 was working fine for you?
No, I only started building and testing kernels at 6.0.0-r3
>> and following patches to see if it will be fixed by other testers.
>>
>> I've read the bug report instructions, so I hope this will be useful.
> These?
> https://docs.kernel.org/admin-guide/reporting-issues.html
>
> Just wondering, as then I maybe should make it clearer that sending a
> report to just the mainling list is a bad idea, as nearly nobody will
> see this.
I see, but my knowledge of the kernel source is insufficient to pinpoint the
source of the problem. It happens only in snaps, so it might have something
to do with conteinerisation, however, plain `snap refresh firefox` did not
work in their official mainline 6.0.0-060000 build, so I had to reboot 
into a
stable kernel and then the same commands worked.

Hopefully, I might find a maintainer for this code if I succeed to pinpoint
the origin, but as I said this is way too much for me ATM.

>> However, now we are at rc7, so keeping it for myself when the kernel is
>> near production state might be an offence to good conscience.
>> In particular, it is the problem with Firefox 104.x and 105.x, which has
>> tabs crashing, and later it refuses to restart.
>>
>> Exactly the same config works with the other Linux kernels tried (5.15.x
>> and 5.19.x) on the Ubuntu 22.04 system.
>>
>> Firefox is a snap. The bug persisted with apparmor ON and OFF.
>> The kernel is compiled with KMEMLEAK and KASAN options, but otherwise it
>> is the default config file for Ubuntu's rc3 release candidate.
> Hmm. I have no idea at all what kernel change might cause this and hence
> don't know whom to ask to look into this. What really would help
> tremendously: if someone could bisect the problem with a vanilla kernel.
>
> Here is a rough guide (hopefully I sooner or later find time to write
> one that is more user-friedly):
> https://docs.kernel.org/admin-guide/bug-bisect.html
>
>> Here is the syslog of the startup.
>>
>> Please find dmesg output. It is rather similar to the dmesg output of
>> production kernels.
>>
>> /var/log/syslog:
>>
>> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]: message
>> repeated 11 times: [ /snap/firefox/1883/usr/lib/firefox/firefox:
>> /snap/firefox/1883/usr/lib/firefox/firefox: no version information
>> available (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)]
>> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
>> /snap/firefox/1883/usr/lib/firefox/firefox:
>> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
>> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
>> /snap/firefox/1883/usr/lib/firefox/firefox:
>> /lib/x86_64-linux-gnu/librt.so.1: version `' not found (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
>> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
>> /snap/firefox/1883/usr/lib/firefox/firefox:
>> /lib/x86_64-linux-gnu/libdl.so.2: version `' not found (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
>> Sep 27 18:43:27 IdeaPad-3 firefox_firefox.desktop[2686]: Missing chrome
>> or resource URL: resource://gre/modules/UpdateListener.sys.mjs
>> Sep 27 18:43:31 IdeaPad-3 firefox_firefox.desktop[2921]:
>> /snap/firefox/1883/usr/lib/firefox/firefox: symbol lookup error:
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so: undefined symbol: ,
>> version
>> Sep 27 18:43:33 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.8b8574d2-116e-411a-9bba-c145e8cc0aa2.scope:
>> Consumed 10min 18.279s CPU time.
>> Sep 27 18:44:49 IdeaPad-3 snapd[818]: storehelpers.go:748: cannot
>> refresh: snap has no updates available: "bare", "canonical-livepatch",
>> "core", "core18", "core20", "firefox", "gnome-3-34-1804",
>> "gnome-3-38-2004", "gtk-common-themes", "slack", "snap-store", "snapd",
>> "zoom-client"
>> Sep 27 19:04:59 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope.
>> Sep 27 19:05:04 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope:
>> Consumed 4.239s CPU time.
>> Sep 27 19:05:41 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope.
>> Sep 27 19:05:42 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope:
>> Consumed 1.256s CPU time.
>> Sep 27 19:06:39 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope.
>> Sep 27 19:06:41 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope:
>> Consumed 1.231s CPU time.
>> Sep 27 19:06:55 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.c42cb676-a7a7-49e6-8685-610bd9c1de81.scope.
>>
>> $ sudo dmesg -l err
>> [    1.638759] ACPI BIOS Error (bug): Could not resolve symbol
>> [\_SB.PCI0], AE_NOT_FOUND (20220331/dswload2-162)
>> [    1.638854] ACPI Error: AE_NOT_FOUND, During name lookup/catalog
>> (20220331/psobject-220)
>> [    2.175611] ACPI BIOS Error (bug): Could not resolve symbol
>> [\_SB.PC00.DGPV], AE_NOT_FOUND (20220331/psargs-330)
>> [    2.175731] ACPI Error: Aborting method \_SB.PC00.PEG0.PCRP._ON due
>> to previous error (AE_NOT_FOUND) (20220331/psparse-529)
>> [    5.519037] integrity: Problem loading X.509 certificate -65
>> [   10.010679] mtd device must be supplied (device name is empty)
>> [   12.220863] i801_smbus 0000:00:1f.4: Transaction timeout
>> [   12.222934] i801_smbus 0000:00:1f.4: Failed terminating the transaction
>> [   12.223023] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
>> [   13.092867] rcu: INFO: rcu_preempt detected expedited stalls on
>> CPUs/tasks: { 3-.... } 6 jiffies s: 61 root: 0x8/.
>> [   13.092878] rcu: blocking rcu_node structures (internal RCU debug):
>> [   13.991053] mtd device must be supplied (device name is empty)
>> [   15.315968] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
>> [   18.018388] ACPI BIOS Error (bug): Could not resolve symbol
>> [\_TZ.ETMD], AE_NOT_FOUND (20220331/psargs-330)
>> [   18.018857] ACPI Error: Aborting method \_SB.IETM._OSC due to
>> previous error (AE_NOT_FOUND) (20220331/psparse-529)
>>
>> Please find attached the config file for the kernel build. Source is rc7
>> "master" clean after rc7 rlse.
>>
>> Here is the demonstration of bug with apparmor ON and OFF:
>>
>> $ sudo systemctl stop apparmor
>> $ firefox &
>> [1] 7825
>> $ date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: symbol lookup error: date: undefined symbol: , version GLIBC_2.2.5
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: symbol lookup error: chmod: undefined symbol: , version
>> xdg-user-dirs-update: error while loading shared libraries:
>> xdg-user-dirs-update: unsupported version 0 of Verneed record
>> rm: rm: no version information available (required by rm)
>> rm: rm: no version information available (required by rm)
>> rm: rm: no version information available (required by rm)
>> rm: rm: no version information available (required by rm)
>> rm: rm: no version information available (required by rm)
>> rm: symbol lookup error: rm: undefined symbol: , version GLIBC_2.2.5
>> XPCOMGlueLoad error for file
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so:
>> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
>> Couldn't load XPCOM.
>>
>> [1]+  Exit 255                firefox
>> $
>> $ sudo systemctl start apparmor
>> $ firefox &
>> [1] 7996
>> $ date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: date: no version information available (required by date)
>> date: symbol lookup error: date: undefined symbol: , version GLIBC_2.2.5
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: chmod: no version information available (required by chmod)
>> chmod: symbol lookup error: chmod: undefined symbol: , version
>> xdg-user-dirs-update: error while loading shared libraries:
>> xdg-user-dirs-update: unsupported version 0 of Verneed record
>> XPCOMGlueLoad error for file
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so:
>> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
>> Couldn't load XPCOM.
>>
>> All other apps work OK AFAICS, however I suspected a kernel bug since it
>> only shows only in RC kernels
>> (even the Ubuntu's own 6.0.0-rc3 mainline build).
>>
>> Hope this helps someone. I could provide more info at request.
>>
>> Kind regards,
>>
>> Mirsad
>>
>> [config file removed when quoting]
> Anyway, to be sure below issue doesn't fall through the cracks
> unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> bot:
>
> #regzbot ^introduced v5.19..v6.0-rc3
> #regzbot title Firefox snap fails to run ("undefined symbol" and
> "unsupported version 0 of Verneed record" error messages)
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://linux-regtracking.leemhuis.info/tracked-regression/
Right now I am testing the 6.0.0-060000 Ubuntu mainline official
build. But as I said above, it is not without the issues ("core dump"
during the `snap refresh firefox` that goes away when tried with
5.x lines of kernels.)

I can verify that 5.19.x line of kernels worked OK with the same
Ubuntu 22.04 jammy installation (no crashed tabs and missing Verdeen
records).

Regards,
mt

> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report (the mail this one replies to), as explained for
> in the Linux kernel's documentation; above webpage explains why this is
> important for tracked regressions.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.

-- 
Mirsad Goran Todorovac
CARNet sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
CARNet system engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

