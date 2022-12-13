Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA35864AEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiLME4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiLME4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:56:41 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B017E13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:56:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=12;SR=0;TI=SMTPD_---0VXCTSqP_1670907394;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXCTSqP_1670907394)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 12:56:36 +0800
Date:   Tue, 13 Dec 2022 12:56:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Hou Tao <houtao1@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
Message-ID: <Y5gGAedWBwMgqjAm@B-P7TQMD6M-0146.local>
References: <Y5TB6E77vbpRMhIk@debian>
 <Y5bRuDiEwUAK1si1@debian>
 <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 08:12:18PM -0800, Linus Torvalds wrote:
> On Sun, Dec 11, 2022 at 11:01 PM Gao Xiang <xiang@kernel.org> wrote:
> >
> > Comparing with the latest -next on the last Thursday, there was one-liner
> > addition  commit 927e5010ff5b ("erofs: use kmap_local_page()
> > only for erofs_bread()") as below:
> [...]
> > Because there is no -next version on Monday, if you would like to
> > take all commits in -next you could take
> >   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1-alt
> 
> No worries. That one-liner isn't a problem, and you sent the pull
> request to me early, so I'm perfectly happy with your original request
> and have pulled it.
> 
> Thanks for being careful,

Thank you, Linus!

Thanks,
Gao Xiang

> 
>                  Linus
