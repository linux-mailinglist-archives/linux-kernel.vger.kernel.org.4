Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C22658C00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiL2K7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiL2K7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:59:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007164D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:59:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so18604180pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Do/JrGiYmxU3uxYDXwb8h1ST2ozS7lPRxIDh95Xkgg8=;
        b=iIorUFryoMSrOSDSa0IdUmxUQt4djcLCMTkatyG2Xt6yGVIVRcbPVKi5E/ZAv/E5yW
         js9fm0Lf5Mkapb2x/eIl5KXzkFr+IxBmI/lfCnariwAWH7jDYt58/0QUGF5BzqmJIqzA
         GOvYmxc363iIYEmq9F68locvPGwXJPmnysdjEUCurcrRRn1U+Hzky46OMAkFmPArYnIB
         gw8xEKQXeQZt8/GdhSgFMh0nx5UtN0BNmwGSZDFZV0fC/ZYZD+Zou2zv6QVO073IBxz9
         fbDg7LcNOkaXVb795N0+fkCGm3N8xLtJJsYSld/AxZ/7NnxkwrWBHnrl5orOUTcOOprb
         FQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do/JrGiYmxU3uxYDXwb8h1ST2ozS7lPRxIDh95Xkgg8=;
        b=rEMFvPBG8URp7zOaGiknUfd73pUPv8VPJSbOrW7c1m18kQh5Z66Yr7YoWGzdtf9iSy
         IW8QEkmN1EW35RVxItcYeBmRdiWMWyeMlk8VnDs5pGFvFGa7I/WJh+UjVirpmWvrKs6J
         vIBhLYcccldyhK0QBIjLZnl2ru4d9v+EAceDoYMWnnv9uNxvFG6fML8BcVARzP5ISgi+
         TWZUwmeqc/hILYiYVVP6OdWHhWRiR7RAraF0JNltHNXZ1sW6Q9rymRT8xLCySIbMvyul
         lNCt9+Ub8Qt0G33EhmsGF848OSbLX/eOfe4blxVisSyJMJIjsKI8uEADwtSXcnGVuFSC
         nmFw==
X-Gm-Message-State: AFqh2kowyf2jkABH1V0MHrAwC3ACO2BGMq/NU8hSH+Y/SYF+rfelIgvc
        nHTPFVMDn32yQYGVB0lLJTzkcYCcLGxHLeWC
X-Google-Smtp-Source: AMrXdXu3LNrSKZ3JFubQx+hFN6ispV3F11u0JnjTB5yVNtFvHewSWr7MFF7wMqEBSVCPW9c+8ncxtg==
X-Received: by 2002:a17:903:2790:b0:192:849d:120d with SMTP id jw16-20020a170903279000b00192849d120dmr12196870plb.46.1672311551383;
        Thu, 29 Dec 2022 02:59:11 -0800 (PST)
Received: from local ([202.131.133.58])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090302d000b00186b138706fsm12688412plk.13.2022.12.29.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:59:10 -0800 (PST)
Date:   Thu, 29 Dec 2022 16:29:05 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     error27@gmail.com
Cc:     bagasdotme@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3] staging: rtl8723bs: hal: Fix codespell-reported spelling
 mistakes
Message-ID: <Y61y+flJp9/jEicc@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are appear to be spelling mistakes,
Initially identified in a codespell report and never been addressed so far.

drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:656: regsiters ==> registers
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1696: beacause ==> because
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2092: Checl ==> Check
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2513: checksume ==> checksum
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2726: sequense ==> sequence
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2780: vlaue ==> value
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3409: equall ==> equal, equally

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---

Changes in v2:
 - Added codespell report to make the commit message more clearer.

Changes in v3:
 - Wrap the commit message & included the changes log below "---" line. 

 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index f1fc077ed29c..0fcae6871108 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -653,7 +653,7 @@ static void Hal_EfusePowerSwitch(
 
 
 	if (PwrState) {
-		/*  To avoid cannot access efuse regsiters after disable/enable several times during DTM test. */
+		/*  To avoid cannot access efuse registers after disable/enable several times during DTM test. */
 		/*  Suggested by SD1 IsaacHsu. 2013.07.08, added by tynli. */
 		tempval = rtw_read8(padapter, SDIO_LOCAL_BASE|SDIO_REG_HSUS_CTRL);
 		if (tempval & BIT(0)) { /*  SDIO local register is suspend */
@@ -1693,7 +1693,7 @@ void rtl8723b_InitBeaconParameters(struct adapter *padapter)
 	rtw_write8(padapter, REG_BCNDMATIM, BCN_DMA_ATIME_INT_TIME_8723B); /*  2ms */
 
 	/*  Suggested by designer timchen. Change beacon AIFS to the largest number */
-	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
+	/*  because test chip does not contension before sending beacon. by tynli. 2009.11.03 */
 	rtw_write16(padapter, REG_BCNTCFG, 0x660F);
 
 	pHalData->RegBcnCtrlVal = rtw_read8(padapter, REG_BCN_CTRL);
@@ -2089,7 +2089,7 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
 	u16 EEPROMId;
 
 
-	/*  Checl 0x8129 again for making sure autoload status!! */
+	/*  Check 0x8129 again for making sure autoload status!! */
 	EEPROMId = le16_to_cpu(*((__le16 *)hwinfo));
 	if (EEPROMId != RTL_EEPROM_ID) {
 		pEEPROM->bautoload_fail_flag = true;
@@ -2510,7 +2510,7 @@ static void rtl8723b_cal_txdesc_chksum(struct tx_desc *ptxdesc)
 	/*  Clear first */
 	ptxdesc->txdw7 &= cpu_to_le32(0xffff0000);
 
-	/*  checksume is always calculated by first 32 bytes, */
+	/*  checksum is always calculated by first 32 bytes, */
 	/*  and it doesn't depend on TX DESC length. */
 	/*  Thomas, Lucas@SD4, 20130515 */
 	count = 16;
@@ -2723,7 +2723,7 @@ static void rtl8723b_fill_default_txdesc(
 	 * multicast / mgnt frame should be controlled by Hw because Fw
 	 * will also send null data which we cannot control when Fw LPS
 	 * enable.
-	 * --> default enable non-Qos data sequense number. 2010.06.23.
+	 * --> default enable non-Qos data sequence number. 2010.06.23.
 	 * by tynli.
 	 * (2) Enable HW SEQ control for beacon packet, because we use
 	 * Hw beacon.
@@ -2777,7 +2777,7 @@ void rtl8723b_fill_fake_txdesc(
 	SET_TX_DESC_PKT_SIZE_8723B(pDesc, BufferLen); /*  Buffer size + command header */
 	SET_TX_DESC_QUEUE_SEL_8723B(pDesc, QSLT_MGNT); /*  Fixed queue of Mgnt queue */
 
-	/*  Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
+	/*  Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error value by Hw. */
 	if (IsPsPoll) {
 		SET_TX_DESC_NAV_USE_HDR_8723B(pDesc, 1);
 	} else {
@@ -3406,7 +3406,7 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				/*  polling bit, and No Write enable, and address */
 				ulCommand = CAM_CONTENT_COUNT*ucIndex+i;
 				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
-				/*  write content 0 is equall to mark invalid */
+				/*  write content 0 is equal to mark as invalid */
 				rtw_write32(padapter, WCAMI, ulContent);  /* mdelay(40); */
 				rtw_write32(padapter, RWCAM, ulCommand);  /* mdelay(40); */
 			}
-- 
2.34.1

