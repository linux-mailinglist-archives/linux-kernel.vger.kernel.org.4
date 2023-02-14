Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD06960EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBNKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjBNKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:38:07 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE4244B4;
        Tue, 14 Feb 2023 02:38:06 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 9A0FD26F78E;
        Tue, 14 Feb 2023 11:38:04 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 11:38:01 +0100
Subject: [PATCH 1/2] dt-bindings: arm-pmu: Add PMU compatible strings for
 Apple M2 cores
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net>
References: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
In-Reply-To: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=j@jannau.net;
 h=from:subject:message-id; bh=EYGIdWeuF83XYijlj0mM1HCyJqYwvwRd2MoetNSkaJo=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXKd3G5SYdpuH7vhpzqv5Jfuy10FUvlcnS57TMpRVZl
 h0ZOxd3lLIwiHEwyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmMg/Loa/goJbnhl82Ft7dlrx
 rWdslX9TK27cqrLQfnM4ZJ/f8QuyCgx/JVjn1GUfSZ2SvyX87Cyf6xFX/t85+Hiq+0l+R3tTBvc
 DzAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMUs on the Apple M2 cores avalanche and blizzard CPU are compatible
with M1 ones. As on M1 we don't know exactly what the counters count so
use a distinct compatible for each micro-architecture.
Apple's PMU counter description omits a counter for M2 so there
is some variation on the interpretation of the counters.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index dbb6f3dc5ae5..e14358bf0b9c 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -20,6 +20,8 @@ properties:
     items:
       - enum:
           - apm,potenza-pmu
+          - apple,avalanche-pmu
+          - apple,blizzard-pmu
           - apple,firestorm-pmu
           - apple,icestorm-pmu
           - arm,armv8-pmuv3 # Only for s/w models

-- 
2.39.1

