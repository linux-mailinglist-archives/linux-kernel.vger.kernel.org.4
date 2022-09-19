Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEF5BC326
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiISGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiISGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:55:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34F13D68;
        Sun, 18 Sep 2022 23:55:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t14so45977563wrx.8;
        Sun, 18 Sep 2022 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uT7jE5xg7AsBDz517ORnUT6DIveI4kixoZiddEuhlFA=;
        b=M68uZgow9KToqVTE9e0nu2Q6MaWrhqb1VMi9qUctrjha5+tbwUTd3IqSKGu/GYuu8h
         kb9pq20fHFTUivpuc72F7kw0SZXQCrTWIkNOQ/B99F3TO0rM+5u0nsakRnN9pVxBm+tR
         01vAxIp1QS57RsLdCdD5fEwRPZxcz+5pTece7vHbZJGZLOLCrBU5jgDBSUusgC7pjPRJ
         YrECgzT69GTEY/wiIKo2/PZ5ecIz0WiT6fmZ2nhA3BTNfuN8bdLxYa3hNQnKN4GpWpoW
         PYZOdec/71jEiJxyqyd7tyVjB88FOYlkJuqC5l6tKKCWsiqLDdgkRJ5Jayx29oXRTqYh
         rSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uT7jE5xg7AsBDz517ORnUT6DIveI4kixoZiddEuhlFA=;
        b=wPb81J274+ORYTas/VxjscXun5BbuBNfnRj41jF97DobgpdalNE6GSSlNUHM5AuNYO
         sdbIWu6ponazHnSA4yren9jsoJ1seDDeaqX6ZgvpKci9ax7IcRYaT6c8Udxgse0+CF46
         wBA1yVExDpQ0xpLlMt2qUUWn/COjHo3OqLjYat7oYY14i22XBrnDrcivKljOkTzj2Jy1
         SLQRXvnmRZ3L5vz4s+VSArNtR0PoqMZnNo/PuqbID6pqC47MTXidFOsWK3f/SEhbPDsP
         tq9yUc6nWbh9M3ZSG0sdIvr21dVYExi21Vy/QF29lrQp/rdEmwfpJ/CA8rEibdRTOVgV
         3r5A==
X-Gm-Message-State: ACrzQf38ydUEtlfA2CckvBoqEkZi5r4xKCEaGNZBYkaHgXSTt37GZdww
        tfYiWJxr6W0MDVZ0NKfUPxg=
X-Google-Smtp-Source: AMsMyM59ePymicd9P3BMSVukXDAExzkWZY+t22qqQbMoWFPGLqgcpZ01NEpmu/QUM3K3UVlf1F6dmg==
X-Received: by 2002:a05:6000:387:b0:22a:3cae:93c4 with SMTP id u7-20020a056000038700b0022a3cae93c4mr10361952wrf.321.1663570502746;
        Sun, 18 Sep 2022 23:55:02 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003b47581979bsm13630955wmq.33.2022.09.18.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 23:55:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] pinctrl: nomadik: remove dead code after DB8540 pinctrl removal
Date:   Mon, 19 Sep 2022 08:54:35 +0200
Message-Id: <20220919065435.27747-1-lukas.bulwahn@gmail.com>
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

Commit b6d09f780761 ("pinctrl: nomadik: Drop U8540/9540 support") removes
the DB8540 pin controller driver and its config PINCTRL_DB8540.

There is some code left-over in the generic nomadik pinctrl driver, i.e.,
drivers/pinctrl/nomadik/pinctrl-nomadik.{ch}, that is still around for the
removed DB8540 pin controller driver.

Remove this remaining dead code.

This issue was discovered with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  6 ------
 drivers/pinctrl/nomadik/pinctrl-nomadik.h | 14 --------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 58c7ac8c7d4d..8fdffbb925aa 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1802,10 +1802,6 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 		.compatible = "stericsson,db8500-pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8500,
 	},
-	{
-		.compatible = "stericsson,db8540-pinctrl",
-		.data = (void *)PINCTRL_NMK_DB8540,
-	},
 	{},
 };
 
@@ -1856,8 +1852,6 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 		nmk_pinctrl_stn8815_init(&npct->soc);
 	if (version == PINCTRL_NMK_DB8500)
 		nmk_pinctrl_db8500_init(&npct->soc);
-	if (version == PINCTRL_NMK_DB8540)
-		nmk_pinctrl_db8540_init(&npct->soc);
 
 	/*
 	 * Since we depend on the GPIO chips to provide clock and register base
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.h b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
index 820f07f4db32..84e297757335 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.h
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.h
@@ -5,7 +5,6 @@
 /* Package definitions */
 #define PINCTRL_NMK_STN8815	0
 #define PINCTRL_NMK_DB8500	1
-#define PINCTRL_NMK_DB8540	2
 
 /* Alternate functions: function C is set in hw by setting both A and B */
 #define NMK_GPIO_ALT_GPIO	0
@@ -173,17 +172,4 @@ nmk_pinctrl_db8500_init(const struct nmk_pinctrl_soc_data **soc)
 
 #endif
 
-#ifdef CONFIG_PINCTRL_DB8540
-
-void nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc);
-
-#else
-
-static inline void
-nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc)
-{
-}
-
-#endif
-
 #endif /* PINCTRL_PINCTRL_NOMADIK_H */
-- 
2.17.1

