Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A49652D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLUHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:41:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B163ED
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:41:11 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2409:4041:6e00:8664:7b2b:8fb:60de:a205])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6649EFB;
        Wed, 21 Dec 2022 08:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671608468;
        bh=eFlNBXwSSXctvuPUS9pXmGHrLnv5YhS5W9CJ67PeCAI=;
        h=From:To:Cc:Subject:Date:From;
        b=oD54nE+MO8FZZBeM2qhzezzombfMcjovY29Zc3E2ooJVEzhWBpC8s4lh9nZ/ekiqP
         bS2nSMcIyQcJH/1COl9mW9x9XHy0b3+6bT8gzWuK/66SHMrpfKtS38C4ocKyvj0nAx
         QfPsbtU3+09gHNSzxEzeglfviTLTQ0ULIFQ0+Lhw=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] staging: vchiq_arm: Remove extra struct vchiq_instance declaration
Date:   Wed, 21 Dec 2022 13:10:47 +0530
Message-Id: <20221221074047.233473-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional declaration of struct vchiq_instance was introduced in the
commit 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to
service callbacks"). Drop the extra declaration.

Fixes: 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to service callbacks")
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 66965da11443..52e106f117da 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -78,8 +78,6 @@ struct vchiq_service_params_kernel {
 	short version_min;   /* Update for incompatible changes */
 };
 
-struct vchiq_instance;
-
 extern int vchiq_initialise(struct vchiq_instance **pinstance);
 extern int vchiq_shutdown(struct vchiq_instance *instance);
 extern int vchiq_connect(struct vchiq_instance *instance);
-- 
2.38.1

