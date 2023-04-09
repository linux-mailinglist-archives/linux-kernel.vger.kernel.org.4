Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A96DBF8D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDIKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 06:52:29 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5549DE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 03:52:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VfcswfY_1681037541;
Received: from 30.13.186.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfcswfY_1681037541)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 18:52:24 +0800
Message-ID: <013084a3-8a80-9825-66b9-e4bd6674169e@linux.alibaba.com>
Date:   Sun, 9 Apr 2023 18:52:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] erofs: initialize packed inode after root inode is
 assigned
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
 <20230407141710.113882-3-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230407141710.113882-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 22:17, Jingbo Xu wrote:
> As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
> fill_super()"), move the initialization of packed inode after root
> inode is assigned, so that the iput() in .put_super() is adequate as
> the failure handling.
> 
> Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
> fails halfway.
> 

Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")

> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
