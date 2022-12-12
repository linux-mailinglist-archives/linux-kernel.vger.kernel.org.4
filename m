Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51064A2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiLLOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiLLOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:00:05 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5136FBC4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:00:03 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71AA1240002;
        Mon, 12 Dec 2022 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670853602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6CCT62JP1C7U0DXDZAyRviDx98X4et9QFWwKWnF20lc=;
        b=YOtdqWzKck5OZMbcQ9aP/uxsYRnLTBIXwOtt+slHAC2/unQFuKKcmdYGWHWrS5woIrdGjD
        cVYzU9QpS75uZxlwfvpD1gC07kzYpIc6CG67c1hOzioQkK7caaFClKF/JWXsTNFyZwXEyT
        xkGr5R8DdDbjN2JehiLJjmNK4STKSaKtkBCzypqPbe4szvR+wjDh0YIgR7uOe0MDho0bDy
        lHufuQdNJKBoVLtgifryOalPAmmPOOb7snbvq2gmrX40qcYQTaK698ZW3pvOGK9ye+io5k
        +/OOkOjh+lIHgKdO/66vb/MSLRRpGMf7T75xdUw902Tr3eZtXK0M8SdLpyq0OA==
From:   alexandre.belloni@bootlin.com
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: footbridge: drop unnecessary inclusion
Date:   Mon, 12 Dec 2022 14:59:52 +0100
Message-Id: <20221212135953.212303-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

isa-rtc.c doesn't use any definition from bcd.h, remove its inclusion

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-footbridge/isa-rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/isa-rtc.c b/arch/arm/mach-footbridge/isa-rtc.c
index b8f741a3a37e..237b828dd2f1 100644
--- a/arch/arm/mach-footbridge/isa-rtc.c
+++ b/arch/arm/mach-footbridge/isa-rtc.c
@@ -20,7 +20,6 @@
 
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
-#include <linux/bcd.h>
 #include <linux/io.h>
 
 #include "common.h"
-- 
2.38.1

