Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533363F44A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiLAPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiLAPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:39:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B46A75E;
        Thu,  1 Dec 2022 07:39:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m14so3294463wrh.7;
        Thu, 01 Dec 2022 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m4lR5iK2kmxABfa43t2m8SIZD2ax3y9Sc1+j5dpKAI=;
        b=LCvjsgK+CJig+4ldDaHtFllWv0RCXqDGiuaOGqkjxBb/MbaSDbgyGe8l5JV7Z3DaSq
         B+W6IKfOnodpVe5JClUu5OsuMWLyEPvYKKLVjnNPI0+6qOrFifEAksE2dZwvAPPte+CN
         5lFsUJgwit1WV0Tb1OYfRLSWPiQNXcscdrCdY3jfBeya7akC1csG9oSaXW4tAtdgeACM
         uMaQ5bgpr4hpzXSRl6AIwODi17mlcQaiNMbD1ZC50MfuJC7OVCvRM3Q8JwoIBhAAD5IT
         Hkpk4KatoTm8DhzKoHgz342mSym9AWuFnCduxmvMyR+NZc4FzUp+2A3S5tXqXJuCPGGc
         sUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m4lR5iK2kmxABfa43t2m8SIZD2ax3y9Sc1+j5dpKAI=;
        b=VDdwMvD/Q2g19b4d6F3xsEIRLjRaTsApi14eF6aiBDiw5zVOTN1IVvQnDTBh+2yoUr
         aw3w7UtJxaH0x+t/rdtadqcy7+jIsaBuyzbpL77LSeggM8Kc+P+GiIAygkSXZ/JvhUzJ
         jJXzcD3HqLe4mpS4Q8wXXWeANuXTVxEmDuybHkzLNn76ETXrm1x83l8PNSuEl9QkZ/U1
         NYjYbfgv6GaF6W56VT639aWjzGyTiloQ4FER2eZLe76ld0562tC81otZmDGrrnqwOz3R
         KToQx6ptIPjwpf637aYATdJOABigicTwrJSZUZ/9ccci6yfMvXyu7OYwg4stH3WikMgi
         pLeg==
X-Gm-Message-State: ANoB5pldO/j39T+mIk43tWCiGCmOY8iXyUXWo4v3QJA+3lEw0EvCZHh8
        J50tpE/ttdKHHpvoHMm3l4zAJalx19Q=
X-Google-Smtp-Source: AA0mqf4YF2ImTRWdFV3LVCym0LVVnvPdj5LT9uGv92FB1Bh89MJf2KmQ3XjU18ekZuWMau74F8S5mg==
X-Received: by 2002:a5d:6210:0:b0:22e:6a6f:3416 with SMTP id y16-20020a5d6210000000b0022e6a6f3416mr40531398wru.60.1669909140115;
        Thu, 01 Dec 2022 07:39:00 -0800 (PST)
Received: from wlan-cl-kit-cs-172-17-20-201.scc.kit.edu ([2a00:1398:9:fb03:6341:588f:5b6d:9173])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm5523597wmb.42.2022.12.01.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:38:59 -0800 (PST)
From:   Peter Maucher <bellosilicio@gmail.com>
To:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Maucher <bellosilicio@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: improve GART and GTT documentation
Date:   Thu,  1 Dec 2022 16:38:20 +0100
Message-Id: <20221201153820.257570-2-bellosilicio@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201153820.257570-1-bellosilicio@gmail.com>
References: <20221201153820.257570-1-bellosilicio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document difference between amdgpu.gartsize and amdgpu.gttsize
module parameters, as initially explained by Alex Deucher here:
https://lists.freedesktop.org/archives/dri-devel/2022-October/375358.html

Signed-off-by: Peter Maucher <bellosilicio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bf2d50c8c92a..d647836ba7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -230,17 +230,18 @@ module_param_named(vis_vramlimit, amdgpu_vis_vram_limit, int, 0444);
 
 /**
  * DOC: gartsize (uint)
- * Restrict the size of GART in Mib (32, 64, etc.) for testing. The default is -1 (The size depends on asic).
+ * Restrict the size of GART (for kernel use) in Mib (32, 64, etc.) for testing.
+ * The default is -1 (The size depends on asic).
  */
-MODULE_PARM_DESC(gartsize, "Size of GART to setup in megabytes (32, 64, etc., -1=auto)");
+MODULE_PARM_DESC(gartsize, "Size of kernel GART to setup in megabytes (32, 64, etc., -1=auto)");
 module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
 
 /**
  * DOC: gttsize (int)
- * Restrict the size of GTT domain in MiB for testing. The default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
- * otherwise 3/4 RAM size).
+ * Restrict the size of GTT domain (for userspace usage) in MiB for testing.
+ * The default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM, otherwise 3/4 RAM size).
  */
-MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 = auto)");
+MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes (-1 = auto)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
 
 /**
-- 
2.38.1

