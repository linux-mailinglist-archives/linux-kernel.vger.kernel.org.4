Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D355646676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLHB0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLHB0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:26:07 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326E8E5B1;
        Wed,  7 Dec 2022 17:26:03 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2B81HKDk039245;
        Thu, 8 Dec 2022 09:17:20 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Dec
 2022 09:25:46 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <stanimir.varbanov@linaro.org>, <ezequiel@vanguardiasur.com.ar>,
        <nicolas.dufresne@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: docs: pixfmt-reserved: Update reference
Date:   Thu, 8 Dec 2022 09:26:31 +0800
Message-ID: <20221208012631.3160-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2B81HKDk039245
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
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 73cd99828010..58f6ae25b2e7 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -271,7 +271,7 @@ please make a proposal on the linux-media mailing list.
         The implementation is based on AST2600 A3 datasheet, revision 0.9, which
         is not publicly available. Or you can reference Video stream data format
         – ASPEED mode compression of SDK_User_Guide which available on
-        AspeedTech-BMC/openbmc/releases.
+        `github <https://github.com/AspeedTech-BMC/openbmc/releases/>`__.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__

base-commit: 8ed710da2873c2aeb3bb805864a699affaf1d03b
prerequisite-patch-id: bf47e8ab2998acfbc32be5a4b7b5ae8a3ae4218b
prerequisite-patch-id: bf82715983e08f2e810ff1a82ce644f5f9006cd9
prerequisite-patch-id: 28a2040ef0235e5765f05d2fc5529bce2a0f4c6f
prerequisite-patch-id: 7e761c779730536db8baf50db5fc8caf058e95af
prerequisite-patch-id: c48ea20973fa35938a7d33a0e20d2900df48755f
prerequisite-patch-id: 5d2c8043e4026469638dc4541aec76deefa39315
prerequisite-patch-id: 81f37634b7fd1203fb728b11032f5e8f2f24b7bf
-- 
2.25.1

