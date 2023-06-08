Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF7727BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjFHJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjFHJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:44:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E582715;
        Thu,  8 Jun 2023 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686217440; x=1717753440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R8q82ndEJ9gFg507RIn2KqaYq9tX56kzV/e8VAKlpdo=;
  b=CU81FvtXDbVdyIS0htb/RCEjkLJJ2Ws7KwRh3pETotMbI7ZKOMaasrvZ
   uJQSSXGLS4yQnCs/J1aeSVVpHn6Cv5hOodPvDxYZ5SoQfXVyp1MWwW4/d
   ng7NTpML0+B63/B+2I0Dz1O4fmo0fz6IxAOoxLWvEjs9jvQ2drXpyczdW
   sRsbyUUdo6SBgrrR7oNQ/WOXxlLqvf7PbUlIPUYMXHL4nLrH5YmCe8YiE
   328CH+LQTPBIfGaXXUp0HHF154ez8N+3ig9N61pf9xIe8kcX3WksMfveb
   MrU0lfangHyfQCXxc/YmiExTSlQbyzCG75gqCutn+IlGrhbNFXhr+dblZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354751247"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="354751247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="704015780"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="704015780"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:43:57 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 547E2120BE1;
        Thu,  8 Jun 2023 12:43:54 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1q7CAd-00H0sd-H2; Thu, 08 Jun 2023 12:43:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: Assign Shawn Tu's sensor drivers to myself
Date:   Thu,  8 Jun 2023 12:42:57 +0300
Message-Id: <20230608094257.4054914-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Tu's e-mail address is bouncing and he hasn't told he has a new one:

   shawnx.tu@intel.com
   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound;
   Recipient not found by SMTP address lookup'

Assign the sensor drivers Shawn maintained to myself.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26f705e94a416..cec3c9ef43590 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9548,7 +9548,7 @@ S:	Maintained
 F:	arch/x86/kernel/cpu/hygon.c
 
 HYNIX HI556 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
+M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
@@ -9561,7 +9561,7 @@ S:	Maintained
 F:	drivers/media/i2c/hi846.c
 
 HYNIX HI847 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
+M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/hi847.c
@@ -15440,7 +15440,7 @@ F:	Documentation/filesystems/omfs.rst
 F:	fs/omfs/
 
 OMNIVISION OG01A1B SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
+M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/og01a1b.c
@@ -15506,7 +15506,7 @@ F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER
 M:	Tianshu Qiu <tian.shu.qiu@intel.com>
-R:	Shawn Tu <shawnx.tu@intel.com>
+R:	Sakari Ailus <sakari.ailus@linux.intel.com>
 R:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
@@ -15546,7 +15546,7 @@ F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5670.yaml
 F:	drivers/media/i2c/ov5670.c
 
 OMNIVISION OV5675 SENSOR DRIVER
-M:	Shawn Tu <shawnx.tu@intel.com>
+M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-- 
2.30.2

