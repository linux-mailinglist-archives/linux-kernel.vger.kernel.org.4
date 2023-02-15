Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6D697D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBON3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjBON3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9F392B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:29:05 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 181B0660218B;
        Wed, 15 Feb 2023 13:29:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676467744;
        bh=Sh4IjgaHokJgqHxuz69NNaDzjOc7kjI45TUUvWgBqN8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZsoQDgIkrIcWTRcE4vZCQzUkyJidWRL35fXuYH8HRY7tkeG8cy60wOgJc0R1PwuHs
         +FtFzU5FhoP24BuLSZKKCLDHvovyGtqwZYomcY3u/ZO9vMqCM1JnjwCMmuNFcbj+ir
         4jl/+mVDQLnRQwqY9LiFsbxjQJfEA52wUS4hBahheD7kBAEPVuBI/GsABKgNdYUFNi
         LZnTNHXPhf8a7rsXWVgvfhmWLlGRP5YenhbaQRlsW5hpC3mB3UOaN/gCwXXDwP+XK4
         /8L0HM+9ovPxUiWKWhOJy1b851URODxuMwAtVcCuhJabbVZVH54k2AFEQK8h/seh7D
         ZJ6G679yk6JHw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream not declared
Date:   Wed, 15 Feb 2023 13:28:51 +0000
Message-Id: <20230215132851.1626881-1-lucas.tanure@collabora.com>
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

Add struct snd_pcm_substream forward declaration

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
Changes since v1:
- Use forward declaration instead of header sound/pcm.h
---
 include/sound/soc-dapm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 77495e5988c1..64915ebd641e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -16,6 +16,7 @@
 #include <sound/asoc.h>
 
 struct device;
+struct snd_pcm_substream;
 struct snd_soc_pcm_runtime;
 struct soc_enum;
 
-- 
2.39.1

