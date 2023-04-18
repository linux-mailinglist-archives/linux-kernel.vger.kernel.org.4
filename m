Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD96E5B41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjDRIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjDRIB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:01:29 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EDE72A4;
        Tue, 18 Apr 2023 01:01:16 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A3B3824001B;
        Tue, 18 Apr 2023 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLABZBNg77lXkYmbYD6rmCLffL1EmDa6Je6DquhfXlI=;
        b=jCmpIYQWDWm4Ns73jcDFnertj7akxCBeeQSqWOL1zM+b/J50TmHltmZ7HVZM2dRhCFaMTQ
        zGHK/tnD9UKlhNq6SVmyblQJr70Xcf+2u8eaIxQk1w8dLaZhvL5bB/M8gip6kmyN7BlOfU
        /se22K5p/eNQQL5j+MMBhBUd2S4pZz8OJk2ww18fn/Ipjv2yKq3RgnEmobOT3ypQmPt/R4
        MCjl7Mwvh0nYGLVRc4Muj6JqkdE84buC68fjPv7mUEm2TBcO/oL56vIEStZJ4g/EgNZWlv
        1RZIX+SqvCTi0SblwJi2AolIDcqDY39P/Gpgwu1pl1OJGzIij2lg1qmRP8Y/+Q==
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
Subject: [PATCH v6 03/20] staging: media: tegra-video: improve documentation of tegra_video_format fields
Date:   Tue, 18 Apr 2023 10:00:37 +0200
Message-Id: <20230418080054.452955-4-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields are irrelevant for Tegra20/VIP. Add a note to clarify that.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v6
No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index a68e2c02c7b0..5396bf53ab75 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -260,11 +260,11 @@ enum tegra_image_dt {
 /**
  * struct tegra_video_format - Tegra video format description
  *
- * @img_dt: image data type
- * @bit_width: format width in bits per component
+ * @img_dt: MIPI CSI-2 data type (for CSI-2 only)
+ * @bit_width: format width in bits per component (for CSI/Tegra210 only)
  * @code: media bus format code
  * @bpp: bytes per pixel (when stored in memory)
- * @img_fmt: image format
+ * @img_fmt: image format (for CSI/Tegra210 only)
  * @fourcc: V4L2 pixel format FCC identifier
  */
 struct tegra_video_format {
-- 
2.34.1

