Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B36BA56C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCODA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCODAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:00:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B0F4AFF3;
        Tue, 14 Mar 2023 20:00:50 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6045924E2E7;
        Wed, 15 Mar 2023 11:00:42 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 11:00:42 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 11:00:42 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>
Subject: [PATCH v2] media: admin-guide: Update rkisp1.rst
Date:   Wed, 15 Mar 2023 11:00:40 +0800
Message-ID: <20230315030040.107901-1-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Rockchip ISP1 driver file path

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

---
Changes in v2:
- keep that the number of characters in the line is within 80.
---
 Documentation/admin-guide/media/rkisp1.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/media/rkisp1.rst b/Documentation/admin-guide/media/rkisp1.rst
index ccf418713623..6f14d9561fa5 100644
--- a/Documentation/admin-guide/media/rkisp1.rst
+++ b/Documentation/admin-guide/media/rkisp1.rst
@@ -10,8 +10,8 @@ Introduction
 ============
 
 This file documents the driver for the Rockchip ISP1 that is part of RK3288
-and RK3399 SoCs. The driver is located under drivers/staging/media/rkisp1
-and uses the Media-Controller API.
+and RK3399 SoCs. The driver is located under drivers/media/platform/rockchip/
+rkisp1 and uses the Media-Controller API.
 
 Revisions
 =========
-- 
2.34.1

