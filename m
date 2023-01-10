Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92242664202
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjAJNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjAJNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:33 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDCFBAD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:36:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZJVlQr_1673357786;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZJVlQr_1673357786)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 21:36:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some small improvements for compaction
Date:   Tue, 10 Jan 2023 21:36:17 +0800
Message-Id: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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

Hi,

When I did some compaction testing, I found some small rooms to improve
as well as some code cleanups. Please help to review. Thanks.

Baolin Wang (5):
  mm: compaction: Remove redundant VM_BUG_ON() in compact_zone()
  mm: compaction: Move list validation into compact_zone()
  mm: compaction: Count the migration scaned pages events for proactive
    compaction
  mm: compaction: Add missing kcompactd wakeup trace event
  mm: compaction: Avoid fragmentation score calculation for empty zones

 mm/compaction.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.27.0

