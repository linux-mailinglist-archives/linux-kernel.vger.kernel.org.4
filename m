Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC25E9BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiIZIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiIZIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:08:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06750B4D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t14so8892106wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Kl561rbA3hT35T5DOSGEMOspKdL6/HXZwIpKjtLQhzI=;
        b=h8zG35o+rGXR+Cz+ZMtvh1hXnqy9ljYpTpKQ6j9+Q0Puy1iTAzZr+oO//gN+jaKGpE
         +rPLKk+vB2ydMnXvkE+6vbB7qpRLrWQ+fTcbzDr5CcwayZ9wGHJhrnQu40/40PRwuiOT
         d+cr6rgVLwV2EwA+sssMjePuf3NMZIMMoExjKOMDlnUeUTqiWecywwYjGGZ/mqPrYD9W
         OlE3UmhZresjpbNFfa+vq4L24GJBJ+cNW0owAwe8xG0xIXq1R2CbGACYfpWalSwajsy3
         UuV79DEVMESW7AO0vRl9qvTET97hylsDi1dcXEO7SuV5XKk8NxWObD25mu6uBRAcma+h
         cEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kl561rbA3hT35T5DOSGEMOspKdL6/HXZwIpKjtLQhzI=;
        b=DufnEARh4TSHav/Gmd78uhD95YaM+E8kfEJMttxofv6UPEq0nW+dwb6I+xJcdiU7wz
         dAHTeyrICZEiPPw996frwd9ssfytuRtIYb0PVn3z7WOimi/3lmTCO1w0NFjvJkXafcoq
         OTpbmVGSRK1qjIDjpMyMQ96ReelmpO55BiRssh8zPDRRikoDHLum6ytCcNAYZFdjYBOM
         74KkzxGD9Mcj3/TcRM+zrW05D/Ip76zvZUSXWxvrLG9Oq7EquvJ5fzSl3S3WgBlyzoSO
         +fIeO2FwBxSJoJMPpWsghLhX0MU57Fl57TnfNM+WJ20gYdybwpW4wkAkEdkFCcECaoEG
         C2Ig==
X-Gm-Message-State: ACrzQf0Vm3EwfXWedjpINmdwQie60Ygi2D1djk3nT+CWigoQ+dq5SrYP
        xa7gOzB43fmEsO2MPoM0DbU=
X-Google-Smtp-Source: AMsMyM4uyzp01GdYg4n9/evvnjs3Hl+DnQ7+usgWJ8d52IZaa0ZqZIiLN2ibgxVWcNKAhzwrAKaYhQ==
X-Received: by 2002:a5d:4342:0:b0:22c:9161:7776 with SMTP id u2-20020a5d4342000000b0022c91617776mr6198259wrr.228.1664179729529;
        Mon, 26 Sep 2022 01:08:49 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d6642000000b0022ac61ebb14sm13421078wrw.22.2022.09.26.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:08:49 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 2/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()
Date:   Mon, 26 Sep 2022 10:08:36 +0200
Message-Id: <20220926080837.65734-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926080837.65734-1-jose.exposito89@gmail.com>
References: <20220926080837.65734-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing test cases to test the conversion from XRGB8888 to
XRGB2101010.

In order to be able to call drm_fb_xrgb8888_to_xrgb2101010() when
compiling CONFIG_DRM_KMS_HELPER as a module export the symbol.

Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/drm_format_helper.c           |  1 +
 .../gpu/drm/tests/drm_format_helper_test.c    | 63 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 4afc4ac27342..e2f76621453c 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -553,6 +553,7 @@ void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *d
 	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false,
 		    drm_fb_xrgb8888_to_xrgb2101010_line);
 }
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010);
 
 static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index bc830601e7a2..4a2f3c0de060 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -32,6 +32,11 @@ struct convert_to_rgb888_result {
 	const u8 expected[TEST_BUF_SIZE];
 };
 
+struct convert_to_xrgb2101010_result {
+	unsigned int dst_pitch;
+	const u32 expected[TEST_BUF_SIZE];
+};
+
 struct convert_xrgb8888_case {
 	const char *name;
 	unsigned int pitch;
@@ -40,6 +45,7 @@ struct convert_xrgb8888_case {
 	struct convert_to_rgb332_result rgb332_result;
 	struct convert_to_rgb565_result rgb565_result;
 	struct convert_to_rgb888_result rgb888_result;
+	struct convert_to_xrgb2101010_result xrgb2101010_result;
 };
 
 static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
@@ -61,6 +67,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = { 0x3FF00000 },
+		},
 	},
 	{
 		.name = "single_pixel_clip_rectangle",
@@ -83,6 +93,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = 0,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = { 0x3FF00000 },
+		},
 	},
 	{
 		/* Well known colors: White, black, red, green, blue, magenta,
@@ -132,6 +146,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
 			},
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 0,
+			.expected = {
+				0x3FFFFFFF, 0x00000000,
+				0x3FF00000, 0x000FFC00,
+				0x000003FF, 0x3FF003FF,
+				0x3FFFFC00, 0x000FFFFF,
+			},
+		},
 	},
 	{
 		/* Randomly picked colors. Full buffer within the clip area. */
@@ -175,6 +198,14 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			},
 		},
+		.xrgb2101010_result = {
+			.dst_pitch = 20,
+			.expected = {
+				0x03844672, 0x0444D414, 0x2A20300C, 0x00000000, 0x00000000,
+				0x1B1705CD, 0x03844672, 0x0444D414, 0x00000000, 0x00000000,
+				0x2A20300C, 0x1B1705CD, 0x03844672, 0x00000000, 0x00000000,
+			},
+		},
 	},
 };
 
@@ -319,10 +350,42 @@ static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
+static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_xrgb2101010_result *result = &params->xrgb2101010_result;
+	size_t dst_size;
+	__u32 *buf = NULL;
+	__u32 *xrgb8888 = NULL;
+	struct iosys_map dst, src;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_XRGB2101010,
+				       result->dst_pitch, &params->clip);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	iosys_map_set_vaddr(&dst, buf);
+
+	xrgb8888 = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
+	iosys_map_set_vaddr(&src, xrgb8888);
+
+	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
+	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
+}
+
 static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_xrgb2101010, convert_xrgb8888_gen_params),
 	{}
 };
 
-- 
2.25.1

