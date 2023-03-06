Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0F6AB8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCFIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCFInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:43:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEB21A1F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:43:23 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVX9V5RTMzKpsJ;
        Mon,  6 Mar 2023 16:41:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 16:43:21 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH -next 0/2] Minor cleanup in PAT
Date:   Mon, 6 Mar 2023 16:43:14 +0800
Message-ID: <20230306084316.2275757-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Patch #1 move follow_phys to memtype.c since only pat use this.
Patch #2 drop the unnecessary WARN_ON_ONCE if follow_phys fails.

Ma Wupeng (2):
  x86/mm/pat: Move follow_phys to pat-related file
  x86/mm/pat: Drop the unnecessary WARN_ON_ONCE if follow_phys fails

 arch/x86/mm/pat/memtype.c | 32 ++++++++++++++++++++++++++------
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 26 insertions(+), 36 deletions(-)

-- 
2.25.1

