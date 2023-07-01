Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E805744613
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGACKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 22:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGACKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 22:10:18 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F39448B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FpvV1NRn92NjSFc/aa9HU0kB1fj/LcwCHP8r7t79LKQ=; b=IQwSBaK4dtvffDRp6/HaKl/E7a
        HJgIluzVyRfp+1nipl9ZO4ikcNp8vPJyIiK/sZ+AWWQz+fEHLF82HpYZdnE/xq61NQ0xOcAkPXuhj
        pNuMDYbZBfQX4QF3DdXJRehvlT1FOK1ExMYnBSGJvkYGAeE+wqpoqi7VxqUovfVXj7uiUZRvZ7oj+
        HIgVNImcyhMGUOTsesmF9Nc19mBFj+GqABzhb0pwSEHz3Udeit2RPm1/3ygDq4s42EMG4D4FvKMjA
        KYl6+k6jm1dmt0Z+IHtvyZSQP2YpdRPA/xy2zERwziURYskIVdOjutkBqjj87mWiK5IG4ArTQ9aVz
        oswa/ALg==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qFQ3g-006abr-5T; Sat, 01 Jul 2023 04:09:56 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 6/6] drm/doc: Define KMS atomic state set
Date:   Fri, 30 Jun 2023 23:09:17 -0300
Message-ID: <20230701020917.143394-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701020917.143394-1-andrealmeid@igalia.com>
References: <20230701020917.143394-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify how the atomic state is maintained between userspace and
kernel, plus the special case for async flips.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch
---
 Documentation/gpu/drm-uapi.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 65fb3036a580..5464376051cc 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -486,3 +486,22 @@ and the CRTC index is its position in this array.
 
 .. kernel-doc:: include/uapi/drm/drm_mode.h
    :internal:
+
+KMS atomic state
+================
+
+If a userspace using the DRM atomic API would like to change the modeset, it
+needs to do in an atomic way, changing all desired properties in a single
+commit. Following commits may contain the same properties again, as if they were
+new. The kernel can then judge if those properties requires modesetting and real
+changes, or it's just the same state as before. In summary, userspace commits do
+not need to set the minimal state as possible and can commit redundant
+information, and the kernel will ignore it.
+
+An observation must be made for atomic operations with DRM_MODE_PAGE_FLIP_ASYNC.
+In such scenarios properties values can be sent, but the if they change
+something, the kernel will reject the flip. This is done because property
+changes can lead to modesetting, that would defeat the goal of flipping as fast
+as possible. The only exceptions are the framebuffer ID to be flipped to and
+mode IDs changes, which could be referring to an identical mode, thus not
+requiring modeset.
-- 
2.41.0

