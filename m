Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA66B8909
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCNDib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCNDiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:38:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0C187
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:38:22 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PbK0W1xCBzSlRQ;
        Tue, 14 Mar 2023 11:35:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 11:38:19 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <vishal.moola@gmail.com>,
        <sidhartha.kumar@oracle.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 0/3] userfaultfd: convert userfaultfd functions to use folios
Date:   Tue, 14 Mar 2023 03:37:31 +0000
Message-ID: <20230314033734.481904-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts several userfaultfd functions to use folios.
And this series pass the userfaultfd selftests and the LTP userfaultfd
test cases.

ZhangPeng (3):
  userfaultfd: convert mcopy_atomic_pte() to use a folio
  userfaultfd: convert __mcopy_atomic_hugetlb() to use a folio
  userfaultfd: convert __mcopy_atomic() to use a folio

 include/linux/hugetlb.h  |  4 +--
 include/linux/mm.h       |  3 +-
 include/linux/shmem_fs.h |  2 +-
 mm/hugetlb.c             | 25 +++++++-------
 mm/memory.c              | 18 +++++-----
 mm/shmem.c               | 17 +++++----
 mm/userfaultfd.c         | 74 +++++++++++++++++++---------------------
 7 files changed, 70 insertions(+), 73 deletions(-)

-- 
2.25.1

