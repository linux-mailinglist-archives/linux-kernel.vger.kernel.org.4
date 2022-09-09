Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215E05B3470
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIIJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIIJtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D834766C;
        Fri,  9 Sep 2022 02:49:44 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPB1L6qJWzZcP9;
        Fri,  9 Sep 2022 17:45:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:42 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:41 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 00/10] crypto: hisilicon - support get device information from registers
Date:   Fri, 9 Sep 2022 17:46:54 +0800
Message-ID: <20220909094704.32099-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports obtaining device information from
device registers, including the supported algorithms,
device features, and so on.

Weili Qian (6):
  crypto: hisilicon/qm - get hardware features from hardware registers
  crypto: hisilicon/qm - get qp num and depth from hardware registers
  crypto: hisilicon/qm - add UACCE_CMD_QM_SET_QP_INFO support
  crypto: hisilicon/qm - get error type from hardware registers
  crypto: hisilicon/qm - support get device irq information from
    hardware registers
  crypto: hisilicon/zip - support zip capability

Wenkai Lin (1):
  crypto: hisilicon/sec - get algorithm bitmap from registers

Zhiqi Song (3):
  crypto: hisilicon/hpre - support hpre capability
  crypto: hisilicon/hpre - optimize registration of ecdh
  crypto: hisilicon - support get algs by the capability register

 drivers/crypto/hisilicon/hpre/hpre.h        |   8 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 250 ++++---
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 208 +++++-
 drivers/crypto/hisilicon/qm.c               | 765 +++++++++++++-------
 drivers/crypto/hisilicon/sec2/sec.h         |  34 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 454 +++++++-----
 drivers/crypto/hisilicon/sec2/sec_main.c    | 160 +++-
 drivers/crypto/hisilicon/zip/zip.h          |   1 +
 drivers/crypto/hisilicon/zip/zip_crypto.c   |  73 +-
 drivers/crypto/hisilicon/zip/zip_main.c     | 256 +++++--
 include/linux/hisi_acc_qm.h                 |  63 +-
 include/uapi/misc/uacce/hisi_qm.h           |  17 +-
 12 files changed, 1589 insertions(+), 700 deletions(-)

-- 
2.33.0

