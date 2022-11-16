Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180E62B6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiKPJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKPJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:39:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7F26489;
        Wed, 16 Nov 2022 01:39:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1034415wmo.1;
        Wed, 16 Nov 2022 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+VhJIT56E3eyqauVp2za8R6dR/zAfRqC25svBjA2II=;
        b=gL7KASVfMY7yKpFvv4CgNTMJMNncFBVfLkz96aQRcU/bjdkksCfmvgS0rinIkpt3OW
         sdLJyAjRuJyREdrMmLBINLLpBTHzrPOYZGenei3C1oCEJqvvi5jaS9t3psKRHuoUyxs1
         te3QCEHFDgr4yabNxKm5zFkk/jloW8yJaSxJ657HVjPsTPeMRxTwb9sq85wytgB9cizx
         y93FaSoibF/FhV6jwHhi4XH3QVo9C3nKn0cINmXpcIiCKjgF83CeMIPlrcCYw1jsZrKH
         yjO7WLFYiNsJ21Nif1l4TJZoyEutqx9ezmq2Kons8f0yHfrdGpEgRp0qkD+NfqnX0od6
         7m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+VhJIT56E3eyqauVp2za8R6dR/zAfRqC25svBjA2II=;
        b=xIzHNdfkBqATPuAKakDbsPUe87hEy640nIjWWUW1uv2nsQWkNEUrQ5pK+To7vxfduF
         TDmIBlIL+WfyzEql5G0KuOSZCmah2KddJZlN+1jkvFsHCO9msERncNc/l4+rQ9BhCUcU
         TjIe6/jIjf1UZtDQKPVap7cZ3PMVXy7BRlJ2Qie9EoTHMFqQqzqDydgEzJo/l+dbCMKT
         iccDnoA2dr790BRswI9ZtZKEda5nDQ5QQA8nJG8B6tX3sU8GW9Ha6560e+GCVjjr9XY/
         Ft6SMZNPHJ7seoy4F5JhGfvx4NHa6rBG5HO2CU2V0GV7HwCKXYAWuNzVqUeTEngKyPiL
         O62g==
X-Gm-Message-State: ANoB5pke3eyS4N+lofhkpQCbO8l/fxx5WxMFHJ7RHHGUcB+/vgm93M9o
        zTJNsZJzfRd66vVZBzDztaQ=
X-Google-Smtp-Source: AA0mqf4sk015FT734mG6coyeEbpO+oFWeDewcyacn59OPoYlwasoeOwPsCRbs37SJd7D6KWGY+z7Tw==
X-Received: by 2002:a05:600c:4fc3:b0:3cf:7d3e:f985 with SMTP id o3-20020a05600c4fc300b003cf7d3ef985mr1636855wmq.7.1668591584286;
        Wed, 16 Nov 2022 01:39:44 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003cf78aafdd7sm1607050wmq.39.2022.11.16.01.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:39:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] samples/hid: Fix spelling mistake "wihout" -> "without"
Date:   Wed, 16 Nov 2022 09:39:43 +0000
Message-Id: <20221116093943.597572-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a comment and a usage message. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 samples/hid/hid_surface_dial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/hid/hid_surface_dial.c b/samples/hid/hid_surface_dial.c
index bceea53d39b0..4bc97373a708 100644
--- a/samples/hid/hid_surface_dial.c
+++ b/samples/hid/hid_surface_dial.c
@@ -4,7 +4,7 @@
  * This program will morph the Microsoft Surface Dial into a mouse,
  * and depending on the chosen resolution enable or not the haptic feedback:
  * - a resolution (-r) of 3600 will report 3600 "ticks" in one full rotation
- *   wihout haptic feedback
+ *   without haptic feedback
  * - any other resolution will report N "ticks" in a full rotation with haptic
  *   feedback
  *
@@ -57,7 +57,7 @@ static void usage(const char *prog)
 		"This program will morph the Microsoft Surface Dial into a mouse,\n"
 		"and depending on the chosen resolution enable or not the haptic feedback:\n"
 		"- a resolution (-r) of 3600 will report 3600 'ticks' in one full rotation\n"
-		"  wihout haptic feedback\n"
+		"  without haptic feedback\n"
 		"- any other resolution will report N 'ticks' in a full rotation with haptic\n"
 		"  feedback\n"
 		"\n"
-- 
2.38.1

