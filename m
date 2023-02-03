Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD80F688F26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBCFzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:55:53 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B966012
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:55:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VandA8f_1675403748;
Received: from 30.221.129.149(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VandA8f_1675403748)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 13:55:49 +0800
Message-ID: <9d14321a-2406-df05-0401-699547c1b12d@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 13:55:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] erofs: call erofs_map_dev() inside erofs_map_blocks()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
 <20230203035303.35082-4-jefflexu@linux.alibaba.com>
 <cc67566e-6b49-c351-b8e7-9c842df8325e@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <cc67566e-6b49-c351-b8e7-9c842df8325e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/23 1:52 PM, Gao Xiang wrote:
> 
> 
> On 2023/2/3 11:53, Jingbo Xu wrote:
>> For now erofs_map_blocks() is always followed by erofs_map_dev().
>> Make erofs_map_dev() called inside erofs_map_blocks() to reduce code
>> duplication.
> 
> Could we just integrate mdev into struct erofs_map_blocks?

Okay I will give it a try.


> 
> BTW, I still think erofs_map_dev() is useful since it can handle
> non-inode IO requests, so let's keep this rather than mergeing all
> code into erofs_map_blocks()

Yeah erofs_map_dev() is kept as a separated function API.


-- 
Thanks,
Jingbo
