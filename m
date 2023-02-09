Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2A69003E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBIGOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBIGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:14:33 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F521A07
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:14:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEsIZ9_1675923266;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEsIZ9_1675923266)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:14:27 +0800
Message-ID: <d18fbe06-fec1-2d9a-169e-145fd5ae7c79@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 14:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/4] erofs: relinquish volume with mutex held
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
 <20230209051838.33297-4-jefflexu@linux.alibaba.com>
 <fcb92d78-fc5a-8f51-8a1b-75fd878cf8a1@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <fcb92d78-fc5a-8f51-8a1b-75fd878cf8a1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 2:06 PM, Gao Xiang wrote:
> 
> 
> On 2023/2/9 13:18, Jingbo Xu wrote:
>> Relinquish fscache volume with mutex held.  Otherwise if a new domain is
>> registered when the old domain with the same name gets removed from the
>> list but not relinquished yet, fscache may complain the collision.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> 
> Do we need to backport this to old kernels?
> IOWs, whether "Fixes:" tag is needed?

Yeah the small fix is appropriate for being backported.

Fixes: 8b7adf1dff3d ("erofs: introduce fscache-based domain")

I will add the "Fixes" tag in the next version.


-- 
Thanks,
Jingbo
