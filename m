Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3760F2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiJ0Iqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiJ0Iqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:46:44 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181232AB1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:46:40 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WKW00033;
        Thu, 27 Oct 2022 16:46:33 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 27 Oct 2022 16:46:34 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] drm: Include missing header
Date:   Thu, 27 Oct 2022 04:46:25 -0400
Message-ID: <20221027084625.2505-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202210271646332f5d602ca8eb02dc5222562c63677094
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file drm_nomodeset.c missed the header drm_drv.h, which
resulted on the following warning:

drivers/gpu/drm/drm_nomodeset.c:8:6:
warning: no previous prototype for 'drm_firmware_drivers_only'
[-Wmissing-prototypes]

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/gpu/drm/drm_nomodeset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
index f3978d5bd3a1..9402deb4985f 100644
--- a/drivers/gpu/drm/drm_nomodeset.c
+++ b/drivers/gpu/drm/drm_nomodeset.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <drm/drm_drv.h>
 
 static bool drm_nomodeset;
 
-- 
2.27.0

