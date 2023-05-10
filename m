Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4E6FDD88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjEJMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjEJMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:16:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A9037DB6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:16:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8855F1063;
        Wed, 10 May 2023 05:17:13 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 068A43F5A1;
        Wed, 10 May 2023 05:16:27 -0700 (PDT)
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Brian Starkey <brian.starkey@arm.com>,
        Mihail Atanasov <mihail.atanasov@arm.com>
Subject: [PATCH] MAINTAINERS: Cleanup Arm Display IP maintainers
Date:   Wed, 10 May 2023 13:16:18 +0100
Message-Id: <20230510121618.1871790-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1802c0990c8928a430f32d5396d9bc403821551b.camel@perches.com>
References: <1802c0990c8928a430f32d5396d9bc403821551b.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some people have moved to different roles and are no longer involved
in the upstream development. As there is only one person left,
remove the mailing list as well as it serves no purpose.

Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Mihail Atanasov <mihail.atanasov@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 276298cfc7ee4..7d5184550a11e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1660,10 +1660,7 @@ F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
 ARM KOMEDA DRM-KMS DRIVER
-M:	James (Qian) Wang <james.qian.wang@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
-M:	Mihail Atanassov <mihail.atanassov@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
@@ -1684,8 +1681,6 @@ F:	include/uapi/drm/panfrost_drm.h
 
 ARM MALI-DP DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
-M:	Brian Starkey <brian.starkey@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
-- 
2.40.1

