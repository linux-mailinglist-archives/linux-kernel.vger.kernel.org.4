Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001FC697945
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjBOJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjBOJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:47:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DA21A3D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:47:07 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABC386602180;
        Wed, 15 Feb 2023 09:47:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676454425;
        bh=mvxOqqapfj6uQfFYJy5MPiAdOHRW9+w+Kgp5tU5Vt24=;
        h=From:To:Cc:Subject:Date:From;
        b=UOa9ju30eQ5z3xqrvJFXf1I1B4IMdDPpow22dPQQOM9k+1NeZjxer6UzxHum8E2Ci
         6PgpYOGZjLKH32bmBJPvmM4QVB2Rqno0aF6kcjDJ5vAZ8I2lOwka5kVJxStSkyP2ij
         fCIVH++sMw+0/7XhYM2sC6qMR3lRSBECK0l3E8OgEqmcE++cgX8d3PKBoVNZ8AcV0B
         V/JthwmaDpeDbHZe602dGOq6rljDeKi9B7YCNFNfT1NuGWh2z0YnDlK+P0aNxO5Gom
         jibmBynjTl7+cRbRySmQRrGdiXeGit6aRbS1dH0e8MOBcjH0taK9RO6g1B5Lf8SkID
         wbEZLkFI7ILlA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream not declared
Date:   Wed, 15 Feb 2023 09:46:43 +0000
Message-Id: <20230215094643.823156-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound/pcm.h header to include struct snd_pcm_substream used in
snd_soc_dapm_update_dai function.

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 include/sound/soc-dapm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 77495e5988c1..8fbb50a11d80 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -14,6 +14,7 @@
 #include <sound/control.h>
 #include <sound/soc-topology.h>
 #include <sound/asoc.h>
+#include <sound/pcm.h>
 
 struct device;
 struct snd_soc_pcm_runtime;
-- 
2.39.1

