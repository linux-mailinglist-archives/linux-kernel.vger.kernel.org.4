Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153D626673
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiKLCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiKLCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:19:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B52F390;
        Fri, 11 Nov 2022 18:19:06 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8K1X6qsXzJnfs;
        Sat, 12 Nov 2022 10:16:00 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:19:05 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 10:19:04 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH v3 0/4] crypto: hisilicon/qm - reconstruct and optimize the debugfs code
Date:   Sat, 12 Nov 2022 02:12:49 +0000
Message-ID: <20221112021253.34862-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split a debugfs.c from qm to reduce the qm code complexity. And optimize the
process of the command dumping. Some optimizations on command dumping in
debugfs.c file code.

changes v1->v2:
	- delete a redundant line.
changes v2->v3:
	- adjusting the patch sequence. modify a comment.

Kai Ye (4):
  crypto: hisilicon/qm - delete redundant null assignment operations
  crypto: hisilicon/qm - modify the process of regs dfx
  crypto: hisilicon/qm - split a debugfs.c from qm
  crypto: hisilicon/qm - the command dump process is modified

 drivers/crypto/hisilicon/Makefile         |    2 +-
 drivers/crypto/hisilicon/debugfs.c        | 1147 +++++++++++++++++
 drivers/crypto/hisilicon/hpre/hpre_main.c |    7 +-
 drivers/crypto/hisilicon/qm.c             | 1360 ++-------------------
 drivers/crypto/hisilicon/qm_common.h      |   87 ++
 drivers/crypto/hisilicon/sec2/sec_main.c  |    7 +-
 drivers/crypto/hisilicon/zip/zip_main.c   |    7 +-
 include/linux/hisi_acc_qm.h               |    8 +-
 8 files changed, 1356 insertions(+), 1269 deletions(-)
 create mode 100644 drivers/crypto/hisilicon/debugfs.c
 create mode 100644 drivers/crypto/hisilicon/qm_common.h

-- 
2.17.1

