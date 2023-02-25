Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AE6A27B8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 08:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBYH32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 02:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBYH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 02:29:24 -0500
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDC193DD;
        Fri, 24 Feb 2023 23:29:22 -0800 (PST)
Received: from MTA-08-3.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id A855760149;
        Sat, 25 Feb 2023 07:29:20 +0000 (UTC)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 3F62A18000A0;
        Sat, 25 Feb 2023 02:29:19 -0500 (EST)
Received: from localhost.localdomain (cpe-66-66-66-125.rochester.res.rr.com [66.66.66.125])
        by mta-08.privateemail.com (Postfix) with ESMTPA id E7B7D18000A2;
        Sat, 25 Feb 2023 02:29:06 -0500 (EST)
From:   Dylan Le <self@dylanle.dev>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dylan Le <self@dylanle.dev>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 1/1] Documentation: gpu: add acceleration node section
Date:   Sat, 25 Feb 2023 07:28:34 +0000
Message-Id: <40a2ba00efc1f2479bf55b90f4afe7a1532ef760.1677308797.git.self@dylanle.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1677308797.git.self@dylanle.dev>
References: <cover.1677308797.git.self@dylanle.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a stubbed section on Acceleration Nodes.
Resolve gpu documentation warning:
./Documentation/gpu/drm-internals:179: ./include/drm/drm_file.h:411: WARNING: undefined label: drm_accel_node

Signed-off-by: Dylan Le <self@dylanle.dev>
---
 Documentation/gpu/drm-uapi.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index ce47b4292..98c5add9c 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -175,6 +175,15 @@ other hand, a driver requires shared state between clients which is
 visible to user-space and accessible beyond open-file boundaries, they
 cannot support render nodes.
 
+.. _drm_accel_node:
+
+Acceleration nodes
+==================
+
+.. admonition:: This section is empty.
+
+   Add relevant documentation here.
+
 Device Hot-Unplug
 =================
 
-- 
2.30.2

