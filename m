Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E766922D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjBJP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjBJP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:59:05 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F75895E;
        Fri, 10 Feb 2023 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676044185;
        bh=JFMlB1aX3qf2fUdQC5LzmEbj4Cohdg5vUwREenKUSuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0Nh/pYaQxTegmQLQg5asiY75c3OEBQ5lsNXvlCj2DH+KCN9Zim49Ti+Qv4OkcSI9
         WVetFTwAb01QMqu/lZcRHS4D5Ml9bkUIcErTQJNZoemx/hk9EBFkZI0I6dqr9o+4TQ
         CdzsqcWgr/+txIWbGqzuHXs8NaQhtYJy4rL+NW7I=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 0A6BDA08F0;
        Fri, 10 Feb 2023 16:49:45 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 6/6] =?UTF-8?q?MAINTAINERS:=20Add=20Michal=20Vok=C3=A1?= =?UTF-8?q?=C4=8D=20as=20yapp4=20boards=20maintainer?=
Date:   Fri, 10 Feb 2023 16:48:55 +0100
Message-Id: <20230210154855.3086900-7-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210154855.3086900-1-michal.vokac@ysoft.com>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of the boards is continually growing and we expect more to come.
Add myself as a maintainer of the yapp4 (ysoft appliance v4) platform to
state that we do take care about all of these.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5ed3..4d4d9ffc700c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23005,6 +23005,12 @@ S:	Maintained
 F:	Documentation/input/devices/yealink.rst
 F:	drivers/input/misc/yealink.*
 
+YSOFT IOTA BOARD SUPPORT
+M:	Michal Vokáč <michal.vokac@ysoft.com>
+L:	devicetree@vger.kernel.org
+S:	Supported
+F:	arch/arm/boot/dts/imx6*-yapp4*
+
 Z8530 DRIVER FOR AX.25
 M:	Joerg Reuter <jreuter@yaina.de>
 L:	linux-hams@vger.kernel.org
-- 
2.25.1

