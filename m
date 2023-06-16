Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7409732E34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbjFPKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbjFPK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44F49DC;
        Fri, 16 Jun 2023 03:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6123B6356C;
        Fri, 16 Jun 2023 10:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99228C433C8;
        Fri, 16 Jun 2023 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911208;
        bh=8YCPQa2X4QTcHRnnV0hdZsWBdlZBqIomQ70I0X5aPZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqB9A6lNl+deHxpGSfV+zOKxq15MIVymhze7VDX6tbGTNJo0UpLDq/IRa+IcQIW1O
         0BEBYZbFcyuWi0Q1hKQ3PLH8A0mPqgz6YVuAowQYT9cppVDHBREF/FOw57SwWh+2LU
         Htf2HscW+GgZ/LeNmwMd0dIn1ZSAI9yfLBbSnpg4kPtnhb33jeB109LPebkh8Z7blr
         ONnNUKI657rg5BfEBoj2eOLDqbzgOAQSeGXhxuPh6PBhksjiJV0vHKGKicpQ6JxOEF
         lNFhBZw4JcZZ5836w3DZSYI1oQuTFI9ForKknwi8u9EUuFu+e22y7mgtqzAky3OjdY
         An1et+J8D0OSA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sicong Jiang <kevin.jiangsc@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        Syed.SabaKareem@amd.com, xazrael@hotmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 11/26] ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x
Date:   Fri, 16 Jun 2023 06:26:08 -0400
Message-Id: <20230616102625.673454-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
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

From: Sicong Jiang <kevin.jiangsc@gmail.com>

[ Upstream commit 57d1e8900495cf1751cec74db16fe1a0fe47efbb ]

Thinkpad Neo14 Ryzen Edition uses Ryzen 6800H processor, and adding to
quirks list for acp6x will enable internal mic.

Signed-off-by: Sicong Jiang <kevin.jiangsc@gmail.com>
Link: https://lore.kernel.org/r/20230531090635.89565-1-kevin.jiangsc@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 84b401b685f7f..c1ca3ceac5f2f 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

