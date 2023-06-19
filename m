Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA973601D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFSX0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFSXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:24:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA419B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:22:59 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1acdfbe1c78so489760fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687216979; x=1689808979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfNSjXBuKM+6HmRYQwLz0qjo1KyosHUhRL762fqxh/Q=;
        b=YfueofKuZCq1gjJQCocUP0jH/vW8oFVQ/MMoPlx1CMUR8F6HKbGq21PKfl4GMU6+ky
         qJjgFvlgJdb7XNJNun2MmumQSmCKP2II5bA2lSIH6NphuFUcV8sQsFAd2XgUIAQBsiKl
         cKlDFYHgBiahiM6sdhgfyBQSpvUCUqTXphzkSyLrarWtKK4JNUuIJ6za9ZNJOJj6ByMR
         iuNIl3ABvl9DNIHvTnWivixI9P2tNS2scWRIDBFAgX93KXlbn+hCvldq4jMQ0fhEvJ/5
         3sbmgTWS20kDyBhHpco29vkDbhW4E1p8B6UZ0tZ+DuQytHL2V3SeoeJKnSiUo5FKWDee
         bIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216979; x=1689808979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfNSjXBuKM+6HmRYQwLz0qjo1KyosHUhRL762fqxh/Q=;
        b=EpWOHKGRhKPFnXxbH93CZCqkAPzKqiprPZclw/DhgdRUahDU9xdgsxuN4pnurUoCpx
         DgiCDX2DlUfhM9FUzC3RcKKTLossJlL6OaB0nMAoW/49UXlZYRr0vBf5FSXgvs0Mayoa
         /oyXF8dEgMCijC5jZBopgBUu62tN2j1kURsD9l5Hk0sW0udkX+eUNjzZNWLobwEQcphz
         jZ1JFSb0F7TIUz0AoyrFagtdXqtqt46Wg7D54VJQBSa5GiDXwNBzsTbtiRykWmwHLXUT
         IynkcAirLHUSjsbB/ut+NTEqxMsbvGS+LJNnw+dfMl6BjP2JLlth68dKihXCdgVaqsjC
         Wcyg==
X-Gm-Message-State: AC+VfDyebk+Aw31mezo4Yh7je/RMsfgTyBCAuaeGHo/vsz5Nxgu70nw7
        X2769n2pxYa0XX4rHWylX3AcIBPaBSgetg==
X-Google-Smtp-Source: ACHHUZ79aiTlm+f1fr7phm2qA0RkHfoC/RIknkfD4npcLFTuyyI2i+EJy8x/SFu0pQnoBzgY52IOdw==
X-Received: by 2002:a05:6870:3845:b0:1a9:9847:b485 with SMTP id z5-20020a056870384500b001a99847b485mr7133046oal.2.1687216978844;
        Mon, 19 Jun 2023 16:22:58 -0700 (PDT)
Received: from nelson-Aspire-A315-51.. ([181.124.133.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a056870d18400b0019f4f5c8298sm482474oac.56.2023.06.19.16.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:22:58 -0700 (PDT)
From:   edagarmarjara <edgarmarjara@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        edagarmarjara <edgarmarjara@gmail.com>
Subject: [PATCH] Tercera entrega completa
Date:   Mon, 19 Jun 2023 19:22:49 -0400
Message-Id: <20230619232249.16319-1-edgarmarjara@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/tests/drm_rect_test.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index e9809ea32696..d03e1d9b208d 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -35,6 +35,7 @@ static void drm_test_rect_clip_scaled_div_by_zero(struct kunit *test)
 	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
 
+
 static void drm_test_rect_clip_scaled_not_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
@@ -196,11 +197,40 @@ static void drm_test_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
 
+static void drm_test_rect_clip_over_scaled_signed_vs_unsigned(struct kunit *test)
+{
+	
+	const void* gem_params(const void *prev, char *desc); 
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/*
+	 * 'clip.x2 - dst.x1 >= dst width' could result a negative
+	 * src rectangle width which is no longer expected by the
+	 * code as it's using unsigned types. This could lead to
+	 * the clipped source rectangle appering visible when it
+	 * should have been fully clipped. Make sure both rectangles
+	 * end up invisible.
+	 * en esta parte cambio los valores y hago por aun mas afuera para el clip scaled
+	 * para poder saber si al exagerar mas aun la escala sigue funcionando
+	 */
+	drm_rect_init(&src, 2, 2, INT_MAX, INT_MAX);
+	drm_rect_init(&dst, 2, 2, 4, 4);
+	drm_rect_init(&clip, 6, 6, 3, 3);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+	
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+}
+
+
 static struct kunit_case drm_rect_tests[] = {
 	KUNIT_CASE(drm_test_rect_clip_scaled_div_by_zero),
 	KUNIT_CASE(drm_test_rect_clip_scaled_not_clipped),
 	KUNIT_CASE(drm_test_rect_clip_scaled_clipped),
 	KUNIT_CASE(drm_test_rect_clip_scaled_signed_vs_unsigned),
+	KUNIT_CASE(drm_test_rect_clip_over_scaled_signed_vs_unsigned), //Test entrega 2
 	{ }
 };
 
-- 
2.34.1

