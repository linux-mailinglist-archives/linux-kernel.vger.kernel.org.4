Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6335FFC1B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 23:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJOV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 17:59:21 -0400
Received: from p3plwbeout26-06.prod.phx3.secureserver.net (p3plsmtp26-06-2.prod.phx3.secureserver.net [216.69.139.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E76544CF1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 14:59:17 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id jpBboSu7WjYPtjpBcoY4LB; Sat, 15 Oct 2022 14:59:16 -0700
X-CMAE-Analysis: v=2.4 cv=G8TZr/o5 c=1 sm=1 tr=0 ts=634b2d34
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=Qawa6l4ZSaYA:10 a=lAgNKBcoAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=GRPhd0ZzCgtLxuiCWnkA:9
 a=drE6d5tx1tjNRBs8zHOc:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  jpBboSu7WjYPt
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp06.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ojpBb-0005Be-4i; Sat, 15 Oct 2022 22:59:15 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, phillip@squashfs.org.uk,
        regressions@lists.linux.dev, srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Sat, 15 Oct 2022 21:59:36 +0100
Message-Id: <20221015205936.5735-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfIfARGWxvWNGzC9ERKAM+DqLBpSMeeD5wQb9vOxLKuc4LPn0lWjRc973OrBOG193Zxtw6CxVVtajd6w2JoVKNVsy78Rd03s+RrW+7LkFhH3jG22WYvtX
 EWRVAgSZ1WFLIjMa9yoq72WTej3XGRBHqLjfpD6OHfXs36zGUu9qQZjnT2ZYRf53ZMnTlDc6SXOldClACRNeNP/kAX+HbCaVqjg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>
>Topposting, to make this easier to access for everyone.
>
>@Mirsad, thx for bisecting.
>
>@Phillip: if you want to see a problem description and the whole
>backstory of the problem that apparently is caused by 	b09a7a036d20
>("squashfs: support reading fragments in readahead call"), see this
>thread (Mirsad sadly started a new one with the quoted mail below):
>https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
>

The above backstory tends to suggest data corruption which is happening
after a couple of hours especially on heavy loads, e.g. the comment

> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>The bug usually isn't showing immediately, but after a couple of hours 
>of running (especially with multimedia running inside Firefox).

Which is typically caused by double freed buffers or race conditions in
freeing and reusing.

Thanks Mirsad for the following

On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
>
>Here are the results of the requested bisect on the bug involving the 
>Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on 
>both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
>
>mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>git bisect start
># bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
># good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
>git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
># good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
># good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag 
>'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
>git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
># good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag 
>'mm-stable-2022-08-03' of 
>git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
># bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag 
>'mm-nonmm-stable-2022-08-06-2' of 
>git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
># good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek: 
>Add quirk for HP Spectre x360 15-eb0xxx
>git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
># good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag 
>'dma-mapping-5.20-2022-08-06' of 
>git://git.infradead.org/users/hch/dma-mapping
>git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
># good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix 
>kexec build error
>git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
># good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag 
>'s390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
># good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always 
>build "file direct" version of page actor
>git bisect good db98b43086275350294f5c6f797249b714d6316d
># good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb: 
>Check the size of screen before memset_io()
>git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
># good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag 
>'for-5.20/fbdev-1' of 
>git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
># bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some 
>useless functions
>git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
># bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix 
>address space of proc_dohung_task_timeout_secs
>git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
># bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support 
>reading fragments in readahead call
>git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
>mtodorov@domac:~/linux/kernel/linux_stable$
>
>The git bisect stopped at the squashfs commit 
>b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:, 
>according to the Code of Conduct.

Which identified the "squashfs: support reading fragments in readahead call"
patch.

There is a race-condition introduced in that patch, which involves cache
releasing and reuse.

The following diff will fix that race-condition.  It would be great if
someone could test and verify before sending it out as a patch.

Thanks

Phillip

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e56510964b22..6cc23178e9ad 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
 		squashfs_i(inode)->fragment_size);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	int error = buffer->error;
 
-	if (buffer->error)
+	if (error)
 		goto out;
 
 	expected += squashfs_i(inode)->fragment_offset;
@@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
 
 out:
 	squashfs_cache_put(buffer);
-	return buffer->error;
+	return error;
 }
 
 static void squashfs_readahead(struct readahead_control *ractl)

