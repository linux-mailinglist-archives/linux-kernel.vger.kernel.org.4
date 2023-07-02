Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AABD744CAF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGBITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 04:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjGBITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 04:19:35 -0400
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05CD10E6;
        Sun,  2 Jul 2023 01:19:22 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from  (unknown[183.194.157.248])
        by rmsmtp-lg-appmail-33-12047 (RichMail) with SMTP id 2f0f64a132f5463-07581;
        Sun, 02 Jul 2023 16:19:04 +0800 (CST)
X-RM-TRANSID: 2f0f64a132f5463-07581
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v1 3/3] MAINTAINERS: Add entries for TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
Date:   Sun,  2 Jul 2023 16:18:57 +0800
Message-Id: <20230702081857.799693-3-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702081857.799693-1-13916275206@139.com>
References: <20230702081857.799693-1-13916275206@139.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MAINTAINERS entries for TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS.

Signed-off-by: Shenghao Ding <13916275206@139.com>
---
 MAINTAINERS | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6621aec58f9..16deb2a1fd89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21040,6 +21040,38 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
+TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+M:	Shenghao Ding <shenghao-ding@ti.com>
+M:	Kevin Lu <kevin-lu@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/tas2552.txt
+F:	Documentation/devicetree/bindings/sound/tas2562.yaml
+F:	Documentation/devicetree/bindings/sound/tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/tas27xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
+F:	include/sound/tas2*.h
+F:	include/sound/tlv320*.h
+F:	include/sound/tpa6130a2-plat.h
+F:	sound/pci/hda/tas2781_hda_i2c.c
+F:	sound/soc/codecs/pcm1681.c
+F:	sound/soc/codecs/pcm1789*.*
+F:	sound/soc/codecs/pcm179x*.*
+F:	sound/soc/codecs/pcm186x*.*
+F:	sound/soc/codecs/pcm3008.*
+F:	sound/soc/codecs/pcm3060*.*
+F:	sound/soc/codecs/pcm3168a*.*
+F:	sound/soc/codecs/pcm5102a.c
+F:	sound/soc/codecs/pcm512x*.*
+F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/tlv320*.*
+F:	sound/soc/codecs/tpa6130a2.*
+
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	dmaengine@vger.kernel.org
-- 
2.34.1


