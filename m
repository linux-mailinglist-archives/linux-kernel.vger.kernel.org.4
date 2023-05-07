Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774776F9559
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjEGAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjEGAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEAB1C0F5;
        Sat,  6 May 2023 17:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB93611B6;
        Sun,  7 May 2023 00:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2698C433D2;
        Sun,  7 May 2023 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419478;
        bh=Q2l8J41OyU469PilNyQEOpqfFO7xRFpbCy4X7cgypcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceEQ9thejsLBc+KNiikYH8tyYiXHSvy5YzQ3rSDpKVFL6KloKHTsZ5vd1gslrq3hN
         rRY5KGl+pf+DTjVft+UeYMAWRbzQy2OQvh1bCLEQY+xr4PriYO2HokQEoufOd0od2f
         UEwxoZlRWyNleXTnx8VVjIRX7oa0/lxmJnUOqld1eB39A4GjFZBR2cVyap+Hl8I+ZX
         9suKBBPgOLbT0jvSylDV7yobv1/xTSO7K1Tlh5QAJUZHWoceLdIvN7dV63pOfp02y5
         ccBuFe3WwDp1jNmLvkH9h1s+jSld4SY6NVDwg7fRu/FmeBMNb44OZdNI+FSkYJezs2
         bYmuXVWPJLhjg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baishan Jiang <bjiang400@outlook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        Syed.SabaKareem@amd.com, dukzcry@ya.ru, putr4.s@gmail.com,
        fengwk94@gmail.com, xazrael@hotmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 17/24] ASoC: amd: yc: Add ThinkBook 14 G5+ ARP to quirks list for acp6x
Date:   Sat,  6 May 2023 20:30:13 -0400
Message-Id: <20230507003022.4070535-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
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

From: Baishan Jiang <bjiang400@outlook.com>

[ Upstream commit a8f5da0bf4d85a6ad03810d902aba61c572102a6 ]

ThinkBook 14 G5+ ARP uses Ryzen 7735H processor, and has the same
microphone problem as ThinkBook 14 G4+ ARA.

Adding 21HY to acp6x quirks table enables microphone for ThinkBook
14 G5+ ARP.

Signed-off-by: Baishan Jiang <bjiang400@outlook.com>
Link: https://lore.kernel.org/r/OS3P286MB1711DD6556284B69C79C0C4FE19B9@OS3P286MB1711.JPNP286.PROD.OUTLOOK.COM
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1d59163a882ca..b9958e5553674 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -185,6 +185,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21EN"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

