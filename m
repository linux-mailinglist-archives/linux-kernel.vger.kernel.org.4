Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151FD646672
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLHBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHBYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:24:48 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C1187CA1;
        Wed,  7 Dec 2022 17:24:45 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2B81FC9Q039171;
        Thu, 8 Dec 2022 09:15:12 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Dec
 2022 09:23:38 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <mchehab@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: docs: aspeed-video: Update reference
Date:   Thu, 8 Dec 2022 09:24:23 +0800
Message-ID: <20221208012423.3106-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2B81FC9Q039171
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use URL rather than plain text.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 Documentation/userspace-api/media/drivers/aspeed-video.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
index e5656a8d990e..0e9a3cc838d6 100644
--- a/Documentation/userspace-api/media/drivers/aspeed-video.rst
+++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
@@ -23,7 +23,7 @@ proprietary mode.
 
 More details on the ASPEED video hardware operations can be found in
 *chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
-AspeedTech-BMC/openbmc/releases.
+`github <https://github.com/AspeedTech-BMC/openbmc/releases/>`__.
 
 The ASPEED video driver implements the following driver-specific control:
 

base-commit: 8ed710da2873c2aeb3bb805864a699affaf1d03b
prerequisite-patch-id: bf47e8ab2998acfbc32be5a4b7b5ae8a3ae4218b
prerequisite-patch-id: bf82715983e08f2e810ff1a82ce644f5f9006cd9
prerequisite-patch-id: 28a2040ef0235e5765f05d2fc5529bce2a0f4c6f
prerequisite-patch-id: 7e761c779730536db8baf50db5fc8caf058e95af
prerequisite-patch-id: c48ea20973fa35938a7d33a0e20d2900df48755f
prerequisite-patch-id: 5d2c8043e4026469638dc4541aec76deefa39315
-- 
2.25.1

