Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46C612205
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ2Jx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Jx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:53:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1A43AC7;
        Sat, 29 Oct 2022 02:53:57 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mzvkl5P18zVjHB;
        Sat, 29 Oct 2022 17:49:03 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:53:55 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 17:53:55 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH 0/3] crypto: hisilicon/qm - reconstruct and optimize the debugfs code
Date:   Sat, 29 Oct 2022 09:47:58 +0000
Message-ID: <20221029094801.43843-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Kai Ye (3):
  crypto: hisilicon/qm - modify the process of regs dfx
  crypto: hisilicon/qm - split a debugfs.c from qm
  crypto: hisilicon/qm - the command dump process is modified

 drivers/crypto/hisilicon/Makefile         |    2 +-
 drivers/crypto/hisilicon/debugfs.c        | 1173 ++++++++++++++++++
 drivers/crypto/hisilicon/hpre/hpre_main.c |    6 +-
 drivers/crypto/hisilicon/qm.c             | 1360 ++-------------------
 drivers/crypto/hisilicon/qm_common.h      |   87 ++
 drivers/crypto/hisilicon/sec2/sec_main.c  |    6 +-
 drivers/crypto/hisilicon/zip/zip_main.c   |    6 +-
 include/linux/hisi_acc_qm.h               |    8 +-
 8 files changed, 1382 insertions(+), 1266 deletions(-)
 create mode 100644 drivers/crypto/hisilicon/debugfs.c
 create mode 100644 drivers/crypto/hisilicon/qm_common.h

-- 
2.17.1

