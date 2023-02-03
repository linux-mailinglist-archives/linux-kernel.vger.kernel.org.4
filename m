Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D7688E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBCDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBCDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:53:07 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1D233CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:53:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VanENqE_1675396383;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VanENqE_1675396383)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:53:03 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] erofs: cleanup for erofs_map_blocks()
Date:   Fri,  3 Feb 2023 11:53:00 +0800
Message-Id: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jingbo Xu (3):
  erofs: add print symbols for various flags in trace
  erofs: remove unused flags parameter of erofs_map_blocks()
  erofs: call erofs_map_dev() inside erofs_map_blocks()

 fs/erofs/data.c              | 31 ++++++++++++++-----------------
 fs/erofs/fscache.c           | 20 ++------------------
 fs/erofs/internal.h          |  6 +++---
 include/trace/events/erofs.h | 14 ++++++++++----
 4 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.19.1.6.gb485710b

