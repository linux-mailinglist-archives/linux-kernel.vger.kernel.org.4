Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD861E24E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKFNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:18:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF6BF63
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:18:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so10705862pjh.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wIjgNU88aVc2+sFYCEelT5KhuJ8SvI5h9ckpOpuCAw=;
        b=cLWYtVzcHUtnpfMsI2JPuan2DjSbptj21Zx5CkyiQCczT8+hkJ+LsIrHLdIoiphGvl
         WGVF/69phwq3w7xsDDnZkaE9RFgBsa4gdXsoVL7VwrA+aDOXRaca22oozlnDYJCS5FCD
         GCM2IZOF2XbB65knjTDgyAD25a7hxx7aajJiAvduVJyVitxJYEjE/TKJk1MNB7scsHk4
         LZP41KG5Z7mEefbzZPh3vJDvnabxbrb6jIopUQkrxDy1vFfd45O1s0rs8rnBFg+jFQsy
         N2RIKkuIEkdEaQoVkSms3R+fh/kBb2XWMkZaq7kFpGxATdV+FSG92TUJffime1JSjO88
         m98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wIjgNU88aVc2+sFYCEelT5KhuJ8SvI5h9ckpOpuCAw=;
        b=VW2gGPoKQSxPpgavDOrjp0Iysn+EjPo6o8Tj9EBiVTliNBZ0fqpA5sPecpWdGJG69l
         w0+JparXmHsjqRkuZ3801tG3dSleSMzNpbsGsNf2OC5iEBtLP5Mnz31gooG/ic9sIJmB
         YPz+4mTK/vn+YOJOpNpqLKkz/9RqtuRTyAdx+5BPjR2HiiHYxuSwml/IOeSxnG04Mo8c
         KgzGeWrEAzCH3O2sywUN3LqfPfAnBqmAhPj9vw3EDg2t/PC23Kg0JUvdhPUQRlA9lJst
         vr1zG8suehr9UTqYsdPiUR+yQYjCI0+lVeemDgwFqZs5hQSIiEZgF+KQ41YiCcnDIiZh
         doTA==
X-Gm-Message-State: ACrzQf0aeIlckcN8mb53zL2q9F+ZwmjqkmwJT/k7BIz3bVLPMKdoa1JV
        5h3s+yXdZ/PO17mi6cA/p2c=
X-Google-Smtp-Source: AMsMyM5SZU8IK6OonUxj9BXiRHmLPbjt9Sv7BYUURuiD9z3/Q8ZHBDilsoqvmk8+aCHNrqXx4tE9kw==
X-Received: by 2002:a17:90a:590a:b0:20a:e93e:2022 with SMTP id k10-20020a17090a590a00b0020ae93e2022mr45021261pji.141.1667740696609;
        Sun, 06 Nov 2022 05:18:16 -0800 (PST)
Received: from zephyrus ([103.251.210.204])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b0045751ef6423sm2537049pgg.87.2022.11.06.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 05:18:16 -0800 (PST)
Date:   Sun, 6 Nov 2022 18:48:11 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, dragan.m.cvetic@gmail.com,
        wjsota@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Rename variables TM_Trigger and
 TxPowerCheckCnt to avoid CamelCase
Message-ID: <20221106131811.GA50668@zephyrus>
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

Rename variables
* TM_trigger to tm_trigger
* TxPowerCheckCnt to txpower_check_count
to avoid CamelCase which is not accepted by checkpatch.pl .

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 767c746fc73d..0652940eecc5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -919,32 +919,32 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
 static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	static u8	TM_Trigger;
-	u8		TxPowerCheckCnt = 0;
+	static u8 tm_trigger;
+	u8 txpower_check_count = 0;
 
 	if (IS_HARDWARE_TYPE_8192SE(dev))
-		TxPowerCheckCnt = 5;
+		txpower_check_count = 5;
 	else
-		TxPowerCheckCnt = 2;
+		txpower_check_count = 2;
 	if (!priv->btxpower_tracking)
 		return;
 
-	if (priv->txpower_count  <= TxPowerCheckCnt) {
+	if (priv->txpower_count  <= txpower_check_count) {
 		priv->txpower_count++;
 		return;
 	}
 
-	if (!TM_Trigger) {
+	if (!tm_trigger) {
 		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
 		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
 		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
 		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
-		TM_Trigger = 1;
+		tm_trigger = 1;
 		return;
 	}
 	netdev_info(dev, "===============>Schedule TxPowerTrackingWorkItem\n");
 	schedule_delayed_work(&priv->txpower_tracking_wq, 0);
-	TM_Trigger = 0;
+	tm_trigger = 0;
 
 }
 
-- 
2.25.1

