Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D65ED7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiI1IhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E59F0ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v2so15432452edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MBektPIlMNaA94hBUX0CqK9rztppqrFQ5yZw6cU5GA0=;
        b=nPowmBvi0n48oK8YdWwlNpwVqzUohZDIbZ6IeTiNfgHLlJ8NYAlh/4Pyluc7lIAa/L
         16N1y+rHrLvENsNatjnSGhKwwvXZMs/i/qcAv9hRPCfDorku4qTRB0xoh/OwE4WpFVl+
         5syX9koK47487SX4eughY8qYHorRRQykNPlusQrBoJhQTkSgo5Ws9Y4e/ek0gHCXfQ9f
         UWl5dvf85g7MpHjezxrovZ/ktB/Un3GxYG/jYT3zgq8T9AgYpE7PLwmxr5/ofJF8joiF
         NpMLrA6HnUVs/7RW87NzdUUfbfkekVaP1f+8Y/DC+jqu3WQwMc2KUa3y+PprukqCJcHU
         8uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MBektPIlMNaA94hBUX0CqK9rztppqrFQ5yZw6cU5GA0=;
        b=ByzpP9eucCW4aq9U0Jx+fnQprOACe5U9h3Mx+ECmx06PsS2EmrWgLiI07F+Ybwlhug
         NkfcbcT/AziirxjABnbx7ED1lgnyMC9J5f9kzIzZz6s/hHOIbr4AQ/aSgiSHFf7zmU87
         dUqR7svNcwXs3n2Lkw4AQR1/ey5OI7VGvPcOOuKi9UShf9NsaTdO4TfRHAcW9ru93wET
         96vjIb+eyDTPsFIMc6pbxXEaFtsjPIgispDrxqN9qBjoozI1CmucfM8dR5cJtcA+nCtw
         qDokRoKmbRedCDKKMK+y2u9eKd0dNuauJOEXmd66lpgkVAqWcP2adNQDtPrzSjjObqCw
         xktw==
X-Gm-Message-State: ACrzQf2z+daoqICJhE/PEDa+7tpYHeCNxpRWQI5+VMbmhOzpH2JIlYKW
        umDsq9ilQWEmdxapLMTHxcU=
X-Google-Smtp-Source: AMsMyM4twxMuvjaYsmnTWGMP/Jsa+DOULJ4IT+cCUr07gRi+SeVNi1RRVmEet7caj68BkC4mHllRSA==
X-Received: by 2002:aa7:c6d6:0:b0:457:d8cd:abb5 with SMTP id b22-20020aa7c6d6000000b00457d8cdabb5mr3999708eds.382.1664354211697;
        Wed, 28 Sep 2022 01:36:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id gy23-20020a170906f25700b00730b3bdd8d7sm2024526ejb.179.2022.09.28.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:36:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove PHY_RFConfig8188E()
Date:   Wed, 28 Sep 2022 10:36:41 +0200
Message-Id: <20220928083641.8275-3-straube.linux@gmail.com>
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

The function PHY_RFConfig8188E() is just a wrapper around
phy_RF6052_Config_ParaFile(). Remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c    | 9 ---------
 drivers/staging/r8188eu/hal/usb_halinit.c        | 2 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 1 -
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index cb2788bc383b..731179635c54 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -507,15 +507,6 @@ PHY_BBConfig8188E(
 	return rtStatus;
 }
 
-int PHY_RFConfig8188E(struct adapter *Adapter)
-{
-	int		rtStatus = _SUCCESS;
-
-	/*  RF config */
-	rtStatus = phy_RF6052_Config_ParaFile(Adapter);
-	return rtStatus;
-}
-
 static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
 			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
 			       u8 *BW40PowerLevel)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index a478b83dcbf3..d28b4dc2a767 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -611,7 +611,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	if (status == _FAIL)
 		goto exit;
 
-	status = PHY_RFConfig8188E(Adapter);
+	status = phy_RF6052_Config_ParaFile(Adapter);
 	if (status == _FAIL)
 		goto exit;
 
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 9e6f2361b090..4a0b782c33be 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -80,7 +80,6 @@ void rtl8188e_PHY_SetRFReg(struct adapter *adapter, u32 regaddr, u32 mask, u32 d
 /* MAC/BB/RF HAL config */
 int PHY_MACConfig8188E(struct adapter *adapter);
 int PHY_BBConfig8188E(struct adapter *adapter);
-int PHY_RFConfig8188E(struct adapter *adapter);
 
 /*  BB TX Power R/W */
 void PHY_SetTxPowerLevel8188E(struct adapter *adapter, u8 channel);
-- 
2.37.3

