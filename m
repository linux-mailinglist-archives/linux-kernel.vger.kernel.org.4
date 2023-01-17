Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703F66D697
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjAQHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjAQHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:02:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86223C62
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5I2Zy0kqRlQJom1yDfokfsGYO/K5DfqUgzErbHGVL+I=; b=4hzrdTBBdegDh/+PkXMyOAELqt
        rNgH4KyJnWTXCKoGktXMZJWwIFjOj2fsHfgiwgEHa0ltW8HZzaf08C9e0YwIO66uFm9nctEsiDF4N
        mDE8fho5yq3+xfVIwKONQR9dEIoZGSHqs/HJhFuqvXfwK/cQHu2S1j0bToVrow3vqcU+++jlhVPat
        UaIsuc9zT2cz5JaycdWeqLWVAOiO9IGOpQAYqObyeHnJqzrQkfn3atweWrbpfjEb2Dn31Ui3WyHEP
        NUww/fDHTEDrlr6brssw8KDKpVsTx2+denBVktnjcsD8Yr32ZG5OdU5E6RxLJI5GNUn7qcVOVQWP2
        idh5Aquw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfzF-00D7F5-Ce; Tue, 17 Jan 2023 07:02:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/connector: fix a kernel-doc bad line warning
Date:   Mon, 16 Jan 2023 23:02:24 -0800
Message-Id: <20230117070224.30751-1-rdunlap@infradead.org>
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

Building the kernel documentation causes this warning 7 times.
Fix it by adding a " *" line instead of a blank line.

drivers/gpu/drm/drm_connector.c:1849: warning: bad line: 

Fixes: 7d63cd8526f1 ("drm/connector: Add TV standard property")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_connector.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1846,7 +1846,7 @@ EXPORT_SYMBOL(drm_mode_create_tv_propert
  * drm_mode_create_tv_properties - create TV specific connector properties
  * @dev: DRM device
  * @supported_tv_modes: Bitmask of TV modes supported (See DRM_MODE_TV_MODE_*)
-
+ *
  * Called by a driver's TV initialization routine, this function creates
  * the TV specific connector properties for a given device.
  *
