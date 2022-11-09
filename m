Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CF622D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiKIOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKIOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:19:45 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A601F2FA;
        Wed,  9 Nov 2022 06:19:33 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 20AD5FF810;
        Wed,  9 Nov 2022 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJlzuVONFEpiaYrldIzh/q/NNHairzTg7dXH/ruzq4U=;
        b=o6F8fyvzViN80butPvVwZpXC84UKR7GjN5NQ82XS+sU72u6cLrxeMuiIGiJyurEXqc/Bpw
        N+MzMlbjA+vznUbrYouCBdp8k58Oidykv/pvnvkT29+DEj/5QFSeosfqRd70WTXex0c6Hz
        GKmATB8Gk+2Ax00n40Mq7+6MRt0JgpDl8a4StvaBLd+sDD6iHtbAEx5r6+Or3Gho8egSRl
        z5frJDQ4K9uBc5qk3FjblsGmgk9S43S+gvp4LT8PiljWuy2G1YCD670M7p3IYlWt4t2iBy
        boxqxfkBKojS9oo4NFKcxUFNh9skPGdehq8t4THr+w0FQubANtr+O2+yW5kL+w==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 06/23] staging: media: tegra-video: improve documentation of tegra_video_format fields
Date:   Wed,  9 Nov 2022 15:18:35 +0100
Message-Id: <20221109141852.729246-7-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

Some fields are irrelevant for Tegra20/VIP. Add a note to clarify that.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/vi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 183796c8a46a..dd35c3ac992b 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -256,11 +256,11 @@ enum tegra_image_dt {
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

