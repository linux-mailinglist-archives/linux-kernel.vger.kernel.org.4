Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A661F7BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiKGPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiKGPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:33:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DB13F2B;
        Mon,  7 Nov 2022 07:33:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t1so7111642wmi.4;
        Mon, 07 Nov 2022 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNmLWsv0kOPbaij43L8PfdGtUfA1FHnBM0jiToGdqOU=;
        b=WdC3MC8z3itl9c+IF64z/rV5qalzXE8UZBKgROyfzxrEug7x8+e7Yj+iOtliqkZRTj
         w6wrfjO0jJwzKusjCm4hScyZer/toiJA5g0NgkesWIWAw+QqpumKaspbMZSY/Pwy+d69
         z9eOeFSvNlS8vIl9ohb1dmwlpb/kjmmVMK3RXlWL/DLSb9UU18uJs4BwhiH8G2fO2iSr
         8ss8/oZYahLx2JuDgRYyP5qfT4uma3I+w25lta2M55Ufg1brVLNGKqs+tplpqFkQXfzS
         Hl0931T+In5lF+VxJIulpTSuiSCtdGz4LRUFKxm6eGQDs2GtgEQ5/Qbz215+JVD8oQ6Y
         0qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNmLWsv0kOPbaij43L8PfdGtUfA1FHnBM0jiToGdqOU=;
        b=F0uxlylgbft2DkRO9OhU4yXId8ZmvytJs+z0mSxAVCwr16Oxn3YDPeM47WS5+L6tCK
         VFo/h9ULwf9Jaqu1Pv7xmypd36uVv0hnfQvItBQRka92HdlocU+qhoCuPGU4AX185crC
         wEOBIiP5jKnJXNn81wNYVLepkz7wO70tEZg4B7l5p6EsTR3E5SPqis2TQKpJxnROakhw
         06O5Zh8yf86Z1d/oNMTyVsxB3WtwMOsOBjpc4Dw8jola5iT+utWd9XscN1SFSvej/7PI
         1X6FzXwQF735BzIEPFEZ1XZ2fncFMMN/gwEZWm3tfcGVK1DGdnp4M97+rJCk6RnwuboK
         hLEA==
X-Gm-Message-State: ACrzQf1Ftfv79U9ir6CRQJ30LDaCAPKMpXW18TJcVv7h7W4VQ3VmlnAo
        FbG+QXUtJcdHXBwk/CeGFV8=
X-Google-Smtp-Source: AMsMyM6GDea4zCfO3UsQihQEQjc+aE0RhRYzlNhDtrmkpHRHyxYERIh+UUAWqLS9TxenW2dd2rVB4A==
X-Received: by 2002:a05:600c:2150:b0:3cf:6c05:b4ab with SMTP id v16-20020a05600c215000b003cf6c05b4abmr31346030wml.161.1667835214116;
        Mon, 07 Nov 2022 07:33:34 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id q5-20020adf9dc5000000b002364835caacsm7393291wre.112.2022.11.07.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:33:33 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2] extcon: usbc-tusb320: Call the Type-C IRQ handler only if a port is registered
Date:   Mon,  7 Nov 2022 18:33:17 +0300
Message-Id: <20221107153317.657803-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
added an optional Type-C interface to the driver but missed to check
if it is in use when calling the IRQ handler. This causes an oops on
devices currently using the old extcon interface. Check if a Type-C
port is registered before calling the Type-C IRQ handler.

Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v1:
- Drop "for backward compatibility" from comment to avoid confusion on
  whether Type-C is meant to be the old or new interface.

 drivers/extcon/extcon-usbc-tusb320.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 41041ff0fadb..2a120d8d3c27 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -327,7 +327,13 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	tusb320_extcon_irq_handler(priv, reg);
-	tusb320_typec_irq_handler(priv, reg);
+
+	/*
+	 * Type-C support is optional. Only call the Type-C handler if a
+	 * port had been registered previously.
+	 */
+	if (priv->port)
+		tusb320_typec_irq_handler(priv, reg);
 
 	regmap_write(priv->regmap, TUSB320_REG9, reg);
 
-- 
2.38.1

