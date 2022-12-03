Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1E641552
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLCJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLCJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:37:15 -0500
X-Greylist: delayed 88272 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Dec 2022 01:37:14 PST
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF3186EF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:37:14 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670060232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TjMN80lVYmNgIjzL3qaQ3pSDtxrrc3ClLWCJhz9eCSk=;
        b=RAlvfzU9ZNsVEJPKxP80SZU5T92MFsRUDhIHpFg7QNW7Iw1bb3U1hBj3P0U59LBf4LJu6A
        MdH15atxUhx9rwRRbqRA75Ln0INAQWK6wym2yjcrsg4Gvvhs/1TRAZ/M4lVYmn2nfazPYc
        R/aeKDQYcGcFDvMGlQMgBb7MlSjetfc=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     tzimmermann@suse.de
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Danilo Krummrich <dakr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH linux-next v2 00/10] drm: Remove some obsolete drivers(tdfx, mga, i810, savage, r128, sis, via)
Date:   Sat,  3 Dec 2022 17:35:36 +0800
Message-Id: <20221203093700.34608-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 399516ab0fee ("MAINTAINERS: Add a bunch of legacy (UMS) DRM drivers")
marked these drivers obsolete 7 years ago.
And the mesa UMD of these drm drivers already in deprecated list
in the link: https://docs.mesa3d.org/systems.html

3dfx Glide-->driver/gpu/drm/tdfx
Matrox-->driver/gpu/drm/mga
Intel i810-->driver/gpu/drm/i810
S3 Savage-->drivers/gpu/drm/savage
ATI Rage 128->drivers/gpu/drm/r128
Silicon Integrated Systems->drivers/gpu/drm/sis
VIA Unichrome->drivers/gpu/drm/via

v1->v2:
1.Add drm via driver to the patchset.
2.Remove related drm_pciids.
3.Remove related drm uapi header files.
4.split to series avoid large patch email.

Cai Huoqing (10):
  drm: Remove the obsolete driver-i810
  drm: Remove the obsolete driver-mga
  drm: Remove the obsolete driver-r128
  drm: Remove the obsolete driver-savage
  drm: Remove the obsolete driver-sis
  drm: Remove the obsolete driver-tdfx
  drm: Remove the obsolete driver-via
  drm: Add comments to Kconfig
  drm: Remove some obsolete drm pciids(tdfx, mga, i810, savage, r128,
    sis, via)
  MAINTAINERS: Remove some obsolete drivers info(tdfx, mga, i810,
    savage, r128, sis)

 MAINTAINERS                           |   29 -
 drivers/gpu/drm/Kconfig               |   59 +-
 drivers/gpu/drm/Makefile              |    7 -
 drivers/gpu/drm/i810/Makefile         |    8 -
 drivers/gpu/drm/i810/i810_dma.c       | 1266 ---------
 drivers/gpu/drm/i810/i810_drv.c       |  101 -
 drivers/gpu/drm/i810/i810_drv.h       |  246 --
 drivers/gpu/drm/mga/Makefile          |   11 -
 drivers/gpu/drm/mga/mga_dma.c         | 1168 --------
 drivers/gpu/drm/mga/mga_drv.c         |  104 -
 drivers/gpu/drm/mga/mga_drv.h         |  685 -----
 drivers/gpu/drm/mga/mga_ioc32.c       |  197 --
 drivers/gpu/drm/mga/mga_irq.c         |  169 --
 drivers/gpu/drm/mga/mga_state.c       | 1099 --------
 drivers/gpu/drm/mga/mga_warp.c        |  167 --
 drivers/gpu/drm/r128/Makefile         |   10 -
 drivers/gpu/drm/r128/ati_pcigart.c    |  228 --
 drivers/gpu/drm/r128/ati_pcigart.h    |   31 -
 drivers/gpu/drm/r128/r128_cce.c       |  944 -------
 drivers/gpu/drm/r128/r128_drv.c       |  116 -
 drivers/gpu/drm/r128/r128_drv.h       |  544 ----
 drivers/gpu/drm/r128/r128_ioc32.c     |  199 --
 drivers/gpu/drm/r128/r128_irq.c       |  118 -
 drivers/gpu/drm/r128/r128_state.c     | 1641 -----------
 drivers/gpu/drm/savage/Makefile       |    9 -
 drivers/gpu/drm/savage/savage_bci.c   | 1082 --------
 drivers/gpu/drm/savage/savage_drv.c   |   91 -
 drivers/gpu/drm/savage/savage_drv.h   |  580 ----
 drivers/gpu/drm/savage/savage_state.c | 1169 --------
 drivers/gpu/drm/sis/Makefile          |   10 -
 drivers/gpu/drm/sis/sis_drv.c         |  143 -
 drivers/gpu/drm/sis/sis_drv.h         |   80 -
 drivers/gpu/drm/sis/sis_mm.c          |  363 ---
 drivers/gpu/drm/tdfx/Makefile         |    8 -
 drivers/gpu/drm/tdfx/tdfx_drv.c       |   90 -
 drivers/gpu/drm/tdfx/tdfx_drv.h       |   47 -
 drivers/gpu/drm/via/Makefile          |    8 -
 drivers/gpu/drm/via/via_3d_reg.h      | 1771 ------------
 drivers/gpu/drm/via/via_dri1.c        | 3630 -------------------------
 include/drm/drm_pciids.h              |  112 -
 include/uapi/drm/i810_drm.h           |  292 --
 include/uapi/drm/mga_drm.h            |  429 ---
 include/uapi/drm/r128_drm.h           |  336 ---
 include/uapi/drm/savage_drm.h         |  220 --
 include/uapi/drm/sis_drm.h            |   77 -
 include/uapi/drm/via_drm.h            |  282 --
 46 files changed, 1 insertion(+), 19975 deletions(-)
 delete mode 100644 drivers/gpu/drm/i810/Makefile
 delete mode 100644 drivers/gpu/drm/i810/i810_dma.c
 delete mode 100644 drivers/gpu/drm/i810/i810_drv.c
 delete mode 100644 drivers/gpu/drm/i810/i810_drv.h
 delete mode 100644 drivers/gpu/drm/mga/Makefile
 delete mode 100644 drivers/gpu/drm/mga/mga_dma.c
 delete mode 100644 drivers/gpu/drm/mga/mga_drv.c
 delete mode 100644 drivers/gpu/drm/mga/mga_drv.h
 delete mode 100644 drivers/gpu/drm/mga/mga_ioc32.c
 delete mode 100644 drivers/gpu/drm/mga/mga_irq.c
 delete mode 100644 drivers/gpu/drm/mga/mga_state.c
 delete mode 100644 drivers/gpu/drm/mga/mga_warp.c
 delete mode 100644 drivers/gpu/drm/r128/Makefile
 delete mode 100644 drivers/gpu/drm/r128/ati_pcigart.c
 delete mode 100644 drivers/gpu/drm/r128/ati_pcigart.h
 delete mode 100644 drivers/gpu/drm/r128/r128_cce.c
 delete mode 100644 drivers/gpu/drm/r128/r128_drv.c
 delete mode 100644 drivers/gpu/drm/r128/r128_drv.h
 delete mode 100644 drivers/gpu/drm/r128/r128_ioc32.c
 delete mode 100644 drivers/gpu/drm/r128/r128_irq.c
 delete mode 100644 drivers/gpu/drm/r128/r128_state.c
 delete mode 100644 drivers/gpu/drm/savage/Makefile
 delete mode 100644 drivers/gpu/drm/savage/savage_bci.c
 delete mode 100644 drivers/gpu/drm/savage/savage_drv.c
 delete mode 100644 drivers/gpu/drm/savage/savage_drv.h
 delete mode 100644 drivers/gpu/drm/savage/savage_state.c
 delete mode 100644 drivers/gpu/drm/sis/Makefile
 delete mode 100644 drivers/gpu/drm/sis/sis_drv.c
 delete mode 100644 drivers/gpu/drm/sis/sis_drv.h
 delete mode 100644 drivers/gpu/drm/sis/sis_mm.c
 delete mode 100644 drivers/gpu/drm/tdfx/Makefile
 delete mode 100644 drivers/gpu/drm/tdfx/tdfx_drv.c
 delete mode 100644 drivers/gpu/drm/tdfx/tdfx_drv.h
 delete mode 100644 drivers/gpu/drm/via/Makefile
 delete mode 100644 drivers/gpu/drm/via/via_3d_reg.h
 delete mode 100644 drivers/gpu/drm/via/via_dri1.c
 delete mode 100644 include/uapi/drm/i810_drm.h
 delete mode 100644 include/uapi/drm/mga_drm.h
 delete mode 100644 include/uapi/drm/r128_drm.h
 delete mode 100644 include/uapi/drm/savage_drm.h
 delete mode 100644 include/uapi/drm/sis_drm.h
 delete mode 100644 include/uapi/drm/via_drm.h

-- 
2.25.1

