Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC007281E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjFHN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjFHN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:58:02 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65626B3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:58:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5F8D6807B;
        Thu,  8 Jun 2023 21:57:53 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Jun
 2023 21:57:53 +0800
Received: from SD-Server.starfivetech.com (183.27.98.122) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 8 Jun 2023 21:57:52 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] ASoC: starfive: Remove some unused macros
Date:   Thu, 8 Jun 2023 21:57:50 +0800
Message-ID: <20230608135750.11041-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608135750.11041-1-walker.chen@starfivetech.com>
References: <20230608135750.11041-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.122]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are unused and can be dropped.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 sound/soc/starfive/jh7110_tdm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/starfive/jh7110_tdm.c b/sound/soc/starfive/jh7110_tdm.c
index a9a3d52bdd2a..e4bdba20c499 100644
--- a/sound/soc/starfive/jh7110_tdm.c
+++ b/sound/soc/starfive/jh7110_tdm.c
@@ -25,11 +25,8 @@
 #include <sound/soc-dai.h>
 
 #define TDM_PCMGBCR			0x00
-	#define PCMGBCR_MASK		0x1e
 	#define PCMGBCR_ENABLE		BIT(0)
-	#define PCMGBCR_TRITXEN		BIT(4)
 	#define CLKPOL_BIT		5
-	#define TRITXEN_BIT		4
 	#define ELM_BIT			3
 	#define SYNCM_BIT		2
 	#define MS_BIT			1
@@ -42,11 +39,6 @@
 	#define LRJ_BIT			1
 #define TDM_PCMRXCR			0x08
 	#define PCMRXCR_RXEN		BIT(0)
-	#define PCMRXCR_RXSL_MASK	0xc
-	#define PCMRXCR_RXSL_16BIT	0x4
-	#define PCMRXCR_RXSL_32BIT	0x8
-	#define PCMRXCR_SCALE_MASK	0xf0
-	#define PCMRXCR_SCALE_1CH	0x10
 #define TDM_PCMDIV			0x0c
 
 #define JH7110_TDM_FIFO			0x170c0000
-- 
2.17.1

