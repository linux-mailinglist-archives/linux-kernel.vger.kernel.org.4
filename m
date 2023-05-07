Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823396F9588
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjEGAeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjEGAd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B8E19433;
        Sat,  6 May 2023 17:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E28E614DF;
        Sun,  7 May 2023 00:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6448C433D2;
        Sun,  7 May 2023 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419614;
        bh=rHX3+4HNWpaIyjXC4vG2Ai1ck+Uw7+0j3VesE1SKAFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cmxcguh7w7MltJECc50FRCX2OQMTX4GxAbBx88Mtjnr5t6UzFF7a56iSuG6unQc1m
         WbiqdWLDw9wzYouUdNAqj0F51OSIjrq4BaCHrFPIMWs4Rf0EhmWqBu/x8f672O3NqL
         DHqE8Y/BpURVdcgzhNQlyUvVlsa2c3tZaV7TlDnkm6Q7o5Kn/bjvL/R4qtqrkIRwFY
         Bb2R8b80A18rUzUsFL+5GCnTMb4Jtpj5bSe+pV1CEJrUBZSk+AW9tOJVDVe2rwvZBl
         3D31Y8JQWQBcQCiVYVn32+2YciSK5m0bbHFzjelulKByZjId0pjbutjJHkIj+hL0vD
         2Y9aiBRVlOKJw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 15/20] HID: apple: Set the tilde quirk flag on the Geyser 3
Date:   Sat,  6 May 2023 20:32:30 -0400
Message-Id: <20230507003237.4074305-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003237.4074305-1-sashal@kernel.org>
References: <20230507003237.4074305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit 29e1ecc197d410ee59c8877098d54cf417075f7d ]

I was finally able to obtain a MacBook1,1 to test and I've now confirmed
that it has the tilde key quirk as well:

Product    Model  Year  System      CPU    Shape  Labels     Country  Quirky
============================================================================
05ac:0218  A1181  2006  MacBook1,1  T2500  ISO    British    13       Yes

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Link: https://lore.kernel.org/r/20230404024829.13982-1-alexhenrie24@gmail.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 5c145775482bc..e2c73a78b5972 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -875,7 +875,8 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
-- 
2.39.2

