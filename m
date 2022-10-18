Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F3603178
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiJRRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJRRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:18:18 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 10:18:14 PDT
Received: from p3plwbeout16-03.prod.phx3.secureserver.net (p3plsmtp16-03-2.prod.phx3.secureserver.net [173.201.193.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3106A347B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:18:14 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id kqBco3zbV5A6BkqBdoO93u; Tue, 18 Oct 2022 10:15:29 -0700
X-CMAE-Analysis: v=2.4 cv=GM3NrsBK c=1 sm=1 tr=0 ts=634edf31
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=lAgNKBcoAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=ygIEzA4lYqtJ-tnP5d0A:9
 a=QEXdDO2ut3YA:10 a=drE6d5tx1tjNRBs8zHOc:22 a=AjGcO6oz07-iQ99wixmX:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kqBco3zbV5A6B
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okqBY-0000Nu-2a; Tue, 18 Oct 2022 18:15:27 +0100
Message-ID: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
Date:   Tue, 18 Oct 2022 18:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Jintao Yin <nicememory@gmail.com>
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, mirsad.todorovac@alu.unizg.hr,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net, Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20221018021507.612-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfCowMskq7U6p9shwdsXd+WHlmdlsO/SE817Zwm/ldYhtuqw7XtvDhkInuaj2gVfnGx5iq5katKp7q0hs4ylMIs0sDkprpSGDOLGHwgzaLKKzwYhgxPZh
 tM/1u0Ghao/JP2AEyTaH/HBEzSiFgcbvtuegCnQTjXkcBe6V3vAHfZIrcb7pZlV090M9u6EqmMt/Y6teOMjoz29WeNQadHpuCb0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 03:15, Jintao Yin wrote:
> On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
>> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>
>>> Topposting, to make this easier to access for everyone.
>>>
>>> @Mirsad, thx for bisecting.
>>>
>>> @Phillip: if you want to see a problem description and the whole
>>> backstory of the problem that apparently is caused by 	b09a7a036d20
>>> ("squashfs: support reading fragments in readahead call"), see this
>>> thread (Mirsad sadly started a new one with the quoted mail below):
>>> https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
>>>
>>
>> The above backstory tends to suggest data corruption which is happening
>> after a couple of hours especially on heavy loads, e.g. the comment
>>
>>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>>> The bug usually isn't showing immediately, but after a couple of hours
>>> of running (especially with multimedia running inside Firefox).
>>
>> Which is typically caused by double freed buffers or race conditions in
>> freeing and reusing.
>>
>> Thanks Mirsad for the following
>>
>> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
>>>
>>> Here are the results of the requested bisect on the bug involving the
>>> Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on
>>> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
>>>
>>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>>> git bisect start
>>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
>>> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
>>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
>>> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
>>> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
>>> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
>>> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
>>> 'mm-stable-2022-08-03' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
>>> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
>>> 'mm-nonmm-stable-2022-08-06-2' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
>>> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
>>> Add quirk for HP Spectre x360 15-eb0xxx
>>> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
>>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
>>> 'dma-mapping-5.20-2022-08-06' of
>>> git://git.infradead.org/users/hch/dma-mapping
>>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
>>> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
>>> kexec build error
>>> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
>>> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
>>> 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>>> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
>>> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
>>> build "file direct" version of page actor
>>> git bisect good db98b43086275350294f5c6f797249b714d6316d
>>> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb:
>>> Check the size of screen before memset_io()
>>> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
>>> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
>>> 'for-5.20/fbdev-1' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>>> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
>>> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
>>> useless functions
>>> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
>>> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix
>>> address space of proc_dohung_task_timeout_secs
>>> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
>>> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support
>>> reading fragments in readahead call
>>> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
>>> mtodorov@domac:~/linux/kernel/linux_stable$
>>>
>>> The git bisect stopped at the squashfs commit
>>> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:,
>>> according to the Code of Conduct.
>>
>> Which identified the "squashfs: support reading fragments in readahead call"
>> patch.
>>
>> There is a race-condition introduced in that patch, which involves cache
>> releasing and reuse.
>>
>> The following diff will fix that race-condition.  It would be great if
>> someone could test and verify before sending it out as a patch.
>>
>> Thanks
>>
>> Phillip
> Hi Phillip,
>    There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed92083d4f
>    which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d73770f65.
>    
>    In function squashfs_readahead(...),
>    file_end is initialized with i_size_read(inode) >> msblk->block_log,
>    which means the last block index of the file.
>    But later in the logic to check if the page is last one or not the
>    code is
>      if (pages[nr_pages - 1]->index == file_end && bytes) {
>        ...
>      }
>    , use file_end as the last page index of file but actually is the last
>    block index, so for the common setup of page and block size, the first
>    comparison is true only when pages[nr_pages - 1]->index is 0.
>    Otherwise, the trailing bytes of last page won't be zeroed.
> 
>    Maybe it's the real cause of the snap bug in some way.
> 

That code segment is indeed the cause of the bug.  But the logic to
check if it is the last page is completely wrong and more broken than
described.

I will send a diff.  This has aleady been shown to fix the issue with my
reproducer.

Thanks

Phillip

>    Thanks,
> 
>    Jintao


