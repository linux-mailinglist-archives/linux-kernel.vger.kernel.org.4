Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF7688E23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBCDr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCDr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:47:26 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB7721C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:47:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Van-GYb_1675396041;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Van-GYb_1675396041)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:47:21 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] erofs: cleanup for fscache mode
Date:   Fri,  3 Feb 2023 11:47:18 +0800
Message-Id: <20230203034720.24619-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are misc cleanup for fscache mode, while patch 2 is dependent on
the page cache sharing codebase [1].

[1] https://lore.kernel.org/all/20230203030143.73105-1-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  erofs: simplify instantiation of pseudo mount in fscache mode
  erofs: simplify the name collision checking in share domain mode

 fs/erofs/fscache.c  | 84 ++++++++++++++++++++-------------------------
 fs/erofs/internal.h | 15 ++++----
 fs/erofs/super.c    | 37 +++++---------------
 3 files changed, 53 insertions(+), 83 deletions(-)

-- 
2.19.1.6.gb485710b

