Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF15BBDB4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIRMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIRMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:14:38 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 05:14:32 PDT
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net [150.101.137.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE8D2BFB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:14:32 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AuKLA8qgoXK87KF///wa5pX0TX161/xEKZh0uj?=
 =?us-ascii?q?C45NGQN5FlHY01jehtvDGyOaKvbYmT3fNAiaI+wpx5UvcLRx4NiQQZqqno8R?=
 =?us-ascii?q?ClGo5PMC9nAcU7+ZijNdcSdRU5rtZ5PYIXOc5w+RSeC+z6gY+PrxZVe/fjYH?=
 =?us-ascii?q?uCmVIYoGczQqTeJ+07NsDo78wIEqtcAbeaRU1vlVeza+6UzCHf9s9JFGjp8B?=
 =?us-ascii?q?5Cr8XuDj9yq0N8shWHSUNgQ1LPoe9j5O7pETU25ByOQroC5hYdWTc6bpF2y1?=
 =?us-ascii?q?juxExvAlrqYfrjHnk0iGtY+PORgZnh+AvTk2F4b/3B0iPthXBYfQR4/ZzGhl?=
 =?us-ascii?q?sptyMhX85m5UxwpFqzKhOkHVR5UHmd5O+tA9aOvzX2X65zKlxGeLCCwqxlpJ?=
 =?us-ascii?q?BpuZt1CoLcf7Xt13fUcJSABYw2Ih++s6L2+Q+howM8kKaHDNYIFvnBtwRndD?=
 =?us-ascii?q?PA7UdbCTs3i7NpUmTg+luhKHO3CfIwXczdiYBnbYAFIIhEQEp1WtOuyhzzzf?=
 =?us-ascii?q?iNVrHqRpLEr+C7d1gF83LX2M8bSYpqNX8o9tkmCq2/A8WP+KgxLbpqS1FKtw?=
 =?us-ascii?q?nOqhvLO2xvyXqobEbH+/flv6HWawmEDARsaWEH9rfSkgU6zQfpWLkBS8S0rx?=
 =?us-ascii?q?YA76VaiRNj7Uxr+uH+Auhcdc9NVH6sx7wTl4qHU+QeCGmkNSHhCb9EgtcAeT?=
 =?us-ascii?q?DkmkFSOmrvBCiFksKCTD3md+7G8pDa+fyMSKAcqZSYBXwJD5tDjroY0nDrGS?=
 =?us-ascii?q?9olG6mw5vXxGDft03WJoTI4irE7k8EGzeO48ErBjjbqoYLGJiYu6wzRRmu46?=
 =?us-ascii?q?ityZJSiYo217B7c9/koEWozZk3Z6SBCw9zHubhIVYXXwXTLHb1VRKXysq7Db?=
 =?us-ascii?q?SmD1GV0E414r2H1vya3FWxLyClmPB41d5xBIGa1JRWO40VY6JsWNWO2KLd2e?=
 =?us-ascii?q?ce7Ec0xlvKmCczqEPHSctdUZJ99eUmA+mdoaFL44owkq2B0+YlXBHtRWZ/E4?=
 =?us-ascii?q?a4mNJla?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyEbpqq56YMMnSnOngAPXwN/XdLJyesId70?=
 =?us-ascii?q?hD6qm+c3Bom6uj5qSTdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcK2+gs1N6ZNW?=
 =?us-ascii?q?GMhILrFvAB0WKI+VLd8kPFm9K1rZ0BT5RD?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AVBAClCSdjZPxyAg5agRKBRoR9lBc?=
 =?us-ascii?q?BAQEGgUWdEBSBaAsBUwQBAYUFAoRrJjQJDgECBBUBAQYBAQEBAQcEBWoBLIV?=
 =?us-ascii?q?1hkMCAQMyAUYQCxQyVxmCfYMhq0OBAYoCgT2KcoUygUCBEIQ/PoQrZoVvBJk?=
 =?us-ascii?q?2AwkEBwUPAjhBAwsfDRY0GAMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgM?=
 =?us-ascii?q?CBhMFAgI1GDgIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCY?=
 =?us-ascii?q?XBxMzGQEFWRAJIRwOGg0FBhMDChZvBQc+DygyaysdGwqBDCooFQMEBAMCBhM?=
 =?us-ascii?q?DAyICECoxFAQpExItBytzCQIDIgRjBQMDBCosAwkhHwcoJjwHWDoBBAMDECI?=
 =?us-ascii?q?9BgMJAwIkW3g4FBQFAw0ZJggFIxYdBAg8AgUGmzqBPpQnCpBhnl0Hg1mDSAG?=
 =?us-ascii?q?cUEwRqHOUNIJWhAOfEoYxghV7gyxRKJ0AZTsCBgsBAQMJiwMBAQ?=
Received: from ppp14-2-114-252.adl-apt-pir-bras32.tpg.internode.on.net (HELO localhost) ([14.2.114.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 18 Sep 2022 21:39:29 +0930
Received: from root by localhost with local (Exim 4.96)
        (envelope-from <arthur.marsh@internode.on.net>)
        id 1oZt70-0002gc-1o;
        Sun, 18 Sep 2022 21:39:26 +0930
From:   root <arthur.marsh@internode.on.net>
To:     alexdeucher@gmail.com
Cc:     Xinhui.Pan@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
        christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        greenfoo@u92.eu, guchun.chen@amd.com, hamza.mahfooz@amd.com,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org
Subject: Re: [PATCH] drm/amdgpu: use dirty framebuffer helper
Date:   Sun, 18 Sep 2022 21:39:26 +0930
Message-Id: <20220918120926.10322-1-user@am64>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <CADnq5_O0W-ipCCy3hsub5GwirjDTM76Xn3kAxgyZT5V+vDguSA@mail.gmail.com>
References: <CADnq5_O0W-ipCCy3hsub5GwirjDTM76Xn3kAxgyZT5V+vDguSA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I recently experienced lock-ups that only responded to magic sysreq 
reboots when the amdgpu module was loading on my pc (Athlon II X4 640 CPU,
with Radeon R7 250 - Cape Verde).

.config has:

CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set

kernel command line has:

amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on \
amdgpu.gpu_recovery=1

Bisecting lead to:

commit 66f99628eb24409cb8feb5061f78283c8b65f820
Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date:   Tue Sep 6 15:01:49 2022 -0400

    drm/amdgpu: use dirty framebuffer helper
    
    Currently, we aren't handling DRM_IOCTL_MODE_DIRTYFB. So, use
    drm_atomic_helper_dirtyfb() as the dirty callback in the amdgpu_fb_funcs
    struct.
    
    Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c20922a5af9f..5b09c8f4fe95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -496,6 +497,7 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
        .destroy = drm_gem_fb_destroy,
        .create_handle = drm_gem_fb_create_handle,
+       .dirty = drm_atomic_helper_dirtyfb,
 };
 
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,

After doing a git bisect reset, git pull and reverting the patch above, I
rebuilt the kernel and am successfully running with the amdgpu module loaded
and using the Radeon R7 250 GPU.

I am happy to supply any further configuration details.

Arthur Marsh.
