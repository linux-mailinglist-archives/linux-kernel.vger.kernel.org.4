Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108687113BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbjEYScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbjEYScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED9D135;
        Thu, 25 May 2023 11:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631C164893;
        Thu, 25 May 2023 18:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB9C4339B;
        Thu, 25 May 2023 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039518;
        bh=30LUA668h7VdTQuEqajPXaMTBzrCOVJwFLuPF9LjHBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f77ZhGjtPRuFcDb3H6pAow3J/NMDGXwIxs+UQeFAS6ttZOmFcfVLekmr79o5TQhyV
         4wEDuJ4lPqJmXnkb3Fzl6ANU1PgXhuL4Xk7eHhJIxEu7O+CtMQAu1E9Jum8jSBdEte
         7lsJ/qgKnSaKtKK3VowbiByjCzr/VJ1kD1rXwTVJln8cEWHlQm5c9XOmvzFH+LJZtr
         mFtcX9hTaHST5q/JBJbWCoYRnX1jdrQdrX1EAHu/W2PPVxGn/G6tJ7ZvD3RI2zl+ml
         Puxl4vqrIjau1bW8hVOAolrgp4cR8tZ/OcqMyxrBoTNde2BzGFqZX2yp3EIkhNBbuR
         ZmkTCSeHvXYqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeremy Soller <jeremy@system76.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mario.limonciello@amd.com, Syed.SabaKareem@amd.com,
        xazrael@hotmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 04/67] ASoC: amd: yc: Add DMI entry to support System76 Pangolin 12
Date:   Thu, 25 May 2023 14:30:41 -0400
Message-Id: <20230525183144.1717540-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Jeremy Soller <jeremy@system76.com>

[ Upstream commit 7b9891ad25246b18b5ccc19518da7abc7763aa0a ]

Add pang12 quirk to enable the internal microphone.

Signed-off-by: Jeremy Soller <jeremy@system76.com
Signed-off-by: Tim Crawford <tcrawford@system76.com
Link: https://lore.kernel.org/r/20230505161458.19676-1-tcrawford@system76.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0acdf0156f075..b844f321d139e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -276,6 +276,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
+		}
+	},
 	{}
 };
 
-- 
2.39.2

