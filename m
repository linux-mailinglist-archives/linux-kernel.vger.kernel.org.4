Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F06A9438
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCCJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCCJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:34:58 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE91421B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:34:55 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 44D71240002;
        Fri,  3 Mar 2023 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677836093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPN/c3ipGWQR2bm5yNDVoKeti4qZhppCJONmVazuaCg=;
        b=Ajil5Dx2W9lyJXw8nlQ5udAC8XIZHc77lK2KbEGwbqJzeLdz+nnFA+hzJ9+zpOn2KKLkuR
        wVy9khYUqsWqyeDWJ+vmRRDqmoqBollU6q9HZaBFp+JXwFKyRy5fhBSM9LfUFsdIaspwDh
        ZcQT7QDVx+o/faXFKfcXcstlFVQJNGd1AeuCbVtBNd/MhGFWVK33z9j7zuyrYZdwvUnLNe
        KpprY5zxwRWJIOWWiTnJhauST0OJssoOk0huljVIO+OSRDG2vfDnDwuQEC7sxxLyvqKQfm
        FNZZT6UX6x/iOohN9+A9J5qKA40+vtPbXYHLRfCUsd5IoWg2nfcFMGR0zvJ0Yg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     alsa-devel@alsa-project.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: clarify that SND_SOC_IMX_SGTL5000 is the old driver
Date:   Fri,  3 Mar 2023 10:34:10 +0100
Message-Id: <20230303093410.357621-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both SND_SOC_IMX_SGTL5000 and SND_SOC_FSL_ASOC_CARD implement the
fsl,imx-audio-sgtl5000 compatible string, which is confusing. It took a
little research to find out that the latter is much newer and it is
supposed to be the preferred choice since several years.

Add a clarification note to avoid wasting time for future readers.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Viorel Suman <viorel.suman@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/fsl/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 614eceda6b9e..33b67db8794e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -294,6 +294,10 @@ config SND_SOC_IMX_SGTL5000
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
 
+	  Note that this is an old driver. Consider enabling
+	  SND_SOC_FSL_ASOC_CARD and SND_SOC_SGTL5000 to use the newer
+	  driver.
+
 config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
 	select SND_SOC_IMX_PCM_DMA
-- 
2.34.1

