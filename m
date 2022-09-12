Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375FD5B5752
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiILJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiILJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:41:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9532051;
        Mon, 12 Sep 2022 02:41:26 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MR1lJ1trdzHnc9;
        Mon, 12 Sep 2022 17:39:24 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 12 Sep
 2022 17:41:23 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next 1/2] Kconfig: remove unused argment 'ch'
Date:   Mon, 12 Sep 2022 17:48:37 +0800
Message-ID: <20220912094838.2398580-2-zengheng4@huawei.com>
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

Remove unused argment 'ch' in sym_set_choice_value

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 scripts/kconfig/conf.c | 2 +-
 scripts/kconfig/lkc.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 4178065ca27f..635265a18a07 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -551,7 +551,7 @@ static int conf_choice(struct menu *menu)
 			print_help(child);
 			continue;
 		}
-		sym_set_choice_value(sym, child->sym);
+		sym_set_choice_value(child->sym);
 		for (child = child->list; child; child = child->next) {
 			indent += 2;
 			conf(child);
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index fa8c010aa683..279d56a44136 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -124,7 +124,7 @@ static inline struct symbol *sym_get_choice_value(struct symbol *sym)
 	return (struct symbol *)sym->curr.val;
 }
 
-static inline bool sym_set_choice_value(struct symbol *ch, struct symbol *chval)
+static inline bool sym_set_choice_value(struct symbol *chval)
 {
 	return sym_set_tristate_value(chval, yes);
 }
-- 
2.25.1

