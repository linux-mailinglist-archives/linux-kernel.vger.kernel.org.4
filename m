Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDF668E72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjAMG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjAMGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FA1AA2C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XxVuLEsDnNeCVqCNDUx6jgxAKgdO3WfhmffAPm4BOTo=; b=NQPnhOFt9I9tCk9x9p9WeT9sSt
        qz5swIDLn3n51P3rG+w3Gp3LsNnDCLB1u8aoJVCA5NZxWbcZlCDVYWcqSyACW7ooVuvBYmeyQghoz
        wb6r59d7JBxfORRWk4yBdWc7mkY63Vo7sXcBPQCJRB+zL7gGixMSO0r/0zxTAmEarFb+KsyqOwhX0
        zIXMVOGfv5+P+xf/dbb2+tDniQSSg+L8cijP2PwZkcazwejG0RVF3JrueOaGsh1y0TiHP1Qg6xYEx
        MMABFlrZVn2LBCrh3xwRBYibnPp9cOqVGQy8Gux61ANazD/9kEfUNktZXf6p/Uaot86qR4r1wlN6V
        khBYC3lQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDjR-000qZP-4T; Fri, 13 Jan 2023 06:40:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stefan Agner <stefan@agner.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: rawnand: vf610_nfc: use regular comments for functions
Date:   Thu, 12 Jan 2023 22:40:04 -0800
Message-Id: <20230113064004.24391-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These comments are not quite in kernel-doc format and they don't need
to be, so just use "/*" comment markers for them. This prevents these
kernel-doc warnings:

drivers/mtd/nand/raw/vf610_nfc.c:210: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Read accessor for internal SRAM buffer
drivers/mtd/nand/raw/vf610_nfc.c:245: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Write accessor for internal SRAM buffer

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/nand/raw/vf610_nfc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -206,7 +206,7 @@ static inline bool vf610_nfc_kernel_is_l
 #endif
 }
 
-/**
+/*
  * Read accessor for internal SRAM buffer
  * @dst: destination address in regular memory
  * @src: source address in SRAM buffer
@@ -241,7 +241,7 @@ static inline void vf610_nfc_rd_from_sra
 	}
 }
 
-/**
+/*
  * Write accessor for internal SRAM buffer
  * @dst: destination address in SRAM buffer
  * @src: source address in regular memory
