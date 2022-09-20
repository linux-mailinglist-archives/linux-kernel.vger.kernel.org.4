Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E85BDC84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiITFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiITFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:41:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A44507A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SFA4U7SNnj5axMlyD6+ZISStwj66ZZ5rXuREXi8QMfM=; b=sW+JodFX8jPpgU5zktkR/G9VcH
        b3XRpzznJ1uI3aSl9He44RXvJX7I7PnyoN2sXgROC9EgHVOZu8qySf0gURRQs8BzPG1vVmAlmx/kL
        0+i5UwiqCb3gqX7PPf36h3tIhyFtKdRpv7qlWJjOXW63y+wjTV1T6yec6YMhbVsTVz2XSXw4yKX5T
        KWHt56vP9zXCp51tEgjJk1hmuBxTIYGfTVGQnfUVk18tb04D7+PFamcWU/H8ZDy8udWISPXw9rcC2
        PQCabQMt1DGwm7or1qNViX9rRn8XfxEVU7tjnUMlGSrwmjyyeB6FBxcArRY0SAYPj/4V7jvGmQekf
        fQlbEnoQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaW0S-005Hes-KP; Tue, 20 Sep 2022 05:41:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: [PATCH] drm/atomic_helper: correct kernel-doc function name warning
Date:   Mon, 19 Sep 2022 22:41:09 -0700
Message-Id: <20220920054109.5658-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
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

kernel-doc warns that a function name in a comment does not match the
code's function name, so correct that.

../drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com
---
 drivers/gpu/drm/drm_atomic_helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -786,7 +786,7 @@ drm_atomic_helper_check_modeset(struct d
 EXPORT_SYMBOL(drm_atomic_helper_check_modeset);
 
 /**
- * drm_atomic_helper_check_wb_connector_state() - Check writeback encoder state
+ * drm_atomic_helper_check_wb_encoder_state() - Check writeback encoder state
  * @encoder: encoder state to check
  * @conn_state: connector state to check
  *
