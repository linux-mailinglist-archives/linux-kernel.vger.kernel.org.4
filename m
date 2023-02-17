Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4569A9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBQLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBQLKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430266649
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:36 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3874266021C2;
        Fri, 17 Feb 2023 11:09:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632175;
        bh=b02ydShPBaSHojbDWpln2wCVcx6gcsVv5n+Og/pMkOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJceWvOgsA1IBEJCzLLq3zzFkr90PhXq/97d0JG3ZN+nYgJRFYLXV+cbkE9d+X7sB
         UZL3l4CywbhxsMjlTmXLukXH0rDQzJQr8hsuyc9QOevwEzI5WnMsgBoBCONXuoxpUr
         6rnKDdNizRr9LFoxcD4MrEmdbvNZungx92p2NkI/zHrawdsh5GslQfN0KC5D5egpXC
         PVPNbwDrEPsJ1fMRCF6rVK7vJCuIS2+DnPgEGd4hhr1BIT0Q9BRTbWjY+nutduKzru
         WBASxieF5Jhp7//JqJ/2BkOrQGRBqmZ/zt7Ky+/WhPTC+FVVpuaUHdXiTfAWBj7AjV
         hjwJjXckW9eAA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 4/9] ASoC: amd: vangogh: remove unnecessarily included headers
Date:   Fri, 17 Feb 2023 11:08:45 +0000
Message-Id: <20230217110850.1045250-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217110850.1045250-1-lucas.tanure@collabora.com>
References: <20230217110850.1045250-1-lucas.tanure@collabora.com>
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
index 43c80103d138..a1cd52e58574 100644
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

