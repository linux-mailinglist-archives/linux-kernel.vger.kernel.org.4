Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE75E9DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiIZJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiIZJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:32:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E01DF18;
        Mon, 26 Sep 2022 02:31:02 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbcpG5f0Wz1P6rp;
        Mon, 26 Sep 2022 17:26:46 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 17:30:59 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] crypto: ccp: Add __init/__exit annotations to module init/exit funcs
Date:   Mon, 26 Sep 2022 17:27:11 +0800
Message-ID: <20220926092711.1192679-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/crypto/ccp/ccp-crypto-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-main.c b/drivers/crypto/ccp/ccp-crypto-main.c
index 5976530c00a8..332181027305 100644
--- a/drivers/crypto/ccp/ccp-crypto-main.c
+++ b/drivers/crypto/ccp/ccp-crypto-main.c
@@ -400,7 +400,7 @@ static void ccp_unregister_algs(void)
 	}
 }
 
-static int ccp_crypto_init(void)
+static int __init ccp_crypto_init(void)
 {
 	int ret;
 
@@ -421,7 +421,7 @@ static int ccp_crypto_init(void)
 	return ret;
 }
 
-static void ccp_crypto_exit(void)
+static void __exit ccp_crypto_exit(void)
 {
 	ccp_unregister_algs();
 }
-- 
2.25.1

