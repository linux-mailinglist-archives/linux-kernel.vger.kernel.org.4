Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85195E715E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIWBZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIWBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:25:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB131176C2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:25:53 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28N1PoNm064633;
        Fri, 23 Sep 2022 10:25:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Fri, 23 Sep 2022 10:25:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28N1PoHS064629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Sep 2022 10:25:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <423b1fa6-10fa-3ff9-52bc-1262643c62d9@I-love.SAKURA.ne.jp>
Date:   Fri, 23 Sep 2022 10:25:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] fs/ntfs3: fix negative shift size in
 true_sectors_per_clst()
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, ntfs3@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
References: <000000000000f8b5ef05dd25b963@google.com>
 <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/23 9:38, Randy Dunlap wrote:
> I slightly prefer the earlier patch:
> 
> https://lore.kernel.org/all/20220823144625.1627736-1-syoshida@redhat.com/
> 
> but it appears that the NTFS3 maintainer is MIA again. :(
> 

Shigeru Yoshida posted a patch against https://syzkaller.appspot.com/bug?extid=35b87c668935bb55e666
and I posted a patch against https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76 .
We didn't realize that these are the same problem.

It seems that sending to not only syzbot+XXXXXXXXXXXXXXXXXXXX@syzkaller.appspotmail.com
but also syzkaller-bugs@googlegroups.com is required for proposed patches to be recorded
(in order to avoid duplicated works) into a page linked from "Status:" in each bug page.

Since https://syzkaller.appspot.com/upstream does not have a column for tracking intermediate
status between "Open" and "Fixed" (e.g. cause identified, patch proposed) because it can take
long time until patches are accepted into one of git trees syzbot is tracking, we need to
utilize "Last activity" in the list page and a page linked from "Status:" in each bug page.
Time to boost priority for implementing user-supplied comment column (e.g. "#syz memo:" command)
to each bug?

