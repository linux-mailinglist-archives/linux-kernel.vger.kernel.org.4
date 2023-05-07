Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D06F9586
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjEGAed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEGAdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2437EC7;
        Sat,  6 May 2023 17:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B831E614DA;
        Sun,  7 May 2023 00:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4699DC433D2;
        Sun,  7 May 2023 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419605;
        bh=r5FfBb6CW8nFU+ZiL/0R/JZ8Lr7kbtLOcztZ1Sk9VyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQfT0e4tbOojibL92U6OAosnVAsQP95pGknt1fuJ/4DpU954g4zgNsBo0EZH0wEhg
         u7BINaFLDa6vWktbfCoW9/AkKOARnQ6ONjs9f+dTzBP0dUgmNxJ+hUq1vrHUjPpBbY
         WCb1x9Q/GdJ/y5AWrDo+zmIfB7iXuiYe83lhPNgIAqTZx4iilR8XrglPlx+t7GT7cK
         b5mveYpDpymaMDdWSgbHzqfttiH6R9T/tVRYdS5v8+YTh3VYD5to1ub5r9uBLXlm9V
         jYfXaR/tYx3qmOPMf+gn5RAe8ag8MLqHasmRNwRz1SpZ1ozrHd/tN9BrrJuJR3M+02
         QDp/MVp61vG+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cem Kaya <cemkaya.boun@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        Syed.SabaKareem@amd.com, dukzcry@ya.ru, jhunkeler@gmail.com,
        gbrohammer@outlook.com, lub.the.studio@gmail.com,
        aniol@aniolmarti.cat, fengwk94@gmail.com, xazrael@hotmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.2 13/20] ASoC: amd: Add Dell G15 5525 to quirks list
Date:   Sat,  6 May 2023 20:32:28 -0400
Message-Id: <20230507003237.4074305-13-sashal@kernel.org>
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

From: Cem Kaya <cemkaya.boun@gmail.com>

[ Upstream commit faf15233e59052f4d61cad2da6e56daf33124d96 ]

Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that
internal mic works.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217155
Signed-off-by: Cem Kaya <cemkaya.boun@gmail.com>
Link: https://lore.kernel.org/r/20230410183814.260518-1-cemkaya.boun@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ce6630318858e..9e0c936ebd688 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

