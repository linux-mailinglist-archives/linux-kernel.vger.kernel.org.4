Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02AB5F020A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiI3A6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3A57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:57:59 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CC17F554
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:57:57 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id YZJ00049;
        Fri, 30 Sep 2022 08:57:49 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 30 Sep 2022 08:57:53 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <martyn@welchs.me.uk>, <manohar.vanga@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] vme: fix the typo
Date:   Tue, 27 Sep 2022 15:21:02 -0400
Message-ID: <20220927192102.8623-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022930085749e3d034e8e7bb5e2c10667cf3b02fb6fb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the typo of the enty.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index b5555683a069..d9c64c60ccc0 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1090,7 +1090,7 @@ void vme_dma_free_attribute(struct vme_dma_attr *attributes)
 EXPORT_SYMBOL(vme_dma_free_attribute);
 
 /**
- * vme_dma_list_add - Add enty to a VME DMA list.
+ * vme_dma_list_add - Add entry to a VME DMA list.
  * @list: Pointer to VME list.
  * @src: Pointer to DMA list attribute to use as source.
  * @dest: Pointer to DMA list attribute to use as destination.
-- 
2.27.0

