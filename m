Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F06031B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJRRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJRRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:41:34 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B4ACA05
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:41:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F1972604F5;
        Tue, 18 Oct 2022 19:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666114889; bh=adBDjvyH25erZehmhH84YnZSxPer6W8HxPZUBU13sDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=12EBj4Cf+y26mBgk86Wd60nuZnO6O+WHcV7qyUF4TIBJiPpoTWxACpFLzLfAzvhEI
         kjmWqCjFzpfs0T4kjEb6rWeAYTEC+p0qW2Iv7yp/JH8ydFOskNjiqRUrPTN3xyClrz
         5g9tcU3ewXEedr6ACDY5W61SCAmltgYqOk+Vfn+Yk88ZQEoulkQXSLLSWn4puC9CQI
         305BGl4P7E5rNq23e5Tkpkh5bJzjRid75Ro944wv0YVL13W+IdFZldMp3LyaEBXBKt
         7T2ODPOO0KvRtZbOmb68IJ86MGisKzWsVLZZH9NOUOwB+pW9xr+OEmGcWpcarhgDcH
         DvHyYAEm2cTGQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BzMZldRDlu_p; Tue, 18 Oct 2022 19:41:26 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.198.228])
        by domac.alu.hr (Postfix) with ESMTPSA id 27DA3604F4;
        Tue, 18 Oct 2022 19:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666114886; bh=adBDjvyH25erZehmhH84YnZSxPer6W8HxPZUBU13sDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SFQOh6pajKaF/RVZdjVu5ZfNHbr1guvcdjFDPbqhp53CwnJvqKmnefo06mt0UYU2a
         qI5+VtSKQUyb+ZrsmsCHoTD2QJUlkmb0gQW1U6CS4M4R8f2nUG4RUpul+4pQY01v70
         MTA1CDAkZcFYaBUV1ykUDKn2x5YkNVR63BNaxVS4IGpveUAPlzqdGhDcfR2OvjcOdp
         VDUphYG0JY9joQ9wJSh+15anJ/uSq02Spmr1kSw1sCiA2GenMu6BJRzdmTv+U1DS1T
         9oNKD+0lb6S9pf33bl/JJGS4UFYeACAIb2p0MM4T/LBaePRKyS1GNqcRbq5jl5Cn6w
         kacdV1uX9dAbg==
Message-ID: <1c6e9939-63b0-d663-1d48-8655e04f0716@alu.unizg.hr>
Date:   Tue, 18 Oct 2022 19:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Jintao Yin <nicememory@gmail.com>
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
 <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 10. 2022. 19:15, Phillip Lougher wrote:

> On 18/10/2022 03:15, Jintao Yin wrote:
>> On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
>>> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>>
>>>> Topposting, to make this easier to access for everyone.
>>>>
>>>> @Mirsad, thx for bisecting.
>>>>
>>>> @Phillip: if you want to see a problem description and the whole
>>>> backstory of the problem that apparently is caused by b09a7a036d20
>>>> ("squashfs: support reading fragments in readahead call"), see this
>>>> thread (Mirsad sadly started a new one with the quoted mail below):
>>>> https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/ 
>>>>
>>>>
>>>
>>> The above backstory tends to suggest data corruption which is happening
>>> after a couple of hours especially on heavy loads, e.g. the comment
>>>
>>>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>>>> The bug usually isn't showing immediately, but after a couple of hours
>>>> of running (especially with multimedia running inside Firefox).
>>>
>>> Which is typically caused by double freed buffers or race conditions in
>>> freeing and reusing.
>>>
>>> Thanks Mirsad for the following
>>>
>>> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
>>>>
>>>> Here are the results of the requested bisect on the bug involving the
>>>> Firefox snap build 104.x, 105.0.x, squashfs and which was 
>>>> manifested on
>>>> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
>>>>
>>>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>>>> git bisect start
>>>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>>>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
>>>> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
>>>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>>>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
>>>> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
>>>> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
>>>> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
>>>> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
>>>> 'mm-stable-2022-08-03' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
>>>> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
>>>> 'mm-nonmm-stable-2022-08-06-2' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
>>>> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
>>>> Add quirk for HP Spectre x360 15-eb0xxx
>>>> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
>>>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
>>>> 'dma-mapping-5.20-2022-08-06' of
>>>> git://git.infradead.org/users/hch/dma-mapping
>>>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
>>>> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
>>>> kexec build error
>>>> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
>>>> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
>>>> 's390-5.20-1' of 
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>>>> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
>>>> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
>>>> build "file direct" version of page actor
>>>> git bisect good db98b43086275350294f5c6f797249b714d6316d
>>>> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb:
>>>> Check the size of screen before memset_io()
>>>> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
>>>> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
>>>> 'for-5.20/fbdev-1' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>>>> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
>>>> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
>>>> useless functions
>>>> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
>>>> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: 
>>>> fix
>>>> address space of proc_dohung_task_timeout_secs
>>>> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
>>>> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support
>>>> reading fragments in readahead call
>>>> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
>>>> mtodorov@domac:~/linux/kernel/linux_stable$
>>>>
>>>> The git bisect stopped at the squashfs commit
>>>> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in 
>>>> Cc:,
>>>> according to the Code of Conduct.
>>>
>>> Which identified the "squashfs: support reading fragments in 
>>> readahead call"
>>> patch.
>>>
>>> There is a race-condition introduced in that patch, which involves 
>>> cache
>>> releasing and reuse.
>>>
>>> The following diff will fix that race-condition.  It would be great if
>>> someone could test and verify before sending it out as a patch.
>>>
>>> Thanks
>>>
>>> Phillip
>> Hi Phillip,
>>    There is a logical bug in commit 
>> 8fc78b6fe24c36b151ac98d7546591ed92083d4f
>>    which is parent commit of commit 
>> b09a7a036d2035b14636cd4c4c69518d73770f65.
>>       In function squashfs_readahead(...),
>>    file_end is initialized with i_size_read(inode) >> msblk->block_log,
>>    which means the last block index of the file.
>>    But later in the logic to check if the page is last one or not the
>>    code is
>>      if (pages[nr_pages - 1]->index == file_end && bytes) {
>>        ...
>>      }
>>    , use file_end as the last page index of file but actually is the 
>> last
>>    block index, so for the common setup of page and block size, the 
>> first
>>    comparison is true only when pages[nr_pages - 1]->index is 0.
>>    Otherwise, the trailing bytes of last page won't be zeroed.
>>
>>    Maybe it's the real cause of the snap bug in some way.
>>
>
> That code segment is indeed the cause of the bug.  But the logic to
> check if it is the last page is completely wrong and more broken than
> described.
>
> I will send a diff.  This has aleady been shown to fix the issue with my
> reproducer.
>
> Thanks
Then it is no surprise that v6.0.2 build with Phillip's and Hsin-Yi's 
patches also
failed, giving the same "Gah, tab crashed" and Verneed errors as before 
given
the same Firefox windows and tabs test:

Oct 18 19:34:00 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7400]: 
/snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: 
unsupported version 0 of Verneed record
Oct 18 19:34:00 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7400]: 
Couldn't load XPCOM.
Oct 18 19:34:03 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7418]: 
XPCOMGlueLoad error for file 
/snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
Oct 18 19:34:03 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7418]: 
/snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: 
unsupported version 0 of Verneed record
Oct 18 19:34:03 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7418]: 
Couldn't load XPCOM.
Oct 18 19:34:04 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5416]: 
Missing chrome or resource URL: 
resource://gre/modules/UpdateListener.sys.mjs
Oct 18 19:34:05 marvin-IdeaPad-3-15ITL6 systemd[1629]: 
snap.firefox.firefox.945b7e54-eb2c-40d3-836d-96ac26e19293.scope: 
Consumed 3min 19.877s CPU time.
Oct 18 19:34:19 marvin-IdeaPad-3-15ITL6 systemd[1629]: Started 
Application launched by gnome-shell.
Oct 18 19:34:19 marvin-IdeaPad-3-15ITL6 systemd[1629]: Started 
snap.firefox.firefox.b586e811-9aaa-4b30-afa8-54ae3b119798.scope.
Oct 18 19:34:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7483]: 
cut: cut: no version information available (required by cut)
Oct 18 19:34:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7483]: 
message repeated 5 times: [ cut: cut: no version information available 
(required by cut)]
Oct 18 19:34:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7483]: 
cut: symbol lookup error: cut: undefined symbol:
Oct 18 19:34:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7441]: 
XPCOMGlueLoad error for file 
/snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
Oct 18 19:34:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7441]: 
/snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: 
unsupported version 0 of Verneed record
Oct 18 19:34:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[7441]: 
Couldn't load XPCOM.
Oct 18 19:34:21 marvin-IdeaPad-3-15ITL6 systemd[1629]: 
snap.firefox.firefox.b586e811-9aaa-4b30-afa8-54ae3b119798.scope: 
Consumed 1.382s CPU time.
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 systemd[1]: Starting Download 
data for packages that failed at package install time...
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 anacron[956]: Job `cron.daily' 
started
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 systemd[1]: 
update-notifier-download.service: Deactivated successfully.
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 systemd[1]: Finished Download 
data for packages that failed at package install time.
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 anacron[7529]: Updated timestamp 
for job `cron.daily' to 2022-10-18
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 cracklib: no dictionary update 
necessary.
Oct 18 19:34:39 marvin-IdeaPad-3-15ITL6 anacron[956]: Job `cron.daily' 
terminated
Oct 18 19:34:42 marvin-IdeaPad-3-15ITL6 dbus-daemon[782]: [system] 
Activating via systemd: service name='org.freedesktop.timedate1' 
unit='dbus-org.freedesktop.timedate1.service' requested by ':1.45' 
(uid=0 pid=810 comm="/usr/lib/snapd/snapd ")
Oct 18 19:34:42 marvin-IdeaPad-3-15ITL6 systemd[1]: Starting Time & Date 
Service...
Oct 18 19:34:42 marvin-IdeaPad-3-15ITL6 dbus-daemon[782]: [system] 
Successfully activated service 'org.freedesktop.timedate1'
Oct 18 19:34:42 marvin-IdeaPad-3-15ITL6 systemd[1]: Started Time & Date 
Service.
Oct 18 19:34:43 marvin-IdeaPad-3-15ITL6 snapd[810]: storehelpers.go:748: 
cannot refresh: snap has no updates available: "bare", 
"canonical-livepatch", "core", "core18", "core20", "gnome-3-34-1804", 
"gnome-3-38-2004", "gtk-common-themes", "slack", "snap-store", "snapd", 
"zoom-client"

I wish there is something I could do to help other than bug reports, but the
squashfs source is way too complex for me ...

Good luck then guys.

Thanks

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

