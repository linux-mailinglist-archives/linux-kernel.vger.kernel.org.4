Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29260469B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiJSNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiJSNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:15:21 -0400
X-Greylist: delayed 3540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 06:01:02 PDT
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E451D1E37;
        Wed, 19 Oct 2022 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eNRpwG4buJx4Tvqox9EQWn+avHOAaaONBH2lWfkT/jc=; b=BXivr5bd5mQEaqcXCZNEmiEbz3
        t9zNa27BFIH1TNvmhWDiBYB8ubQHWGHrxwRFyF4v6GtWMeekMRw860/wjdY+/Gbv9EfyhgLgMZfEM
        UdmPkFKp8d1fydsswt4egcumijRwIlS9oKk1TQdPCC4XTO/yQGGPRO2rKCII8tBn86zPKSOvK/J5W
        Brjit72EQEoAJ+ZAHWUZoPIkaEJ9nOKXiAQyRvwz/0lwOXfDIPlA2XoAkRFlQnbv8TG1Y321NegFP
        p2o8ISBUdoCDt3xe6LO7b1CElwkXf3PBQLhBnSIpIbVJVVj/Swzl+xcMNR9kZOBBT6ZfowdMdsOLg
        VezasqOw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:45936 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1ol74W-007ZXa-DP;
        Wed, 19 Oct 2022 13:17:16 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Subject: [PATCH 2/3] dt-bindings: watchdog: fsl-imx: document suspend in wait mode
Date:   Wed, 19 Oct 2022 13:17:13 +0200
Message-Id: <20221019111714.1953262-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019111714.1953262-1-andrej.picej@norik.com>
References: <20221019111714.1953262-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index fb7695515be1..01b3e04e7e65 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -55,6 +55,11 @@ properties:
       If present, the watchdog device is configured to assert its
       external reset (WDOG_B) instead of issuing a software reset.
 
+  fsl,suspend-in-wait:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      If present, the watchdog device is suspended in WAIT mode.
+
 required:
   - compatible
   - interrupts
-- 
2.25.1

