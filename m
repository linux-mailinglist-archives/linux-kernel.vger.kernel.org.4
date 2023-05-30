Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F00715B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjE3KJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjE3KJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:09:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC29D9;
        Tue, 30 May 2023 03:09:36 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGQzj-1prbxp339R-00GmI8; Tue, 30 May 2023 12:09:08 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/2] dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
Date:   Tue, 30 May 2023 12:08:42 +0200
Message-Id: <20230530100843.15072-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530100843.15072-1-stefan.wahren@i2se.com>
References: <20230530100843.15072-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xP34w7NW6X/95qKpiWd0ZWy/Dn+u7KdAa0iZBQVKN+aFTOuChgC
 OM80/Z5XrsCTVzcJp4Yjej44d8O9oUPcXF2EBBPL0alPlGEGw7hgPBZJ5veTHex1uv0GBWy
 Cx7XAEHR13aEmI9EUP+iWshZczMRdwEEJHIKbOqUOEqpVScvwT6DeYgF2KfH/Kl7mhJees6
 OAgJhvgHXInYjpp9t1dLg==
UI-OutboundReport: notjunk:1;M01:P0:UbvcRpKmoHo=;NN+lnzyAibCRvpnaUBfrLgr2cWQ
 8xu808gZuXld/yiw8LzuN5aFDJELr0QDgBzE7+hVE8s5+e+bmwqlIGll91L7zJTqakNZYXuus
 sMIrOUkWFoSgW+zV9+btTvC9kq7T5UxbTQiB3tttj0C3oQhay6HzL9F7O8PmObVesrlRQW07v
 ZnHOu3we4S/PUyiSylUPeC2wa3ui6voXfmyqQdOY21B68Vti6jYyeVbEA0mMedv36wC9s8eAz
 OOIH+gRiljf8UpHirhsOe5zKUVbpEZzUmo05lDaJ211aZldDZl+twzrREYkADNcKdRraJx8Jc
 4v7C6dz2I+68m++PfHEaJmw7N1u4BIKpM3X+C1hYH/QpMnvzChK8hYLAXkeg6PrzX8DAJQmxD
 IRfiPRXclHIlO1DlQZYTtOUwH+XC3GcTVYlW9Lv0JhjJkZbb5rdkMJeSccRgoeGl41RISCbSq
 YEowY260QOQ+wM9T3JwyudBihDIHiBgK4ek38jJ+h1bT3rjVchrcouMR/2UGkz+1sCxId0P2V
 7VCCXf63Mvdh5Wvph68jDuvIIc/iJjn806fwNAhuZ5+A+P6OLUBFMxNZP1BbczmCOi7DmWahq
 RcwqvjNoPOto0ZNQjMTO2ABn914P9mO2p39keXoFbwdTYuYMBWLiAnfTaTMbMgzTtyd+WV5Fg
 TFXyVU8XRbhGRdO6qEOZ6TbSexRMwZ18Dcv9BiYyCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dtbs_check for imx6 generates warnings like this:

'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long

or

'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long

So add them to the devicetree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/crypto/fsl-dcp.yaml          | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
index 99be01539fcd..8dd36c2f76fd 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
@@ -11,9 +11,15 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-dcp
-      - fsl,imx28-dcp
+    oneOf:
+      - enum:
+          - fsl,imx23-dcp
+          - fsl,imx28-dcp
+      - items:
+          - enum:
+              - fsl,imx6sl-dcp
+              - fsl,imx6ull-dcp
+          - const: fsl,imx28-dcp
 
   reg:
     maxItems: 1
-- 
2.34.1

