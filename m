Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED038668E83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjAMG4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjAMGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:55:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3071886;
        Thu, 12 Jan 2023 22:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qYlLrpZOeX0XDRGr7kUV2sDy+3wC/neWYtjmMseCmbA=; b=aOoXaKioV5ANGM42lam5GuMhwA
        PJ5Z+BgGV0hcRGIRmkcWLEhlBJtJjL0trfcnDdg23zb8CpQTtUMn0zNP/plpyzGI/a8zITjY4Spur
        lSAzDDQQdr9kCxrM7SX/lpXO1EycAe8+K8ylXFcsqYfKGnA+gs54VPdKeMWxVybL5t4VUHVS1gFln
        dbF94339Iszf8gtLuHBCbMPtNsbF13kxVqm+cmzMzi7rNruEtWZ0ZbFS3fVKOlWwvlfEtRImwYBma
        w0wRHytA3q1tRsutPwPqXwhuwGrUqSIEbPuqi8vG+SZ3dTRAqLQnxMxSq+We/ZpwqJi1rFzXgIDR2
        NuUs6t8A==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDkT-000qpl-AY; Fri, 13 Jan 2023 06:41:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: ili922x: fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:41:08 -0800
Message-Id: <20230113064108.29172-1-rdunlap@infradead.org>
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

Convert comments for START_BYTE() and CHECK_FREQ_REG() macros into
kernel-doc notation to avoid these kernel-doc warnings:

drivers/video/backlight/ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * START_BYTE(id, rs, rw)
drivers/video/backlight/ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/ili922x.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -- a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -82,13 +82,7 @@
 #define START_RW_READ		1
 
 /**
- * START_BYTE(id, rs, rw)
- *
- * Set the start byte according to the required operation.
- * The start byte is defined as:
- *   ----------------------------------
- *  | 0 | 1 | 1 | 1 | 0 | ID | RS | RW |
- *   ----------------------------------
+ * START_BYTE - Set the start byte according to the required operation.
  * @id: display's id as set by the manufacturer
  * @rs: operation type bit, one of:
  *	  - START_RS_INDEX	set the index register
@@ -96,19 +90,25 @@
  * @rw: read/write operation
  *	 - START_RW_WRITE	write
  *	 - START_RW_READ	read
+ *
+ * The start byte is defined as:
+ *   ----------------------------------
+ *  | 0 | 1 | 1 | 1 | 0 | ID | RS | RW |
+ *   ----------------------------------
  */
 #define START_BYTE(id, rs, rw)	\
 	(0x70 | (((id) & 0x01) << 2) | (((rs) & 0x01) << 1) | ((rw) & 0x01))
 
 /**
- * CHECK_FREQ_REG(spi_device s, spi_transfer x) - Check the frequency
- *	for the SPI transfer. According to the datasheet, the controller
- *	accept higher frequency for the GRAM transfer, but it requires
+ * CHECK_FREQ_REG - Check the frequency for the SPI transfer.
+ * @s: pointer to an SPI device
+ * @x: pointer to the spi_transfer spec (for read/write buffer pair)
+ *
+ *	According to the datasheet, the controller
+ *	accepts a higher frequency for the GRAM transfer, but it requires
  *	lower frequency when the registers are read/written.
  *	The macro sets the frequency in the spi_transfer structure if
  *	the frequency exceeds the maximum value.
- * @s: pointer to an SPI device
- * @x: pointer to the read/write buffer pair
  */
 #define CHECK_FREQ_REG(s, x)	\
 	do {			\
