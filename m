Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D767A6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjAXXes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjAXXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:34:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F4C15B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uT0YqJBPmKZz3fozeGYWLQMLCtqA1Ku+GS9mk6AzqdM=; b=dp37X6xtz89np8/GExSy0zXPiL
        Jb5cQq9yOlyiOxKLUxZ2UaopDWtB6/6EqG6psJDMnIdbaZegFfrUyX+DuNWrezKN2DIcqmyo750+X
        wsuhTxz+Yul0HXGK3oF7T15d3pmOtVHB5QvTJIUqS+QRBJbsz5dpatF7W7ewqjsQHb3rk2rl2ouss
        8yxBxUOBe2Kt/xeF4vG1I5XnpPGrKwxgHc/tSfhLTWjcnYd/BS8nWWnHrUn035Mi5ah4LGsWOsYJ9
        ldG0tTBL3FxS2a49FE1BF6jRo9+d/AL9fY0V2iFo0Tfpgv6nLcgBrz05h/CyS1F8sa7gQ400OtOwb
        Z++1vSXA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKSoN-005eDB-5c; Tue, 24 Jan 2023 23:34:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: Kconfig: fix a spelling mistake
Date:   Tue, 24 Jan 2023 15:34:42 -0800
Message-Id: <20230124233442.22305-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

Correct a spelling mistake (reported by codespell).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
-- 
 drivers/gpu/drm/bridge/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -326,7 +326,7 @@ config DRM_TI_DLPC3433
 	  input that produces a DMD output in RGB565, RGB666, RGB888
 	  formats.
 
-	  It supports upto 720p resolution with 60 and 120 Hz refresh
+	  It supports up to 720p resolution with 60 and 120 Hz refresh
 	  rates.
 
 config DRM_TI_TFP410
