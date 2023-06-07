Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6389726740
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFGR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFGR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:27:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAE2136;
        Wed,  7 Jun 2023 10:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84948641C9;
        Wed,  7 Jun 2023 17:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB1DC433D2;
        Wed,  7 Jun 2023 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158785;
        bh=HEmJioAGrUOt68QctcKOcG/xC5pDrpH7rHRR1z54i8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F873Efo11bsrPI9tb9jqfpPK7MN/XCpgVIwIsvW/Brt4VOPEviwDPEZ8YiXqp1GJx
         UxoKNmO7zRH9PhaoEajIxXTmgscB9hVIZvN356sT3ObisW/Hz7iDbxceFn3DxI1ANu
         14y/5uqmsUolp1gJxd0ipbGGReWsTaBxHJ0GY40cHpvoorwQLgCmka6Z7rLpY65hw+
         G+QoWsX2ezV3TofEjf5p8lRqF2vhj+RS4u6ZF8pYkFN9mRIWIVJv1SqCd54evBZNsQ
         0iWjDgSErYQZkEMoapDYmlsERVi6ETxdSRPAQbej9eWYteFFYICnecz2Vv0HSn/vMP
         QW4siI39lMC9g==
From:   Conor Dooley <conor@kernel.org>
To:     linux-media@vger.kernel.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: drop Shawn Tu due to mail bounces
Date:   Wed,  7 Jun 2023 18:26:07 +0100
Message-Id: <20230607-unfounded-blandness-93cf1e44f127@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=C8ELCUiNZMkz/UMrBgNL7zPGny1ZtX6GLE/KGqcKOeg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkNe1de43CzyUrm3dB7olWm3lTY5L/xr3VRUXMmLRa+y LKtOOx7RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACay/Q3DX6nGjesPtrQUlqzm ZtSLZwjKyWk8IC9xXnb6pmdrvyadcmVk+H744oqvL7f+Sa6VL0pJfNHz9W/d5DvTrKoDnXLPaM6 05AcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Emails to Shawn Tu bounce & I could not easily see a non-intel email
for them on lore. Drop them and orphan their drivers.

CC: Shawn Tu <shawnx.tu@intel.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
A conversation starter as much as anything else.

CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
CC: linux-media@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbf6c035000..3d2a1314cb26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9614,9 +9614,8 @@ S:	Maintained
 F:	arch/x86/kernel/cpu/hygon.c
 
 HYNIX HI556 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/hi556.c
 
@@ -9627,9 +9626,8 @@ S:	Maintained
 F:	drivers/media/i2c/hi846.c
 
 HYNIX HI847 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/media/i2c/hi847.c
 
 Hyper-V/Azure CORE AND DRIVERS
@@ -15519,9 +15517,8 @@ F:	Documentation/filesystems/omfs.rst
 F:	fs/omfs/
 
 OMNIVISION OG01A1B SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/media/i2c/og01a1b.c
 
 OMNIVISION OV01A10 SENSOR DRIVER
@@ -15585,7 +15582,6 @@ F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER
 M:	Tianshu Qiu <tian.shu.qiu@intel.com>
-R:	Shawn Tu <shawnx.tu@intel.com>
 R:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
@@ -15625,9 +15621,8 @@ F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5670.yaml
 F:	drivers/media/i2c/ov5670.c
 
 OMNIVISION OV5675 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
 F:	drivers/media/i2c/ov5675.c
-- 
2.39.2

