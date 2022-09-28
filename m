Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C915ED7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiI1IhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiI1Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E1A9E88D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u24so1613708edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uXGCeCEAXm7WShuxFsGAnc4TEA0foi/qCDefq62rLtE=;
        b=dfPmt210cXwB+x6AA22pSGoZuGSh4iWi+xj3hLrVytXB1xQzCGEJgtvWgxKdxNbU6m
         uh1aNUAolvsFMm1BwZ/+NIMYHI2C8z7s8hyNsn/vX7XIVoAkSwEindW0qmgOfOKD/Gf1
         aY8jfEWG1X2GEgvWoNn9es7ovNDpNScbsbwv2ltpQrMtEyW4uMBlYSkGHlUHtGE1DTWE
         kuYGqXHGoUCeH/Qvg6t8ktkQCU3wOMgJHW8vzyjwtiaRNSFucc/DqToTka+uD5OXl8ao
         smhdkTLHAxhJ0v2+2FJhL/+uuYvZF/kuiKdYbVS1SXHtO+leyme+Qw8SJvZBqEfqovYk
         IfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uXGCeCEAXm7WShuxFsGAnc4TEA0foi/qCDefq62rLtE=;
        b=BJrOq/cVp3opwodrVIAK665+CHngn1b75VYq+F1zAbXiXR4rCIxgc190+X8HgQHbpP
         AxhLZzVAf5uERV/16yVGA01ABhA0LUUwZGcR/uvjSIOMmNesTH0b8KszANM4GRwEIQQq
         Hw43C9YWEl1WULU773aZhON1HegwnllSowlB8cJRH65KkxfqZ/6okseuVY7PVWd56YjO
         DoUeec70GuJozKSjC1Cbwsk9tV5mzeuSRp4aTsDQJB9mfFlH1MPBAeOWGDz/1V3BqGcK
         QQInvCwL26MkLuIt7/bFrxsQw2fBWEUEvFfnUk6jxEZMBR187XDAWHhGPGJK6Tx4mLa+
         xT5A==
X-Gm-Message-State: ACrzQf0nGQEO1mmtzMvJuZXRO0WsRKzGWcwMWjWPnqjCv/BOxSNgI1dV
        PC0BogqL+4zrYQr0RN9AV9w=
X-Google-Smtp-Source: AMsMyM61Zc1csNqRtaf/3/POuEYcEKQPL8bsZ4ixUbSYOVRgUX0R8MLfqa64HQ7Wp47QzgX5f3mFDQ==
X-Received: by 2002:a05:6402:27ca:b0:451:7b58:1b01 with SMTP id c10-20020a05640227ca00b004517b581b01mr32830416ede.61.1664354211104;
        Wed, 28 Sep 2022 01:36:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id gy23-20020a170906f25700b00730b3bdd8d7sm2024526ejb.179.2022.09.28.01.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:36:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove PHY_RF6052_Config8188E()
Date:   Wed, 28 Sep 2022 10:36:40 +0200
Message-Id: <20220928083641.8275-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928083641.8275-1-straube.linux@gmail.com>
References: <20220928083641.8275-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function PHY_RF6052_Config8188E() is just a wrapper around
phy_RF6052_Config_ParaFile(). Remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 13 +------------
 drivers/staging/r8188eu/include/rtl8188e_rf.h |  2 +-
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index a435ec65d4b1..cb2788bc383b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -512,7 +512,7 @@ int PHY_RFConfig8188E(struct adapter *Adapter)
 	int		rtStatus = _SUCCESS;
 
 	/*  RF config */
-	rtStatus = PHY_RF6052_Config8188E(Adapter);
+	rtStatus = phy_RF6052_Config_ParaFile(Adapter);
 	return rtStatus;
 }
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 237232432f37..0dc902b0abae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -366,7 +366,7 @@ rtl8188e_PHY_RF6052SetOFDMTxPower(
 	}
 }
 
-static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
+int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 {
 	struct bb_reg_def *pPhyReg;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
@@ -404,14 +404,3 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 	return rtStatus;
 }
-
-int PHY_RF6052_Config8188E(struct adapter *Adapter)
-{
-	int rtStatus = _SUCCESS;
-
-	/*  */
-	/*  Config BB and RF */
-	/*  */
-	rtStatus = phy_RF6052_Config_ParaFile(Adapter);
-	return rtStatus;
-}
diff --git a/drivers/staging/r8188eu/include/rtl8188e_rf.h b/drivers/staging/r8188eu/include/rtl8188e_rf.h
index 04556496baad..63ac0acc68fd 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_rf.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_rf.h
@@ -8,7 +8,7 @@
 #define		RF6052_MAX_REG			0x3F
 #define		RF6052_MAX_PATH			2
 
-int	PHY_RF6052_Config8188E(struct adapter *Adapter);
+int phy_RF6052_Config_ParaFile(struct adapter *Adapter);
 void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 				     enum ht_channel_width Bandwidth);
 void	rtl8188e_PHY_RF6052SetCckTxPower(struct adapter *Adapter, u8 *level);
-- 
2.37.3

