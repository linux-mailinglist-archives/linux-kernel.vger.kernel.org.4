Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69A6EB91C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDVMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDVMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B211C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 05:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9576138B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB8AC433EF;
        Sat, 22 Apr 2023 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682165724;
        bh=dLzgToQ+97zNNFKyQ4T4DaBcoPkeYRwGP3sxxYoPM9E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eldrpYS8vH7GeFYeEKT4IhBo9fFMy7vhetIHJvkjuyjRUb365ddyzEQsRkdD7HYWM
         Rko3d3jdLDvUNvOm8zTGkAlRwiw1QsmBVMD0DJaJcPo8XD8iYvUUhkjiX+7ewPkKMY
         y1Sm1eznUkLbw42qZOSsLyke9JjMbuGA2wb8dU8dziT/cnU5znOTp5qE2hiKLOGq6K
         hvIofEQGg00LGGvOA46Odk+jy+LG0Q3NfwH4O2nXj520h9HCC9KBNcmdohYY5LvVDL
         VZqNhey9RMG1yiOoGcYHfR5BAml+cHwHpNRmHszlbATz2dPZyRmrZb9FJUJAcUKYAf
         mGKATj5TgiRww==
Message-ID: <84f8a1d4-a0c6-c618-b3e0-4d0f4d4d5a8d@kernel.org>
Date:   Sat, 22 Apr 2023 20:15:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: remove unnessary comment in __may_age_extent_tree
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230418060954.67585-1-hanqi@vivo.com>
 <b031f528-f3dd-44ed-5370-2133a74f9332@kernel.org>
 <ZELiCve2x31uJFhM@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZELiCve2x31uJFhM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/22 3:20, Jaegeuk Kim wrote:
> On 04/21, Chao Yu wrote:
>> On 2023/4/18 14:09, Qi Han wrote:
>>> This comment make no sense and is in the wrong place, so let's
>>> remove it.
>>>
>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>> ---
>>>    fs/f2fs/extent_cache.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 28b12553f2b3..1f6d7de35794 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -86,7 +86,6 @@ static bool __may_age_extent_tree(struct inode *inode)
>>>    	if (!test_opt(sbi, AGE_EXTENT_CACHE))
>>>    		return false;
>>> -	/* don't cache block age info for cold file */
>>>    	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
>>>    		return false;
>>
>> Should move it here instead of removal?
>>
>> /* don't cache block age info for cold file */
> 
> Not worth to comment this, as the code is exactly saying that.

Correct.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>>>    	if (file_is_cold(inode))
