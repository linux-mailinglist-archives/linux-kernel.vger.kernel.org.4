Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39C6562AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiLZMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLZMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:50:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B62CD0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:50:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge16so6938209pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GvTGLH9wrG1dCqu/5/WQGE+DMEzGakELb3zwl+tBa0=;
        b=ZV6CAnSyA36rapcnwmd3Ep0yrUgrs2XPBHldnl9/I1+k3g9Bk716X71MufTHnAY3GQ
         bMmgi3O0Ms7TbWrlQ+BjHWPBExSBpHUJeIc61ksqlsNAZDMR/2DiQgXvW+uKwApuUJmP
         oCrIC8jSdeVaNpZ+sNvWBi+3rHSV58j/MdEOg0sa0G3bKibSSOFRwnJcdbCsaPyNXyfW
         adkhgB5FZFR78N7UaIJVOmP6VDwXIcXmztwkEdMT+9wcRaWIUrDopBp3Of+5QR+4Mm6w
         JTZ6J/BVfWRB+C/31ca0C1zMUafmloMUNQW/RlBhUeGfzMDpTrZlPmSkz6hYQW4dtARN
         oINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GvTGLH9wrG1dCqu/5/WQGE+DMEzGakELb3zwl+tBa0=;
        b=Lj7GMElbop9ytxsZAd5i/7TxEn1UTEKCkjkZvKaDhUUxYMgRcySv7+p9aMTrK/1Sku
         SoeRv4d4ftFdutt/HXVDRaQjQ74z29qP0cCmcAYPZd3kfHaPbHnALQ+WWgPoNqHeEiUH
         AcrB6JOfzrRJ9tlo33XGlab1N1vTAzrR4vi5oitZZqC8GhwV3ooHKk6wR8aTq0awTPpK
         03UKsu83genOIHIwtTJszLXUE7PGDKKLdtXjCH1I7EuKlzJ0V7ntJWA9zqM8u38m75Et
         hmO0d9NpmMx5mWnRFQK0oDCnaXX+Jb+Krt1O++z6PurWDeBUgos6S9hbiHzM56gntKUc
         nhfw==
X-Gm-Message-State: AFqh2kosEIrbVMusu2Na5L0WAe1oxrg8PLlXFaRQjGR5GFeBkI/BPMpx
        DqT8fM9QmuyXKJaCw6aaZ3IrkQRqU51CwQ==
X-Google-Smtp-Source: AMrXdXucTJQJGxJert5x9oCW51PRvCm9yYuQlnzdBAx1nImYk8WxmCI/3VAmxgakvv6m6fkqd0Gi1A==
X-Received: by 2002:a17:902:f80c:b0:185:441e:90dd with SMTP id ix12-20020a170902f80c00b00185441e90ddmr21235067plb.67.1672059001254;
        Mon, 26 Dec 2022 04:50:01 -0800 (PST)
Received: from local ([202.131.133.59])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902f61200b001783f964fe3sm7128299plg.113.2022.12.26.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:50:00 -0800 (PST)
Date:   Mon, 26 Dec 2022 18:19:56 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in comments
Message-ID: <Y6mYdPlqIK1VgQ0Z@local>
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

They are appear to be spelling mistakes, initially identified in a codespell report and never been addressed so far.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
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

