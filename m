Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D869915E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBPKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBPKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0C4DE0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:18 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0682166021A9;
        Thu, 16 Feb 2023 10:33:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543597;
        bh=ZpcE2oB019Vx9W+2McN1zJf+PPUx52lteTlLNDgCDzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToJ0nZWnBnVV2z3olLVYeW1e9I3ZCqwCWY/jXJHAMgZCY5nKJXSs1PCDAa/WhSWwH
         sf0h80qfowBSUv+NgmnoIir+BNBlgfI4ew5KUgiIeoNmSaBBCtFSW/bV4KqKqaTQ1g
         MF3tsLOsM7gtUD1LJdiznqSKKb/D+WLp7gJahIvggxHqdzNuZvEIkRWvqNu1z1OEEu
         ghwQgd/XrgROHQEO4K55OJPdHtsPyDCLyIXrOnV0dVh+ryq2Hp1uIPWvZhCcEi0aau
         /AIvVGBF0XiFlP9hV2PuA7Jx0HmWYyhd8/mDxpf3ucIcwsHk9C49MrfBI5d7i8nBxl
         ZHqgP2edOk2Pg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 4/9] ASoC: amd: vangogh: remove unnecessarily included headers
Date:   Thu, 16 Feb 2023 10:32:55 +0000
Message-Id: <20230216103300.360016-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216103300.360016-1-lucas.tanure@collabora.com>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
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

Remove unused includes and replace <linux/input.h> by
<linux/input-event-codes.h>

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index ec67345bcda4..841b79fa6af5 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -5,23 +5,19 @@
  *
  * Copyright 2021 Advanced Micro Devices, Inc.
  */
+
 #include <linux/acpi.h>
-#include <linux/clk.h>
 #include <linux/dmi.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/input.h>
+#include <linux/input-event-codes.h>
 #include <linux/module.h>
 #include <sound/jack.h>
-#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
 #include "../../codecs/nau8821.h"
-#include "../../codecs/cs35l41.h"
 #include "acp5x.h"
 
 #define DRV_NAME			"acp5x_mach"
-- 
2.39.2

