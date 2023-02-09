Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588356908FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBIMhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBIMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:37:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2557758;
        Thu,  9 Feb 2023 04:36:58 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PCGXM29n6z16NXm;
        Thu,  9 Feb 2023 20:34:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 20:36:55 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 0/5] crypto: hisilicon/qm - some fixes and cleanups
Date:   Thu, 9 Feb 2023 20:36:12 +0800
Message-ID: <20230209123617.30545-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix and clean up some issues in qm.c and sgl.c.

v1 -> v2:
- Instead of changing the data type in min_t(),
use min() instead of min_t().

Weili Qian (5):
  crypto: hisilicon/qm - remove some unused defines
  crypto: hisilicon/qm - use min() instead of min_t()
  crypto: hisilicon/qm - change function names
  crypto: hisilicon/qm - update comments to match function
  crypto: hisilicon/qm - fix coding style issues

 drivers/crypto/hisilicon/qm.c  | 54 ++++++++++++----------------------
 drivers/crypto/hisilicon/sgl.c |  1 -
 include/linux/hisi_acc_qm.h    |  5 ++--
 3 files changed, 21 insertions(+), 39 deletions(-)

-- 
2.33.0

