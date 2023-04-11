Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296416DD495
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDKHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDKHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:45:18 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E054F4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:45:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfrMJ5S_1681199112;
Received: from 30.97.49.18(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfrMJ5S_1681199112)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 15:45:13 +0800
Message-ID: <9be0b507-4c02-86cb-20d8-052e9c7b97be@linux.alibaba.com>
Date:   Tue, 11 Apr 2023 15:45:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
To:     syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000ebd27d05f8f7f713@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000ebd27d05f8f7f713@google.com>
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



On 2023/4/10 17:26, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: unable to handle kernel paging request in z_erofs_decompress_queue
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/ dev-test
