Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7566DC556
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDJJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:47:52 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8155BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:47:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vfl5d6x_1681120056;
Received: from 30.97.49.25(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfl5d6x_1681120056)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 17:47:38 +0800
Message-ID: <1142fe0c-4464-8735-1d49-9b21c0774303@linux.alibaba.com>
Date:   Mon, 10 Apr 2023 17:47:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [syzbot] [erofs?] BUG: spinlock bad magic in
 erofs_pcpubuf_growsize
To:     syzbot <syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000de8f6a05f8f834e5@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000de8f6a05f8f834e5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/10 17:43, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         09a9639e Linux 6.3-rc6
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc39abc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c47e989e3f0f1947
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6a0e4b80bd39f54c2f6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

#syz invalid
