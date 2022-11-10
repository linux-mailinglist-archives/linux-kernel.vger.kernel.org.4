Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AAA6238E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiKJBer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiKJBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:34:45 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16241E71D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:34:44 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9F1F1216;
        Wed,  9 Nov 2022 17:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1668044084;
        bh=aMUJmwn2tQh5G1GOQ7muR4JdKNLACHu6x6zglyc6xeo=;
        h=From:To:Cc:Subject:Date:From;
        b=j3YgJkCeaZFMY3ySEztwGyArlwSjTmP2O3YQ9XznmrjQgLKe0ziaFVEd78TzMGzSn
         XNHCgYpHGfmliBnFeIcVUvVReWxXBRGbafKgF6UMAss+moAda/muO3OqjWf/n26UX1
         bt/RAjF6hkR0XbIH2ZmKMjN42G4e3ccJwyrsFJs8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH] MAINTAINERS: aspeed: Update git tree URL
Date:   Wed,  9 Nov 2022 17:34:38 -0800
Message-Id: <20221110013438.16212-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description for joel/aspeed.git on git.kernel.org currently says:

    Old Aspeed tree. Please see joel/bmc.git

Let's update MAINTAINERS accordingly.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cac5a4ad4eb8..1775e5fdaefd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1969,7 +1969,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	arch/arm/mach-aspeed/
-- 
2.38.1

