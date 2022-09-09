Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628655B2F10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiIIGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiIIGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:33:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D0C12FBAB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:33:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP5jL1qdvznVCC;
        Fri,  9 Sep 2022 14:31:02 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:33:37 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <kay.sievers@vrfy.org>, <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: remove make_class_name declaration
Date:   Fri, 9 Sep 2022 14:33:37 +0800
Message-ID: <20220909063337.1146151-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make_class_name has been removed since
commit 39aba963d937 ("driver core: remove CONFIG_SYSFS_DEPRECATED_V2
but keep it for block devices"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/base/base.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b3a43a164dcd..b902d1ecc247 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -154,8 +154,6 @@ extern void driver_remove_groups(struct device_driver *drv,
 				 const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
-extern char *make_class_name(const char *name, struct kobject *kobj);
-
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
-- 
2.25.1

