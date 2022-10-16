Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732C600340
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJPUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJPUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 16:19:54 -0400
Received: from p3plwbeout25-04.prod.phx3.secureserver.net (p3plsmtp25-04-2.prod.phx3.secureserver.net [216.69.139.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8491571E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 13:19:51 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id kA6volDCQWVEXkA6woZCjF; Sun, 16 Oct 2022 13:19:51 -0700
X-CMAE-Analysis: v=2.4 cv=HOkGqqhv c=1 sm=1 tr=0 ts=634c6767
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=RK3ebuFzAAAA:8
 a=MXePCOTu_zqNRUNV2r4A:9 a=QEXdDO2ut3YA:10 a=MmWwAi3SEDLxan5u_6-u:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kA6volDCQWVEX
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp04.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okA6t-0002At-Ui; Sun, 16 Oct 2022 21:19:49 +0100
Message-ID: <beba6259-6049-4f5b-6e54-a9c1faba0d5f@squashfs.org.uk>
Date:   Sun, 16 Oct 2022 21:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        regressions@leemhuis.info
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@lists.linux.dev,
        srw@sladewatkins.net, phillip.lougher@gmail.com
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
 <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
In-Reply-To: <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfLwLMI/5Sym4vpylAkfvWr4AWGiPsaeTJz/B6LoaYodzcVn2L7+smkvqo3zsAIqN/7cVTGRn30fyNvlhR/YW5q9fiEXJUzVLdmDe+lTxtxcCdWn93gut
 AYx8+N5yKh8KXb38h/gNRvK6mVlc/FlHtWyNYC3vyjYwktn4sNm1mAzEcD+2MipTIxE77OoPL6fbEIPmdS4EkB1Ge8hcwgziePE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2022 20:55, Phillip Lougher wrote:
> 
> Tracking down bugs of this sort is always a process of elimination,
> and gathering information to pinpoint the exact circumstances of why
> it is triggering.
> 
> Next step is to download the exact snap(s) where the problems are 
> occurring, as this may provide some insights.
> 
> I don't run Ubuntu, and I don't use snaps.  Can you provide the
> download link(s) of the snap(s) that cause problems?  If there's
> any firefox snaps that don't cause problems those will be useful
> too.
> 

It appears there's a searchable "Snap Store" https://snapcraft.io,
but, it doesn't give any download links to the actual snaps which
is rather annoying.

Does anyone know how to get the download link?  I have not run
Ubuntu for over 14 years and have absolutely no wish to do so
now either.

Thanks

Phillip

> You don't mention if there's any errors present in "dmesg" when
> this happens, and so I'm assuming there aren't any?
> 
> Phillip
> 
> 
>> marvin@marvin-IdeaPad-3-15ITL6:~$ sudo tail -300f /var/log/syslog | 
>> grep firefox
>> Oct 16 17:23:17 marvin-IdeaPad-3-15ITL6 systemd[1795]: Started 
>> snap.firefox.firefox.41ac7adc-efbd-4c47-bccb-06711efb7a2e.scope.
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
>> update.go:85: cannot change mount namespace according to change mount 
>> (/var/lib/snapd/hostfs/usr/share/cups/doc-root 
>> /usr/share/cups/doc-root none bind,ro 0 0): cannot create directory 
>> "/usr/share/cups/doc-root": permission denied
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
>> update.go:85: cannot change mount namespace according to change mount 
>> (/var/lib/snapd/hostfs/usr/share/gimp/2.0/help 
>> /usr/share/gimp/2.0/help none bind,ro 0 0): cannot create directory 
>> "/usr/share/gimp/2.0": permission denied
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
>> update.go:85: cannot change mount namespace according to change mount 
>> (/var/lib/snapd/hostfs/usr/share/libreoffice/help 
>> /usr/share/libreoffice/help none bind,ro 0 0): cannot create directory 
>> "/usr/share/libreoffice/help": permission denied
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2556]: 
>> update.go:85: cannot change mount namespace according to change mount 
>> (/var/lib/snapd/hostfs/usr/share/xubuntu-docs /usr/share/xubuntu-docs 
>> none bind,ro 0 0): cannot open directory "/var/lib": permission denied
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.654344] audit: 
>> type=1400 audit(1665933798.028:105): apparmor="DENIED" 
>> operation="mkdir" profile="snap-update-ns.firefox" 
>> name="/usr/share/cups/doc-root/" pid=2556 comm="5" requested_mask="c" 
>> denied_mask="c" fsuid=0 ouid=0
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655141] audit: 
>> type=1400 audit(1665933798.028:106): apparmor="DENIED" 
>> operation="mkdir" profile="snap-update-ns.firefox" 
>> name="/usr/share/gimp/2.0/" pid=2556 comm="5" requested_mask="c" 
>> denied_mask="c" fsuid=0 ouid=0
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655528] audit: 
>> type=1400 audit(1665933798.028:107): apparmor="DENIED" 
>> operation="mkdir" profile="snap-update-ns.firefox" 
>> name="/usr/share/libreoffice/help/" pid=2556 comm="5" 
>> requested_mask="c" denied_mask="c" fsuid=0 ouid=0
>> Oct 16 17:23:18 marvin-IdeaPad-3-15ITL6 kernel: [   25.655671] audit: 
>> type=1400 audit(1665933798.028:108): apparmor="DENIED" 
>> operation="open" profile="snap-update-ns.firefox" name="/var/lib/" 
>> pid=2556 comm="5" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
>> Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 firefox[2527]: Failed to load 
>> module "canberra-gtk-module"
>> Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 firefox[2527]: Failed to load 
>> module "canberra-gtk-module"
>> Oct 16 17:23:19 marvin-IdeaPad-3-15ITL6 kernel: [   27.287722] audit: 
>> type=1326 audit(1665933799.660:110): auid=1000 uid=1000 gid=1000 ses=3 
>> subj=snap.firefox.firefox pid=2527 comm="firefox" 
>> exe="/snap/firefox/1943/usr/lib/firefox/firefox" sig=0 arch=c000003e 
>> syscall=314 compat=0 ip=0x7f54ec28673d code=0x50000
>> Oct 16 17:23:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
>> ATTENTION: default value of option mesa_glthread overridden by 
>> environment.
>> Oct 16 17:23:20 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
>> message repeated 2 times: [ ATTENTION: default value of option 
>> mesa_glthread overridden by environment.]
>> Oct 16 17:23:23 marvin-IdeaPad-3-15ITL6 snapd[817]: 
>> storehelpers.go:748: cannot refresh: snap has no updates available: 
>> "bare", "canonical-livepatch", "core", "core18", "core20", "firefox", 
>> "gnome-3-34-1804", "gnome-3-38-2004", "gtk-common-themes", "slack", 
>> "snap-store", "snapd", "zoom-client"
>> Oct 16 17:23:40 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
>> Missing chrome or resource URL: 
>> resource://gre/modules/UpdateListener.sys.mjs
>> Oct 16 17:23:55 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> [2022-10-16T15:23:55Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
>> Oct 16 17:23:55 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> message repeated 3 times: [ [2022-10-16T15:23:55Z ERROR mp4parse] 
>> Found 2 nul bytes in "\0\0"]
>> Oct 16 17:23:56 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> [2022-10-16T15:23:56Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
>> Oct 16 17:23:56 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> message repeated 3 times: [ [2022-10-16T15:23:56Z ERROR mp4parse] 
>> Found 2 nul bytes in "\0\0"]
>> Oct 16 17:23:58 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> [2022-10-16T15:23:58Z ERROR mp4parse] Found 2 nul bytes in "\0\0"
>> Oct 16 17:23:58 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[3990]: 
>> message repeated 3 times: [ [2022-10-16T15:23:58Z ERROR mp4parse] 
>> Found 2 nul bytes in "\0\0"]
>> Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
>> XPCOMGlueLoad error for file 
>> /snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
>> Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
>> /snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: unsupported version 0 of Verneed record
>> Oct 16 17:24:14 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4942]: 
>> Couldn't load XPCOM.
>> Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
>> XPCOMGlueLoad error for file 
>> /snap/firefox/1943/usr/lib/firefox/libmozgtk.so:
>> Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
>> /snap/firefox/1943/gnome-platform/usr/lib/x86_64-linux-gnu/libXcomposite.so.1: unsupported version 0 of Verneed record
>> Oct 16 17:24:19 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4995]: 
>> Couldn't load XPCOM.
>> Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:21 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5033]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:24:27 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[4480]: 
>> Inconsistency detected by ld.so: ../elf/dl-runtime.c: 80: _dl_fixup: 
>> Assertion `ELFW(R_TYPE)(reloc->r_info) == ELF_MACHINE_JMP_SLOT' failed!
>> Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:31 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5163]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:36 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5205]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:42 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5372]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:45 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5396]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
>> message repeated 2 times: [ 
>> /snap/firefox/1943/usr/lib/firefox/firefox: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record]
>> Oct 16 17:24:53 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5483]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: error while loading shared 
>> libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verneed record
>> Oct 16 17:25:02 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2527]: 
>> Missing chrome or resource URL: 
>> resource://gre/modules/UpdateListener.sys.mjs
>> Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
>> /snap/firefox/1943/usr/lib/firefox/pingsender: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
>> /snap/firefox/1943/usr/lib/firefox/pingsender: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5514]: 
>> /snap/firefox/1943/usr/lib/firefox/pingsender: error while loading 
>> shared libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported 
>> version 0 of Verneed record
>> Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[2764]: 
>> /snap/firefox/1943/usr/lib/firefox/firefox: symbol lookup error: 
>> /snap/firefox/1943/usr/lib/firefox/libmozsandbox.so: undefined symbol: 
>> , version
>> Oct 16 17:25:07 marvin-IdeaPad-3-15ITL6 systemd[1795]: 
>> snap.firefox.firefox.41ac7adc-efbd-4c47-bccb-06711efb7a2e.scope: 
>> Consumed 6min 11.938s CPU time.
>> Oct 16 17:26:22 marvin-IdeaPad-3-15ITL6 systemd[1795]: Started 
>> snap.firefox.firefox.8af6eb39-1ebc-4e81-a7c1-a6cc66e76eac.scope.
>> Oct 16 17:26:23 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5573]: 
>> /bin/bash: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
>> Verdef record
>> Oct 16 17:26:23 marvin-IdeaPad-3-15ITL6 firefox_firefox.desktop[5573]: 
>> /bin/bash: error while loading shared libraries: 
>> /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verneed record
>>
>> I have double-checked that this version of the function is in my build 
>> tree:
>>
>> static int squashfs_readahead_fragment(struct page **page,
>>          unsigned int pages, unsigned int expected)
>> {
>>          struct inode *inode = page[0]->mapping->host;
>>          struct squashfs_cache_entry *buffer = 
>> squashfs_get_fragment(inode->i_sb,
>>                  squashfs_i(inode)->fragment_block,
>>                  squashfs_i(inode)->fragment_size);
>>          struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>>          unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) 
>> - 1;
>>          int error = buffer->error;
>>
>>          if (error)
>>                  goto out;
>>
>>          expected += squashfs_i(inode)->fragment_offset;
>>
>>          for (n = 0; n < pages; n++) {
>>                  unsigned int base = (page[n]->index & mask) << 
>> PAGE_SHIFT;
>>                  unsigned int offset = base + 
>> squashfs_i(inode)->fragment_offset;
>>
>>                  if (expected > offset) {
>>                          unsigned int avail = min_t(unsigned int, 
>> expected -
>>                                  offset, PAGE_SIZE);
>>
>>                          squashfs_fill_page(page[n], buffer, offset, 
>> avail);
>>                  }
>>
>>                  unlock_page(page[n]);
>>                  put_page(page[n]);
>>          }
>>
>> out:
>>          squashfs_cache_put(buffer);
>>          return error;
>> }
>>
>> The same set of Firefox windows and tabs loaded correctly once 
>> switching back to the 5.19.13 kernel image.
>>
>> The same applies for running the same setup with the home-built "Linux 
>> 5.19.15-20221014-conf051913ub x86_64": No Verdef nor Verneed error 
>> messages.
>>
>> Have a nice day, and good bug hunting!
>>
>> Regards,
>> Mirsad
>>
>> -- 
>> Mirsad Goran Todorovac
>> Sistem inženjer
>> Grafički fakultet | Akademija likovnih umjetnosti
>> Sveučilište u Zagrebu
> 

