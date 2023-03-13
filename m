Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48B6B6E65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCMEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMEW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:22:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A513D91F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:22:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so5048463plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucdavis.edu; s=google; t=1678681345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=No+4CxSofQQCbiLutPb6SUUcEj/2X/+hpRalVCwfJ+o=;
        b=jQMENLAj7LXoeXFTzN7ugEMp8kDdiCCdWLNg9bt/y2zv7Pf8/Ux7hCt1eUkkwj2SiK
         r69fPqeJfda0dpbs1W9bUYCQSmNyo7dqFu/ow81Nr+/vo2X+c9K6a2MwW03krfcBBIbT
         TpACBmipaXfgsxemTx8onbKtgZrJEeXOLp84k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No+4CxSofQQCbiLutPb6SUUcEj/2X/+hpRalVCwfJ+o=;
        b=aAyIac0UvS/zBl2OwhzVYt44TaA5fBSDVed05fu7kcGiPhIS/PhEtvzqsFHNB4B4uy
         vP4uxejx42No+thd20iDzAJ3eY0Uf1gspjwvgRvAfH59Lm55HOzd9WSqv7B54g6LTSyz
         vRFVJwqjYnk5iq0NGB4IJ2igdlD2BOL967DrZoNuHzAAsT5C67hQRCELnwHUQJbH2Mef
         vhzMWQU132UedhFhgBhlWD4AF6NGlTBxx+S9EahREIyUvu6voCWqSEdmiHEwRc3mEpgx
         fLvSTOCTptYzRnTL0SQZM4vFgtWEYscRigZXT5kWgDXRHWTGpwgIxbGtZki8t9DSOlqW
         2v6w==
X-Gm-Message-State: AO0yUKUH+9shfZHsF/TTnInpWLwPLvbU+jRONU7QbsRaPOyj5AGf6/ZE
        WZ/JpMgJIwGtbLd+Y/WUvLDFXLi3Ki3n/UmGUb8=
X-Google-Smtp-Source: AK7set9hFuyGos8VeNaEoV2SoJr+bG6xtUpM37LE0eKLPs5Xf6vewQsWGZlJVV5L9436V+pETNaM3w==
X-Received: by 2002:a17:90b:1b52:b0:237:b64c:6bb3 with SMTP id nv18-20020a17090b1b5200b00237b64c6bb3mr35355593pjb.11.1678681345284;
        Sun, 12 Mar 2023 21:22:25 -0700 (PDT)
Received: from phys-kvch7750.hsd1.ca.comcast.net ([2601:200:c002:b110:401b:1b94:9501:c277])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090328cf00b0019a5aa7eab0sm3641982plb.54.2023.03.12.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:22:24 -0700 (PDT)
From:   keerthi <kvch@ucdavis.edu>
To:     linux-kernel@vger.kernel.org
Cc:     keerthi <kvch@ucdavis.edu>
Subject: [PATCH] tools/laptop/dslm/dslm.c : Fixed a comment style issue
Date:   Sun, 12 Mar 2023 21:22:22 -0700
Message-Id: <20230313042222.27744-1-kvch@ucdavis.edu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the styling of the comments

Signed-off-by: keerthi <kvch@ucdavis.edu>
---
 tools/laptop/dslm/dslm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/laptop/dslm/dslm.c b/tools/laptop/dslm/dslm.c
index d5dd2d4b04d8..e62a470b79e8 100644
--- a/tools/laptop/dslm/dslm.c
+++ b/tools/laptop/dslm/dslm.c
@@ -23,9 +23,11 @@
 
 int endit = 0;
 
-/* Check if the disk is in powersave-mode
+/*
+ * Check if the disk is in powersave-mode
  * Most of the code is stolen from hdparm.
- * 1 = active, 0 = standby/sleep, -1 = unknown */
+ * 1 = active, 0 = standby/sleep, -1 = unknown
+ */
 static int check_powermode(int fd)
 {
     unsigned char args[4] = {WIN_CHECKPOWERMODE1,0,0,0};
-- 
2.39.0

