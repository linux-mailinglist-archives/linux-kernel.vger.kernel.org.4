Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025C73065B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjFNRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjFNRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:54:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2E1FCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:54:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b1fa5a03daso4283431a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686765289; x=1689357289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnqOHTTTXCtHzAI4nZtGUJIradZUu8rnvf23Fm+35KA=;
        b=kThihjQiZvaenq368abci6+2qB+Tu8tZT6p4OZzbJCUQP6eNfcEEhGi6PV+VVW5hlc
         plAMv0bqNc0Px155yO+9v7gOnRdsSL1ZsEwKWJWXpkbT/84xmP8GbcSe7F4Smq7keMpd
         d8XybUrLjHQ9EEmmMiA8VdgFyGZn5LPzFVi6+Dj4ivkqiMGgGeUwTsYtzLwgUTns27p5
         kzDgVr2K4Wtqxq3b8NOkbejZmDfTdcQwAiGZBcUd0TxutEh/DlC7ZRKxTIahcYUMFI34
         mepS60Pjhyi09IifNNnnw4PPw5b7bFQ8CfVUAb2146UOGqJKaxxfwylC6D8ls/JKGOPb
         58zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765289; x=1689357289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnqOHTTTXCtHzAI4nZtGUJIradZUu8rnvf23Fm+35KA=;
        b=Wraw2YDGFSPRTtTT99XBtgImK7SSXFeWwKhxu5WxpmVZS8RI5M8HvSYdjPpYDOnZmJ
         JRVOlDOLmEVDWLBQTsnpAK55bjrj5H8mnRtovWGQbIScWouboICumV/bIsqfPXq8gv7s
         x1tducY4luU42EuF1wE36LjMJ5O3XoRWwk1ni/15oiE/QnLYrL89eRO/+YRSsfE/MzUM
         KFaLppoQxXGJ5I2JU6c6dgAQ+3EHDAYwkA0Q/ijTDfrPuDBE2qI4d/mKHltEzM+8JMUE
         eQsCcI4MnYsG/njMyJzI8rbW5gzUBMFYexLrqamFkbMlG5sbmd/aH7yVaxOetBDPNnxt
         ghuw==
X-Gm-Message-State: AC+VfDzLuciTglDMcvC6KcdTfTJSqdce2p3WVrxxiKCEFpFZ4Ogm2vnq
        yNiH+8Vi+Eb0pYNWAW+/cdjMfYvQHx02xueJ
X-Google-Smtp-Source: ACHHUZ4Scto85S6ugnCrm5ynl9sZR4o9ugUvPmrfzKbjLSlrqOxkw2+rdxOIr93actPsO59Ys91P3g==
X-Received: by 2002:a9d:7452:0:b0:6b1:e0c6:2217 with SMTP id p18-20020a9d7452000000b006b1e0c62217mr12655944otk.32.1686765289231;
        Wed, 14 Jun 2023 10:54:49 -0700 (PDT)
Received: from nelson-Aspire-A315-51.. (226-44-239-45.gointer.net.py. [45.239.44.226])
        by smtp.gmail.com with ESMTPSA id e1-20020a9d63c1000000b006aafe381a12sm6129791otl.48.2023.06.14.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:54:48 -0700 (PDT)
From:   nelsonbogado99 <nelosonbrizue99@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nelson Bogado <nelosonbrizue99@gmail.com>
Subject: [PATCH] drm/tests: Add test case for drm_rect_clip_scaled()
Date:   Wed, 14 Jun 2023 13:54:31 -0400
Message-Id: <20230614175431.6496-1-nelosonbrizue99@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nelson Bogado <nelosonbrizue99@gmail.com>

To evaluate the behavior of the drm_rect_clip_scaled() helper function
with misplaced rectangles and improve the robustness and quality of it.

The new test was executed using the following command:

  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests/
  [01:48:12] ================== drm_rect (10 subtests) ==================
  ...
  [01:48:12] [PASSED] drm_test_rect_clip_scaled_out_of_bounds

Signed-off-by: Nelson Bogado <nelosonbrizue99@gmail.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 76332cd2ead8..b3bfdd420123 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -209,6 +209,58 @@ static void drm_test_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
 
+static void drm_test_rect_clip_scaled_out_of_bounds(struct kunit *test)
+{
+	/* Definition of the rectangles and visible variables */
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/*
+	 * Both rectangles are completely out of bounds, initialize the src,
+	 * dst and clip rectangles with specific coordinates and sizes.
+	 */
+	drm_rect_init(&src, -10, -10, -5, -5);
+	drm_rect_init(&dst, -20, -20, -15, -15);
+	drm_rect_init(&clip, 0, 0, 100, 100);
+
+	/* Function call drm_rect_clip_scaled to determine visibility */
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	/* Check expected results */
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+
+	/*
+	 * Only source rectangle is out of bounds, reinitialize the src,
+	 * dst and clip rectangles with new values.
+	 */
+	drm_rect_init(&src, -10, -10, -5, -5);
+	drm_rect_init(&dst, 0, 0, 10, 10);
+	drm_rect_init(&clip, 0, 0, 100, 100);
+
+	/* Function call drm_rect_clip_scaled to determine visibility */
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	/* Check expected results */
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+
+	/*
+	 * Only source rectangle is out of bounds, reinitialize the src,
+	 * dst and clip rectangles with new values.
+	 */
+	drm_rect_init(&src, 0, 0, 10, 10);
+	drm_rect_init(&dst, -10, -10, -5, -5);
+	drm_rect_init(&clip, 0, 0, 100, 100);
+
+	/* Function call drm_rect_clip_scaled to determine visibility */
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	/* Check expected results */
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+}
+
 struct drm_rect_intersect_case {
 	const char *description;
 	struct drm_rect r1, r2;
@@ -511,6 +563,7 @@ static struct kunit_case drm_rect_tests[] = {
 	KUNIT_CASE(drm_test_rect_clip_scaled_not_clipped),
 	KUNIT_CASE(drm_test_rect_clip_scaled_clipped),
 	KUNIT_CASE(drm_test_rect_clip_scaled_signed_vs_unsigned),
+	KUNIT_CASE(drm_test_rect_clip_scaled_out_of_bounds),
 	KUNIT_CASE_PARAM(drm_test_rect_intersect, drm_rect_intersect_gen_params),
 	KUNIT_CASE_PARAM(drm_test_rect_calc_hscale, drm_rect_scale_gen_params),
 	KUNIT_CASE_PARAM(drm_test_rect_calc_vscale, drm_rect_scale_gen_params),
-- 
2.40.1

