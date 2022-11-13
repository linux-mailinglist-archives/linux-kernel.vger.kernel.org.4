Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F06271E1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 20:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiKMTAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 14:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiKMTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 14:00:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362063F3;
        Sun, 13 Nov 2022 11:00:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so2961255ejh.0;
        Sun, 13 Nov 2022 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxTTLqwcHAEVAeTuuCkKjXpW6hN/t89uxKi8B+/b3Us=;
        b=h0mWA+rqNs0FF3Zh1fKm41HP9Xj62c+rQ8bNwUKNtKO6WVKVCCIu0+9U9ZvYMxDOMl
         StBcl+UhWp1E1DyRheAqpz8m7F3e0TncByQHRSWGPy4a6U8IcUPF2ytNYRvNzhGaR/4a
         j8PjIoAXjArZGIw/uGaHhqAaHLjNcGGezzWbYpz9HYabxvKO2vxqAUqskkmvnwGlYE2A
         bUbdko5tEWCrE6i3oeEi4d0Sdhb38H1wXWtbFS4wuSaj9s1OG19HQNPXwsDakWNuPSdD
         M45xdzJVTzT+H7oCbQiO/zOuPWz66xo7Ju0RKzPezpjeIe7yqiufAZ9qJtmdLbaN6p9k
         gIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxTTLqwcHAEVAeTuuCkKjXpW6hN/t89uxKi8B+/b3Us=;
        b=MNEiuNejjM5cW8z5fsW7C/EGitm9DkVJhm65HCeRuHgLGa19foHJ2nIL8XuHcew5GT
         jm/Gr8yJKxFyD6+RFkCi4xbMmaMXGHodk8QSlAX43gndb1Vx3nYto16/n/J9++7i3G0W
         /+GhYFNLsTW435atwpNQ50UHRHBW4dvHmbpk6CavoKhkAMDmGhGO3/XzZD8Ar+6qwY+I
         WhCfIdr/wOLylQ72qbWeUsQp3YtjzSNyLLJY4HlPqzwXlw8tVA76de8dG+dHsBL51iYN
         JgEs3bDrN8/ju2QqxJVNrD+0UtWKQZA/Y5nN4Osq3lUmOp7YS4YDVSw/zSwPIWNJTUui
         E+ag==
X-Gm-Message-State: ANoB5pnSK7QGWoLk81WVwC4fahNHwHZjScILQlfT2sysppAUOAoy15zo
        rB8RnOCDNZkoYOkR1hTf+DnMDhON2kuK7Q==
X-Google-Smtp-Source: AA0mqf7FXud15FQ9C8r7ALLFBNw+tg06lna2iVLOM56eOLuyxbkuVt05CgaznIcg9yJ1Xbecm4g7FA==
X-Received: by 2002:a17:906:8556:b0:7ad:e518:13fd with SMTP id h22-20020a170906855600b007ade51813fdmr8141729ejy.323.1668366001007;
        Sun, 13 Nov 2022 11:00:01 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906140900b007a9a56e2a07sm3233809ejc.49.2022.11.13.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:00:00 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/2] platform/surface: aggregator_registry: Add support for Surface Pro 9
Date:   Sun, 13 Nov 2022 19:59:51 +0100
Message-Id: <20221113185951.224759-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113185951.224759-1-luzmaximilian@gmail.com>
References: <20221113185951.224759-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
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

Add device nodes to enable support for battery and charger status, the
ACPI platform profile, as well as internal and type-cover HID devices
(including sensors, touchpad, keyboard, and other miscellaneous devices)
on the Surface Pro 9.

This does not include support for a tablet-mode switch yet, as that is
now handled via the POS subsystem (unlike the Surface Pro 8, where it is
handled via the KIP subsystem) and therefore needs further changes.

While we're at it, also add the missing comment for the Surface Pro 8.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 585911020cea..db82c2a7c567 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -268,6 +268,7 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 8 */
 static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -284,6 +285,23 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 9 */
+static const struct software_node *ssam_node_group_sp9[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_pprof,
+	/* TODO: Tablet mode switch (via POS subsystem) */
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
+	NULL,
+};
+
 
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
@@ -303,6 +321,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 8 */
 	{ "MSHW0263", (unsigned long)ssam_node_group_sp8 },
 
+	/* Surface Pro 9 */
+	{ "MSHW0343", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.38.1

