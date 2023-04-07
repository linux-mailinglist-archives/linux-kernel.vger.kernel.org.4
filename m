Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33736DAE00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjDGNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbjDGNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:41:17 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A23BDF0;
        Fri,  7 Apr 2023 06:40:16 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id BCB451BF20A;
        Fri,  7 Apr 2023 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680874814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ancsjPRzD7RkHIrMd+4Fj+5TdggxMO2abcceDc4ZHko=;
        b=ZOe+ejUnRImwjrhYuF/F6gvvAvnhLJgFzvzu4RXS7DFZn71GKfft22VGHFmhkzRRadJcAe
        wsDp6GF04msG4XbtGMvOKJ0sLd3ViGbZwiyEhWZI9Il1yWwu2VtiHi1O0m4TXzOy9wN5hZ
        Zm856YCo5TJuhDTgXVgnb8Xxz+TdgnzTbJcZY7o283nDcfikNTa+8cgTlspZLDPVI4jMmS
        7O3zW9oROE7JeepPjsePPKhMT848cR7CtxXszid3dA1EFLOgAhvjsAOxLuY4R5RoogL4Hc
        YqTb9qCR/A7tdHD0V1D8FyWo3FLQY+mpWbwtXMZ6NiCezZE4iT8ztUEYrmNJHQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 11/20] staging: media: tegra-video: Kconfig: allow TPG only on Tegra210
Date:   Fri,  7 Apr 2023 15:38:43 +0200
Message-Id: <20230407133852.2850145-12-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
References: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to add support for the Tegra20 parallel video capture, which
has no TPG. In preparation for that, limit the VIDEO_TEGRA_TPG option to
Tegra210 which is the only implementation currently provided by this
driver.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/tegra-video/Kconfig b/drivers/staging/media/tegra-video/Kconfig
index df1b2cff2417..c53441822fdf 100644
--- a/drivers/staging/media/tegra-video/Kconfig
+++ b/drivers/staging/media/tegra-video/Kconfig
@@ -15,5 +15,6 @@ config VIDEO_TEGRA
 config VIDEO_TEGRA_TPG
 	bool "NVIDIA Tegra VI driver TPG mode"
 	depends on VIDEO_TEGRA
+	depends on ARCH_TEGRA_210_SOC
 	help
 	  Say yes here to enable Tegra internal TPG mode
-- 
2.34.1

