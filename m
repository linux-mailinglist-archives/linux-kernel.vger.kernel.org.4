Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892E66AD80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjANTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 14:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjANTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 14:47:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D64DA5C9;
        Sat, 14 Jan 2023 11:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08284B80A36;
        Sat, 14 Jan 2023 19:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1236C433D2;
        Sat, 14 Jan 2023 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673725670;
        bh=h5oj8uz2mcobJK2H+Hm87QzyJogghFxebdxYASXr6cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiDrcBr9xYYjYZegA2r59TFavCdH1lJzSKxoSZ6AnPCL95MfbvVcN/2vpGfdMQsPS
         cEQ2xGXQikIXt/oa7BuEOV6UUTZwitOmkFZ/IQb+AHojukxeVTNXd7gT4AN+4AE5TF
         xNB1KvHvAWsJJQiJjtrAHEfQ7gL3a2YeYtcoQ+/mKfhDWWwOGZOAOFuWdRRkKcBSR0
         1oLifEXl8Pf53b4bHvQbdXl5r9PY9o9nUOziEzSMP57fwtK63MPFONd5i1qND5Tz2V
         HfKNpJPuqhUU/n0FFCruuQnRLZajl/DjGHd0wL593NZ07RyNMpUnjrPASGFfUoszoq
         wt6ROkuSivsgA==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] Docs: Add some missing SPDX license identifiers of subsystem docs
Date:   Sat, 14 Jan 2023 19:47:41 +0000
Message-Id: <20230114194741.115855-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114194741.115855-1-sj@kernel.org>
References: <20230114194741.115855-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some subsystem documents are missing SPDX license identifiers.  Add
those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/crypto/index.rst     | 2 ++
 Documentation/driver-api/index.rst | 2 ++
 Documentation/gpu/index.rst        | 2 ++
 Documentation/hwmon/index.rst      | 2 ++
 Documentation/input/index.rst      | 2 ++
 Documentation/mm/index.rst         | 2 ++
 Documentation/scheduler/index.rst  | 2 ++
 Documentation/sound/index.rst      | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index da5d5ad2bdf3..95b0870e09b8 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==========
 Crypto API
 ==========
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index b208e0dac3a0..7a2584ab63c4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 Driver implementer's API guide
 ==============================
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index eee5996acf2c..ff06a6b12c5e 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ============================
 GPU Driver Developer's Guide
 ============================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c2b3c1a822dd..2186d732654f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 Hardware Monitoring
 ===================
diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 35581cd18e91..d60bf9cfe005 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 Input Documentation
 ===================
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 5a94a921ea40..c4e9fbacaf38 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================
 Memory Management Documentation
 ===============================
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 1aac972a652f..ae0229f5a9cf 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =========
 Scheduler
 =========
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 5abed5fc6485..7e67e12730d3 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =============================
 Sound Subsystem Documentation
 =============================
-- 
2.25.1

