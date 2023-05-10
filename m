Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F726FE59F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjEJUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjEJUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C97901B;
        Wed, 10 May 2023 13:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1506464075;
        Wed, 10 May 2023 20:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E72C433D2;
        Wed, 10 May 2023 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751802;
        bh=BHQh01yXH/sEZyTZkdbBqgBKswF9gB9kcJkbIBvd1F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0xJ6YW55RGQqYGRR4J8EzlrmzUP0MPvstpHmTQMtbmkvy+GbPIHYpwIkpu4MVs+Q
         HpAZ6utumr1p9tRz+qK7iN64UGS/5GYMHVxNJt7FaWgD5V+pQBCmY/yC51pQgLTfgu
         FBSy+hk5dcSllYqi3Zi1VOxWWLJSTctFwUsdAqjT39DoyhHYe94QRzTEe5OmAhzLE4
         julb2VVZY+NNH1nifF7K58N5n38smBOT+MD82uC0fZWdIjvF+dQygmrI2g9ofo52KW
         8J2CJ9rWQQdICsF3WC82EPiIJxz4eF+cXimI6uebDw1nOTj5hmXTLPBZ3VJj86uTMT
         0uCGimZkAcKyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>,
        andy@kernel.org
Subject: [PATCH AUTOSEL 6.1 5/8] mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F to intel_cht_wc_models
Date:   Wed, 10 May 2023 16:49:46 -0400
Message-Id: <20230510204950.104873-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510204950.104873-1-sashal@kernel.org>
References: <20230510204950.104873-1-sashal@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ded99b89d25fd73a1d7bd910378e0339fd9d4c4a ]

The Android Lenovo Yoga Book X90F / X90L uses the same charger / fuelgauge
setup as the already supported Windows Lenovo Yoga Book X91F/L, add
a DMI match for this to intel_cht_wc_models with driver_data
set to INTEL_CHT_WC_LENOVO_YOGABOOK1.

When the quirk for the X91F/L was initially added it was written to
also apply to the X90F/L but this does not work because the Android
version of the Yoga Book uses completely different DMI strings.
Also adjust the X91F/L quirk to reflect that it only applies to
the X91F/L models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230301095402.28582-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 9216f0d34206c..a82b7cb661b7b 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -159,11 +159,19 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	}, {
-		/* Lenovo Yoga Book X90F / X91F / X91L */
+		/* Lenovo Yoga Book X90F / X90L */
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
 		.matches = {
-			/* Non exact match to match all versions */
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+	}, {
+		/* Lenovo Yoga Book X91F / X91L */
+		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
+		.matches = {
+			/* Non exact match to match F + L versions */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
 	},
 	{ }
-- 
2.39.2

