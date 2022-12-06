Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F4643AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLFBxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiLFBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:53:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2658822BEF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:53:32 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NR3Hj5n09zqSwd;
        Tue,  6 Dec 2022 09:49:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 09:53:30 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <martyn@welchs.me.uk>,
        <manohar.vanga@gmail.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>
Subject: [PATCH -next] vme: Use root_device_register() not underlined version
Date:   Tue, 6 Dec 2022 09:50:33 +0800
Message-ID: <20221206015033.125827-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root_device_register and __root_device_register have exactly same
effect. Use the not underlined version to keep usage consistency.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/staging/vme_user/vme_fake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 1ee432c223e2..0b6a91125846 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1072,7 +1072,7 @@ static int __init fake_init(void)
 	struct vme_lm_resource *lm;
 
 	/* We need a fake parent device */
-	vme_root = __root_device_register("vme", THIS_MODULE);
+	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
 		return PTR_ERR(vme_root);
 
-- 
2.17.1

