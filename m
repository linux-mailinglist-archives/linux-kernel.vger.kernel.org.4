Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF16C38DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCUSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:04:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF6428874;
        Tue, 21 Mar 2023 11:04:03 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 75013D2507;
        Tue, 21 Mar 2023 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679421841; bh=HwB0ZuRNWrqpTOlVVTUYlNTrECE0v12cX7hvTiKu2aY=;
        h=From:Subject:Date:To:Cc;
        b=Fw5fu1dhxcpet0rDPnyHgwqPlPUZCvHDttuQZo7TzMCGdre3QV53cLyG1wqgujPwD
         LQ3gwZTO576N3tF7bK16U/VRWRJP44rmkZQp4ERCSNVb4CHWTVgeUO1vpigtpBRrq/
         0DGQpAxOepM7wdfytOZlgzE2F5SnbICkmhEr/IS8=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 0/3] Improvements for OmniVision OV2685
Date:   Tue, 21 Mar 2023 19:03:54 +0100
Message-Id: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrxGWQC/42OMXLDIBBFr+KhzmpgURThKvfwuAC0sigAGxTGk
 kZ3D3KVKuPy/dn/9m8sU3KU2fm0sUTFZRdDBflxYnbS4UbghsoMOUouUEEs2PWf4Pw9xUKewpz
 BcGkGOwqLirPaNDoTmKSDnY7uw0YPPvtefbXQNaJZwGpPSeNxfE80uudrwuVaeXJ5jml5LSriS
 P9/XgRwGLEXZmiVVMp+rzLMP81zWdnhK/iGA6sDBW85H9F0kv469n3/BdHDpnonAQAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=HwB0ZuRNWrqpTOlVVTUYlNTrECE0v12cX7hvTiKu2aY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkGfGLvRxwXR5Hbw6omGoG95p/e0d3J7ylsBvHu
 7b1BGKHrZeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZBnxiwAKCRBy2EO4nU3X
 Vh1KEAC9bGYskqWkEm6u+4tZEERnaXIncwK9evZoGaCtWrhJFibWlMCzr473a5qX+5/ak2LWRYO
 aXfcN//lyECi2QqSGrukAMaVFCTI0XEKxKfldIZsGLHNd3xraFAPJ1kPbk+rZqlIsKCG5XTfPxU
 a/yyG7PoOEm5Ss4mwjTC0u5nHkfs1EpdLarAPv5bMYbA3NJJk3cuWwsh+UzsMk/y6UqYvwOW1ge
 nN026gpYeq3lYHmwVx839pO/iVBAGUDa3AFnnHVFd15doBkTTgAbMMOe5NsohtSanlbnm+Po/4H
 kCpalxuQpd0aDYpqlGA4gNa2N4NjqcnsqqMTUHcSuZKk3+BmrE17cQTANk19XY8IATyiXfYckxI
 /30AQJOBrnR9Qe2WAUG4gR4q5j8PwvKkADIjd7fOW+8PeAsi9Lhg89gwHsWOmg0qvAGi0bXl0r2
 LffKW8Psh9C4ACVoo+7V4PBIyQGUwJoEHmjRDdzgnApxSe65HbPdXeSRn3xP3p2PnmyuRr0E61Z
 xPE9kcfjhF6Su23v0AhXyaPB7eb5YS+rRJvXo8REe7Mda1qLpktzSstw/s0sZW8ihETY6y6zn72
 Ri9Tva69pL8HeguB2kE+hLkFN7m92oVVQtEl7FT++oyHv/H9mPCpGa/aPSN6M44hfq5T3fwyd5a
 BphBRjKbPGlCIfg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings to dt-schema. Then make the reset gpio optional in
the driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v3:
- Drop applied patches
- Fix rockchip bindings example
- Add dt-bindings patch from separate series
- Link to v2: https://lore.kernel.org/r/20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz

Changes in v2:
- 3/4: Reserve more space for v4l2 handler for the new controls (Jacopo)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz

---
Luca Weiss (3):
      media: dt-bindings: media: rkisp1: complete ov2685 example
      media: dt-bindings: ov2685: convert to dtschema
      media: i2c: ov2685: Make reset gpio optional

 .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
 .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++++++++
 .../devicetree/bindings/media/rockchip-isp1.yaml   |  19 ++--
 MAINTAINERS                                        |   1 +
 drivers/media/i2c/ov2685.c                         |   2 +-
 5 files changed, 116 insertions(+), 48 deletions(-)
---
base-commit: f3594f0204b756638267242e26d9de611435c3ba
change-id: 20230129-ov2685-improvements-b03bdcf1c290

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

