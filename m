Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF868E8C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:15:48 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C922A03
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:15:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbAgGzd_1675840543;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbAgGzd_1675840543)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 15:15:44 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] erofs: cleanup for fscache share domain mode
Date:   Wed,  8 Feb 2023 15:15:43 +0800
Message-Id: <cover.1675840368.git.jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jingbo Xu (4):
  erofs: remove unused device mapping in meta routine
  erofs: maintain cookies of share domain in self-contained list
  erofs: unify anonymous inodes for blob
  erofs: simplify the name collision checking in share domain mode

 fs/erofs/fscache.c  | 163 +++++++++++++++-----------------------------
 fs/erofs/internal.h |  14 ++--
 fs/erofs/super.c    |   4 +-
 3 files changed, 66 insertions(+), 115 deletions(-)

-- 
2.19.1.6.gb485710b

