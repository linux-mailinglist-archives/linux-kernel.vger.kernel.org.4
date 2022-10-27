Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9C60F309
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0I7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiJ0I7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:59:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F3160208
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:59:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so882943pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KU8QUlmyL8K+kL2JWwcrY9MKfup5fHZG57Xenhinxbw=;
        b=KSYKzgO5bo3EHVAA36BTCInDIsYnBhnaVYPX+l79AEiJNHcUstKm85vMi+JzUs58uT
         KFiUXNGJ/611sUUzd3msbLK+C1jVwIw2PS9/nrxVQfwcoUCRYCxr3+ziWgsz9dXszTBS
         tJbRKzhe9vifba5gzjAE1VvW0iWAcxeEAKjsU6oOaZ8fhMAAfBmIDTBhl6t5XrM8r8cq
         zuErgoZ02sCkHxrTHNTz0VTnQapSoABy8hdOQCvFGV1OG0O+uvpVqcVXZ820awkYLViW
         cBcJbRq54zdVXKarPITq8c5P8AvJZ8F8Zv5sAliAdwQ/A2dYlQIKgZ59yjixxLsdAyVl
         /+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KU8QUlmyL8K+kL2JWwcrY9MKfup5fHZG57Xenhinxbw=;
        b=4FNt+IpdIKNB290E5tQCJog6QNvHpUG+KNFDGOvKnrqheUsq572+9SMaXn4A2t8+Nk
         OBoTkB1JKPZ3a9y6g5ybjccy/JmwoIokpZk+sNEqlJnwKaWwTucsTBul0LvEAL0mfWiZ
         hiDWQb7AfCCeiXtalz1b+pN0Cqr7Blg8Qouqk7BhE6vRAqmgyuBEWSPlhe9pi5uZ9cyn
         7TPnY1LJoTY46A7Lm9x0VdSN8/DEyj5k3GndnAJTCr3ECD8FSwi6elUWLTYk3V3ncP1Z
         qgGdff/XuJN+4+E0euLguoBAHdCQPTiaiq0ydlSV2Thvstj1YBr9vLl9eHWLykZzjU0l
         X/kQ==
X-Gm-Message-State: ACrzQf2l+D6nOXC4sOJL7+HNePF0nD9qT9xhnpVxdAN+ckgY6qsJ0nP0
        hVlYNnKQiiYCF+SxxDeIUfQ=
X-Google-Smtp-Source: AMsMyM66ukX1ctNL2P50qsKqcWsCvPccrwS7iSlv8cUwHi9AKQis3RBSWyzfcOhwA1zmjNtdfZSwmw==
X-Received: by 2002:a17:902:dac5:b0:186:a687:e082 with SMTP id q5-20020a170902dac500b00186a687e082mr20920145plx.84.1666861155009;
        Thu, 27 Oct 2022 01:59:15 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id 23-20020a631357000000b0046f1e8cb30dsm635717pgt.26.2022.10.27.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:59:14 -0700 (PDT)
Date:   Thu, 27 Oct 2022 21:59:04 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Isabella Basso <isabbasso@riseup.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] [next] drm/amdgpu: clean up unused constants, macros and
 includes
Message-ID: <Y1pIWKbPi1GtPfE9@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include directives in which header is already included via
another header (atombios.h -> atom.h). Remove unused constants and
macros.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e6ddf05c23c..dc55e60c2e4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -245,10 +245,8 @@ extern int amdgpu_vcnfw_log;
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
-#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
-#define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
 
@@ -1227,7 +1225,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_set_vce_clocks(adev, ev, ec) (adev)->asic_funcs->set_vce_clocks((adev), (ev), (ec))
 #define amdgpu_get_pcie_lanes(adev) (adev)->asic_funcs->get_pcie_lanes((adev))
 #define amdgpu_set_pcie_lanes(adev, l) (adev)->asic_funcs->set_pcie_lanes((adev), (l))
-#define amdgpu_asic_get_gpu_clock_counter(adev) (adev)->asic_funcs->get_gpu_clock_counter((adev))
 #define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_disabled_bios((adev))
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index b81b77a9efa6..0c3448dc4951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -26,7 +26,6 @@
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
-#include "atombios.h"
 #include "soc15_hw_ip.h"
 
 union firmware_info {
-- 
2.37.3

