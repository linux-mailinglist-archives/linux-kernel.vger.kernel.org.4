Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9797E5FED5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJNLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJNLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84EE8C7D;
        Fri, 14 Oct 2022 04:47:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso7835927pjv.0;
        Fri, 14 Oct 2022 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=QfsuP3ZsZ4AvnFYz23tB9VOH67OMDsKagGEughG+WJ5xq+Z5Rfp8rr4+JA7KB7nIvt
         LPAL5zPbRMTFjsS29vuMcViKoLyfeqgU3JgnKJ6g88G8eZ8iCyV05BIwQniCQJ/OSEmm
         oUQC9hH9bwa46g7UorexX4k3t3tJkID6a/JOBoO/h7cm7WZp89NEcvS/XhjLxzxrYxrs
         MwWIqHuZxdpxhwd+D0YSCTjB9hLs+265+ioALqO9iKuxKXu1yZ8YUAgXv4Fjhwj+68hl
         YOWRldcNQXhQ0PTXv7Za1Y1d+i7gHWpoMVQR3nFo587Nzn5W7+iaDKZAf+fufY5i5vrs
         aHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=BnZpPVWxm/9lLNkcu+xej5iUrS3kfxQ/+cdcsnuQ9YQulkssIastjaVsCy5MaWALTQ
         Rc1Xv0j8xOgGyQbnJCE4zS89zfIxqJQ72kxO62hkV2Bz2SGstuO6ukZBM4zPfj4u9dLw
         sXiUb/wap760xRqM7xV3PwdG6qeHmsVxrKxKm36PCVSTGzU6dKse4Z+CFfidcBQLi6GZ
         ykkZrNjgDi0juNKeeQWPrdb4fK5A+Fqsu0g64XF4dqrtO+nncUFYG3sVI+g9T3zed7HC
         TD6B9VhBWO+OGWjBEtJDV2K687GJpmLw6GdWGKP1J7bF1SxKTI3E3bMf++qPJTu33HtV
         BQhQ==
X-Gm-Message-State: ACrzQf06Oa068XccT+15QWAx+D5UnRCCC0pOyWIFcaqqR1DKkHRiGrgS
        O/Xrd65btFBKO035Kdr3GFI=
X-Google-Smtp-Source: AMsMyM7XAA9qYwXvvnq+h2y2NKgmlBgUCDtVXJj1OR7i53IMAMY5lxPOa/VZEh3OyZumNX4RKgTxrw==
X-Received: by 2002:a17:903:1105:b0:178:ae31:aad with SMTP id n5-20020a170903110500b00178ae310aadmr4892840plh.3.1665748032892;
        Fri, 14 Oct 2022 04:47:12 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:12 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 01/26] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Fri, 14 Oct 2022 19:45:36 +0800
Message-Id: <20221014114601.15594-2-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

From: Ulf Hansson <ulf.hansson@linaro.org>

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d8762fa3d5cd..088ec34299c8 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -337,27 +338,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
-- 
2.25.1

