Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446466D696
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjAQHCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjAQHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:02:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52923C76
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dlN0SPwGV6tSfnA71oyz5C3ShFWzVI5hrnRHDzQPSpQ=; b=TydOPX5s33/CT4U6i83K8j4yow
        keyfknQMgYzpLQIZgfpIsR7M4SnAxsvHpSacIKU9EsJPcqj41RLUlDuGt2AZUpXDMIMc6jIqPlmtq
        5q4i0KZzEdugOuaR+aTBCOhAa5R3TGfiSRZ1bz7d+45pJNOpoihSHvLgcZoTweASa68bW7pHL2H4W
        Z1aPm9olQkAn+H7Xyuj98XwV8h8mhjG2+rSVMOS/uEYq5fHNerwQDJU1ead7j3K79S37NHxj7ytD4
        I8RXde3nzTRKlw4Omm+h23ITYnPh5BRlpnHHbvFGgdfvE4t1r/Bz2Z6Mn/JCmdN5MrE2RUNakO10b
        U9uqHVmg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfz7-00D7D3-EK; Tue, 17 Jan 2023 07:02:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/atomic-helper: fix kernel-doc problems
Date:   Mon, 16 Jan 2023 23:02:16 -0800
Message-Id: <20230117070216.30318-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a kernel-doc warning and other kernel-doc formatting for
drm_atomic_helper_connect_tv_check().

drivers/gpu/drm/drm_atomic_state_helper.c:560: warning: Cannot understand  * @drm_atomic_helper_connector_tv_check: Validate an analog TV connector state
 on line 560 - I thought it was a doc line

Fixes: 5a28cefda3a9 ("drm/atomic-helper: Add an analog TV atomic_check implementation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_atomic_state_helper.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -557,15 +557,15 @@ void drm_atomic_helper_connector_tv_rese
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
 
 /**
- * @drm_atomic_helper_connector_tv_check: Validate an analog TV connector state
+ * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
  * @connector: DRM Connector
  * @state: the DRM State object
  *
  * Checks the state object to see if the requested state is valid for an
  * analog TV connector.
  *
- * Returns:
- * Zero for success, a negative error code on error.
+ * Return:
+ * %0 for success, a negative error code on error.
  */
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 					 struct drm_atomic_state *state)
