Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC66FE587
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjEJUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEJUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831D6E9D;
        Wed, 10 May 2023 13:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF20964077;
        Wed, 10 May 2023 20:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005BFC4339B;
        Wed, 10 May 2023 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751783;
        bh=+CClwmlhhoXRV/flrOSGPQcZOJ5y9G17Co5fZemzFmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCYb5JMuX4ac72m8RJ1UY3DMl6QZBQDHDZK6hpeypTP36i9la6gDVGaUKynRUxk0/
         dDTa5+1bn+FaJ+UY6ueD74bIqoy7JBBkCFnnvgizXpGyqnL4pla6PPEfMPFG1KYB9K
         J7jpEhWln9VH4hW/y+1h6qluprzEtP1KkkEIOSPxGqGGjMvRBcjxMpWNjEglSFMqnC
         X8jTLB+YttqWwFHA7GE0g2da1Zpnh2uJLRjTyEDhLLDfS3EGcJCGxJkP5KJnosITUz
         KhdJ4aS2LIQEhKk0vD+YB+rlHMBjN+us49xlS2u/ZbnTv9+0ypOlP2B/8NNogZwSi5
         /5u0QdVBygWAQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugene Huang <eugene.huang99@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.2 2/9] soundwire: dmi-quirks: add remapping for Intel 'Rooks County' NUC M15
Date:   Wed, 10 May 2023 16:49:19 -0400
Message-Id: <20230510204926.104747-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510204926.104747-1-sashal@kernel.org>
References: <20230510204926.104747-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Huang <eugene.huang99@gmail.com>

[ Upstream commit 01b33e284ca28cc977bdcfb23be2c719f2139175 ]

Same DSDT problem as the HP Omen 16-k0005TX, except rt1316 amp is on
link2.

Link: https://github.com/thesofproject/linux/issues/4088
Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230314090618.498716-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/dmi-quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 7969881f126dc..58ea013fa918a 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -73,6 +73,23 @@ static const struct adr_remap hp_omen_16[] = {
 	{}
 };
 
+/*
+ * Intel NUC M15 LAPRC510 and LAPRC710
+ */
+static const struct adr_remap intel_rooks_county[] = {
+	/* rt711-sdca on link0 */
+	{
+		0x000020025d071100ull,
+		0x000030025d071101ull
+	},
+	/* rt1316-sdca on link2 */
+	{
+		0x000120025d071100ull,
+		0x000230025d131601ull
+	},
+	{}
+};
+
 static const struct dmi_system_id adr_remap_quirk_table[] = {
 	/* TGL devices */
 	{
@@ -98,6 +115,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
-- 
2.39.2

