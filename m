Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498D63859F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKYIz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKYIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:55:26 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765D31F94
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:55:22 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VVefQ1k_1669366518;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVefQ1k_1669366518)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 16:55:20 +0800
Date:   Fri, 25 Nov 2022 16:55:17 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [External] [PATCH] erofs: check the uniqueness of fsid in shared
 domain in advance
Message-ID: <Y4CC9dqtuHEITdlt@B-P7TQMD6M-0146.local>
References: <20221125074057.2229083-1-houtao@huaweicloud.com>
 <49b2b8e4-39d0-983c-23c6-f18232a7dff3@bytedance.com>
 <86bf6991-d46b-be95-06a7-87829e8c5e33@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86bf6991-d46b-be95-06a7-87829e8c5e33@huaweicloud.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tao,

On Fri, Nov 25, 2022 at 04:39:47PM +0800, Hou Tao wrote:
> Hi,
> 
> On 11/25/2022 4:25 PM, Jia Zhu wrote:
> > Hi Tao,
> > We've noticed this warning during development. It seems not a bug, so
> > I ignored that.
> > Many thanks for cacthing and clearing up the annoying warning.
> Yes, it is not a bug. The duplicated mount will fail with -EEXIST even without
> the patch. But it is a bit scary to see such warning in dmesg, so just fix it.

Thanks for the catch.

IMO, a WARN is indeed a bug, we cannot rely on this.

Overall the patch itself looks good to me as well, please help Cc LKML
mailing list as well in v2...

Thanks,
Gao Xiang
