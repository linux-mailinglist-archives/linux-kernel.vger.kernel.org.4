Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABA605923
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJTH5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJTH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:57:10 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB5179983
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252619; bh=T0UOIRN0TPiARJsQNXWh4ypcKQ2VQw2Oh13pG+5URb0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=l02ikN0j+J+YSdWpYUiNLC6bAyPEW9EWv0IKRSilw6tMGzPoca1MHtogqsbM+/VbG
         XVg2w2/km2imBqMvpJ9WUNRVXKpHJwIcfjtfr2hQSXBc62GizP6S0B1/O8siEiZLBu
         Z8VyiNFW7z4W2sRBM+N9RZ5flNbKGEQYmIG5lVZ4=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 09:56:58 +0200 (CEST)
X-EA-Auth: GgWXZKGyV56eKzTzfPc0/UEdvUW1ldHKXaRqa78JtRWlz4Es0iUsPSIN2wisyjcHC954vzqEScQbMn53a6N1nzothbKs43/R
Date:   Thu, 20 Oct 2022 13:26:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 06/10] staging: r8188eu: Add space between function &
 macro parameters
Message-ID: <79e0aa96b1c8b2bc0c0f8ef9e651ab254629c7a8.1666249716.git.drv@mailo.com>
References: <cover.1666249715.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666249715.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space required between function and macro parameters to improve code
readability. This Linux kernel coding style guideline resolves following
error reported by checkpatch script:
	ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   1. Patch newly added to the patch set.



 .../staging/r8188eu/include/osdep_service.h   |  4 +--
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h     |  4 +--
 drivers/staging/r8188eu/include/rtw_io.h      | 28 +++++++++----------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 72990a1cdc66..ec2631455f08 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -53,7 +53,7 @@ static inline struct list_head *get_list_head(struct __queue *queue)
 	return (&(queue->queue));
 }

-static inline void _set_timer(struct timer_list *ptimer,u32 delay_time)
+static inline void _set_timer(struct timer_list *ptimer, u32 delay_time)
 {
 	mod_timer(ptimer, jiffies + msecs_to_jiffies(delay_time));
 }
@@ -108,7 +108,7 @@ void rtw_free_netdev(struct net_device *netdev);
 #define FUNC_ADPT_FMT "%s(%s)"
 #define FUNC_ADPT_ARG(adapter) __func__, adapter->pnetdev->name

-#define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)),(sig), 1)
+#define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)), (sig), 1)

 /* Macros for handling unaligned memory accesses */

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 25f9200b1151..577cd3f4f797 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -165,7 +165,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *hwinfo,

 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo,
 				 bool AutoLoadFail);
-void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter,u8 *PROMContent,
+void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent,
 				 bool AutoLoadFail);
 void Hal_ReadThermalMeter_88E(struct adapter *	dapter, u8 *PROMContent,
 			      bool AutoloadFail);
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index d0d6c53e2aa7..e47382ac64a0 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -740,7 +740,7 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra n
 u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
 u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);

-u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
+u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset, u8 *pval);
 u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
 u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);

@@ -751,7 +751,7 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *adapter);
 u8 rtw_lps_ctrl_wk_cmd(struct adapter*padapter, u8 lps_ctrl_type, u8 enqueue);
 u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);

- u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna,u8 enqueue);
+ u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna, u8 enqueue);
 u8 rtw_ps_cmd(struct adapter*padapter);

 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 925c7967ac04..87fcf6c94ff3 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -209,7 +209,7 @@ struct io_priv {
 };

 uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
-void sync_ioreq_enqueue(struct io_req *preq,struct io_queue *ioqueue);
+void sync_ioreq_enqueue(struct io_req *preq, struct io_queue *ioqueue);
 uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
 uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
 struct io_req *alloc_ioreq(struct io_queue *pio_q);
@@ -285,18 +285,18 @@ void bus_sync_io(struct io_queue *pio_q);
 u32 _ioreq2rwmem(struct io_queue *pio_q);
 void dev_power_down(struct adapter *Adapter, u8 bpwrup);

-#define PlatformEFIOWrite1Byte(_a,_b,_c)		\
-	rtw_write8(_a,_b,_c)
-#define PlatformEFIOWrite2Byte(_a,_b,_c)		\
-	rtw_write16(_a,_b,_c)
-#define PlatformEFIOWrite4Byte(_a,_b,_c)		\
-	rtw_write32(_a,_b,_c)
-
-#define PlatformEFIORead1Byte(_a,_b)		\
-		rtw_read8(_a,_b)
-#define PlatformEFIORead2Byte(_a,_b)		\
-		rtw_read16(_a,_b)
-#define PlatformEFIORead4Byte(_a,_b)		\
-		rtw_read32(_a,_b)
+#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
+	rtw_write8(_a, _b, _c)
+#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
+	rtw_write16(_a, _b, _c)
+#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
+	rtw_write32(_a, _b, _c)
+
+#define PlatformEFIORead1Byte(_a, _b)		\
+		rtw_read8(_a, _b)
+#define PlatformEFIORead2Byte(_a, _b)		\
+		rtw_read16(_a, _b)
+#define PlatformEFIORead4Byte(_a, _b)		\
+		rtw_read32(_a, _b)

 #endif	/* _RTL8711_IO_H_ */
--
2.30.2



