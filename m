Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748D6AD4A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCGC03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCGC01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:26:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E2B460B9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:26:12 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVznK2mtQzrSRL;
        Tue,  7 Mar 2023 10:25:25 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 10:26:10 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>, <bp@suse.de>
Subject: [PATCH v2 -next 0/3] Minor cleanup in PAT
Date:   Tue, 7 Mar 2023 10:26:03 +0800
Message-ID: <20230307022606.2367399-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Patch #2 cleanup parameter flags in follow_phys.
Patch #3 drop the unnecessary WARN_ON_ONCE if follow_phys fails.

Changelog since v1:
- split patch #1 into two patches based on Boris's advise

Ma Wupeng (3):
  x86/mm/pat: Move follow_phys to pat-related file
  x86/mm/pat: Cleanup unused parameter in follow_phys
  x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails

 arch/x86/mm/pat/memtype.c | 33 +++++++++++++++++++++++++++------
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 27 insertions(+), 36 deletions(-)

-- 
2.25.1

