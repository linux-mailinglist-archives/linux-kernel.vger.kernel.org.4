Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F66BF641
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCQXYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCQXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A331399D3;
        Fri, 17 Mar 2023 16:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E905AB8271E;
        Fri, 17 Mar 2023 23:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F2C433A1;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095440;
        bh=wMdj6XMSKvcrwZmlfjFE87Mo/K0QwNMqQP6DoUCEh10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7WZLmN/f4vrQhvkHFIhjRas7Jj2UFY3UEQOixFtO03eD6fgNZwgj3qLzBq5nPt0/
         kfevjrBRC3fVUwIO4ahdTus1s07972KBOWtqzDISoCpD+QxwEBpT1JOOGkCAjtPXsx
         JFjVd0k2GYo0RI2lVIV/f8nAQHzn/2ugP98XcdDvpIb9cge+klspr8KDeNNq2sG6ZT
         1QeD3imwyqyOOuEQyYvoKYLmTPFqv37Oj0W4qI9ufDV9SSzLWml/QnI+rJlFrScbvO
         cj4O6fOjHZx4llqqyMArc8LsZNDP9PlV0DXO65dbt+gqxQZ8GrBsFhvQzanpNEhAU5
         rxmIjQ3DYZ+0g==
Received: by mercury (Postfix, from userid 1000)
        id DB22210620FF; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 2/7] dt-bindings: display: st7789v: add Inanbo T28CP45TN89
Date:   Sat, 18 Mar 2023 00:23:50 +0100
Message-Id: <20230317232355.1554980-3-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317232355.1554980-1-sre@kernel.org>
References: <20230317232355.1554980-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible value for Inanbo t28cp45tn89 and
make reset GPIO non mandatory, since it might not
be connected to the CPU.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index d984b59daa4a..4fc86f96b00f 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -15,7 +15,9 @@ allOf:
 
 properties:
   compatible:
-    const: sitronix,st7789v
+    enum:
+      - sitronix,st7789v
+      - inanbo,t28cp45tn89-v17
 
   reg: true
   reset-gpios: true
@@ -29,7 +31,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - power-supply
 
 unevaluatedProperties: false
-- 
2.39.2

