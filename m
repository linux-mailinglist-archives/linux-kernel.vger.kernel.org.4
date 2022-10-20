Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B9606A54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJTVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJTVad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:30:33 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78093155DAA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301418; bh=BSJjUKJn2IEY/wVtRjtEixPryZo2Sh/OIsI/yVAm/xw=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=CCatwa4YRauNw4YgZU0S3iSDgIPd+4YFxldiiQPKVeYVYGLYdFW7z2N9vK1o0rWTV
         pQP8USKqxpMBp5BixrDLsfrVBsUtH4Jj0DB6KRHOIVkUbdg4H4G4VA9CSJpRrdu7Fx
         vRLJCqX3Lh+C62NwaNQbeIp/BULGRx9dQjEW2ERo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:30:18 +0200 (CEST)
X-EA-Auth: g0IWTAGH5LbX3GizWFIdmtNTr3ru39Zepw7PrMTqZ8VihjhPEal4VfnRfWAyLCHvX5pc+upCANsNYJF2ggrzapMvFZ11JFJY
Date:   Fri, 21 Oct 2022 03:00:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 06/11] staging: r8188eu: Add space between function &
 macro parameters
Message-ID: <ce200b3a986628f943dfb0c4e412276793e59bbc.1666299151.git.drv@mailo.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
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

Changes in v4:
   1. Implement corrections provided by julia.lawall@inria.fr

Changes in v3:
   1. Patch newly added to the patch set.

 .../staging/r8188eu/include/osdep_service.h   |  4 +--
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h     | 18 ++++++------
 drivers/staging/r8188eu/include/rtw_io.h      | 28 +++++++++----------
 4 files changed, 26 insertions(+), 26 deletions(-)

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
index d0d6c53e2aa7..8495ce1719ac 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -730,17 +730,17 @@ struct TDLSoption_param
 #define H2C_CMD_OVERFLOW	0x06
 #define H2C_RESERVED		0x07

-u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num);
-u8 rtw_createbss_cmd(struct adapter  *padapter);
+u8 rtw_sitesurvey_cmd(struct adapter *padapter, struct ndis_802_11_ssid *ssid, int ssid_num);
+u8 rtw_createbss_cmd(struct adapter *padapter);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
 u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
-u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
+u8 rtw_joinbss_cmd(struct adapter *padapter, struct wlan_network* pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
-u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
-u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
-u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
+u8 rtw_setopmode_cmd(struct adapter *padapter, enum ndis_802_11_network_infra networktype);
+u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset);
+u8 rtw_setrfintfs_cmd(struct adapter *padapter, u8 mode);

-u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
+u8 rtw_gettssi_cmd(struct adapter *padapter, u8 offset, u8 *pval);
 u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
 u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);

@@ -751,10 +751,10 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *adapter);
 u8 rtw_lps_ctrl_wk_cmd(struct adapter*padapter, u8 lps_ctrl_type, u8 enqueue);
 u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);

- u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna,u8 enqueue);
+u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna, u8 enqueue);
 u8 rtw_ps_cmd(struct adapter*padapter);

-u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
+u8 rtw_chk_hi_queue_cmd(struct adapter *padapter);

 u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan);

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



