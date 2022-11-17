Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887262D876
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiKQKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiKQKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:52:24 -0500
X-Greylist: delayed 246 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 02:52:20 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73D9C5ADFB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:52:20 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id A74175DC6B;
        Thu, 17 Nov 2022 11:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1668682310;
        bh=WzRXQrz6HmNFgkYpE8f7pj/XBXRsA4vhkWo52X7TjJ8=;
        h=From:To:CC:Subject:Date:From;
        b=bQ8DUiKlTwhRyU/GEz+I9488s3ZXlA6XP2lJ6JbYAwP5wxpfwIeS6+FlhhwZuCojJ
         FcPdjpfM3VVqm9a/bLax3sQKtPI4bbt2usD0M8TeZ+tdmaAbV7o0/tHjXYNI/4J9+k
         t2NZLOSvP+3486hJqegICT+c8ugpcOJJ7SKkA9hz6HW2dRJlAkPF7sOxom2wqXTFJu
         5rgZlOa9Lt/D42JwrJhyQ5LZeTnj1eNiW7tfcUnrTl9rSbY3wKjsy1lJvHpJSnnAZg
         pAGzaIouZ8Sir+QxgoWUXecD8z9NEPd9N+oL2g8Vr321Fyo+cQK+K9BeilK5NQ9Wgx
         D8/oVvfDMb1Ww==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Thu, 17 Nov 2022 11:51:44 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Thu, 17 Nov 2022 11:51:44 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <arnd@arndb.de>, <soc@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add DHCOR to the DH electronic i.MX6 board support
Date:   Thu, 17 Nov 2022 11:51:31 +0100
Message-ID: <20221117105131.7059-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DHCOR to the DH electronic i.MX6 board support to cover the
DHCOR i.MX6ULL SoM. It is a solderable SoM.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: arnd@arndb.de
Cc: soc@kernel.org
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e4d61369bee..aaacc277136f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6069,11 +6069,12 @@ F:	include/net/devlink.h
 F:	include/uapi/linux/devlink.h
 F:	net/core/devlink.c
 
-DH ELECTRONICS IMX6 DHCOM BOARD SUPPORT
+DH ELECTRONICS IMX6 DHCOM/DHCOR BOARD SUPPORT
 M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
 L:	kernel@dh-electronics.com
 S:	Maintained
 F:	arch/arm/boot/dts/imx6*-dhcom-*
+F:	arch/arm/boot/dts/imx6*-dhcor-*
 
 DH ELECTRONICS STM32MP1 DHCOM/DHCOR BOARD SUPPORT
 M:	Marek Vasut <marex@denx.de>
-- 
2.11.0

