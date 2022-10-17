Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7800600C60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJQK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJQK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:26:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC74C2CE;
        Mon, 17 Oct 2022 03:26:10 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A8DD5E000C;
        Mon, 17 Oct 2022 10:26:06 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     foss+kernel@0leil.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] =?utf-8?q?dt-bindings:=20arm:=20rockchip:=20add=20Theobro?= =?utf-8?q?ma=20Systems=20PX30-=C2=B5Q7=20(Ringneck)=20with=20Haikou?=
Date:   Mon, 17 Oct 2022 12:25:25 +0200
Message-Id: <20220930-upstream-ringneck-v2-2-6671694b6934@theobroma-systems.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930-upstream-ringneck-v2-0-6671694b6934@theobroma-systems.com>
References: <20220930-upstream-ringneck-v2-0-6671694b6934@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Add entry for the Theobroma Systems PX30-µQ7 (Ringneck) with Haikou
devkit.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149cb..6d256b1c1b588 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -658,6 +658,11 @@ properties:
           - const: rockchip,rv1108-evb
           - const: rockchip,rv1108
 
+      - description: Theobroma Systems PX30-uQ7 with Haikou baseboard
+        items:
+          - const: tsd,px30-ringneck-haikou
+          - const: rockchip,px30
+
       - description: Theobroma Systems RK3368-uQ7 with Haikou baseboard
         items:
           - const: tsd,rk3368-lion-haikou

-- 
b4 0.10.1
