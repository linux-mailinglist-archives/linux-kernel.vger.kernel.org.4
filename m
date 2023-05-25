Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9683F710C73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjEYMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjEYMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:18 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7635189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSMoT4_1685019250;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSMoT4_1685019250)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:11 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Misc cleanups and improvements for compaction
Date:   Thu, 25 May 2023 20:53:55 +0800
Message-Id: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series cantains some cleanups and improvements for compaction.
Please help to review. Thanks.

Baolin Wang (6):
  mm: compaction: drop the redundant page validation in
    update_pageblock_skip()
  mm: compaction: change fast_isolate_freepages() to void type
  mm: compaction: skip more fully scanned pageblock
  mm: compaction: only set skip flag if cc->no_set_skip_hint is false
  mm: compaction: add trace event for fast freepages isolation
  mm: compaction: skip fast freepages isolation if enough freepages are
    isolated

 include/trace/events/compaction.h | 11 +++++++++++
 mm/compaction.c                   | 25 ++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.27.0

