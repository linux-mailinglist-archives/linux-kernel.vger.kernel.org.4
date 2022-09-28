Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C015EE933
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiI1WLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiI1WLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:11:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9273318;
        Wed, 28 Sep 2022 15:11:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so2141118wma.3;
        Wed, 28 Sep 2022 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3t9tajyecZAesXGYXlNk9fq/Z63rAiLHPJf0z/1Mac8=;
        b=PWj0WMxkP4SAN+IFXmhXiKyNt3iT2UawbueUF8ajecpTCKqtDQFRTAU2hCYpetKjm4
         ot0kprojwommBAYpztZpoGju0B8414/PC5V+6e8qYWpAQwq2yLW28bvPjGJpLXjOY76d
         Fe3AHPGa6y2/VLtN/wGBy+CO/ti+O089Q2w29UhnKx6e5jnDvln06bu/QOgmJror/PTF
         PHC8/WEiRbi4VDuahgGGBFT2gj0szPJaAactMdSqz+nv2/sQVrEiWf9dnxoD88UhRbg4
         Xsy/fL14YybGMOk6kxAWv6bgfeMwcVT3GtGfrT4X4y/6d0ypo4/YoSJXIqqqD3omKSzY
         TmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3t9tajyecZAesXGYXlNk9fq/Z63rAiLHPJf0z/1Mac8=;
        b=PdcVMnJJK2rNdSv3cnuaeWBdZDqxBob9wbSXMGROd9/gmkiYpDiTXCgJyGN7V3+OLn
         AtzjIxvSmybJBjOWElkJIvL/K70NWnNltQ0kjFeO/DWoA9D+5kwP4WGqV/7bT0KIwJK/
         GBRzilRcNJLDY66EjKJ+PF81yOPJFcdXRNftO/4o3ZIfQdEFKJWjFd3wo2V8Kp2e0Kl7
         KTWMRL0oIBn67BZE3B3hkqL3TBzA/b7bBiCzU4OyvIsYM+1daI49N5gGCqFSIUh8gxqZ
         WT/UK/yimB6MDIEqwl8uL0iY/RREp4FZG3gFcV3lqdLM1Sx0B7H/nLqYdSORoeRqDqmE
         ueMg==
X-Gm-Message-State: ACrzQf32JU68bIWqyfMYdPxK2wWzNamvPjr4XIfc8vgagd+Ev5V2fFOp
        LH7++T/h8L51SdGmS8E9LnQjWCahbxhypA==
X-Google-Smtp-Source: AMsMyM45tnkZlWypfiGLKdLiXrjfEYW0r4Z2KrjJcjr/1liVdub+7OAeNnP4v6c4zkZmGr90GHApNA==
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr87119wmq.143.1664403101523;
        Wed, 28 Sep 2022 15:11:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2987967wmq.26.2022.09.28.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:11:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: omap_udc: Fix spelling mistake: "tranceiver_ctrl" -> "transceiver_ctrl"
Date:   Wed, 28 Sep 2022 23:11:40 +0100
Message-Id: <20220928221140.67495-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the control name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index b0567c63d754..bea346e362b2 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2234,7 +2234,7 @@ static int proc_otg_show(struct seq_file *s)
 	char		*ctrl_name = "(UNKNOWN)";
 
 	tmp = omap_readl(OTG_REV);
-	ctrl_name = "tranceiver_ctrl";
+	ctrl_name = "transceiver_ctrl";
 	trans = omap_readw(USB_TRANSCEIVER_CTRL);
 	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
 		tmp >> 4, tmp & 0xf, ctrl_name, trans);
-- 
2.37.1

