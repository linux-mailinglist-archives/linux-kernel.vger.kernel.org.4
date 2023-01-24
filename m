Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB3679580
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjAXKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjAXKl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:41:58 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985872134
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:41:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:6083:1fd7:ba05:ea8d])
        by albert.telenet-ops.be with bizsmtp
        id Caht290034604Ck06ahtxU; Tue, 24 Jan 2023 11:41:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pKGkK-007DIk-DV;
        Tue, 24 Jan 2023 11:41:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pKGkS-00GcpT-TR;
        Tue, 24 Jan 2023 11:41:52 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drivers: Restore alignment and newline in Makefile
Date:   Tue, 24 Jan 2023 11:41:45 +0100
Message-Id: <20230124104145.3962497-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of drivers/accel/ broke alignment, and removed the
newline at the end of the file.  Fix all of that.

Fixes: 35b137630f08d913 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index f0972e2226c97cb5..9ea6eb3b5d7b7f17 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -189,4 +189,4 @@ obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_PECI)		+= peci/
 obj-$(CONFIG_HTE)		+= hte/
-obj-$(CONFIG_DRM_ACCEL)	+= accel/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL)		+= accel/
-- 
2.34.1

