Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81E6DE9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDLDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLDHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:07:40 -0400
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591110C3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:07:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---.SDT3N6j_1681268853;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SDT3N6j_1681268853)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:07:34 +0800
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>,
        "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v1 0/3] correct printing for rq->nr_uninterruptible and some updates
Date:   Wed, 12 Apr 2023 11:07:28 +0800
Message-Id: <20230412030731.24990-1-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 1/3 coverts rq->nr_uninterruptible type from unsigned int to int
that prints negative numbers correctly. The rest patches are some little updates,
including updating the descriptions of commments, removing duplicate included headers.

Yan Yan (3):
  sched/debug: use int type and fix wrong print for
    rq->nr_uninterruptible
  sched/debug: update description of print
  sched: remove duplicate included headers psi.h

 kernel/sched/build_utility.c | 1 -
 kernel/sched/debug.c         | 4 ++--
 kernel/sched/loadavg.c       | 2 +-
 kernel/sched/sched.h         | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.32.0.3.g01195cf9f

