Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458E574D323
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjGJKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGJKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:16:53 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504FE7C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:16:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R00255XydzBHXhD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:03:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688983405; x=1691575406; bh=9eGsasZCdvlfGHZbPBuBp6LJrAr
        WhWGbB1Y1Gl7O060=; b=cMhE0ZzDYHXQtRtw2S7cGuQ+AEgRA92QIB0jpxylIQw
        v7Um2xeXdYWbxagnj8oqKVD3yQbl9wkkxhyFXfYE9JKSc92hxnyy2kqouopzyPwO
        yAzz5HqO7VDhBcMap+ckhSt3A5eOfijX5BTKhwYUIC6h6htnRQpkAsMO5iZZ9f3B
        5JUAoAjWQQ6i9WPPp+T10cOlVETKtkTVBG68XlIywX2F1KAzpwm5FeiidKl6kf00
        PmGIOAlzr2S7tdcQ8tkv1AAwg9M2iHQNcTbP4bhrhKN/GiXy8IVQVVr17Df6WqJM
        AEX4/ZwMnWkuwHIV+DePS/03wHY8sMjot+OiDu/lRfg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ixD7zODK_b95 for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 18:03:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R00252j4hzBHXhC;
        Mon, 10 Jul 2023 18:03:25 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 18:03:25 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
In-Reply-To: <20230710091057.64085-1-xujianghui@cdjrlc.com>
References: <20230710091057.64085-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3a541f425a1ab6d2664a6d74cc4c3a51@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix five occurrences of the checkpatch.pl error:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_kms.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c 
b/drivers/gpu/drm/radeon/radeon_kms.c
index e0214cf1b43b..a16590c6247f 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -444,7 +444,7 @@ int radeon_info_ioctl(struct drm_device *dev, void 
*data, struct drm_file *filp)
              DRM_DEBUG_KMS("timestamp is r6xx+ only!\n");
              return -EINVAL;
          }
-        value = (uint32_t*)&value64;
+        value = (uint32_t *)&value64;
          value_size = sizeof(uint64_t);
          value64 = radeon_get_gpu_clock_counter(rdev);
          break;
@@ -543,18 +543,18 @@ int radeon_info_ioctl(struct drm_device *dev, void 
*data, struct drm_file *filp)
          *value = rdev->vce.fb_version;
          break;
      case RADEON_INFO_NUM_BYTES_MOVED:
-        value = (uint32_t*)&value64;
+        value = (uint32_t *)&value64;
          value_size = sizeof(uint64_t);
          value64 = atomic64_read(&rdev->num_bytes_moved);
          break;
      case RADEON_INFO_VRAM_USAGE:
-        value = (uint32_t*)&value64;
+        value = (uint32_t *)&value64;
          value_size = sizeof(uint64_t);
          man = ttm_manager_type(&rdev->mman.bdev, TTM_PL_VRAM);
          value64 = ttm_resource_manager_usage(man);
          break;
      case RADEON_INFO_GTT_USAGE:
-        value = (uint32_t*)&value64;
+        value = (uint32_t *)&value64;
          value_size = sizeof(uint64_t);
          man = ttm_manager_type(&rdev->mman.bdev, TTM_PL_TT);
          value64 = ttm_resource_manager_usage(man);
@@ -614,7 +614,7 @@ int radeon_info_ioctl(struct drm_device *dev, void 
*data, struct drm_file *filp)
          DRM_DEBUG_KMS("Invalid request %d\n", info->request);
          return -EINVAL;
      }
-    if (copy_to_user(value_ptr, (char*)value, value_size)) {
+    if (copy_to_user(value_ptr, (char *)value, value_size)) {
          DRM_ERROR("copy_to_user %s:%u\n", __func__, __LINE__);
          return -EFAULT;
      }
