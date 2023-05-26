Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0810712E06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjEZUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:15:10 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA55F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:15:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN-8_1685132100;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN-8_1685132100)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:06 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/6] erofs: random cleanups and fixes
Date:   Sat, 27 May 2023 04:14:53 +0800
Message-Id: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

These are some cleanups and fixes for the compressed part I'd like to
aim for the next cycle. I will send several versions if there are more
patches available.  This ongoing cleanup work are also for later folio
adaption.

I've set up a stress test for this patchset at the same time.

Thanks,
Gao Xiang

Gao Xiang (6):
  erofs: allocate extra bvec pages directly instead of retrying
  erofs: avoid on-stack pagepool directly passed by arguments
  erofs: kill hooked chains to avoid loops on deduplicated compressed
    images
  erofs: adapt managed inode operations into folios
  erofs: use struct lockref to replace handcrafted approach
  erofs: use poison pointer to replace the hard-coded address

 fs/erofs/internal.h |  41 +-------
 fs/erofs/super.c    |  62 ------------
 fs/erofs/utils.c    |  87 ++++++++--------
 fs/erofs/zdata.c    | 238 ++++++++++++++++++++------------------------
 4 files changed, 156 insertions(+), 272 deletions(-)

-- 
2.24.4

