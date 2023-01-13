Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974066901A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjAMIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjAMIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:07:44 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD674653
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:04:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZU0LP2_1673597071;
Received: from 30.221.130.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZU0LP2_1673597071)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 16:04:31 +0800
Message-ID: <990cc386-cad6-3164-6a13-527bc93f8840@linux.alibaba.com>
Date:   Fri, 13 Jan 2023 16:04:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] erofs: remove linux/buffer_head.h dependency
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
 <20230113065226.68801-2-hsiangkao@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230113065226.68801-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 2:52 PM, Gao Xiang wrote:
> EROFS actually never uses buffer heads, therefore just get rid of
> BH_xxx definitions and linux/buffer_head.h inclusive.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
