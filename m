Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81A645446
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLGGyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:54:09 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629B1E701
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:54:06 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id BII00059;
        Wed, 07 Dec 2022 14:53:59 +0800
Received: from localhost.localdomain (10.180.204.101) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 14:53:59 +0800
From:   wangchuanlei <wangchuanlei@inspur.com>
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <aik@ozlabs.ru>
CC:     <wangpeihui@inspur.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        wangchuanlei <wangchuanlei@inspur.com>
Subject: [PATCH] [PATCH net-next] powerpc: iommu: delete redundant row
Date:   Wed, 7 Dec 2022 01:53:55 -0500
Message-ID: <20221207065355.4070022-1-wangchuanlei@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.204.101]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201609.home.langchao.com (10.100.2.9)
tUid:   20221207145359ec80c3b64be1d5aef652dd31f6be9120
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: wangchuanlei <wangchuanlei@inspur.com>
---
 arch/powerpc/kernel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index caebe1431596..dd010a733404 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -953,7 +953,6 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		size = PAGE_ALIGN(size);
 		nio_pages = size >> tbl->it_page_shift;
 		iommu_free(tbl, dma_handle, nio_pages);
-		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
 	}
 }
-- 
2.27.0

