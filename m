Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8376F960C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjEGAjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjEGAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFF2EB2C;
        Sat,  6 May 2023 17:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9841614FF;
        Sun,  7 May 2023 00:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DDCC433D2;
        Sun,  7 May 2023 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419703;
        bh=Ms5pa3eIzxgugg6+4zemhi4nvEfjq4kpbHN/gX9gGNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soqmXmfQbcaXfj39WPUVxQUQf6WuI7bBbb1sltxzHun4nEMqElFM4eov1CFpS0ng+
         8KMGoX63gC9DXw+s/t0Qjnqw6J/UfFVUYh/2/BEZgo9EPFOMHY8uczjcS3e9xV2l4J
         +LNhrl3URRFYpEzdy/zqcAQVsAxt431FOUw4d3CkxTyDeH3/HThcusNU2q5H33R57K
         Xlrn9PLeOeJRZddzty1zY/drygc0fVmFmSHWi0aYUMK7gOlir7LIJxWvfZ95ZUvtTm
         Js7Lvjog1TNxXb4ZoIXdy5NI7QCQBnOH1sQQyzVgjU0N5QSqlUSyd87FfL+0IQ66ZG
         qwduWYV1cV4pw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baishan Jiang <bjiang400@outlook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        Syed.SabaKareem@amd.com, mendiebm@gmail.com,
        lub.the.studio@gmail.com, wimvanboven@gmail.com,
        fengwk94@gmail.com, jhunkeler@gmail.com, xazrael@hotmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 13/19] ASoC: amd: yc: Add ThinkBook 14 G5+ ARP to quirks list for acp6x
Date:   Sat,  6 May 2023 20:34:11 -0400
Message-Id: <20230507003417.4077259-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003417.4077259-1-sashal@kernel.org>
References: <20230507003417.4077259-1-sashal@kernel.org>
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
index 9e0c936ebd688..b9d9b385f9b98 100644
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

