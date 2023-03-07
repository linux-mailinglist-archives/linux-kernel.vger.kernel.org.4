Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900A96ADE62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCGMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCGMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:13 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC8574FD;
        Tue,  7 Mar 2023 04:10:12 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1B2CD26F888;
        Tue,  7 Mar 2023 13:10:11 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 07 Mar 2023 13:10:09 +0100
Subject: [PATCH v3 03/15] dt-bindings: watchdog: apple,wdt: Add t8112-wdt
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v3-3-d1a5f6383d95@jannau.net>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=816; i=j@jannau.net;
 h=from:subject:message-id; bh=ii0IadQVOv7ya4XwtBGFuGJ/mm304g8PFld9ejyrFvc=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zQXzY+aFXE9WmPOgUF5Z/1HEMZ8rwlVeL9ZJ9cSuc
 rDmy9HrKGVhEONgkBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMBGlKoa/8qWvi7rvPeqc/03i
 XsDUly/bFh1nevdSv9O67atQqPjBnwz/LFa++Tzt//vljTo/Rfk/Tt76I3TfW7lZtQ5l8idurI2
 V5gYA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block on the Apple M2 SoC is compatible with the existing driver so
add its per-SoC compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index e58c56a6fdf6..3d7e2a2bf1f1 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - apple,t8103-wdt
+          - apple,t8112-wdt
           - apple,t6000-wdt
       - const: apple,wdt
 

-- 
2.39.2

