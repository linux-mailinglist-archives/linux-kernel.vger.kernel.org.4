Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB76F3832
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjEAThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjEATh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:37:28 -0400
X-Greylist: delayed 2597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 12:35:05 PDT
Received: from durkon.wrar.name (wrar.name [116.203.248.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5D40D9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wrar.name;
        s=20160710; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Content-Disposition:In-Reply-To:References;
        bh=DDk0mv84ix/RSWWUpia4gKlf8DL3/XKnr62jxyEC3kU=; b=qJpGyV3Ijr69nex0WVGhRgMt3r
        +s/WYms0ojxGVsyZDanilWBvcTQH1rREbd1uAZfL4kRKuUEnOAGMP/E9v9DFaoBG0qxuzsngpMJqZ
        QF2iZuOC5MyhKKQ1DBRtJbGGQMNVh5Nw2vHgnku7S0tAQU4b3dLoN1aB0WJmkqKr4ouQ=;
Received: from [212.58.102.86] (helo=malack.wrar.name)
        by durkon.wrar.name with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <wrar@wrar.name>)
        id 1ptYcZ-00Ag1q-2J;
        Mon, 01 May 2023 20:51:35 +0200
Received: (nullmailer pid 34603 invoked by uid 1000);
        Mon, 01 May 2023 18:51:34 -0000
From:   Andrey Rakhmatullin <wrar@wrar.name>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add Asus VivoBook Pro 14 OLED M6400RC to the quirks list for acp6x
Date:   Mon,  1 May 2023 22:51:34 +0400
Message-Id: <20230501185134.34591-1-wrar@wrar.name>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed (and enough) to get the internal mic visible and working.

Signed-off-by: Andrey Rakhmatullin <wrar@wrar.name>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b9958e555367..0208cb0ae978 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -227,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6400RC"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

