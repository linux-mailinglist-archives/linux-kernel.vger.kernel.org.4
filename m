Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033765F2811
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJCFEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJCFD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:03:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DE26ACB
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:03:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g130so8665438pfb.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 22:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ztuWh3+lm3Xgyvy8ErwnYqF7ln3RGH0S/A4OyK3wmIE=;
        b=Hz8TZprhU9xLfxIJDPiq1ixTjaUkHrGur4fPPa52CFjvLABRT995xyhJWJ8w1pt/HX
         HySMjpKk8DIwly7hIZgDp/G/m5E0OlvM9cErN3xt2UTEUFfpeAkJVSqgtG64B52weKIn
         3sJUdQFTYCDzyfRzvyj+a7heHPSPmwzHDY4Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ztuWh3+lm3Xgyvy8ErwnYqF7ln3RGH0S/A4OyK3wmIE=;
        b=f2GjLBE4Lfxo8Z62DB/l993gXGDrGO7Qd5+1Rw6a5XdkMf5i/a3sCOzEONGKXYQSG/
         KOiz9wPqNfKpk723BKqZ2sW3EzGnX3s5rLPB/WuE2RwAMLtrUXa94dwcgjUxIdmYqe8X
         e2UBQyhwRLxW0JbAqyBkbs8qTr7HJZ3oR81Xp09D/bP/vDeFjz22g7CvTgYzbmDAAQJH
         rkOt4UfDpPqbOXwjIiFDrlAoRQ3ay6XQTRfGBimfk3FLzcWnJhtX8okxNPY9++D54ASA
         VHNVRzNBHfKvOXjVoVWXVsBufzCTY+CzHk7pVNCGr60sICXbeKmndSJhRqkACnGneNTf
         XZsw==
X-Gm-Message-State: ACrzQf1LU3FAxizn4oVY6QF67fKQY0gznWTJ6mWra+G+MVmvkAWWZRo7
        chXBoJ8Voaj5WDfO57HvJWxTlA==
X-Google-Smtp-Source: AMsMyM7w6djAOyImUB/oWDtW7Wxj/dH2t2EMQ4LGPYCFTqC3FDUnNEPHJfsbQCiA4dt1fFO01grIFg==
X-Received: by 2002:a05:6a00:14c4:b0:542:cd3a:591e with SMTP id w4-20020a056a0014c400b00542cd3a591emr20437876pfu.27.1664773436673;
        Sun, 02 Oct 2022 22:03:56 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:dfa6:5a1a:b35a:db69])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902b48800b0017680faa1a8sm6174628plr.112.2022.10.02.22.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 22:03:55 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 2/2] drm/bridge: it6505: Add pre_enable/post_disable callback
Date:   Mon,  3 Oct 2022 13:03:35 +0800
Message-Id: <20221003050335.1007931-3-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221003050335.1007931-1-treapking@chromium.org>
References: <20221003050335.1007931-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_pre_enable and atomic_post_disable callback to make sure the
bridge is not powered off until atomic_post_disable is called. This
prevents a power leakage when it6505 is powered off, but the upstream
DRM bridge is still sending display signals.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

(no changes since v1)

 drivers/gpu/drm/bridge/ite-it6505.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 685d8e750b12..27de6652f842 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2992,6 +2992,28 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
 	}
 }
 
+static void it6505_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					    struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_get_sync(dev);
+}
+
+static void it6505_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_put_sync(dev);
+}
+
 static enum drm_connector_status
 it6505_bridge_detect(struct drm_bridge *bridge)
 {
@@ -3026,6 +3048,8 @@ static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.mode_valid = it6505_bridge_mode_valid,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,
+	.atomic_pre_enable = it6505_bridge_atomic_pre_enable,
+	.atomic_post_disable = it6505_bridge_atomic_post_disable,
 	.detect = it6505_bridge_detect,
 	.get_edid = it6505_bridge_get_edid,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

