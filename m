Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32360087A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJQINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJQINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:13:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1E5C947
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:13:36 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrV4h2MnPz1P6mv;
        Mon, 17 Oct 2022 16:08:52 +0800 (CST)
Received: from huawei.com (10.44.134.232) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 16:13:03 +0800
From:   y00318929 <yeyunfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yeyunfeng@huawei.com>
Subject: [PATCH 0/5] Support ASID Isolation mechanism
Date:   Mon, 17 Oct 2022 16:12:53 +0800
Message-ID: <20221017081258.3678830-1-yeyunfeng@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.134.232]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches introduce an ASID Isolation mechanism to improve
isolation.

Patch 1-3: Prepare for supporting ASID Isolation mechanism. 

Patch 4: Detailed Description and Implementation of ASID Isolation
mechanism.

Patch 5: This patch is used to observe the TLB flush information.

Yunfeng Ye (5):
  arm64: mm: Define asid_bitmap structure for pinned_asid
  arm64: mm: Extract the processing of asid_generation
  arm64: mm: Use cpumask in flush_context()
  arm64: mm: Support ASID isolation feature
  arm64: mm: Add TLB flush trace on context switch

 arch/arm64/mm/context.c | 286 ++++++++++++++++++++++++++++++++++------
 1 file changed, 247 insertions(+), 39 deletions(-)

-- 
2.27.0

