Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0D6BE999
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCQMt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCQMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:49:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6116332
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:49:26 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PdP664CHRzHwxW;
        Fri, 17 Mar 2023 20:47:10 +0800 (CST)
Received: from DESKTOP-EJM108K.china.huawei.com (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 20:49:22 +0800
From:   Dongxu Sun <sundongxu3@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Dongxu Sun <sundongxu3@huawei.com>
Subject: [PATCH 0/4] arm64: Use specific checking for TPIDR2 and some comments update
Date:   Fri, 17 Mar 2023 20:49:11 +0800
Message-ID: <20230317124915.1263-1-sundongxu3@huawei.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use system_supports_tpidr2() for TPIDR2 handling.
And this series update some comments for sigcontext and ARM SME.

Dongxu Sun (4):
  arm64/signal: Use system_supports_tpidr2() to check TPIDR2
  arm64/signal: Alloc tpidr2 sigframe after checking
    system_supports_tpidr2()
  arm64/signal: Add tpidr2/za/zt sigframe size in comment
  arm64/sme: Fix some comments of ARM SME

 arch/arm64/include/uapi/asm/sigcontext.h |  5 ++++-
 arch/arm64/kernel/fpsimd.c               |  4 ++--
 arch/arm64/kernel/signal.c               | 18 ++++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.33.0

