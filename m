Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E165FDAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJMNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJMNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:25:08 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D871D653
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:24:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3202B604F1;
        Thu, 13 Oct 2022 15:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665667486; bh=XEvz/pLV01ozVBm8PWMzOJINKA0gL4zzTA4t3Xlro6k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DYcySbmRmNYfjOOMv6Nm5VTKVHYKkI1d+DIB4beIAhgHiaX1F26B9WJuz33JEJ/lX
         RXjtH+HXyM1TsrFEpSbQLhzVpjjX2PFRprmp2IMk5cYcARp7SdoDln5KYSbCyjgNe8
         2q8loQsIYik4XHv0VzBtWc5xbFSPOzOeJLZ2qH9+mcmutFPPO4iCyJHw1kXScVumQJ
         D9IieC8JS4/LzDN9+gjCtnmLh1qYmUZ/6/rCMKWWmusyItM0ivnGGOuIQDg3pqgbdr
         bTn2sjTqdjarnQSJdIPN61mXuGmJ5xWFiKorwggTLh7UCW2nzHMAD4dY9FdCB7foAb
         cSiZn/WjeHsFw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lro28jfh7bXU; Thu, 13 Oct 2022 15:24:43 +0200 (CEST)
Received: from [161.53.83.51] (pc-mtodorov.grf.hr [161.53.83.51])
        by domac.alu.hr (Postfix) with ESMTPSA id A18AC604EC;
        Thu, 13 Oct 2022 15:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665667483; bh=XEvz/pLV01ozVBm8PWMzOJINKA0gL4zzTA4t3Xlro6k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U5nxucyQQRbrGIr3C1ccFiNh4DIv6YhMpM8ppswVB7YPrpZdD8fR3h/RBFw2GHVVs
         lIaH1oOssGnsOzOIgqmDpLqKYtJxZlKcXmRUa6Y5d5DK4/nteHgIPhmg6NIGuFth2P
         geCbbu0/uIkjsLrtyls1DIkcALT/d2Ap6ogBrTlFYzjCK8S1LRAsryp4TRlyDW2/LJ
         PwXjOOoydgB8z+r3JfUtd4pG0e9Ka+4HHcmOsLgNsSS+31S4HpPtoxjbi5B5tH34UN
         jZVZ0yoYLpmCy2ac4SwF0hOMR08hxaiWdiUdYqXdQvMyQZmAOuhJCO+9iclbuXWMAP
         mQ0PMg8y0bajg==
Message-ID: <29362d2e-eec6-5a23-4354-cf8868d50b2c@alu.unizg.hr>
Date:   Thu, 13 Oct 2022 15:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <Y0Zw2eHEb1aZ9f4y@debian.me>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y0Zw2eHEb1aZ9f4y@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

Than you for the instruction for how to shorten the bisection time. My 
fastest build was almost 2 hours.

This bug did appear with the mainline Ubuntu's and ElRepo's 6.0.0 
kernels, however not with the
/usr/bin/firefox build, but only that using snapd, squashfs and 
/snap/bin/firefox ...

The Firefox 91.x esr was unaffected, indeed, in a couple of days of 
testing its work (on AL).

However, please not that this bug is no deterministic, and that it can 
take from a couple of hours
to an overnight work to manifest.

The "make localmodconfig" feature will probably help reducing the build 
time, but I am also doing
my day job stuff which by the Murphy's law surged right now ...

You second request, to reproduce with Firefox from the dev site, is as 
you will understand impossible
to meet: the bug occurred only with Firefox 104.x and 105.0.1, 105.0.2, 
105.0.3 in Ubuntu snap
release (and the snap release guest installed at AlmaLinux, the CentOS 
fork).

I was able to confirm that AppArmor doesn't affect behaviour once the 
Firefox misbehaves.
After starting to crash tabs and refusing to connect to the Internet 
from inside Yahoo mail (Chrome
simultaneously connected), then it complained about libmozsandbox.so 
version and Verneed record.

-Mirsad

On 12.10.2022. 9:46, Bagas Sanjaya wrote:
> On Tue, Sep 27, 2022 at 07:57:59PM +0200, Mirsad Goran Todorovac wrote:
>> Hello all,
>>
>> This is my first kernel BUG report, so please bear with me for a while if
>> I'm doing something wrong or otherwise awkward.
>> I've noticed it in the 6.0.0-rc3 kernel and following patches to see if it
>> will be fixed by other testers.
>>
>> I've read the bug report instructions, so I hope this will be useful.
>>
>> However, now we are at rc7, so keeping it for myself when the kernel is near
>> production state might be an offence to good conscience.
>>
>> In particular, it is the problem with Firefox 104.x and 105.x, which has
>> tabs crashing, and later it refuses to restart.
>>
>> Exactly the same config works with the other Linux kernels tried (5.15.x and
>> 5.19.x) on the Ubuntu 22.04 system.
>>
>> Firefox is a snap. The bug persisted with apparmor ON and OFF.
>>
>> The kernel is compiled with KMEMLEAK and KASAN options, but otherwise it is
>> the default config file for Ubuntu's rc3 release candidate.
>>
>> Here is the syslog of the startup.
>>
>> Please find dmesg output. It is rather similar to the dmesg output of
>> production kernels.
>>
>> /var/log/syslog:
>>
>> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]: message repeated 11
>> times: [ /snap/firefox/1883/usr/lib/firefox/firefox:
>> /snap/firefox/1883/usr/lib/firefox/firefox: no version information available
>> (required by /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)]
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
>> Sep 27 18:43:27 IdeaPad-3 firefox_firefox.desktop[2686]: Missing chrome or
>> resource URL: resource://gre/modules/UpdateListener.sys.mjs
>> Sep 27 18:43:31 IdeaPad-3 firefox_firefox.desktop[2921]:
>> /snap/firefox/1883/usr/lib/firefox/firefox: symbol lookup error:
>> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so: undefined symbol: ,
>> version
>> Sep 27 18:43:33 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.8b8574d2-116e-411a-9bba-c145e8cc0aa2.scope: Consumed
>> 10min 18.279s CPU time.
>> Sep 27 18:44:49 IdeaPad-3 snapd[818]: storehelpers.go:748: cannot refresh:
>> snap has no updates available: "bare", "canonical-livepatch", "core",
>> "core18", "core20", "firefox", "gnome-3-34-1804", "gnome-3-38-2004",
>> "gtk-common-themes", "slack", "snap-store", "snapd", "zoom-client"
>> Sep 27 19:04:59 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope.
>> Sep 27 19:05:04 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope: Consumed
>> 4.239s CPU time.
>> Sep 27 19:05:41 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope.
>> Sep 27 19:05:42 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope: Consumed
>> 1.256s CPU time.
>> Sep 27 19:06:39 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope.
>> Sep 27 19:06:41 IdeaPad-3 systemd[1791]:
>> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope: Consumed
>> 1.231s CPU time.
>> Sep 27 19:06:55 IdeaPad-3 systemd[1791]: Started
>> snap.firefox.firefox.c42cb676-a7a7-49e6-8685-610bd9c1de81.scope.
>>
>> $ sudo dmesg -l err
>> [    1.638759] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0],
>> AE_NOT_FOUND (20220331/dswload2-162)
>> [    1.638854] ACPI Error: AE_NOT_FOUND, During name lookup/catalog
>> (20220331/psobject-220)
>> [    2.175611] ACPI BIOS Error (bug): Could not resolve symbol
>> [\_SB.PC00.DGPV], AE_NOT_FOUND (20220331/psargs-330)
>> [    2.175731] ACPI Error: Aborting method \_SB.PC00.PEG0.PCRP._ON due to
>> previous error (AE_NOT_FOUND) (20220331/psparse-529)
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
>> [   18.018388] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.ETMD],
>> AE_NOT_FOUND (20220331/psargs-330)
>> [   18.018857] ACPI Error: Aborting method \_SB.IETM._OSC due to previous
>> error (AE_NOT_FOUND) (20220331/psparse-529)
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
> Hi Mirsad,
>
> The bug doesn't appear on 6.0 mainline release. However, in my case,
> Firefox is downloaded and installed from official Mozilla binary [1].
>
> Also, many developers here want to see bisection result. In order to
> shorten kernel build time (and thus time needed for bisection),
> you can strip out unneeded modules in your kernel configuration with
> "make localmodconfig". Ensure that all devices on your computer is
> plugged in before running that. And as other people pointed, base
> your localmodconfig from last working kernel.
>
> In any case, please reproduce with Firefox from [1].
>
> Thanks.
>
> [1]: https://www.mozilla.org/en-US/firefox/
>
-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

