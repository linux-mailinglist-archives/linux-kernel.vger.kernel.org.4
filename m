Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051F66612A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjAKRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjAKQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:59:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA3316;
        Wed, 11 Jan 2023 08:59:42 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1ee3:efce:e4f6:17a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4ADE06602DA6;
        Wed, 11 Jan 2023 16:59:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673456381;
        bh=9um+KEVR7P+gZc2gYPj/3g5J+YLW4FhxyxYBCrnBhZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd9EhdAZIo5dmC5sKWqQCy1LFtG0SHw2npSCl3ja+Cqe99ddSgmJRG1W3rjbkf0+/
         oRFz5mC/vaXy6YlqCPz8YV8/oIyY9vv4Dv8S893Aml9eib61Sj1KCsB25O0PzOiFNm
         3Kjaz3BtYOAezkKhpI2gzvBMH7YJBJp7QezxmJ5jIePYStFp4aRVkbaeD/cc8ONyHC
         +1RZH6MRYrCwdXSCW+edEHvG2o1QHSPRhIeHYNiD1WTb7nciUnUKTcrIJCu4pClKOI
         RIQIT0mHiS5k/hoGyGJ5qgTQq0CeETLoIFXwbbkvng4NVWqIffhB1LgLX9PrhdL2Zh
         cQJXRzMRvqC1w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 04/13] media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
Date:   Wed, 11 Jan 2023 17:59:22 +0100
Message-Id: <20230111165931.753763-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
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

