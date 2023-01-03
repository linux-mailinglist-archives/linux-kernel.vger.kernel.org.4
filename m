Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC565C4A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjACREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbjACRCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:02:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CA13E35;
        Tue,  3 Jan 2023 09:01:12 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:abfa:cf23:1e4e:2b14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E52F6602CDE;
        Tue,  3 Jan 2023 17:01:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672765271;
        bh=9um+KEVR7P+gZc2gYPj/3g5J+YLW4FhxyxYBCrnBhZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvSm4baQOwhZ4B92OKP2cfiFaP97PX590UiGpe8i/DFSfM/OTe9xqnhJrSDIEYoaN
         r2u2IHfIOIrSUD72PVhdh339P3PFt54Jx1lcY7CJFpxu2bVUyrqk4cIImAFZSXqaHT
         56t4E5BsKZphYMvYlCBYyr46kMotb1EWm/0WTUVCjQ4fgAYSageHKtjGh3BQxM6el/
         +wc9kaVA7ybWGXXecPX3zseTjcXsxw6SlNWeiLA4AX4Jh/CaalpGDg9eQ+fHrU1zm8
         3s6gjSx8V6tVM3LSHp8+c1kWpnOYzubDE8J4iDPKd6FK8qTK/VGcc95DlK/qb2YDY9
         JfVuVZZDmvpJA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 04/13] media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
Date:   Tue,  3 Jan 2023 18:00:49 +0100
Message-Id: <20230103170058.810597-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
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

Let's the driver knows that V4L2_PIX_FMT_NV12_10LE40_4L4 is a 10bits
pixel format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2c7a805289e7..162110ac118d 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -69,6 +69,7 @@ int hantro_get_format_depth(u32 fourcc)
 	switch (fourcc) {
 	case V4L2_PIX_FMT_P010:
 	case V4L2_PIX_FMT_P010_4L4:
+	case V4L2_PIX_FMT_NV12_10LE40_4L4:
 		return 10;
 	default:
 		return 8;
-- 
2.34.1

