Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AB56D0A11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjC3PlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjC3Pk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:40:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A619C;
        Thu, 30 Mar 2023 08:40:54 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:792c:96d5:14:366a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 350F9660318E;
        Thu, 30 Mar 2023 16:40:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680190853;
        bh=n+WUNu+qt01YD/GB1kVjnN4Q8SGaOcbVyUQJP0WmOHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnMvAk9BzzBLFJFtICcEDucQKraFv9qifv8nuSmcTwvEyxcF++JPUSc1UuA8XWv38
         dEljvo3uOtHpQMtw/6OpRrafJk8usM3mqVecyD/rw9Ysqeyup4Z7kDliSEXL3Pyoma
         keLd19w5cZFOli4X3FiqSf5eRjo589ywb85PFrqOutetAyUyf8CiKJIyhsgG4kK/Fl
         7UqpEZwwggtf7zSg/zaRX2fIsqv77wmjmS/vdxLqRX24imnws7QiOIH2i5Ni4QRg7a
         U8b10cL6mEkyqbFXSyAl+k3pOhJ2FG3IFdobSR5CTEeA8o2Lqipf0BN+JsuhU20uoj
         2vb5UfRrkuzxA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 04/13] media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
Date:   Thu, 30 Mar 2023 17:40:34 +0200
Message-Id: <20230330154043.1250736-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index d238d407f986..7ed2dfd4aefa 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -71,6 +71,7 @@ int hantro_get_format_depth(u32 fourcc)
 	switch (fourcc) {
 	case V4L2_PIX_FMT_P010:
 	case V4L2_PIX_FMT_P010_4L4:
+	case V4L2_PIX_FMT_NV12_10LE40_4L4:
 		return 10;
 	default:
 		return 8;
-- 
2.34.1

