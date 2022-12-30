Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B27657891
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiL1Owj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiL1OwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:52:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75212090
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:51:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAXmQ-0007hS-EY; Wed, 28 Dec 2022 15:51:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAXmM-002Iu4-K8; Wed, 28 Dec 2022 15:51:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAXmL-008XdM-NC; Wed, 28 Dec 2022 15:51:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mpc52xx_lpbfifo: Drop unused functions
Date:   Wed, 28 Dec 2022 15:51:29 +0100
Message-Id: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qKYoehDSET6RagO3aizGe+M2US4v/dST+TBCb/+4yNw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjrFfsv52FI2ikCUHMgsgLaAukLASh02W1RB+v09UJ hqWzsUKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY6xX7AAKCRDB/BR4rcrsCRlOB/ 9yBrDk6Pta5pW3lBg6K9BD6IWyV8xa31a0sRgq7FAyXkYRD8FOq7CVWc4gNCHFPbtDb87wPSx0JlOx SLRT4iUfpyiuRQokKWKEZXTNKH1Hy71ZX/RlYXa35CRzGpF8RldlhZt6n5Zpu5TPj2Z1fRvgyAWCcT 05j0XhlXnVbmE8DmQFsn9uy5GgJc20QlddJPCmj13mSDyxMH0y0KmXMGrAcOxwW0qcxA9/pvtbLvm0 Wn924wcoVmYQUWDSEfchmsPPS/c/7FLSCB7VNU0XJzKL7qGsTSv3YccA9l9dI3KEeCw93D8gk2c2VM tWbpfTevq0tjLn5tZexgdmUK5S5HWC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The four exported functions mpc52xx_lpbfifo_submit(),
mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll(), and
mpc52xx_lpbfifo_start_xfer() are not used. So they can be dropped and the
definitions needed to call them can be moved into the driver file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/include/asm/mpc52xx.h            |  41 ------
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 134 +++++-------------
 2 files changed, 33 insertions(+), 142 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 5ea16a71c2f0..01ae6c351e50 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -285,47 +285,6 @@ extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 period,
 extern u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt);
 extern int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
 
-/* mpc52xx_lpbfifo.c */
-#define MPC52XX_LPBFIFO_FLAG_READ		(0)
-#define MPC52XX_LPBFIFO_FLAG_WRITE		(1<<0)
-#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT	(1<<1)
-#define MPC52XX_LPBFIFO_FLAG_NO_DMA		(1<<2)
-#define MPC52XX_LPBFIFO_FLAG_POLL_DMA		(1<<3)
-
-struct mpc52xx_lpbfifo_request {
-	struct list_head list;
-
-	/* localplus bus address */
-	unsigned int cs;
-	size_t offset;
-
-	/* Memory address */
-	void *data;
-	phys_addr_t data_phys;
-
-	/* Details of transfer */
-	size_t size;
-	size_t pos;	/* current position of transfer */
-	int flags;
-	int defer_xfer_start;
-
-	/* What to do when finished */
-	void (*callback)(struct mpc52xx_lpbfifo_request *);
-
-	void *priv;		/* Driver private data */
-
-	/* statistics */
-	int irq_count;
-	int irq_ticks;
-	u8 last_byte;
-	int buffer_not_done_cnt;
-};
-
-extern int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
-extern void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req);
-extern void mpc52xx_lpbfifo_poll(void);
-extern int mpc52xx_lpbfifo_start_xfer(struct mpc52xx_lpbfifo_request *req);
-
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 6d1dd6e87478..32fd1345ffeb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -38,6 +38,39 @@ MODULE_LICENSE("GPL");
 #define LPBFIFO_REG_FIFO_CONTROL	(0x48)
 #define LPBFIFO_REG_FIFO_ALARM		(0x4C)
 
+#define MPC52XX_LPBFIFO_FLAG_WRITE		(1<<0)
+#define MPC52XX_LPBFIFO_FLAG_NO_DMA		(1<<2)
+#define MPC52XX_LPBFIFO_FLAG_POLL_DMA		(1<<3)
+
+struct mpc52xx_lpbfifo_request {
+	struct list_head list;
+
+	/* localplus bus address */
+	unsigned int cs;
+	size_t offset;
+
+	/* Memory address */
+	void *data;
+	phys_addr_t data_phys;
+
+	/* Details of transfer */
+	size_t size;
+	size_t pos;	/* current position of transfer */
+	int flags;
+	int defer_xfer_start;
+
+	/* What to do when finished */
+	void (*callback)(struct mpc52xx_lpbfifo_request *);
+
+	void *priv;		/* Driver private data */
+
+	/* statistics */
+	int irq_count;
+	int irq_ticks;
+	u8 last_byte;
+	int buffer_not_done_cnt;
+};
+
 struct mpc52xx_lpbfifo {
 	struct device *dev;
 	phys_addr_t regs_phys;
@@ -381,107 +414,6 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
- * mpc52xx_lpbfifo_poll - Poll for DMA completion
- */
-void mpc52xx_lpbfifo_poll(void)
-{
-	struct mpc52xx_lpbfifo_request *req = lpbfifo.req;
-	int dma = !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
-	int write = req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
-
-	/*
-	 * For more information, see comments on the "Fat Lady" 
-	 */
-	if (dma && write)
-		mpc52xx_lpbfifo_irq(0, NULL);
-	else 
-		mpc52xx_lpbfifo_bcom_irq(0, NULL);
-}
-EXPORT_SYMBOL(mpc52xx_lpbfifo_poll);
-
-/**
- * mpc52xx_lpbfifo_submit - Submit an LPB FIFO transfer request.
- * @req: Pointer to request structure
- *
- * Return: %0 on success, -errno code on error
- */
-int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
-{
-	unsigned long flags;
-
-	if (!lpbfifo.regs)
-		return -ENODEV;
-
-	spin_lock_irqsave(&lpbfifo.lock, flags);
-
-	/* If the req pointer is already set, then a transfer is in progress */
-	if (lpbfifo.req) {
-		spin_unlock_irqrestore(&lpbfifo.lock, flags);
-		return -EBUSY;
-	}
-
-	/* Setup the transfer */
-	lpbfifo.req = req;
-	req->irq_count = 0;
-	req->irq_ticks = 0;
-	req->buffer_not_done_cnt = 0;
-	req->pos = 0;
-
-	mpc52xx_lpbfifo_kick(req);
-	spin_unlock_irqrestore(&lpbfifo.lock, flags);
-	return 0;
-}
-EXPORT_SYMBOL(mpc52xx_lpbfifo_submit);
-
-int mpc52xx_lpbfifo_start_xfer(struct mpc52xx_lpbfifo_request *req)
-{
-	unsigned long flags;
-
-	if (!lpbfifo.regs)
-		return -ENODEV;
-
-	spin_lock_irqsave(&lpbfifo.lock, flags);
-
-	/*
-	 * If the req pointer is already set and a transfer was
-	 * started on submit, then this transfer is in progress
-	 */
-	if (lpbfifo.req && !lpbfifo.req->defer_xfer_start) {
-		spin_unlock_irqrestore(&lpbfifo.lock, flags);
-		return -EBUSY;
-	}
-
-	/*
-	 * If the req was previously submitted but not
-	 * started, start it now
-	 */
-	if (lpbfifo.req && lpbfifo.req == req &&
-	    lpbfifo.req->defer_xfer_start) {
-		out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
-	}
-
-	spin_unlock_irqrestore(&lpbfifo.lock, flags);
-	return 0;
-}
-EXPORT_SYMBOL(mpc52xx_lpbfifo_start_xfer);
-
-void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&lpbfifo.lock, flags);
-	if (lpbfifo.req == req) {
-		/* Put it into reset and clear the state */
-		bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
-		bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
-		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
-		lpbfifo.req = NULL;
-	}
-	spin_unlock_irqrestore(&lpbfifo.lock, flags);
-}
-EXPORT_SYMBOL(mpc52xx_lpbfifo_abort);
-
 static int mpc52xx_lpbfifo_probe(struct platform_device *op)
 {
 	struct resource res;
-- 
2.38.1

