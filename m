Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9C67FDEF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjA2JnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjA2Jm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:42:58 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10ED4EEC;
        Sun, 29 Jan 2023 01:42:53 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 64425CD5C9;
        Sun, 29 Jan 2023 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674985371; bh=5cZ3PSR8RMhBCiVLHiSjlSfXJ/EKM4Jw/LuRNYgOOw4=;
        h=From:Subject:Date:To:Cc;
        b=kdlwVaiUdlXqsxb8G7+c7YgWAIwzgXyrvC0bDVhTI94ptxg7o9blo1ATM6X4FjpT1
         HeiZPi3CSu1QMzzcx5LLkDJW3lGhj7alJS9C1S7/M35nrA9EOA2XxR8r6PNWhzJ2rv
         cARsORt3Qdmdr9Vls1+p+239/hmZdeb/KkTN8d1A=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/4] Improvements for OmniVision OV2685 driver
Date:   Sun, 29 Jan 2023 10:42:34 +0100
Message-Id: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIo/1mMC/x2OQQ6CMBAAv0J6dkm7KIJfMR7askgP22LXNBrC3
 y0eJ5lJZlNCOZCoW7OpTCVISLGCOTXKLzY+CcJUWaHGThscIRXshwsEXnMqxBTfAk53bvKz8Th
 qVUtnhcBlG/1ytC+fGFh4GK9n6FvTfsFbpmzxkNdMc/j8F+6Pff8B+CvB5JIAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=5cZ3PSR8RMhBCiVLHiSjlSfXJ/EKM4Jw/LuRNYgOOw4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj1j+WxAnPEP89xWG0wDUYNJdiMsDrJZusltKTlGLo
 HUwbw2qJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9Y/lgAKCRBy2EO4nU3XVlXiEA
 DLq7jWibpR9b2CjyyJ3EMWjP1Gbcg695AmImGxRk2VLJTk7VA1F6ac1kh2IHSzrU6F7f3fZgvxpCed
 bARa7d6iRdgwQz1Kn5bNUPoWqdh/YK0MzdghP1DjpCq0o+Yu0k0/MHErbDGmNyAS5g660YQtoc5K7B
 1QymTw3HdWfaRR9mHfxf81Iw7btWcCQBWV3ktD7W4L3qL7F8rnqpJIooaoyx4TZnp/6WylPUSyadS1
 SOKr2NhRv9AIjc2UUTJbTo2K3wzEm/3mzBgTTpxubM8Zc8LqLZWyH34JP4SC0sAn9n9ax6aH1dMx83
 9cqQaNMVxdS3P4InoEj2p+qocgDMUxQ2Wc0m7cE1xGHuIAS6HTdbAydsO/kS2f4SS7Iqwqz5OuJdQb
 +V0cpZqUi0BFDvgcyouYVsm5qMxq2MGt607NY3XoOyP8JhywG0lRa6bAfE3vmMFucacLrs5TZInQ3e
 +0nO9brIHF4GQyznbviNlow545Lzeaj1qM4F/Me+yh5+409qLBUT6fZ/Ygu2ah4U4W8ArPyvVBqpBg
 z3uwichgMSrX4W8A5KI+4xU2JjdWVjL0CbPoeWdWFewX9wosw0PY97yZKxYzf/RGWX8y569d1EGUO9
 L6Y+7DNFz2dvaQqYz0KjrBwu42kUXEtak3DROU3p2LCLDQf4Om3ZTpr03cOg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches make the sensor work in my setup, and adds a
missing error print that can happen when the dts is wrong.

The last two patches add extra API support for orientation/rotation and
get_selection that is wanted by libcamera to function correctly.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (4):
      media: i2c: ov2685: Make reset gpio optional
      media: i2c: ov2685: Add print for power on write failed
      media: i2c: ov2685: Add controls from fwnode
      media: i2c: ov2685: Add .get_selection() support

 drivers/media/i2c/ov2685.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)
---
base-commit: b4c97ca9bb2381580a132a6c71b0e93ac6a4524a
change-id: 20230129-ov2685-improvements-b03bdcf1c290

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

