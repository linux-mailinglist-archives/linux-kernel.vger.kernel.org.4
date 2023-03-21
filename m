Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102026C38DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCUSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCUSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:04:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285928875;
        Tue, 21 Mar 2023 11:04:04 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2AE3BD2516;
        Tue, 21 Mar 2023 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679421842; bh=6kJQExPvH5RZ9ofn4GgS9ik4SVqTvX/IERct3TODGKw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=pCmn+N1vHb4hKUKB9AHq8WBHW1n99tCHguviTEgSc/2iMAaiHYcUDWPLV5mX6ZwI+
         YyE8CHIMx+8cYnw9244mNyKFs7XadOFRMx4fZI84Lzzh31/jUmQ0klnXCnM1BgFX5P
         YQyywzF/ccB7hUBEoDgMqg8tu8XsonytFl0mUCY8=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 21 Mar 2023 19:03:55 +0100
Subject: [PATCH v3 1/3] media: dt-bindings: media: rkisp1: complete ov2685
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v3-1-d9737d0707f6@z3ntu.xyz>
References: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v3-0-d9737d0707f6@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=6kJQExPvH5RZ9ofn4GgS9ik4SVqTvX/IERct3TODGKw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkGfGO78PHCXVFhwGiIbUdwJM/wKfie8q7sNBGV
 ulIMD/yNAWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZBnxjgAKCRBy2EO4nU3X
 VuSKEACoA/1wAi1hCrcByMyWts1Pv0rSXuAF9+4wPPYpQM3ms7m59z5MJQGuXe7PjdvQSKN6Bq+
 LcK6RBcPRUKQaE1ljh59r2o3WpxnioTj97Y8Moo6qe3fgkKSMEnSgU3dOw+0DN99f85DTZrcNpT
 0LCavmTYlfGMdzA40kcw9wxi9O2qQfoNnIGapd9WmthaiWdOsaDTeOT33Ci5k+Yy3dZsQtII+JY
 92wM/yWIFbjVjdcRvDg2MgYw16nmZvSzBosJZfnR2LctB/WmePgqqlLfGPFaUGUVbgi26ZG3TnI
 266+td7XzS9MfhzDWdSE41uH3+aPgfvLgXTWXvyEU3/43ddsSNeRzgbHVuRxaTxvj3NvMU9R2ml
 dp7tTCnC/k+e0l8jpYZvFHmNi3NotBW9KQUHG9IQjj1vzVMC+R9XWjP5HMzkf+d0CUqqbzb7EBQ
 unnaqAqtnTfdASRtRPm4V0ewBjhpv/oaAJkmFRPedr9bpEsbbWa/PB+s9yaKE/pAzSpnEsdZ7e7
 8ZryWlkJSibQYa8hZx87VgLmLoJWtmrUnBLaMMUZmyvYUAInHGKx6vKnEAsn9lD4N+1Y/RTb3iY
 C1/ZH2/eAqK4e9PTlIGUs92EU1u1eMksgV+vr3STzQM2sQPlkCtZdC+5LaFm5G25DqsgCsfWabD
 +4823cYwGpAxa9w==
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

With the upcoming conversion of ov2685 to dt-schema let's complete the
example so validation succeeds. At the same time fix the indentation of
the port node in this example.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/media/rockchip-isp1.yaml      | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
index b3661d7d43572..0bad7e6401486 100644
--- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
@@ -212,12 +212,19 @@ examples:
                 compatible = "ovti,ov2685";
                 reg = <0x3c>;
 
-                  port {
-                      ucam_out: endpoint {
-                          remote-endpoint = <&mipi_in_ucam>;
-                          data-lanes = <1>;
-                      };
-                  };
+                clocks = <&cru SCLK_TESTCLKOUT1>;
+                clock-names = "xvclk";
+
+                avdd-supply = <&pp2800_cam>;
+                dovdd-supply = <&pp1800>;
+                dvdd-supply = <&pp1800>;
+
+                port {
+                    ucam_out: endpoint {
+                        remote-endpoint = <&mipi_in_ucam>;
+                        data-lanes = <1>;
+                    };
+                };
             };
         };
     };

-- 
2.40.0

