Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E86F9572
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjEGAeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjEGAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E91E98B;
        Sat,  6 May 2023 17:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF69614C9;
        Sun,  7 May 2023 00:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9C6C433D2;
        Sun,  7 May 2023 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419588;
        bh=ZhqomB73I32kP61xKVm31O65xmH95OhFb7cvG67S7Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kY1jwuHhnVv3JmHFxOGeHnJbu8p0SMYXHdkiOX/84lK4avRHY4PWwjc6SDJivShkz
         pdwmi6CATAJKWdkR1Qq39qgqyrB5FtV4lEphjl4xtarpPpACqdK2Byf1Jbc6Xp6fs2
         /xBeuQ6GJPWFZAUxB/kZbzzrTlqin+0Hd0sX6afGtV9+9uWlkhNYG0Sv4lYHk7Sa4Z
         HtE34Dq/AzpLWvL22VOMggzcd6nkwCqAg4F+8j+DpaWiBHJBDXynYTd6X1aYRfSCDT
         OxhaF8XaA+CjD2YviEXxs4tTmpqmvFG51UuRIFtz5qfbosYDZHhHvCuKajx2srxTic
         laWAGEN8fKWdA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prajna Sariputra <putr4.s@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        Syed.SabaKareem@amd.com, dukzcry@ya.ru, fengwk94@gmail.com,
        lub.the.studio@gmail.com, xazrael@hotmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.2 07/20] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)
Date:   Sat,  6 May 2023 20:32:22 -0400
Message-Id: <20230507003237.4074305-7-sashal@kernel.org>
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

From: Prajna Sariputra <putr4.s@gmail.com>

[ Upstream commit ee4281de4d60288b9c802bb0906061ec355ecef2 ]

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Prajna Sariputra <putr4.s@gmail.com>
Link: https://lore.kernel.org/r/2283110.ElGaqSPkdT@n0067ax-linux62
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360c..ce6630318858e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -262,6 +262,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A42"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

