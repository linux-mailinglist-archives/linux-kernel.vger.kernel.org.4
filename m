Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA15EAEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIZR4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIZRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:55:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6D6173C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hy2so15616409ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kRLijR5oyAOegAsMr9uRqxn4ejdUkVTR852YUUghNUE=;
        b=HAKciU4TTD/RKp/d/Zwr4SkfntWLJ6I2A59VOxclITi0+ND1ld1jMAF4vl1KCNsZd6
         nxcQE7zKVfS/a//nrFteMMgaydHNI2DLLDsvt4O3UoWoSMA4pZuv3BpGdsprZ9O5o0/6
         NMgAh5uw0Y49tl4lbwz1lXqEe9ASBi+78/kAOgDk+VgJuLS82Z/Rs+DFmvmLtZt1b8UK
         N9GPSfeCtrmreSAbve3PHFOeYHIUy2ntW7zZRAKbBpHhTb4P4FeselQwBNpbxYq8yxH2
         ixRvNU/AhDKWdJNb51bDc6OrRVj2SNJoeu2jGKJDhU8+ncvjsDaXpG0XAu14Yqvx/ncG
         qpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kRLijR5oyAOegAsMr9uRqxn4ejdUkVTR852YUUghNUE=;
        b=OQYkZ86PVmSHuLqZk4W2Tm0LfakpGUCCsxKN9bxwz0sHXE+igb1LbSwG3q2I9E/WRL
         lNkWyMujrxGUkRjOnN6WJMuoDzAtow2Pc2g+SbTyhkHiVy3hGrZk9MVaRiKCroji3vB4
         2Sls6oZMcliMZCG6LYFuubQRC9NCZMmMoceCJW36jnw3cSOEIhnjoIPpJamRuQbKoYre
         bcsqW7rFbRyi8gDRC7OX6OX2uPS7T3ERabPxLBzVIHi7dOsLTblU8utNm7eHVfJryzIn
         qPl2/n0sVd9LfKZtJ3aFMV5kvkqkBXO7DkZADpDd/044xUBmpAi6spGtz/pptpdjI196
         IDWg==
X-Gm-Message-State: ACrzQf0NEtcEVxW8dT3Siq1rz5dSfwU/7C0faO9Optem5iy9CGBsMJDX
        vSesYHskfSlRULCAcSP500YSfQOdPwI=
X-Google-Smtp-Source: AMsMyM7m9kNWqUF+vdLNEDJ+Oh4nkq5deojnLJRurAWBKV3yeD4Q6lMxcOu4GxwXON075c8s1fexxQ==
X-Received: by 2002:a17:906:854b:b0:782:4c6f:5ff6 with SMTP id h11-20020a170906854b00b007824c6f5ff6mr18231861ejy.603.1664213570117;
        Mon, 26 Sep 2022 10:32:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00782667df018sm6554617ejf.54.2022.09.26.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:32:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: make odm_ConfigMAC_8188E() static
Date:   Mon, 26 Sep 2022 19:32:41 +0200
Message-Id: <20220926173243.8767-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926173243.8767-1-straube.linux@gmail.com>
References: <20220926173243.8767-1-straube.linux@gmail.com>
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

The function odm_ConfigMAC_8188E() is only used in HalHWImg8188E_MAC.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c      | 5 +++++
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c     | 5 -----
 drivers/staging/r8188eu/include/odm_RegConfig8188E.h | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 77b25885c63b..e615bc37c74f 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -126,6 +126,11 @@ static u32 array_MAC_REG_8188E[] = {
 		0x70B, 0x00000087,
 };
 
+static void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
+{
+	rtw_write8(pDM_Odm->Adapter, Addr, Data);
+}
+
 enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = array[i]; v2 = array[i + 1]; } while (0)
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 0fa17a99f9e9..e6e10a3c8d54 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -33,11 +33,6 @@ void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data
 	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, Addr | maskforPhySet);
 }
 
-void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
-{
-	rtw_write8(pDM_Odm->Adapter, Addr, Data);
-}
-
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
 {
 	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
index 683fa4a07956..9cecbf9532f5 100644
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
@@ -7,8 +7,6 @@
 void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm,
 			       u32 Addr, u32 Data);
 
-void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data);
-
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 			    u32 Bitmask, u32 Data);
 
-- 
2.37.3

