Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA99698908
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBPAE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPAE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:04:56 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5F7AA3;
        Wed, 15 Feb 2023 16:04:55 -0800 (PST)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31G04XeN009311;
        Thu, 16 Feb 2023 09:04:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 16 Feb 2023 09:04:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31G04XaZ009270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Feb 2023 09:04:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <052a1585-1958-0d9a-5508-2b3eb41e15fa@I-love.SAKURA.ne.jp>
Date:   Thu, 16 Feb 2023 09:04:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: linux-next: duplicate patch in the ntfs3 tree
Content-Language: en-US
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230216070609.7045e2e1@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230216070609.7045e2e1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/16 5:06, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   fca02f0f400b ("fs/ntfs3: Don't hold ni_lock when calling truncate_setsize()")
> 
> This is commit
> 
>   0226635c304c ("fs/ntfs3: don't hold ni_lock when calling truncate_setsize()")
> 
> in Linus' tree.
> 

Linus directly applied that patch; please drop from ntfs3 tree and pull from linux.git tree.
https://lkml.kernel.org/r/CAHk-=wioYYi=A8r2bXRE9Nvg1FBe-9UV+HB51cGPGwi5d7N_ug@mail.gmail.com

