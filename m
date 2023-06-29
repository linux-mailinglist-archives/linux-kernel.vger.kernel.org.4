Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A38742D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjF2THD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjF2TFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA34480;
        Thu, 29 Jun 2023 12:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0D161601;
        Thu, 29 Jun 2023 19:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D79C433CA;
        Thu, 29 Jun 2023 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065335;
        bh=lUWaVxP15HP+vlQfvQOWXvQCRcQtq2JiU6ju/1xpPYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBLKM4AbAQNKxJY1hTnIP8r2nLARNd2QTgyvOrvevBEjRrM4jkE4UIfw92CUNbUbi
         q1ZZvKExT7Gvvk0Sxzo9YYEwWHWZ9Ms7zmLT3/sd68I80/bviLvuO8CKcdKC6FH2Us
         0qyxiDVHJdN1bzlRZ2x3uqIwqqZQFJ2nllT0GORzJHxBdBOuK6IW1s1fG3vDFP1/DG
         WstvtFcjiGoHFt92ahOPG7RVXJzVYzfkVEvRwiO0omIo1OytO2Vz+wGay6VM2bJ6aa
         nnnmTtARhn95PoKG3VWiQ2rS6KvpmAzJjXBW//iYt2rl5h6RglyX+nAKtaK6+yT3u9
         FlA480C9IETug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/5] can: sja1000: fix size of OCR_MODE_MASK define
Date:   Thu, 29 Jun 2023 15:02:10 -0400
Message-Id: <20230629190212.908306-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190212.908306-1-sashal@kernel.org>
References: <20230629190212.908306-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.248
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

