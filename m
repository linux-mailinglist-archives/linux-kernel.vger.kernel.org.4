Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4137F6C6FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCWR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:58:01 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C471BD8;
        Thu, 23 Mar 2023 10:58:00 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DE51ED2580;
        Thu, 23 Mar 2023 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679594278; bh=1Vo0lWW8e+lgGTTGvxNP10JPaRio9OYS9Twy6U31giY=;
        h=From:Subject:Date:To:Cc;
        b=FwtEyJ56Yf1RJbBfUhqLwRdtWDR1pua461bbjyWW2dW7lWyMsIB0zcuJ//fSuNqy6
         SPATdXdcEwpIoVWCUobXYVqqvlgaDtWB91vrjmWfOD33+T6UPF3vs/a9eIQM9QUJTe
         LewntJTPSJPwXcYySErdPGTHwL3CqG5/y1/bRKvo=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v4 0/3] Improvements for OmniVision OV2685
Date:   Thu, 23 Mar 2023 18:57:48 +0100
Message-Id: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByTHGQC/43OTW7DIBAF4KtErDsWDK4xXfUeVRf81iyABFwUJ
 /Ldi7OquqiyfKN538ydVFeCq+TtdCfFtVBDTj2MLydiFpW+HATbM0GKnDKUkBtO8yuEeC65uej
 SWkFTrq3xzKCkpDe1qg50UcksR/dicoRY4yzFCNPAhg2Miq4oPJbPxflwfbzw8dnzEuqay/b4q
 LFj+v/xxoCCx5lpO0oupXm/8bR+D9ftRg6v4RMGdgMZHSn1qCfu/hr8CYN3w0rBhaWCCj/9NvZ
 9/wEu88nXawEAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=1Vo0lWW8e+lgGTTGvxNP10JPaRio9OYS9Twy6U31giY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkHJMf8uNkHI8h75NQ5daXnHUBp1pxxM9YhxDg0
 B0VZMWRJAiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZByTHwAKCRBy2EO4nU3X
 Vn6+D/wMbhnYPTwD2ytJ0HutTXYpv+Zncj0jjnUxtODvqly9m/SLcz45WkZwbYHhWa4QE2c2kTC
 ltC2MZbzOYcsc9FoVbkyFiQtpcDGNS49UY/3mXuvDqmHTnpk8gwX3Q6gnL1AyzHhplrjvuSvcvT
 z19gcFajGnF8ytgsZChWhJUT1Fpd1BoPKmTwMYbdxxa2P/MApX48mx9yIxb9D5PzpNqNtnP+aWg
 DQra/AWSQzuhwRbHFlN+GHevRK+IhW+/3FG6gr7xc7V3BZkEjkSCyf/488pokmbgHYz4Gq7fSSM
 j8o4N0IRlxdh+BVLn0iftnwJvpP6X3rNOCOX4Y8waRDp+qvOX2rcMOJuFMSuhF4hSrBmkAQwQer
 FPmXtdO6glbhzWtM5rc6fJSBXIg2EziezTN4CPD3s0z4bCR0igO8VXIOpPdbFE0/O6+vwTiexqa
 MARyTDIvjyh5vihuaWEwmivmy5bSeO9xz9C0VuskULUXF0TVQNwoH01bX50ifk3EHcllVyFcDRA
 rJ4/iIH2DHC05kbBVptHLSHwU6k0imTPk1tQIESsWRf27qkD01YUSJEOsp5fQEHPTY5wWbcPtG3
 DRqDfatJE/voytw2SVi9h1voh61UiHRTam0JVUMhwo1UZYvDwI74D74AJcgED4kYvwCYEn8MNzO
 gLvHkEp3fEJbq4w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings to dt-schema. Then make the reset gpio optional in
the driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v4:
- Change i2c7 to i2c in binding example
- Pick up tags from Krzysztof
- Link to v3: https://lore.kernel.org/r/20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz

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

