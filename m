Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51A5B6661
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIMERF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIMEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:16:59 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F15424D143
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BhBHv
        zEVMyp3CnEaxDcDVkgFh4/ncYg7wV3iItqjlKw=; b=AWVhQcYc/8T/YPyifrNep
        opPLD5bllKm9HK3v4I+HX40znaLB0wF/0RC/iHLvSrVCbKdXzC6sKn3sLATFPxME
        4QT5wCx6FpX7P18MRHQZ4uAXZU41iOyHaOt7j/fiH7gVXoLWJ3BNVRcShMbkIwPF
        mTzQwMdFKPmtGvJxsmbx+4=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp13 (Coremail) with SMTP id EcCowABnt6PiAyBjqDKtbg--.7738S4;
        Tue, 13 Sep 2022 12:15:43 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/writeback: Remove redundant initialization of variable ret
Date:   Tue, 13 Sep 2022 12:15:28 +0800
Message-Id: <20220913041528.115637-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABnt6PiAyBjqDKtbg--.7738S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyrJF47KrWxuFWkKw1Utrb_yoW3Krc_uF
        1UXas7WrnrCFyqyr47Zan3AFyIk3WkuFs3J3Z5t3Z3t3ZrAw1fXry7Gry8Xw1jga47WF9r
        Way2gr4xArs7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZ-BN3UUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbisgl7F1UMWXkpYQACsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    The variable ret is being initialized with a value that is never
    read, it is being updated later on. The assignment is redundant and
    can be removed.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/drm_writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index a031c335bdb9..1bf8987322cd 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -179,7 +179,7 @@ int drm_writeback_connector_init(struct drm_device *dev,
 				 const u32 *formats, int n_formats,
 				 u32 possible_crtcs)
 {
-	int ret = 0;
+	int ret;
 
 	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
 

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

