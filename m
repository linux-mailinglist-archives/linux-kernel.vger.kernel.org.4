Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D86C6FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjCWR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCWR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:58:47 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65944B8;
        Thu, 23 Mar 2023 10:58:30 -0700 (PDT)
Received: from [192.168.0.26] (2a02-8388-6582-fe80-0000-0000-0000-000c.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::c])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 93155D2584;
        Thu, 23 Mar 2023 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1679594279; bh=/s3YATkQEynaY97oNVGkN2PAZTRMQ7bXwfDtDYia87A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=yM9VfVmMzCxKjXTHUR4QnZsf7Wpyqk5zUCMBfRn9LmBOy4MvCB+c+1kmRf+GDiIls
         qvBK4AVdqlBCoFuNUIbJ7kU/qCG6YxdcDCMg7IkspWzH4Twr66X2mMGoAeSMW/YCav
         lWlW4PSHpGexxQLBDpPgrEamB7obzeGmes4AC87Q=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 23 Mar 2023 18:57:49 +0100
Subject: [PATCH v4 1/3] media: dt-bindings: media: rkisp1: complete ov2685
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v4-1-e71985c5c848@z3ntu.xyz>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=/s3YATkQEynaY97oNVGkN2PAZTRMQ7bXwfDtDYia87A=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkHJMjVW/e2Q2s/jXJLNba4KenAFd/cI/tE9sLS
 bxV8NVpRvaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZByTIwAKCRBy2EO4nU3X
 Vm/tD/4h30/j1jv5gjaQlVt6aI85HqI/Uml4zfwAuaEDDinWDDBtOQ4RlYrBM5M8pfPj4zSGNRH
 d+UKndm3lNFif/ZP/Gg8+2DlPf1+U9j0slcm3QfDbyTuAMLA+5ipJPzBLQ/22vpy5+vWAnFZOc4
 VL4rpbi0aMZmq6J/vNSkmER4nxLFb4BMtLSkofbNBfLCTR4Ud5FmWXHKyLnrpux8Tsd5txN5GEt
 rU5s4UHz/z6EgXAsWOPlkMnUX32UoJRhrkSfzjplbLT0u34XGn8acvLGPQgCEqbN3zbfFNvUZFi
 dAeMsttdlfYIWEvThbtWmvuL+vM9cU5iubYRKKwzijBCJp82zMKs+MDp6vRMllw/30Zgc0aif1i
 1+s8FzcE5ul+KmL6JHZEujJxF+5vFB6el0XLe+UW8e4ErW7KvN8vsakZ9bLI5a5JlMBSC632KRn
 +HHFSwu/XvLA6MkQ+Imp+VqYc2i+C6MwhPSxN/cWAIP6qoRz490Cw1ApPdDNqnE07lFH/J039t6
 uzBHcmWZknXO5GkPkSZc4JFpJoQ8ZdbenflVOYyW/eGxrRAlFEZNFaauTQKzcPHvpADWYnu4IKC
 AeaSh8QdNxlMR2ZgQog0nCFoYHCa5WCaJQqClDi9eHmM6UOKcyFbtm245rQ8yeXOhH4OTExF6tG
 Um3eYXgvn7FvKLA==
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

With the upcoming conversion of ov2685 to dt-schema let's complete the
example so validation succeeds. At the same time fix the indentation of
the port node in this example.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

