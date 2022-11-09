Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D796222C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKIDtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKIDtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A529132
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:45 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221109034942epoutp04e443040996b0eae0f816e57a05f4d401~lzgq7Rtaq0168001680epoutp04N
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221109034942epoutp04e443040996b0eae0f816e57a05f4d401~lzgq7Rtaq0168001680epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965782;
        bh=qOib3BVPcMVZWc5FY4R1ETlHc0yz4FOvS4esJiu92sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XebSOG0IhVk1i315rEeYTg20EzIT/uiZqPMpVBP6nUyfhnVNE8tPyank6SfG1YOZZ
         fKOQxr6ivFVygqMDDYujPf9AQ7vEtPpZ1k/qOkBgETZT8lHgTeEErdZnXLdQOjupbw
         9LcI38+ELAgtTGuXlZm9JhBcWD9xbcS6TMASTrjM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221109034941epcas5p28347ea4764de74c791d2a40e9e1ddc4d~lzgqG8tIq3004330043epcas5p2k;
        Wed,  9 Nov 2022 03:49:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N6WDx2QZ7z4x9Pp; Wed,  9 Nov
        2022 03:49:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.1B.56352.F432B636; Wed,  9 Nov 2022 12:49:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221109034703epcas5p3462fab543f9a9f5159476b7d5eadfbfd~lzeWiD5WI0296002960epcas5p3m;
        Wed,  9 Nov 2022 03:47:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221109034703epsmtrp2745436c2f2c5cc1f66922e45d136138e~lzeWgcw6m1855418554epsmtrp2C;
        Wed,  9 Nov 2022 03:47:03 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-a6-636b234f5ba8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.18.18644.6B22B636; Wed,  9 Nov 2022 12:47:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034659epsmtip1a3fa99edd6a35fb64f81b4f317e3adda~lzeTWaEuD0103101031epsmtip1w;
        Wed,  9 Nov 2022 03:46:59 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [PATCH 2/3] media: s5p-mfc:fix usage of Block comment alignment
Date:   Wed,  9 Nov 2022 09:23:47 +0530
Message-Id: <20221109035348.69026-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109035348.69026-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc997fS3MLi/A5EKYw+I2wBWoULigOJy4PMdwGJMFXbKuKY+C
        lNeuLUydTthgsQ0t4HRThqj8EEWgyG/5lYJVIolmBIQt0vJLAnUZDrpNMp2upbD99znnfM/5
        3px7Lw/3miD9eZmsllGzUoWA9CTab4W8LfwoKEsW8XhSiOY6z3PQVEU7iapW5jE0WeUg0EBL
        Gxe1jv6Io9pBMwddtNznoI7+GQLdWHBWh89bCTR/sREge5mNRMaFaRw1z45x0EhXOYmKmto4
        qMFi5aKa8WEMXWl+jqHKtj+4qLDXwkXWnnaACr61YAmQrq+oB3SntRrQ49XLOH2zzMqlq3rs
        GN1cpyPpibEekm6pPkkX3v6boI2tdYDWW8ZJ2tG8iR7608FN4R/K2pHBSNMYdSDDypRpmaw8
        XpB0QLJbIo6OEAlFsShGEMhKs5l4QeKHKcL3MxXOFQgCc6WKHGcqRarRCMJ37lArc7RMYIZS
        o40XMKo0hSpKFaaRZmtyWHkYy2jjRBER28RO4WdZGaMtA6TK8M6R/pK7eB7QBemBBw9SUbDh
        9ALmYi+qG8DCy6QeeDp5GUCdzkK4AweAvfYCbL2jrH4Qcxe6AHxus60FhRj85/ZVXA94PJIS
        wnsdCleDD5UP4OwprUuDU6UEfGhcwF0Fb4qGd66YOS4mqDdhV7F1lflUPCz61b7m9ga83mRe
        1XtQO2F+RzvXNQhSL3lwcPjCmigRfqNzD4WUN3w82Mp1sz90LPaSbpbB2Ur7mkYBTT1nCDe/
        C82j5YTr0DgVAk1d4e706/DsUOPqeJx6FRqePVqz4sPOinV+C5ZPrHDcHABvXa8BbqbhtG4a
        dy+lFEBH7ymiBGwq+9/iEgB1wI9RabLljEasimSZL/67NZkyuxmsPvPQpE4wM/V72ADAeGAA
        QB4u8OHXNx6WefHTpEePMWqlRJ2jYDQDQOxcYCnu/5pM6fwnrFYiioqNiIqOjo6KjYwWCXz5
        VedCZV6UXKplshhGxajX+zCeh38eZvJNX1r662VN+pSxL5y3OeAqMfvzhntYtci8i/O0feth
        T6x2cvP2faK+oiTjft+c5Lj52Lui3wxFeitG/nLELMa5Dkl68EztOXzb4vxyn/eNzZHBcr/O
        ByV+pKnWAtRPK5+EjdT99JV5l/BFyQnz0VfeC+qx+bAB5k8NjR8cvER2fdybe82+eHZky6Kp
        dC7uk8YvL4fvCTGcONN9B1kP2mwbt4c+o9jk1Lyk79QbHmnYhAfdcKvp5m5xfLE89Qfvk8U6
        ZW5//t7jx4m9CfqluQbD50pj074sZqz4RbD/iOTC1wfkMQlticPHHibrFIfokKEnYrgl9fs9
        MaMr1zbuL7gvIDQZUlEortZI/wXvGgjbbwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0xSYQCG+845nHOksBNZfZLVIruM0rJcfrU0ulinZsW6rKU1Y3byEqAD
        TbvrylJG5uw2rWUF6SByhopotJRIly6LIu1Gps7U1bpotmZ3tf4927P3fX+8NC48TYjoeFUy
        p1bJFWKST1jviicHVIr3xMw7UY6jTls+D725ZCWR/lsXhlr1fQRylFVQqNx9AUfF9TU8VOhs
        4qHK2nYC3ez+a135HgJ1FZYA1FPwmkQ53W04snQ089CT6osk0pVW8NANp4dC11pcGCqy/MDQ
        1YovFMq87aSQx24F6NhxJyaFrPmSGbA2jwGwLYZenK0q8FCs3t6DsRZTNsm+araTbJnhCJt5
        b4Bgc8pNgNU6W0i2zzKZbejvo2SCSP6SXZwifi+nnhu2kx/nLnOQSSfnpNXm3sfTQfY0LfCi
        IRMMC8z1mBbwaSFjA/Bh4zNyWPjB38frqGEeC42/uoZYyBzFoNm5RgtommQC4INKxWDWh8kE
        sMWYPVSEM0YCvrypwwYDYxkW1hXV8AaZYKbD6lOeIRYwoVD3rgcbHpgCr5fW4IPsxYTBjErr
        v7FQWF37mJcLvC+DESbgyyVplLFKTVDSfBWXGqiRKzUpqtjAmESlBQz9JpHYgN30KdABMBo4
        AKRxsY/AXJIQIxTsku/bz6kTo9UpCk7jABNpQjxB8Eh7P1rIxMqTuT0cl8Sp/1uM9hKlY5aT
        tNur4KtIDA/An6Nkv9Yd3eFSgXbX+zFnz7g90mV9HcUm7/cNaybeMUo/CLYZpnH+ObO2lB52
        d5fzv+0ThayYkdsk1cuyClXCO9R5jSynaKai5NDbc3XVB6Je+DeejehX+uRJtqvgR9/W1Rnq
        iOWRuHXM0yuirJDo5tHXfaOnLt3qb7krXRs7EJp6y7HAb/HnW97h4w6eKk5euDRvpcNfiyR2
        WW9wSsUEPy5KwAfbdRsjsuLHj/Zci5y9Ie1j+PeeVQZnQr3eKI1vELJlm9vCFo20PrcFdYa4
        NrUHTM/jFlfxiTZcOOmRbjc19XFhiM8JOxjQSa35ieFg1frzYkITJw+S4GqN/A/dPMNsJgMA
        AA==
X-CMS-MailID: 20221109034703epcas5p3462fab543f9a9f5159476b7d5eadfbfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034703epcas5p3462fab543f9a9f5159476b7d5eadfbfd
References: <20221109035348.69026-1-aakarsh.jain@samsung.com>
        <CGME20221109034703epcas5p3462fab543f9a9f5159476b7d5eadfbfd@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix usage of block comment alignment in drivers/media/platform/samsung/
s5p-mfc/s5p_mfc.c as recommended by scripts/checkpatch.pl.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 49 ++++++++++++-------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index bc6d53e78876..e857f974bb98 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -148,11 +148,13 @@ static void s5p_mfc_watchdog(struct timer_list *t)
 	if (test_bit(0, &dev->hw_lock))
 		atomic_inc(&dev->watchdog_cnt);
 	if (atomic_read(&dev->watchdog_cnt) >= MFC_WATCHDOG_CNT) {
-		/* This means that hw is busy and no interrupts were
+		/*
+		 * This means that hw is busy and no interrupts were
 		 * generated by hw for the Nth time of running this
 		 * watchdog timer. This usually means a serious hw
 		 * error. Now it is time to kill all instances and
-		 * reset the MFC. */
+		 * reset the MFC.
+		 */
 		mfc_err("Time out during waiting for HW\n");
 		schedule_work(&dev->watchdog_work);
 	}
@@ -172,8 +174,10 @@ static void s5p_mfc_watchdog_worker(struct work_struct *work)
 	dev = container_of(work, struct s5p_mfc_dev, watchdog_work);
 
 	mfc_err("Driver timeout error handling\n");
-	/* Lock the mutex that protects open and release.
-	 * This is necessary as they may load and unload firmware. */
+	/*
+	 * Lock the mutex that protects open and release.
+	 * This is necessary as they may load and unload firmware.
+	 */
 	mutex_locked = mutex_trylock(&dev->mfc_mutex);
 	if (!mutex_locked)
 		mfc_err("Error: some instance may be closing/opening\n");
@@ -197,8 +201,10 @@ static void s5p_mfc_watchdog_worker(struct work_struct *work)
 	/* De-init MFC */
 	s5p_mfc_deinit_hw(dev);
 
-	/* Double check if there is at least one instance running.
-	 * If no instance is in memory than no firmware should be present */
+	/*
+	 * Double check if there is at least one instance running.
+	 * If no instance is in memory than no firmware should be present
+	 */
 	if (dev->num_inst > 0) {
 		ret = s5p_mfc_load_firmware(dev);
 		if (ret) {
@@ -260,8 +266,10 @@ static void s5p_mfc_handle_frame_copy_time(struct s5p_mfc_ctx *ctx)
 		return;
 	dec_y_addr = (u32)s5p_mfc_hw_call(dev->mfc_ops, get_dec_y_adr, dev);
 
-	/* Copy timestamp / timecode from decoded src to dst and set
-	   appropriate flags. */
+	/*
+	 * Copy timestamp / timecode from decoded src to dst and set
+	 * appropriate flags.
+	 */
 	src_buf = list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
 		u32 addr = (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0);
@@ -289,8 +297,10 @@ static void s5p_mfc_handle_frame_copy_time(struct s5p_mfc_ctx *ctx)
 						V4L2_BUF_FLAG_BFRAME;
 				break;
 			default:
-				/* Don't know how to handle
-				   S5P_FIMV_DECODE_FRAME_OTHER_FRAME. */
+				/*
+				 * Don't know how to handle
+				 * S5P_FIMV_DECODE_FRAME_OTHER_FRAME.
+				 */
 				mfc_debug(2, "Unexpected frame type: %d\n",
 						frame_type);
 			}
@@ -322,8 +332,10 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_ctx *ctx, unsigned int err)
 		return;
 	}
 	ctx->sequence++;
-	/* The MFC returns address of the buffer, now we have to
-	 * check which vb2_buffer does it correspond to */
+	/*
+	 * The MFC returns address of the buffer, now we have to
+	 * check which vb2_buffer does it correspond to
+	 */
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
 		u32 addr = (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0);
 
@@ -476,8 +488,10 @@ static void s5p_mfc_handle_error(struct s5p_mfc_dev *dev,
 		case MFCINST_FINISHING:
 		case MFCINST_FINISHED:
 		case MFCINST_RUNNING:
-			/* It is highly probable that an error occurred
-			 * while decoding a frame */
+			/*
+			 * It is highly probable that an error occurred
+			 * while decoding a frame
+			 */
 			clear_work_bit(ctx);
 			ctx->state = MFCINST_ERROR;
 			/* Mark all dst buffers as having an error */
@@ -535,6 +549,7 @@ static void s5p_mfc_handle_seq_done(struct s5p_mfc_ctx *ctx,
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) &&
 				!list_empty(&ctx->src_queue)) {
 			struct s5p_mfc_buf *src_buf;
+
 			src_buf = list_entry(ctx->src_queue.next,
 					struct s5p_mfc_buf, list);
 			if (s5p_mfc_hw_call(dev->mfc_ops, get_consumed_stream,
@@ -951,7 +966,7 @@ static int s5p_mfc_release(struct file *file)
 		/*
 		 * If instance was initialised and not yet freed,
 		 * return instance and free resources
-		*/
+		 */
 		if (ctx->state != MFCINST_FREE && ctx->state != MFCINST_INIT) {
 			mfc_debug(2, "Has to free instance\n");
 			s5p_mfc_close_mfc_inst(dev, ctx);
@@ -1318,7 +1333,7 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 
 	/*
 	 * Load fails if fs isn't mounted. Try loading anyway.
-	 * _open() will load it, it it fails now. Ignore failure.
+	 * _open() will load it, it fails now. Ignore failure.
 	 */
 	s5p_mfc_load_firmware(dev);
 
@@ -1429,7 +1444,7 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 	 * Clear ctx dev pointer to avoid races between s5p_mfc_remove()
 	 * and s5p_mfc_release() and s5p_mfc_release() accessing ctx->dev
 	 * after s5p_mfc_remove() is run during unbind.
-	*/
+	 */
 	mutex_lock(&dev->mfc_mutex);
 	for (i = 0; i < MFC_NUM_CONTEXTS; i++) {
 		ctx = dev->ctx[i];
-- 
2.17.1

