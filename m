Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1B6A0186
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjBWD0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjBWD0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:26:07 -0500
X-Greylist: delayed 1163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 19:26:03 PST
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F22E0F6;
        Wed, 22 Feb 2023 19:26:03 -0800 (PST)
Received: from MTA-12-4.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPS id 187D86053A;
        Wed, 22 Feb 2023 21:55:03 -0500 (EST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 4ACB218000B0;
        Wed, 22 Feb 2023 21:55:01 -0500 (EST)
Received: from localhost.localdomain (cpe-66-66-66-125.rochester.res.rr.com [66.66.66.125])
        by mta-12.privateemail.com (Postfix) with ESMTPA id DE25E18000A3;
        Wed, 22 Feb 2023 21:54:49 -0500 (EST)
From:   Dylan Le <self@dylanle.dev>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dylan Le <self@dylanle.dev>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] Documentation: gpu: add acceleration node section
Date:   Thu, 23 Feb 2023 02:52:52 +0000
Message-Id: <7799513f0fb5aee27b64752c037980471be669c5.1677120686.git.self@dylanle.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was initially written for the Linux Kernel Bug Fixing Mentorship
program. The patch adds a temporarily stubbed section on Acceleration Nodes
to resolve a documentation warning.

This resolves the warning:
./Documentation/gpu/drm-internals:179: ./include/drm/drm_file.h:411: WARNING: undefined label: drm_accel_node

I would appreciate any feedback on what should be documented here.

Signed-off-by: Dylan Le <self@dylanle.dev>
---
 Documentation/gpu/drm-uapi.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index ce47b4292..d25539862 100644
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
+.. note::
+   There is not any documentation yet need to figure out what this is.
+
+
 Device Hot-Unplug
 =================
 
-- 
2.30.2

