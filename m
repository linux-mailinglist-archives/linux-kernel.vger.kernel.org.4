Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED575024A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGLJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGLJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEE1FC0;
        Wed, 12 Jul 2023 01:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950D8616FC;
        Wed, 12 Jul 2023 08:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BB7C433C7;
        Wed, 12 Jul 2023 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152390;
        bh=q7X2H6wnJfjAIZzf5I1p+6g/psQfHm52+nWJPGyD/fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nu1RxwCLBGO1JbcwAvLaNexfSyoJuJQTwytsebBBUQNtoZIrMa0JJ9THxO+5vu2pa
         v/Qdd39gZJsfTAcB6gh+j8xjRMf4PPC1cBH5sqdF1GPJeJVBNNEqHLIrR+8w7bfPMP
         qGGHe1VPNlc8Fxs154PJUn7aXn8XF5RO6/Z/InMu6BvVmMbZaw/31qvSAXSu2EM/Bh
         H/yfbco6KIN0OWDp3mafTUz8YG1pFPDU7ch2jwPKDHmpRa9k9MkB8jThlAyKki0ey3
         W6oG93UIOXTHajb2c6TgDN/bdF41XeiiCxZElLJceQFgmiYQtF0N8AUTII+DqzMsTQ
         BEwQi/CHTa3VA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/7] vgacon: remove unneeded forward declarations
Date:   Wed, 12 Jul 2023 10:59:37 +0200
Message-ID: <20230712085942.5064-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the forward declarations in vgacon are not needed. Drop them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index fbed2862c317..a34cdfcc10c2 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -65,16 +65,8 @@ static struct vgastate vgastate;
  *  Interface used by the world
  */
 
-static const char *vgacon_startup(void);
-static void vgacon_init(struct vc_data *c, int init);
-static void vgacon_deinit(struct vc_data *c);
-static void vgacon_cursor(struct vc_data *c, int mode);
-static int vgacon_switch(struct vc_data *c);
-static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
-static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
-static void vgacon_save_screen(struct vc_data *c);
-static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
+
 static struct uni_pagedict *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
-- 
2.41.0

