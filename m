Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910263724B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKXGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:19:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D549372C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=P23NM4nqAWcCFp4nIBC+iBFsGGXl6v5G4NOLEXdr/Fo=; b=ALEa6F/KeLi9otJnpTEIXidIiY
        BFrnoWsAtTXugJqm+QRWGfg9/rmGmGBu/LbDgTioAVHHxH7fJDhZH35Gm4pyekz7M8+ErAUzlM7bz
        ufs3lnyNUorX6063iEGamdHk5TXDnowAkWn1qbcvt0RE0FBxE6haf0IUhO165E3eAyAiAN6vHr6su
        v3ROavVTG594onRGtOezIurHgM4IjcxYilnTs1MZMWmU7W2Gpg1abgB8KM+g7OUxjVGiniJH4IGV5
        c45CFGDxaDagLvx+PsEUMyYX4zjFcozktjd4Al17U1CUS9RQSKenqP2ceJXmmvlDmzI0hBm0mal4E
        BtrwWUTQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy5a6-008RmS-7B; Thu, 24 Nov 2022 06:19:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        John Bonesio <bones@secretlab.ca>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/mpc52xx_lpbfifo: fix all kernel-doc warnings
Date:   Wed, 23 Nov 2022 22:19:18 -0800
Message-Id: <20221124061918.1967-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

Fix multiple kernel-doc warnings in mpc52xx_lpbfifo.c:

arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c:377: warning: expecting prototype for mpc52xx_lpbfifo_bcom_poll(). Prototype was for mpc52xx_lpbfifo_poll() instead

mpc52xx_lpbfifo.c:221: warning: No description found for return value of 'mpc52xx_lpbfifo_irq'
mpc52xx_lpbfifo.c:327: warning: No description found for return value of 'mpc52xx_lpbfifo_bcom_irq'
mpc52xx_lpbfifo.c:398: warning: No description found for return value of 'mpc52xx_lpbfifo_submit'

mpc52xx_lpbfifo.c:64: warning: Function parameter or member 'req' not described in 'mpc52xx_lpbfifo_kick'
mpc52xx_lpbfifo.c:220: warning: contents before sections
mpc52xx_lpbfifo.c:223: warning: Function parameter or member 'irq' not described in 'mpc52xx_lpbfifo_irq'
mpc52xx_lpbfifo.c:223: warning: Function parameter or member 'dev_id' not described in 'mpc52xx_lpbfifo_irq'
mpc52xx_lpbfifo.c:328: warning: contents before sections
mpc52xx_lpbfifo.c:331: warning: Function parameter or member 'irq' not described in 'mpc52xx_lpbfifo_bcom_irq'
mpc52xx_lpbfifo.c:331: warning: Function parameter or member 'dev_id' not described in 'mpc52xx_lpbfifo_bcom_irq'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: John Bonesio <bones@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff -- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -59,6 +59,8 @@ static struct mpc52xx_lpbfifo lpbfifo;
 
 /**
  * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transferred
+ *
+ * @req: Pointer to request structure
  */
 static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
 {
@@ -178,6 +180,8 @@ static void mpc52xx_lpbfifo_kick(struct
 
 /**
  * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
+ * @irq: IRQ number to be handled
+ * @dev_id: device ID cookie
  *
  * On transmit, the dma completion irq triggers before the fifo completion
  * triggers.  Handle the dma completion here instead of the LPB FIFO Bestcomm
@@ -216,6 +220,8 @@ static void mpc52xx_lpbfifo_kick(struct
  * or nested spinlock condition.  The out path is non-trivial, so
  * extra fiddling is done to make sure all paths lead to the same
  * outbound code.
+ *
+ * Return: irqreturn code (%IRQ_HANDLED)
  */
 static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
 {
@@ -320,8 +326,12 @@ static irqreturn_t mpc52xx_lpbfifo_irq(i
 
 /**
  * mpc52xx_lpbfifo_bcom_irq - IRQ handler for LPB FIFO Bestcomm task
+ * @irq: IRQ number to be handled
+ * @dev_id: device ID cookie
  *
  * Only used when receiving data.
+ *
+ * Return: irqreturn code (%IRQ_HANDLED)
  */
 static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
 {
@@ -372,7 +382,7 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_
 }
 
 /**
- * mpc52xx_lpbfifo_bcom_poll - Poll for DMA completion
+ * mpc52xx_lpbfifo_poll - Poll for DMA completion
  */
 void mpc52xx_lpbfifo_poll(void)
 {
@@ -393,6 +403,8 @@ EXPORT_SYMBOL(mpc52xx_lpbfifo_poll);
 /**
  * mpc52xx_lpbfifo_submit - Submit an LPB FIFO transfer request.
  * @req: Pointer to request structure
+ *
+ * Return: %0 on success, -errno code on error
  */
 int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
 {
