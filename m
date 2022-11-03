Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8586184C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKCQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiKCQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:32:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2913F03;
        Thu,  3 Nov 2022 09:32:27 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 62A1E240007;
        Thu,  3 Nov 2022 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvuNGVBczAXcUV70wEg2PlpU7BZoZuwdoGtAqYZffRw=;
        b=nG5PJszbINWo+Y+kCO6w9ho64Bd4iLtf8Er/svwQt6MkA2bu0yBrK+JAqDavz4bFjLxi7y
        cVBvgPLnrDz/YdD+okHzzqpZ19MWk8RVv5UwrY2SuDtm4tG/go3wQCby5Qfs/1C+dyCG6F
        ZlQ5LAIou6jaD66hB/OE0fQHir5qzo7S+VuHNeCYfXE2SgrYwcn1BpiELN/4qyfsTcpKw8
        oKwkkSwUu2j9ddQCyIFjLtLQ7P4riCRBSAzCrO5P2iPpbEeadStEHWNElbvh+5H78AodFf
        xjAy8MHw1mAQprkcepVBUayeq2GZ7QsovybSW0FR3EfGtQjpag5ttFzK4r5xTA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 28/28] MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
Date:   Thu,  3 Nov 2022 17:31:13 +0100
Message-Id: <20221103163113.245462-29-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the substantial rework of the driver that I carried out and the
knowledge acquired about the hardware along the way, make myself a
maintainer of the sun6i-csi driver.

Also rename and move the entry while at it since the driver is not
specific to the V3s.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..aeb53085d40a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -775,6 +775,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
 F:	drivers/media/platform/sunxi/sun4i-csi/
 
+ALLWINNER A31 CSI DRIVER
+M:	Yong Deng <yong.deng@magewell.com>
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+F:	drivers/media/platform/sunxi/sun6i-csi/
+
 ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
 M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 L:	linux-media@vger.kernel.org
@@ -5499,14 +5508,6 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
 S:	Maintained
 F:	sound/pci/cs5535audio/
 
-CSI DRIVERS FOR ALLWINNER V3s
-M:	Yong Deng <yong.deng@magewell.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
-F:	drivers/media/platform/sunxi/sun6i-csi/
-
 CTU CAN FD DRIVER
 M:	Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M:	Ondrej Ille <ondrej.ille@gmail.com>
-- 
2.38.1

