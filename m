Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E265239F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiLTPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiLTPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:23:02 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6561C120;
        Tue, 20 Dec 2022 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=SVbYqkm4a1E3YCr2+Z9+Ruxlvn1hYXuMe1ljbrNYwLE=; b=s
        sysWeiBuf4lgKjt5pmVFyWrfWSCbF+mipDzCgh3W/kl0FudRX3pLmenMmJ60nH3riJXJrDB7h8JaC
        29UUlZivK6qNs0yoBEV88QLYGnEUShu9p93YiRgsk2oYZ5fNS9vtsfUYt+n7NKOjTnVN8VcKfs08E
        BA3WVbbD7hm2U/aM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48674 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p7eS0-0005MP-Vg; Tue, 20 Dec 2022 10:22:41 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     hugo@hugovil.com, bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 10:22:37 -0500
Message-Id: <20221220152237.1125178-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] dt-bindings: rtc: pcf2127: remove pca/pcf2129 from trivial RTC devices list
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

pca/pcf2129 devices can also have the 'reset-source' property, so
remove them from the trivial RTC devices list.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index cde7b1675ead..a1148eb22c24 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -14,7 +14,10 @@ maintainers:
 
 properties:
   compatible:
-    const: nxp,pcf2127
+    enum:
+      - nxp,pca2129
+      - nxp,pcf2127
+      - nxp,pcf2129
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d9fc120c61cc..82a4b002cf3d 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -53,8 +53,6 @@ properties:
       - microcrystal,rv3029
       # Real Time Clock
       - microcrystal,rv8523
-      - nxp,pca2129
-      - nxp,pcf2129
       # Real-time Clock Module
       - pericom,pt7c4338
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC

base-commit: e88f319a2546fd7772c726bf3a82a23b0859ddeb
-- 
2.30.2

