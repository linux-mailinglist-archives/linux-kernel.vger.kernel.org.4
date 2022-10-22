Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216BF6084D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJVGCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:02:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26E2B3AF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:02:19 -0700 (PDT)
X-QQ-mid: bizesmtp63t1666418523te9jyncr
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:02:02 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: bYR630AeiPiMJZJOYuUscyfpmUVYVgvXFZ1DUHC++tzvxU8bsrZ9iNVYgttE8
        BBd8CyEwzkGOYuUk1JccjvL0QWnnDMBhcYSlGa55BsdxCssnZ3TYiEQVP5ksq5kTIkHA63g
        c2EwUUMK2iJbse6aaiyZ1fP8kfQGrJyOoDyV1gPe172dwA55oP5o6c9PMGcCc6pVnjISZ1W
        eF4nIzw/ubDmnj+DEDMdL19SGn6hdfbnn0y1caH6uvPWSjwU7RgdVrYx5vm8bngbBAUg4H5
        i93UiAh9/Im9U9LCT6YBRNnHoZKp7EHhpCbkjo9j7REu499aQTVqFrsBAG8zxAe5Sgbf8e5
        fR5dDvk8Z2Qur6DsiX0q1r3AMD5v4pv+g0tQg4mXvfaJR8B9vw=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] amd/amdgpu: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:01:55 +0800
Message-Id: <20221022060155.52548-1-wangjianli@cdjrlc.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e9155dc1c30c..3de990bbbf2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1565,7 +1565,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
  * @pdev: pci dev pointer
  * @state: vga_switcheroo state
  *
- * Callback for the switcheroo driver.  Suspends or resumes the
+ * Callback for the switcheroo driver.  Suspends or resumes
  * the asics before or after it is powered up using ACPI methods.
  */
 static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
-- 
2.36.1

