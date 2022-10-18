Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373CF602835
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJRJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJRJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:23:39 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E4ABD7B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:23:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BED54604F3;
        Tue, 18 Oct 2022 11:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666084989; bh=/DtkNMJyo1dkCldsRBbV8CWOSU2TvwOqS4m2/7JQBh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MQOn+TciZu9qQpKpPogvii1sucjtGtCJb2Y5qoGlcLDjdzgMQfHH29HKUQQzzGx/H
         oJvLRtUonhDiCfrPc5dWLbIii67gaKJb7WP5rI7nCgdXPRIDH+NtzLKRcQIKP5fMVS
         n5f6OWP0K5ZmD0FQaZGF8HKmcgCtmng30132trShFELexpTwqz3oDOdYJKVz1xNKsK
         Y0rClIw6X4tJuaDW7mVI5CrRIMRw0kQ+dWfDn/C6FeyFJWR7WTOtYf5yEPw9TK1pOr
         vMQtod40Z0tZjx3RkSd6FtCTtA0ReZRHe++vBhmgT85nRPvni5F5OZbGXejCqIoT4o
         9VXpcxBrQyIgQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PUxZyBZBiAJe; Tue, 18 Oct 2022 11:23:06 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 0F6DC604E6;
        Tue, 18 Oct 2022 11:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666084986; bh=/DtkNMJyo1dkCldsRBbV8CWOSU2TvwOqS4m2/7JQBh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F+ZsaHnDCaCf96wMWy09PkIM0NeVj5SoDQzrw2m7u7F59W0UEdvH/+qTuQDfDiej/
         Sw9iu3xUqW1pUYw0renP1c0cWFMW3DVyt6snSh1MgMUrE1RQxE/SIweqbVKl/AlPpz
         AdOC5hIZwVmyxxW3YOak8kdPoAcz/qCspMOWvkDvC1RoNwDGuyK79gquka2j2qsJOP
         7q9K/crA9GP5P9TEYVEsOc3gOoceVTpsmcoMoGvBiYpmg58SqYMe2xL9iDCQzYcPuL
         GrE6FXEzmDo4GOqAg9bVyTxVUZv/L2D7foADKFWdFNjfVfXUgV/+jeN56M3lgMYmo6
         n/BQ5Zd4tY1Eg==
Message-ID: <05f42079-5e4e-0194-b645-8c5e10e34cbf@alu.unizg.hr>
Date:   Tue, 18 Oct 2022 11:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk,
        bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
 <41c05ece-2e63-391a-e1ba-fc1acb235559@alu.unizg.hr>
 <CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com>
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

On 10/18/22 10:24, Hsin-Yi Wang wrote:

> On Tue, Oct 18, 2022 at 2:52 PM Mirsad Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>> On 10/18/22 04:15, Jintao Yin wrote:
>>
>>> On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
>>>> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>>> Topposting, to make this easier to access for everyone.
>>>>>
>>>>> @Mirsad, thx for bisecting.
>>>>>
>>>>> @Phillip: if you want to see a problem description and the whole
>>>>> backstory of the problem that apparently is caused by       b09a7a036d20
>>>>> ("squashfs: support reading fragments in readahead call"), see this
>>>>> thread (Mirsad sadly started a new one with the quoted mail below):
>>>>> https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
>>>>>
>>>> The above backstory tends to suggest data corruption which is happening
>>>> after a couple of hours especially on heavy loads, e.g. the comment
>>>>
>>>>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>>>>> The bug usually isn't showing immediately, but after a couple of hours
>>>>> of running (especially with multimedia running inside Firefox).
>>>> Which is typically caused by double freed buffers or race conditions in
>>>> freeing and reusing.
>>>>
>>>> Thanks Mirsad for the following
>>>>
>>>> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
>>>>> Here are the results of the requested bisect on the bug involving the
>>>>> Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on
>>>>> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
>>>>>
>>>>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
>>>>> git bisect start
>>>>> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
>>>>> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>>> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
>>>>> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
>>>>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>>>>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
>>>>> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
>>>>> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
>>>>> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
>>>>> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
>>>>> 'mm-stable-2022-08-03' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
>>>>> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
>>>>> 'mm-nonmm-stable-2022-08-06-2' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
>>>>> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
>>>>> Add quirk for HP Spectre x360 15-eb0xxx
>>>>> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
>>>>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
>>>>> 'dma-mapping-5.20-2022-08-06' of
>>>>> git://git.infradead.org/users/hch/dma-mapping
>>>>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
>>>>> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
>>>>> kexec build error
>>>>> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
>>>>> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
>>>>> 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>>>>> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
>>>>> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
>>>>> build "file direct" version of page actor
>>>>> git bisect good db98b43086275350294f5c6f797249b714d6316d
>>>>> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb:
>>>>> Check the size of screen before memset_io()
>>>>> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
>>>>> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
>>>>> 'for-5.20/fbdev-1' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>>>>> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
>>>>> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
>>>>> useless functions
>>>>> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
>>>>> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix
>>>>> address space of proc_dohung_task_timeout_secs
>>>>> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
>>>>> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support
>>>>> reading fragments in readahead call
>>>>> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
>>>>> mtodorov@domac:~/linux/kernel/linux_stable$
>>>>>
>>>>> The git bisect stopped at the squashfs commit
>>>>> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:,
>>>>> according to the Code of Conduct.
>>>> Which identified the "squashfs: support reading fragments in readahead call"
>>>> patch.
>>>>
>>>> There is a race-condition introduced in that patch, which involves cache
>>>> releasing and reuse.
>>>>
>>>> The following diff will fix that race-condition.  It would be great if
>>>> someone could test and verify before sending it out as a patch.
>>>>
>>>> Thanks
>>>>
>>>> Phillip
>>> Hi Phillip,
>>>     There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed92083d4f
>>>     which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d73770f65.
>>>
>>>     In function squashfs_readahead(...),
>>>     file_end is initialized with i_size_read(inode) >> msblk->block_log,
>>>     which means the last block index of the file.
>>>     But later in the logic to check if the page is last one or not the
>>>     code is
>>>       if (pages[nr_pages - 1]->index == file_end && bytes) {
>>>         ...
>>>       }
>>>     , use file_end as the last page index of file but actually is the last
>>>     block index, so for the common setup of page and block size, the first
>>>     comparison is true only when pages[nr_pages - 1]->index is 0.
>>>     Otherwise, the trailing bytes of last page won't be zeroed.
>>>
>>>     Maybe it's the real cause of the snap bug in some way.
>>>
> Hi Jintao,
>
> Thanks for pointing out and sorry for missing this. Does the following
> diff improve the issue?
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b229..7759bd70dfbf2 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -600,7 +600,7 @@ static void squashfs_readahead(struct
> readahead_control *ractl)
>
>                          /* Last page (if present) may have trailing
> bytes not filled */
>                          bytes = res % PAGE_SIZE;
> -                       if (pages[nr_pages - 1]->index == file_end && bytes)
> +                       if ((pages[nr_pages - 1]->index >> shift) ==
> file_end && bytes)
>                                  memzero_page(pages[nr_pages - 1], bytes,
>                                               PAGE_SIZE - bytes);
>
>
> readahead only handles the case that the first page and the last page
> have the same block index:
>      index = pages[0]->index >> shift;
>      if ((pages[nr_pages - 1]->index >> shift) != index)
>          goto skip_pages;
>
> The diff above makes a difference to SQUASHFS_INVALID_BLK case, which
> will not be handled by squashfs_readahead_fragment() if
> index==file_end.
> With the above diff, it will now be memzero_page().
>
> Hi Phillip,
> Does the SQUASHFS_INVALID_BLK case handling with index==file_end
> sounds reasonable to you?
>
> Thanks.
Hi Hsin-Yi,

The patches were successfully applied (both yours and Phillip's) on v6.0.2 source
and the build is already in progress.

However, due to the stochastic nature of the bug, it may take time before saying
anything for sure.

I will test at around 6 PM UTC+02 on the machine with the same set of windows and
tabs in Firefox that triggered the bug so we'll know then if that case at least is
fixed.

Thanks.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

