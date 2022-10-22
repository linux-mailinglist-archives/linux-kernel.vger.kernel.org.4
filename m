Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916606082AF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJVAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJVAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:06:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BDE2B3AC5;
        Fri, 21 Oct 2022 17:06:27 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D9B36602822;
        Sat, 22 Oct 2022 01:05:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666397130;
        bh=Q30j2SwCE58xqoM2kD/yZq4CuQYxasuDf5e541eYp8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOjtSc6JS0vppvK/r1xz0wGMVSsFsSLKrqGOf4BQVqcayOLCYPFkcFGZRjPLD2Gc/
         6JOx2CYQF5oj7kVuxzcDwqoi7DZNu0WF3fVbeGRtVKSi2+7dxQd8yg/dXNqH0CBVYm
         h2esnk4F7O2+wuuG7Bu5PS4cZFuABhluqc+IGYOPGjH98k2bFBHlP12IAfCSNhSQWz
         gfsFZ6ulAlQfOlQ75IxfcXYn12NrCPshFLwd1VnBs6b5z89xGoR/gS8W9qjKmi/Daz
         e8s3uWN7ENjeeZ0ksTa+dD12P3Sgti4aZvUeoSZf7QUpAjXEISBOopZzlIgq9pYde9
         c+B6PRlvLlBtQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: [PATCH v10 7/7] media: chips-media: wave5: Add wave5 driver to maintainers file
Date:   Sat, 22 Oct 2022 02:05:06 +0200
Message-Id: <20221022000506.221933-8-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221022000506.221933-1-sebastian.fricke@collabora.com>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
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

From: Robert Beckett <bob.beckett@collabora.com>

Add the Chips&Media wave5 encoder/decoder driver to the maintainers file

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 MAINTAINERS                                              | 9 +++++++++
 .../media => media/platform/chips-media}/wave5/TODO      | 0
 2 files changed, 9 insertions(+)
 rename drivers/{staging/media => media/platform/chips-media}/wave5/TODO (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 618fd1a490f8..5b08d4187125 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22122,6 +22122,15 @@ F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
 
+WAVE5 VPU CODEC DRIVER
+M:	Nas Chung <nas.chung@chipsnmedia.com>
+M:	Robert Beckett <bob.beckett@collabora.com>
+M:	Sebastian Fricke <sebastian.fricke@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
+F:	drivers/media/platform/chips-media/wave5/
+
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/staging/media/wave5/TODO b/drivers/media/platform/chips-media/wave5/TODO
similarity index 100%
rename from drivers/staging/media/wave5/TODO
rename to drivers/media/platform/chips-media/wave5/TODO
-- 
2.25.1

