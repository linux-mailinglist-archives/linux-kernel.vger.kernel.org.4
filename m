Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21165B5751
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiILJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiILJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:41:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF3A32052;
        Mon, 12 Sep 2022 02:41:26 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MR1hL45snzNmCF;
        Mon, 12 Sep 2022 17:36:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 12 Sep
 2022 17:41:24 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next 2/2] Kconfig: remove unused function 'menu_get_root_menu'
Date:   Mon, 12 Sep 2022 17:48:38 +0800
Message-ID: <20220912094838.2398580-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912094838.2398580-1-zengheng4@huawei.com>
References: <20220912094838.2398580-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nowhere calling `menu_get_root_menu` function,
so remove it.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 scripts/kconfig/lkc.h  | 1 -
 scripts/kconfig/menu.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 279d56a44136..a61907686d22 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -98,7 +98,6 @@ bool menu_is_empty(struct menu *menu);
 bool menu_is_visible(struct menu *menu);
 bool menu_has_prompt(struct menu *menu);
 const char *menu_get_prompt(struct menu *menu);
-struct menu *menu_get_root_menu(struct menu *menu);
 struct menu *menu_get_parent_menu(struct menu *menu);
 bool menu_has_help(struct menu *menu);
 const char *menu_get_help(struct menu *menu);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 3d6f7cba8846..62b6313f51c8 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -661,11 +661,6 @@ const char *menu_get_prompt(struct menu *menu)
 	return NULL;
 }
 
-struct menu *menu_get_root_menu(struct menu *menu)
-{
-	return &rootmenu;
-}
-
 struct menu *menu_get_parent_menu(struct menu *menu)
 {
 	enum prop_type type;
-- 
2.25.1

