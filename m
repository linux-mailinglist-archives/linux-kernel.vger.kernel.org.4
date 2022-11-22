Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4160E633D44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiKVNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiKVNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:13:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4129C81;
        Tue, 22 Nov 2022 05:13:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z63so1545746ede.1;
        Tue, 22 Nov 2022 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y8Hrci7gEBpK8ypTuE+fYD+XXvaKAxlJq93rw+OoIc=;
        b=IyO6TpaYxflFJhaxYOV2PfGkRAwSZO3j+wxYnACuQZtZ47AAlMVq7mtJetf6M2SLn4
         VlgBL5d5/82zp+sqUpl67AbeQfBs2fLSvZ4myCkMtzX+sBWBeAzAvJRA9b24MjOIbS1O
         wD7XRoszDCFtQJHIHgNeniYHJsczpZPFTAK0i5gh9MX8cWPoXMZcUAWzje8wPLcEWDUi
         JBUnisSTdn7jGG3Y9M5sn0/REyHc3tgkhogNJHb9j3LBYsW4y4BhNIJD/LQHd6HTOqoC
         u1YyEfc24LkSSpO3fmjSaOvNgHxJyK0a7r83wYi1IWICrF7SKs4v5n/tihujwiJGBhBu
         wbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y8Hrci7gEBpK8ypTuE+fYD+XXvaKAxlJq93rw+OoIc=;
        b=J6f/Vt7pC2QU4OTG6ZpUtFw6cPhvg4l4VphkeObMFDnh3ek7Q7X64sk2Ewl0UsVHJG
         VO1CioXI4oAK7+K7kwU9DcdW4WJvWeLVUEl917lVQuCIUk4sCWe4+X3DJnvEen8gxvef
         +vlwUx5oichxv2F6ZNuN/+RMCLQIBVNF0VOGd8A+U6yt6jq8A4hzQWCQElCqpeonRIj2
         HeS7t3IrU0KBH5ptcOOMhwp7QxCCThH48EE+6irKhpIQUd5i2HC+4mZj5EJUu8TeBQyn
         Hx/pA7mkiZ65w7OXpT4VVnNcnWkaI8cdtRRTxOvfVpO84T6sslJbKUd8su/dgM78GMXg
         D7Gw==
X-Gm-Message-State: ANoB5plAF0FV0US0C5VZGlPj7WWMDmY9No2DDThrzvu3Mol7nBqdOnxm
        GmTZnkzeupnypdXw3Wmw8+/ToPWEQtg=
X-Google-Smtp-Source: AA0mqf7TQImuxqzpm8QfnBN7SZmV3h7LqqStygAGln0CurVZbkJJHbTc5h85jMQbWbfutDxzZCMC7g==
X-Received: by 2002:a05:6402:4512:b0:461:4c59:12d6 with SMTP id ez18-20020a056402451200b004614c5912d6mr20960202edb.250.1669122787880;
        Tue, 22 Nov 2022 05:13:07 -0800 (PST)
Received: from felia.fritz.box (200116b8267b3700c41d4e99e424db57.dip.versatel-1u1.de. [2001:16b8:267b:3700:c41d:4e99:e424:db57])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b0079dbf06d558sm6033234ejn.184.2022.11.22.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:13:05 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] wifi: b43: remove reference to removed config B43_PCMCIA
Date:   Tue, 22 Nov 2022 14:12:48 +0100
Message-Id: <20221122131248.23738-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 399500da18f7 ("ssb: pick PCMCIA host code support from b43 driver")
removes the config B43_PCMCIA.

Clean up the last reference to this removed config B43_PCMCIA in the
b43_print_driverinfo() function.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/net/wireless/broadcom/b43/main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 298febbdffc0..92ca0b2ca286 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5784,15 +5784,12 @@ void b43_controller_restart(struct b43_wldev *dev, const char *reason)
 
 static void b43_print_driverinfo(void)
 {
-	const char *feat_pci = "", *feat_pcmcia = "", *feat_nphy = "",
+	const char *feat_pci = "", *feat_nphy = "",
 		   *feat_leds = "", *feat_sdio = "";
 
 #ifdef CONFIG_B43_PCI_AUTOSELECT
 	feat_pci = "P";
 #endif
-#ifdef CONFIG_B43_PCMCIA
-	feat_pcmcia = "M";
-#endif
 #ifdef CONFIG_B43_PHY_N
 	feat_nphy = "N";
 #endif
@@ -5803,9 +5800,8 @@ static void b43_print_driverinfo(void)
 	feat_sdio = "S";
 #endif
 	printk(KERN_INFO "Broadcom 43xx driver loaded "
-	       "[ Features: %s%s%s%s%s ]\n",
-	       feat_pci, feat_pcmcia, feat_nphy,
-	       feat_leds, feat_sdio);
+	       "[ Features: %s%s%s%s ]\n",
+	       feat_pci, feat_nphy, feat_leds, feat_sdio);
 }
 
 static int __init b43_init(void)
-- 
2.17.1

