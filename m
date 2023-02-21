Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8969DCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjBUJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjBUJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:17:26 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B607449A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:17:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcBkPmn_1676971039;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcBkPmn_1676971039)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 17:17:20 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, zhujia.zj@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] erofs: remove the constraint of 4KB blksize for fscache mode
Date:   Tue, 21 Feb 2023 17:17:17 +0800
Message-Id: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
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

Make erofs in fscache mode support PAGE_SIZE larger than 4KB.  After
that we can remove the constraint of 4KB blksize for fscache mode.

This relies on some improvement to fscache/cachefiles sent soon.

Jingbo Xu (2):
  erofs: pass accurate blob size to prepare_ondemand_read()
  erofs: set blksize to on-disk blksize for fscache mode

 fs/erofs/fscache.c | 13 +++++++++++--
 fs/erofs/super.c   | 38 ++++++++++++++++++++------------------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.19.1.6.gb485710b

