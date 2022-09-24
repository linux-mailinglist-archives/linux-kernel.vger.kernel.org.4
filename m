Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CD5E8E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiIXPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiIXPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:33:34 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB59DF8F;
        Sat, 24 Sep 2022 08:33:26 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B4E3A240006;
        Sat, 24 Sep 2022 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664033605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptqGvFLHe0QXADVVgJCZNUAjloY0GZnzuNEFAwuOVTI=;
        b=KieaFL/YZiiYejoooXdNPM5gaSWB38E+343iILdR5JQRDl2lRQXovfRzRKo0uOVgTEVluc
        29eE25kv61wSiDLaw13IR8ilxdjWbTXSKc3vsZ3tdHVVKWWicst7BxvtEfLct0jJQenWVZ
        t49cqFW76XIBp9kTWIHmKvhu+X8DsIZFcmX+BQt/0BoVpJCwuAYIJH8Udqn2y8a2iIqBlT
        cJWmhyPz6P72uhHiJwtzJMPOx/NC8F6FRKgQ8l4uLWrYy7f8KAgDdeU7r/kQ8Ic9Fosau7
        KznbE9NSar8407UIp9oRLe6e5aiPmk5dkOTCLkHzs9YCliqFSVO05bonCyTohQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 4/6] MAINTAINERS: Add entry for the Allwinner A31 ISP driver
Date:   Sat, 24 Sep 2022 17:33:02 +0200
Message-Id: <20220924153304.77598-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
References: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
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

Add myself as maintainer of the Allwinner A31 ISP media driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc64efc9ba0..78be98ea5da9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -787,6 +787,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
 F:	drivers/media/platform/sunxi/sun6i-csi/
 
+ALLWINNER A31 ISP DRIVER
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
+F:	drivers/staging/media/sunxi/sun6i-isp/
+F:	drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
+
 ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
 M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 L:	linux-media@vger.kernel.org
-- 
2.37.3

