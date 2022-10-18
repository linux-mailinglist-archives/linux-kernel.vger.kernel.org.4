Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6896A6024C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJRGwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJRGwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:52:21 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245949E2C2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:52:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 03390604F3;
        Tue, 18 Oct 2022 08:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666075936; bh=IQq8rEJKvbHqEnqkK7p+mGeuoMrNPTe3xZyIS0ZBKBE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OdwQ1ERLMVnpDQVWMP5HpciMzHk4DGrP+LVXoW8aU03KEXwoG6zmHhznPDoVQWkxz
         K3pfsHIbeI8W6Hc2H+SP2mRflTD5luPL0hrd+KGwpG8i8dYe8b7engZYL0MEcYQkjS
         b7JfWKpBRO/wlzxiieZH36DUwYt90mhkHDqlwjqQPbbsCLcTSJgdV9WChtWAh/PxQq
         EBAbMnVoEz6lekOGexRE84cT9js7t8irDJg6T1FnsAqdt2H53GY3zzj0+3q04sIPh2
         pYaUEE4HroTaLvxLLBN3gYEhTddMS/6ko9WfGNapPbtM9P7YtgmHOQXF/AORPkJrFp
         FOwFlV6t8NMTw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XScqepld4QCb; Tue, 18 Oct 2022 08:52:13 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 5ADE7604E6;
        Tue, 18 Oct 2022 08:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666075933; bh=IQq8rEJKvbHqEnqkK7p+mGeuoMrNPTe3xZyIS0ZBKBE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lOOn8Bq02bJz0t+ckpVbAYyt7PgoaaOHU+QE/qzhoZ5jEIKzIfZhNQzVmmQboGGqp
         oi6D4JruPsgKR2F12UAzFCWpwVQMKB1ZxX7SnlTefBPkCnX3ZgExYmxjLUj1SxZY0k
         wuRbswNsBrgH6T6IXxJkbEnPcWqviEwTuGBdRE6kW7IOJXhGkHE4+NxnxwgIi4xc1n
         /tmN7x+vKeOQlgKQktAuF79cURyPe24b2APj8w3SaQAv6YvoFZhneg24DuqWnhnXCQ
         3ojag1hkZ986Ej1QwpifQwVZxiJJjx1dFIc4li2cDQc+YLgARc36PmGbtCp/6+crt8
         Hoo3DDbQEDu4g==
Message-ID: <41c05ece-2e63-391a-e1ba-fc1acb235559@alu.unizg.hr>
Date:   Tue, 18 Oct 2022 08:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20221018021507.612-1-nicememory@gmail.com>
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

On 10/18/22 04:15, Jintao Yin wrote:

> On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
>> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
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
>> The above backstory tends to suggest data corruption which is happening
>> after a couple of hours especially on heavy loads, e.g. the comment
>>
>>> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>>> The bug usually isn't showing immediately, but after a couple of hours
>>> of running (especially with multimedia running inside Firefox).
>> Which is typically caused by double freed buffers or race conditions in
>> freeing and reusing.
>>
>> Thanks Mirsad for the following
>>
>> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
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
>    Thanks,
>
>    Jintao

Dear Jintao,

Forgive me for noticing that this is no longer Phillip's code, so I took the
freedom as the original submitter of the bug to include Hsin-Yi into the Cc:
list, so he'd be informed about the error in his code.

Phillip:
I usually stop myself at bisecting bugs, and not people, so if you think that
I was demeaning your professional contribution, I will pull a halt on this and
pull out of this thread.

I am more like weeks than decades long in Linux kernel study, so I realise I
haven't earned the right to give you lessons, and if I sounded like that, I
apologise again.

Owing to the Author of my story, it is more important for me to win hearts for
my Saviour than points in bug hunting.

Thank you.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

