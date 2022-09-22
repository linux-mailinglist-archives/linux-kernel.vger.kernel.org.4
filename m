Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837125E5F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIVKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIVKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:12:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581CE17E21;
        Thu, 22 Sep 2022 03:12:50 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8625A4000F;
        Thu, 22 Sep 2022 10:12:46 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, foss+kernel@0leil.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 3/3] =?UTF-8?q?dt-bindings:=20arm:=20rockchip:=20add=20The?= =?UTF-8?q?obroma=20Systems=20PX30-=C2=B5Q7=20(Ringneck)=20with=20Haikou?=
Date:   Thu, 22 Sep 2022 12:12:11 +0200
Message-Id: <20220922101211.3215888-4-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922101211.3215888-1-foss+kernel@0leil.net>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Add entry for the Theobroma Systems PX30-µQ7 (Ringneck) with Haikou
devkit.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149c..f2aa5ddb76d2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -658,6 +658,11 @@ properties:
           - const: rockchip,rv1108-evb
           - const: rockchip,rv1108
 
+      - description: Theobroma Systems PX30-µQ7 with Haikou baseboard
+        items:
+          - const: tsd,px30-ringneck-haikou
+          - const: rockchip,px30
+
       - description: Theobroma Systems RK3368-uQ7 with Haikou baseboard
         items:
           - const: tsd,rk3368-lion-haikou
-- 
2.37.3

