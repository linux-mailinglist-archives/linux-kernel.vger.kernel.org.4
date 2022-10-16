Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB696000F8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJPPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:55:49 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39932E9FE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:55:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 62E70604EC;
        Sun, 16 Oct 2022 17:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665935744; bh=K2X0ktDmQobtM/jbtKnUX9yH0ZcSdZkM4/Yu16rKEVA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=VdoKRNfVhhCXzJwDw4eM1Urup7iuwqjxXvzCmkgya1jsnczZ8P/HlPSX8ebSmQp60
         duMv5ptwERLu2UM94g7E8vdTYI6mxZwCQ5LTohdK94luSeRLCgnsv8iGeBH9SlluEm
         S5pU311GmGaW622rTHPQxs5OvqC0RRAhs/ei1sFI+1LjgsfGiIUZoGGFtjiMEIQrIx
         vktlCRCY84V6PoJryi2YtZIzsR+zgUX8XgNF1sBPzm8gbLeci/qGX9LlT86MDhg+pf
         BxqD/BU/KUYRnud02TfLadxFAxpIqVYgSvyEHbll2biiVr+4EXjmWg268N5PNUWciD
         DmOAzJdd1toFA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vxiFILTByPFe; Sun, 16 Oct 2022 17:55:40 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.197.215])
        by domac.alu.hr (Postfix) with ESMTPSA id 85129604E6;
        Sun, 16 Oct 2022 17:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665935740; bh=K2X0ktDmQobtM/jbtKnUX9yH0ZcSdZkM4/Yu16rKEVA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=1bS6iNFOXlJSekoEIHA1+26j9pe7tA7VWvkeTI+lpmy+1rZxLZwZxJaTXg14KvBZw
         EEo0ax477e9H2iDvgYFukTXN7Lks99YMzg9kM5LglpC4psASPiol2rSWSKALooqyve
         MiBnph4oX8WFNR76rMpkFvbIkVrNGNzaNiVSQ9CoJCvOQtYXfmd5SuKYdIdu/x0Pmt
         aO412TJ1A1e/CT8XUfXW1s8ELIC6wB8QsRYP7D+WX3XVKqgHga1go01KlcdYHc1TZT
         gBlPgdV+Bo734pVoOmnqKVFmRP65JxZJPE4nm1KiFNRIAg8g7fZiU2hh1nfnwdLcRX
         jzJutXas10SPQ==
Message-ID: <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
Date:   Sun, 16 Oct 2022 17:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@lists.linux.dev,
        srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
Content-Language: en-US
In-Reply-To: <20221015205936.5735-1-phillip@squashfs.org.uk>
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

On 15. 10. 2022. 22:59, Phillip Lougher wrote:

> Thorsten Leemhuis<regressions@leemhuis.info>  wrote:
>> Topposting, to make this easier to access for everyone.
>>
>> @Mirsad, thx for bisecting.
>>
>> @Phillip: if you want to see a problem description and the whole
>> backstory of the problem that apparently is caused by 	b09a7a036d20
>> ("squashfs: support reading fragments in readahead call"), see this
>> thread (Mirsad sadly started a new one with the quoted mail below):
>> https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
>>
> The above backstory tends to suggest data corruption which is happening
> after a couple of hours especially on heavy loads, e.g. the comment
>
>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>> The bug usually isn't showing immediately, but after a couple of hours
>> of running (especially with multimedia running inside Firefox).
> Which is typically caused by double freed buffers or race conditions in
> freeing and reusing.
>
> Thanks Mirsad for the following
>
> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
>> Here are the results of the requested bisect on the bug involving the
>> Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on
>> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
>>
>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>> git bisect start
>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
>> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
>> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
>> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
>> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
>> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
>> 'mm-stable-2022-08-03' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
>> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
>> 'mm-nonmm-stable-2022-08-06-2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
>> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
>> Add quirk for HP Spectre x360 15-eb0xxx
>> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
>> 'dma-mapping-5.20-2022-08-06' of
>> git://git.infradead.org/users/hch/dma-mapping
>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
>> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
>> kexec build error
>> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
>> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
>> 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
>> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
>> build "file direct" version of page actor
>> git bisect good db98b43086275350294f5c6f797249b714d6316d
>> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb:
>> Check the size of screen before memset_io()
>> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
>> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
>> 'for-5.20/fbdev-1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
>> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
>> useless functions
>> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
>> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix
>> address space of proc_dohung_task_timeout_secs
>> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
>> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support
>> reading fragments in readahead call
>> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
>> mtodorov@domac:~/linux/kernel/linux_stable$
>>
>> The git bisect stopped at the squashfs commit
>> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:,
>> according to the Code of Conduct.
> Which identified the "squashfs: support reading fragments in readahead call"
> patch.
>
> There is a race-condition introduced in that patch, which involves cache
> releasing and reuse.
>
> The following diff will fix that race-condition.  It would be great if
> someone could test and verify before sending it out as a patch.
>
> Thanks
>
> Phillip
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..6cc23178e9ad 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
>   		squashfs_i(inode)->fragment_size);
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int error = buffer->error;
>   
> -	if (buffer->error)
> +	if (error)
>   		goto out;
>   
>   	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>   
>   out:
>   	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return error;
>   }
>   
>   static void squashfs_readahead(struct readahead_control *ractl)

Dear Phillip,

I am sorry to have to disappoint you.

Having applied the patch to the version 6.0.1. The first run succeeded, 
but the second (after quit and restart from toolbar) run's results are 
still not good:

marvin@marvin-IdeaPad-3-15ITL6:~$ sudo tail -300f /var/log/syslog | grep 
firefox
Oct 16 17:23:17 marvin-IdeaPad-3-15ITL6 systemd[1795]: Started 
snap.firefox.firefox.41ac7adc-efbd-4c47-bccb-06711efb7a2e.scope.
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
update.go:85: cannot change mount namespace according to change mount 
(/var/lib/snapd/hostfs/usr/share/cups/doc-root /usr/share/cups/doc-root 
none bind,ro 0 0): cannot create directory "/usr/share/cups/doc-root": 
permission denied
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
update.go:85: cannot change mount namespace according to change mount 
(/var/lib/snapd/hostfs/usr/share/gimp/2.0/help /usr/share/gimp/2.0/help 
none bind,ro 0 0): cannot create directory "/usr/share/gimp/2.0": 
permission denied
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
update.go:85: cannot change mount namespace according to change mount 
(/var/lib/snapd/hostfs/usr/share/libreoffice/help 
/usr/share/libreoffice/help none bind,ro 0 0): cannot create directory 
"/usr/share/libreoffice/help": permission denied
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
update.go:85: cannot change mount namespace according to change mount 
(/var/lib/snapd/hostfs/usr/share/xubuntu-docs /usr/share/xubuntu-docs 
none bind,ro 0 0): cannot open directory "/var/lib": permission denied
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.654344] audit: 
type=1400 audit(1665933798.028:105): apparmor="DENIED" operation="mkdir" 
profile="snap-update-ns.firefox" name="/usr/share/cups/doc-root/" 
pid=2556 comm="5" requested_mask="c" denied_mask="c" fsuid=0 ouid=0
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655141] audit: 
type=1400 audit(1665933798.028:106): apparmor="DENIED" operation="mkdir" 
profile="snap-update-ns.firefox" name="/usr/share/gimp/2.0/" pid=2556 
comm="5" requested_mask="c" denied_mask="c" fsuid=0 ouid=0
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655528] audit: 
type=1400 audit(1665933798.028:107): apparmor="DENIED" operation="mkdir" 
profile="snap-update-ns.firefox" name="/usr/share/libreoffice/help/" 
pid=2556 comm="5" requested_mask="c" denied_mask="c" fsuid=0 ouid=0
Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655671] audit: 
type=1400 audit(1665933798.028:108): apparmor="DENIED" operation="open" 
profile="snap-update-ns.firefox" name="/var/lib/" pid=2556 comm="5" 
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 firefox[2527]: Failed to load 
module "canberra-gtk-module"
Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 firefox[2527]: Failed to load 
module "canberra-gtk-module"
Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 kernel: [   27.287722] audit: 
type=1326 audit(1665933799.660:110): auid=1000 uid=1000 gid=1000 ses=3 
subj=snap.firefox.firefox pid=2527 comm="firefox" 
exe="/snap/firefox/1943/usr/lib/firefox/firefox" sig=0 arch=c000003e 
syscall=314 compat=0 ip=0x7f54ec28673d code=0x50000
Oct 16 17:23:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
ATTENTION: default value of option mesa_glthread overridden by environment.
Oct 16 17:23:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
message repeated 2 times: [ ATTENTION: default value of option 
mesa_glthread overridden by environment.]
Oct 16 17:23:23 marvin-IdeaPad-3-15ITL6 snapd[817]: storehelpers.go:748: 
cannot refresh: snap has no updates available: "bare", 
"canonical-livepatch", "core", "core18", "core20", "firefox", 
"gnome-3-34-1804", "gnome-3-38-2004", "gtk-common-themes", "slack", 
"snap-store", "snapd", "zoom-client"
Oct 16 17:23:40 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
Missing chrome or resource URL: 
resource://gre/modules/UpdateListener.sys.mjs
Oct 16 17:23:55 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
[2022-10-16T15:23:55Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
Oct 16 17:23:55 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
message repeated 3 times: [ [2022-10-16T15:23:55Z ERROR mp4parse] Found 
2 nul bytes in "\0\0"]
Oct 16 17:23:56 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
[2022-10-16T15:23:56Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
Oct 16 17:23:56 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
message repeated 3 times: [ [2022-10-16T15:23:56Z ERROR mp4parse] Found 
2 nul bytes in "\0\0"]
Oct 16 17:23:58 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
[2022-10-16T15:23:58Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
Oct 16 17:23:58 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
message repeated 3 times: [ [2022-10-16T15:23:58Z ERROR mp4parse] Found 
2 nul bytes in "\0\0"]
Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
XPCOMGlueLoad error for file 
/snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
/snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: 
unsupported version 0 of Verneed record
Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
Couldn't load XPCOM.
Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
XPCOMGlueLoad error for file 
/snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
/snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: 
unsupported version 0 of Verneed record
Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
Couldn't load XPCOM.
Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:24:27 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4480]: 
Inconsistency detected by ld.so: ../elf/dl-runtime.c: 80: _dl_fixup: 
Assertion `ELFW(R_TYPE)(reloc->r_info) == ELF_MACHINE_JMP_SLOT' failed!
Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
/snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
message repeated 2 times: [ /snap/firefox/1943/usr/lib/firefox/firefox: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
/snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verneed record
Oct 16 17:25:02 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
Missing chrome or resource URL: 
resource://gre/modules/UpdateListener.sys.mjs
Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
/snap/firefox/1943/usr/lib/firefox/pingsender: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
/snap/firefox/1943/usr/lib/firefox/pingsender: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
/snap/firefox/1943/usr/lib/firefox/pingsender: error while loading 
shared libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 
0 of Verneed record
Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2764]: 
/snap/firefox/1943/usr/lib/firefox/firefox: symbol lookup error: 
/snap/firefox/1943/usr/lib/firefox/libmozsandbox.so: undefined symbol: , 
version
Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 systemd[1795]: 
snap.firefox.firefox.41ac7adc-efbd-4c47-bccb-06711efb7a2e.scope: 
Consumed 6min 11.938s CPU time.
Oct 16 17:26:22 marvin-IdeaPad-3-15ITL6 systemd[1795]: Started 
snap.firefox.firefox.8af6eb39-1ebc-4e81-a7c1-a6cc66e76eac.scope.
Oct 16 17:26:23 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5573]: 
/bin/bash: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verdef record
Oct 16 17:26:23 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5573]: 
/bin/bash: error while loading shared libraries: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verneed record

I have double-checked that this version of the function is in my build tree:

static int squashfs_readahead_fragment(struct page **page,
         unsigned int pages, unsigned int expected)
{
         struct inode *inode = page[0]->mapping->host;
         struct squashfs_cache_entry *buffer = 
squashfs_get_fragment(inode->i_sb,
                 squashfs_i(inode)->fragment_block,
                 squashfs_i(inode)->fragment_size);
         struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
         unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
         int error = buffer->error;

         if (error)
                 goto out;

         expected += squashfs_i(inode)->fragment_offset;

         for (n = 0; n < pages; n++) {
                 unsigned int base = (page[n]->index & mask) << PAGE_SHIFT;
                 unsigned int offset = base + 
squashfs_i(inode)->fragment_offset;

                 if (expected > offset) {
                         unsigned int avail = min_t(unsigned int, expected -
                                 offset, PAGE_SIZE);

                         squashfs_fill_page(page[n], buffer, offset, avail);
                 }

                 unlock_page(page[n]);
                 put_page(page[n]);
         }

out:
         squashfs_cache_put(buffer);
         return error;
}

The same set of Firefox windows and tabs loaded correctly once switching 
back to the 5.19.13 kernel image.

The same applies for running the same setup with the home-built "Linux 
5.19.15-20221014-conf051913ub x86_64": No Verdef nor Verneed error messages.

Have a nice day, and good bug hunting!

Regards,
Mirsad

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

