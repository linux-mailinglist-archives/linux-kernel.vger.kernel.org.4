Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7674DD23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGJSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGJSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:14:30 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 11:14:29 PDT
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF1128;
        Mon, 10 Jul 2023 11:14:29 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 51387601EE21;
        Mon, 10 Jul 2023 20:58:18 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Mon, 10 Jul 2023 20:58:18 +0300
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     vesa.jaaskelainen@vaisala.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: dp83822: Add line driver class selection
Date:   Mon, 10 Jul 2023 20:56:19 +0300
Message-Id: <20230710175621.8612-2-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 17:58:18.0211 (UTC) FILETIME=[1B630B30:01D9B358]
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to specify either class A or class B (default) for line driver.

Class A: full MLT-3 on both Tx+ and Tx–
Class B: reduced MLT-3

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..62943a1e8941 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -27,6 +27,14 @@ properties:
   reg:
     maxItems: 1
 
+  ti,line-driver-class-a:
+    type: boolean
+    description: |
+       DP83822 PHY's line driver selection to class A.
+       Sets the DP83822 line driver as class A i.e. program full MLT-3 on both
+       Tx+ and Tx-.
+       If not defined class B will be configured (default) i.e. reduced MLT-3.
+
   ti,link-loss-low:
     type: boolean
     description: |
-- 
2.34.1

