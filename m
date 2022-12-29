Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B46589C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiL2Gxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiL2Gxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:53:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873111C18
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:53:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d15so18139118pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGIi0uaFWqbs6bmI/OFzS+qM/6uwF6Yi0IRHoUfhbFs=;
        b=jgXjjsDB59Nhjm6tKMmT+/TR8z0FchOGqUvCWp8lzXRSmMAgvxWZ5SFVVZKWH2HuNh
         SZiLeZoL+qFsPGb+o8YniXneC6Zy8JdwCo7Hgg5aKGSUre6F59MZx62/itwGXXR4FZ+u
         s2MSgQQ/7ExftzlBV3LKLozo/w6wd1CxesiVtt/ZpBJ+OwThhR5o+xEUW/aI4cof9JUL
         FmPVgR63rjSbLwOj9KCOnNkfS+50NekNh836kl6Zif3rEmtITUxO+X8Chz0JtjKlx5rR
         fi0ZdvqmpJkAB6yPuw7FMKG5uwz0r5YHkUm5blu0TU9e5I9uckT4bpI6hi3sYIbN8Kdj
         BsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGIi0uaFWqbs6bmI/OFzS+qM/6uwF6Yi0IRHoUfhbFs=;
        b=5ryTcWj7gXwx7K6VSEdsr9p0bOv/+iggbDuiqC970q4/+ryq+ZrunAF6GF/YE1Neeq
         /gb8l4qfKk+BmmY4w4EsDzCgpkvLHjqR6djPhh5RhJi2nD0vLRlKG4PkPbAH44gtsKk5
         PDht+ztiTRXtlzdwoqZva6BmRtFj3uNWUM7DrjamLTm0CBzhPg4O0wRNfCDwCve8beoT
         goe5OfaRYMRSjmxreD1VHKJYAxH696160LMgEJw0f4h/if48zhKa54y7sQJ1EDYFijtp
         o4r8aSF08RhSzNFtX8WQyrQC5qbt8EGTuCWa1Wc519W+6W2ek+RGeclSlwf9oPhlqAWB
         H3xw==
X-Gm-Message-State: AFqh2kqcC7bmYVhQvb9gjkvGPTGje8pJ7El6kjg5wi1++w0mS79fC/Y1
        vKLLbmy2id/S4zwMR2ZSkTI=
X-Google-Smtp-Source: AMrXdXvKwb4Zcp6DEJkerdLDi/ZA/1nDXPN0OpltmY/l+JJGBum23tGo5x4bGIVOkoIfEXcLMBK1Lw==
X-Received: by 2002:a17:902:da86:b0:189:747e:97cc with SMTP id j6-20020a170902da8600b00189747e97ccmr38819392plx.26.1672296820053;
        Wed, 28 Dec 2022 22:53:40 -0800 (PST)
Received: from local ([202.131.133.254])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001896ba683b9sm2417848plg.131.2022.12.28.22.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 22:53:39 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:23:33 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     bagasdotme@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: hal: Fix codespell-reported spelling
 mistakes
Message-ID: <Y605bbJ+gPtBFrAZ@local>
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

drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:656: regsiters ==> registers
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1696: beacause ==> because
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2092: Checl ==> Check
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2513: checksume ==> checksum
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2726: sequense ==> sequence
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2780: vlaue ==> value
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3409: equall ==> equal, equally

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Changes in v2:
  - Added codespell report to make the commit message more clearer.
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

