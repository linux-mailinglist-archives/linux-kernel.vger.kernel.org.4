Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4016FCECC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjEITxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjEITxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:53:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D23AA4;
        Tue,  9 May 2023 12:53:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439df6c268so3756893b3a.0;
        Tue, 09 May 2023 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683662011; x=1686254011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YigFI0J8gEeJ9cS/4TbGx1mSqvxtVecjV4VaaynehVs=;
        b=F6SueKdsqAQd67bwmrJH/yXCbVZzk7pexPYCJWZLLHqA4lHaabi8TIl5IBddrEO2Ys
         92xBtPh2FvUttUfaOhVxveveHmsucYdiMkoYH4+Gda4iKfE9CKrUYMMsQcQGrl7m71Qf
         +NUURXgF1D/evhSzlLorfzi7JxSkGRG+3ONTr99R90qGFIziWETrsYQvC8YD3SIzQ27r
         gVE+Xo2GCwJBLqzq1h8KuqgZYNmI9C4pS2Fe44NKtgh2pKklDSLed+ECc/Bv5RgYh/kC
         U2AJRBi4rYolvjKprwgBCTOHgdupgtOM1+5oA21O/fbqKDUgAsX213lseuB14V433qv7
         16Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662011; x=1686254011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YigFI0J8gEeJ9cS/4TbGx1mSqvxtVecjV4VaaynehVs=;
        b=BZwBPOfSPgG4WXsASAIlVPIBAoW3AWf9wklqIVArzrYkfCSBVsnKjUdgcf8oUS6I8v
         Es5VNF82d684jjyz3pEHnCmwHLv5PZitnglPpyx54CnJoyYnXFHCKTKUaACQLqMwRaq1
         NDe4QeRCiGdsucOZ7Mh65kbMAy2XYdAvNKRWKgg4NpMoTLyucjMdSuesPms+HvjPPW+S
         xfEKtq0uwds1hozSn/F/zyCC5Q3vkg+eTpm61TPRnu/yEvEancQF+gjhAiGmzjjnKW5v
         Nuqqe8fSiZO5JwAtaijoxqu4ItSUcdD38RQ9+F1sxJ553WtsdDWYJqK06iMY/OFkDp/6
         nM6A==
X-Gm-Message-State: AC+VfDx/4tEcNcfRNglmO2orvQfugnKzPF3or5Fx35YoqTyx4gipe3Pk
        p3aoSL+PJ1corc+VNMMN7MetltObe6Yn/w==
X-Google-Smtp-Source: ACHHUZ5FoaWYZKlVFSKQYNxq47jfzra4vCZOi5A2k8Y7lH5AQ1iW61wB62HZN1oo7Hw3T5eiqmbTag==
X-Received: by 2002:a05:6a20:7489:b0:f6:4c57:265d with SMTP id p9-20020a056a20748900b000f64c57265dmr18577016pzd.1.1683662010411;
        Tue, 09 May 2023 12:53:30 -0700 (PDT)
Received: from localhost.localdomain (ip70-179-44-160.sd.sd.cox.net. [70.179.44.160])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7808a000000b0063d3fbf4783sm2124247pff.80.2023.05.09.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:53:30 -0700 (PDT)
From:   Dan Gora <dan.gora@gmail.com>
Cc:     Dan Gora <dan.gora@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations
Date:   Tue,  9 May 2023 12:51:19 -0700
Message-Id: <20230509195119.9655-1-dan.gora@gmail.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
In-Reply-To: <20230504212843.18519-1-dan.gora@gmail.com>
References: <20230504212843.18519-1-dan.gora@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_FIRMWARE declarations for firmware referenced in
btrtl.c.

Signed-off-by: Dan Gora <dan.gora@gmail.com>
---
 drivers/bluetooth/btrtl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 2915c82d719d..d978e7cea873 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1367,14 +1367,30 @@ MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821cs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821cs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
@@ -1383,5 +1399,3 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
-- 
2.35.1.102.g2b9c120970

