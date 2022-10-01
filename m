Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4F5F1720
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiJAATX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiJAASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:18:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AA3A174
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AEB0B823AC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0ABC433D7;
        Sat,  1 Oct 2022 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664583376;
        bh=FAHwj+8JpdEpeBHnBv/tRm0Spzw+5KxeRqQ5U2Ch+jY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nFib9jiJNQ8NSdzhsE4wo6xjcA5zSkEOwdngDFRCJ07fXnTKUeKUhCt/pJxuP/dKf
         awrUzLM/xlYBpJDS+VJ9De0TbiZkMwKqLbgWM4xIrAPJm48tkuTMWkAofVon5Xuet7
         R5VIgxeWn5Rq+Mt3VrdX/aWjUJDf4SR7wlxGXWOU4nyPtHCF/CorHMQlt5/FVcb+my
         lAgVTv4US71+DYYGSTBDTCTgynR2ZWGJ89IIjknUQXPNoADaEVbZNbw8X2nlCyqI2n
         IpDkIDwwIA9z6pw/Op4q/r7ae+ROiqYN+FfsArG+rzrfmfatyntprxctIY7Tjg7mCR
         aoBtBo/hS4T2g==
Message-ID: <d3992e1c-3251-f900-97be-049b1e1e4e37@kernel.org>
Date:   Sat, 1 Oct 2022 08:16:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20220920014036.2295853-1-daeho43@gmail.com>
 <f4ce9486-f104-b0e2-25ed-f6de96316b76@kernel.org>
 <CACOAw_z=9H6jEQNd8C99c6xO55PJXWJOW7Q=78qtppgysebN2A@mail.gmail.com>
 <4aca0d00-d3b7-975f-6b72-ccd6f07d22e5@kernel.org>
 <CACOAw_wVU1gmH1gyWHYNqCpgy4KGKB+EZK6pbGL-h_1ToDV=vg@mail.gmail.com>
 <53df1b78-c611-6a22-88b1-74cc83a9e148@kernel.org>
 <CACOAw_w_09sz8PxnSGzNmJwh1-y_3JoKbBu80VjgZgV1uxo7KA@mail.gmail.com>
 <CACOAw_wjcFr1fg3QRYPUyOGyo-G9D9U6=qprkPUP8PzoxPQkMQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_wjcFr1fg3QRYPUyOGyo-G9D9U6=qprkPUP8PzoxPQkMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/1 4:01, Daeho Jeong wrote:
> On Fri, Sep 30, 2022 at 9:04 AM Daeho Jeong <daeho43@gmail.com> wrote:
>>
>>>>>>>
>>>>>>> Hi Daeho,
>>>>>>>
>>>>>>> isize should be updated after tagging inode as atomic_write one?
>>>>>>> otherwise f2fs_mark_inode_dirty_sync() may update isize to inode page,
>>>>>>> latter checkpoint may persist that change? IIUC...
>>>>>>>
>>>>>>> Thanks,
>>>>>>
>>>>>> Hi Chao,
>>>>>>
>>>>>> The first patch of this patchset prevents the inode page from being
>>>>>> updated as dirty for atomic file cases.
>>>>>> Is there any other chances for the inode page to be marked as dirty?
>>>>>
>>>>> I mean:
>>>>>
>>>>> Thread A                                Thread B
>>>>> - f2fs_ioc_start_atomic_write
>>>>>     - f2fs_i_size_write(inode, 0)
>>>>>      - f2fs_mark_inode_dirty_sync
>>>>>                                           - checkpoint
>>>>>                                            - persist inode with incorrect zero isize
>>>>>
>>>>>     - set_inode_flag(inode, FI_ATOMIC_FILE)
>>>>>
>>>>> Am I missing something?
>>>>>
>>>>
>>>> So, f2fs_mark_inode_dirty_sync() will not work for atomic files
>>>> anymore, which means it doesn't make the inode dirty.
>>>> Plz, refer to the first patch of this patchset. Or I might be confused
>>>> with something. :(
>>>
>>> I mean FI_ATOMIC_FILE was set after f2fs_i_size_write(), so inode will be set
>>> as dirty.
>>>
>>> Thanks,
>>>
>>
>> Oh, I was confused that f2fs_update_inode() is called in
>> f2fs_mark_inode_dirty_sync().
>> That is called in f2fs_write_inode(). Let me fix this.
> 
> Hmm, I think the issue was already there before my patch.
> So, how about making the inode flushed and clean if the inode is
> already dirty when starting atomic write?

What I mean is:

---
  fs/f2fs/file.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e4b6e51086a3..31b229678b1d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2053,6 +2053,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)

  	isize = i_size_read(inode);
  	fi->original_i_size = isize;
+
+	set_inode_flag(inode, FI_ATOMIC_FILE);
+
  	if (truncate) {
  		set_inode_flag(inode, FI_ATOMIC_REPLACE);
  		truncate_inode_pages_final(inode->i_mapping);
@@ -2063,7 +2066,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)

  	stat_inc_atomic_inode(inode);

-	set_inode_flag(inode, FI_ATOMIC_FILE);
  	set_inode_flag(fi->cow_inode, FI_COW_FILE);
  	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
  	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 


Let's set FI_ATOMIC_FILE flag before f2fs_i_size_write(inode, 0), so
- f2fs_ioc_start_atomic_write
  - f2fs_i_size_write(, 0)
   - f2fs_mark_inode_dirty_sync
    check f2fs_is_atomic_file() and return correctly.

And for the case the inode is dirty before f2fs_i_size_write(, 0), we
can call f2fs_write_inode() to flush dirty feilds into inode page, and
make inode clean.

> 
>>
>> Thanks,
