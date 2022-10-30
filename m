Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E761272F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ3Dgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Dgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:36:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96258476F2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:36:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h185so8047742pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EewIqadtxsCyBiEyM/6JdLw3ehusmy2aS1aWjmcfQs=;
        b=cggBeky7GhYnq/3rdW4Hn800u3zX6M4KE3uTeEt2FUME2R++pOC9+T1vyjQOZCxYuw
         KeVkjml//POeGcWJmulbtWAkGxArfultufYaElCYfIMJsYqe/sTYXhtzx1uuwgekRnaG
         yR7vg1t31pfVkrwPclCa9g4NaBywZ7BzrnXrjBL8+CwyxUkUbKMPVBC4SgPWSnL/X8wf
         YprjHu8DqzdATZf5haEVQ2cM7C2CNODq80dM7/x1ewvn3NYgdnLZwX9kwcdAx+uWpb9O
         cooWNpplbOWyHMG6eTFfCF1XLNI15mGKUO5L77gOvqUoN9TSFJbtQyd7sRhJ3AKEi4Sq
         7uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EewIqadtxsCyBiEyM/6JdLw3ehusmy2aS1aWjmcfQs=;
        b=RpPoaPTHbVL3Ks27/Y1h9NXVM6BTQ/wC+4knC/OXGwaSr9sYgMia6fMH/pkHB2Wkhh
         siYu5kXpxbvnKozcSkpbjC/5B79KLqHTG4g7vQR+CEIfAxZZ96sPtnuja6OYLUnP0pap
         7aZ7iikMIJsjoaXtXVN7ZlssNfGnL/JyH8yY/6DdKLF1IIxYhiqhTkua4KLFDg33vSVk
         ue5OT5KEzEh8vAuqzbkVy9W3gL+7olKf8TUzQ9mAdhK1h1Lj5LtkmaHAbrGFL0MklLNh
         bcNTOWdhSgDavwr1GadMgtQwvFs2HgZcnqCP+puvzDe0TJ57Ac6hmBn4NSuWq7/VHu8E
         I7tQ==
X-Gm-Message-State: ACrzQf3cjtkA9N7J71gZjfSKo0y/hWsRvhdpoVsxZCKYr/MN2Q6fcIGn
        ygX0tOvitRM6wIjhW1AgiX3gXMEIU+TTirtl
X-Google-Smtp-Source: AMsMyM6cNkA47FxiGKt3aNBxsBNyMkBiMslykI+flo0fmq8e95cHyU0L/ofCAXEcRzPkwasDVdtWOw==
X-Received: by 2002:a63:2215:0:b0:43b:e00f:7c7b with SMTP id i21-20020a632215000000b0043be00f7c7bmr6561352pgi.511.1667100996044;
        Sat, 29 Oct 2022 20:36:36 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id 85-20020a621458000000b005613220346asm1841130pfu.205.2022.10.29.20.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:36:35 -0700 (PDT)
Date:   Sun, 30 Oct 2022 16:36:28 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] i915/gvt: remove hardcoded value on crc32_start
 calculation
Message-ID: <20221030033628.GA279284@mail.google.com>
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

struct gvt_firmware_header has a crc32 member in which all members that
come after the that field are used to calculate it. The previous
implementation added the value '4' (crc32's u32 size) to calculate the
crc32_start offset which came across as a bit cryptic until you take a
deeper look at the struct.

This patch changes crc32_start offset to the 'version' member which is
the first member of the struct gvt_firmware_header after crc32.

It's worth mentioning that doing a build before/after this patch results
in no binary output differences.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/gpu/drm/i915/gvt/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 54fe442238c6..a683c22d5b64 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -104,7 +104,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 
 	memcpy(p, gvt->firmware.mmio, info->mmio_size);
 
-	crc32_start = offsetof(struct gvt_firmware_header, crc32) + 4;
+	crc32_start = offsetof(struct gvt_firmware_header, version);
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
 
 	firmware_attr.size = size;
-- 
2.25.4

