Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B3742D51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjF2TIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjF2TFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68B4687;
        Thu, 29 Jun 2023 12:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F3C61616;
        Thu, 29 Jun 2023 19:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7F1C4339A;
        Thu, 29 Jun 2023 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065346;
        bh=lUWaVxP15HP+vlQfvQOWXvQCRcQtq2JiU6ju/1xpPYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G67n9brB62/5tX3Emb2NBCvrpDK2NI8bn3nRVQj4rXq5VrRWyeoXuxvWQ/5puxuzC
         aRJvkMuPKpSD7ojB8t2FNPpPeF2uiHaofUj0SVHOB4SYHZgpW74KThV6NKBijH/KwC
         liLLhcFLOxjtadTOO8w9fAX+GpTeQs6B7fhp/kWOxCfPPAQkVWwX/tsxx/ou8wt7HE
         zU+DQHCL7ZGt7l51zaOsS+P48Ovbf1B/nJFVEw3SGchP+yR0JsziG1mSHcTTfrh8G4
         ewfys5NLBZArxwT/xXFM69yT0XHP/u9UlWtQabZt+wtUFh4vGa8VvjKP6fx3jyOx7B
         oycWW1Z475hyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/4] can: sja1000: fix size of OCR_MODE_MASK define
Date:   Thu, 29 Jun 2023 15:02:22 -0400
Message-Id: <20230629190225.908451-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190225.908451-1-sashal@kernel.org>
References: <20230629190225.908451-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.319
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Schocher <hs@denx.de>

[ Upstream commit 26e8f6a75248247982458e8237b98c9fb2ffcf9d ]

bitfield mode in ocr register has only 2 bits not 3, so correct
the OCR_MODE_MASK define.

Signed-off-by: Heiko Schocher <hs@denx.de>
Link: https://lore.kernel.org/all/20221123071636.2407823-1-hs@denx.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/can/platform/sja1000.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/platform/sja1000.h b/include/linux/can/platform/sja1000.h
index 5755ae5a47122..6a869682c1207 100644
--- a/include/linux/can/platform/sja1000.h
+++ b/include/linux/can/platform/sja1000.h
@@ -14,7 +14,7 @@
 #define OCR_MODE_TEST     0x01
 #define OCR_MODE_NORMAL   0x02
 #define OCR_MODE_CLOCK    0x03
-#define OCR_MODE_MASK     0x07
+#define OCR_MODE_MASK     0x03
 #define OCR_TX0_INVERT    0x04
 #define OCR_TX0_PULLDOWN  0x08
 #define OCR_TX0_PULLUP    0x10
-- 
2.39.2

