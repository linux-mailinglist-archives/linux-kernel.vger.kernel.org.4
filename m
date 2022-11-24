Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3A637A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKXNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiKXNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:46:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B424105A8D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:46:09 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7cYHg023037;
        Thu, 24 Nov 2022 07:45:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=PCU4Pz6VEwUh1O9LfRadkp/i9tn0sdXIUuT+Z2opB2c=;
 b=TCS6JvQTrDcEytg2JdkM+K8wrrs1vyJah4eYGmPpWNjMfPXcn4MgkBL3JraChi3Ts9xt
 0IIVVBVso3A99ffzUyI0Uqmq9a69whZPaAj5tP6Wa0H9h4XN0c+TuwWKalaQMISf20Op
 qScH7g5PsvPsswRhu1UmrBDCzSpE3CuAoX1E9b5YzrmWoAg16MfDRuQTx9ml4/9ntR+M
 y/+XF3Fj9XJVsoGVDCHKJgb/hAwkMbaoIg3uH7HlY7pSN+17h/WHDv2EEkqOoJi+B1pS
 /7GH+ajwSTkk2TcZEXvlLzpI3FGXRBfTJMZe1RRRU1O6NRAMVTC1iWqSUAmBrVPJUnn0 /w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet664v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 07:45:58 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 07:45:56 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 24 Nov 2022 07:45:56 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7B0DCB10;
        Thu, 24 Nov 2022 13:45:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
Date:   Thu, 24 Nov 2022 13:45:55 +0000
Message-ID: <20221124134556.3343784-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221124134556.3343784-1-rf@opensource.cirrus.com>
References: <20221124134556.3343784-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vOPWZzwnsAehjm0bqyk6nRgU7uk7Uc57
X-Proofpoint-GUID: vOPWZzwnsAehjm0bqyk6nRgU7uk7Uc57
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualify the KConfig symbol for cs_dsp by adding a FW_ prefix so that
it is more explicit what is being referred to. This is preparation for
using the symbol to namespace the exports.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/Kconfig  | 2 +-
 drivers/firmware/cirrus/Makefile | 2 +-
 sound/pci/hda/Kconfig            | 2 +-
 sound/soc/codecs/Kconfig         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
index f9503cb481d2..3ccbe14e4b0c 100644
--- a/drivers/firmware/cirrus/Kconfig
+++ b/drivers/firmware/cirrus/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config CS_DSP
+config FW_CS_DSP
 	tristate
 	default n
diff --git a/drivers/firmware/cirrus/Makefile b/drivers/firmware/cirrus/Makefile
index f074e2638c9c..b91318ca0ff4 100644
--- a/drivers/firmware/cirrus/Makefile
+++ b/drivers/firmware/cirrus/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_CS_DSP)		+= cs_dsp.o
+obj-$(CONFIG_FW_CS_DSP)		+= cs_dsp.o
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index a8e8cf98befa..06d304db4183 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -98,7 +98,7 @@ config SND_HDA_SCODEC_CS35L41
 
 config SND_HDA_CS_DSP_CONTROLS
 	tristate
-	select CS_DSP
+	select FW_CS_DSP
 
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6b3726a1ff45..0f9d71490075 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -349,7 +349,7 @@ config SND_SOC_WM_HUBS
 
 config SND_SOC_WM_ADSP
 	tristate
-	select CS_DSP
+	select FW_CS_DSP
 	select SND_SOC_COMPRESS
 	default y if SND_SOC_MADERA=y
 	default y if SND_SOC_CS47L24=y
-- 
2.30.2

