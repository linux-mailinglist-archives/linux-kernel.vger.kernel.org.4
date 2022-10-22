Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417FA6084E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJVGEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJVGEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:04:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663B4316C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:04:39 -0700 (PDT)
X-QQ-mid: bizesmtp82t1666418665tjb23529
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:04:23 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 83ShfzFP0oApFjXZWh6Y6La/aRvAwxua0Tpqn8jzPPYTX0L7/oa19+NgcY7Qf
        KOa2nDJGUPCsPhWk9XSa92bJNZSuFgWKhPctmcgn0z+PMjz8CiF+AmVehUwlFHiX835Dq8A
        0dZ9DJazxcGVKzXYGOiNUwUx9Qytw/nqLVehwSIp59JbOo9/ZV989EIYZp56fcjk/wT5BQB
        cqk9FgxJ4ZyUYs9/R3LwU9dHkVqK52xazSQRbJ9VKA1hA/YkpRYLqnRhEwpCCFWGcm3+VDa
        hPgokJteOVbLfPTDQsUf6N2g6sDw5WoAznB1N5tft7Cq5KmoThvM5EQ5KGMKa3tzvKqm0bU
        tqW8LMfpejQIeg4BQUZJ6aARKZx9y0c/92xM5Oh6VSfm9ZpFrg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/radeon: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:04:17 +0800
Message-Id: <20221022060417.55166-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 15692cb241fc..ff52b5f4c1e6 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1206,7 +1206,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
  * @pdev: pci dev pointer
  * @state: vga_switcheroo state
  *
- * Callback for the switcheroo driver.  Suspends or resumes the
+ * Callback for the switcheroo driver.  Suspends or resumes
  * the asics before or after it is powered up using ACPI methods.
  */
 static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
-- 
2.36.1

