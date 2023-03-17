Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202596BF63F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCQXYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCQXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E4399EA;
        Fri, 17 Mar 2023 16:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A353B82719;
        Fri, 17 Mar 2023 23:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C75C433A8;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095440;
        bh=40wNAXlyIA7VZKGyZ/AHWKvTBQOSewOxuHR9874XOtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bauausuf+Ul8D8hrfy65CjeljDX2wWvOW6qAhSVR5rYKj1kHYlu8T/Xx0vjoL83/7
         32m5/aiJgEOnjaXRFLmkDgMGfi5ciY4zYYyfGjqePOvx8BhM1oAiUcfvTjzCygmfD4
         kaCGhSV6JtLc2UtEXmBPSzTBUWfHYoLGQba4bxXCH/ltjpl6MWcG9cP2RYOoo5EXy5
         w+nbRgUTZzgx//jvoGqOycoARkE8InRm2qNQqfhsdD+kfzhuDcP6YwZ8r4df7KHdoa
         +r6hX/dldX6AGFFB02Z50wQq5j+KKeFk/FcxerW5Ljmp8TrewfKa3sBIe1yFvcTz8V
         vzfbu8L1RWIvw==
Received: by mercury (Postfix, from userid 1000)
        id DA45A10620F5; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
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
Subject: [PATCHv1 1/7] dt-bindings: vendor-prefixes: add Inanbo
Date:   Sat, 18 Mar 2023 00:23:49 +0100
Message-Id: <20230317232355.1554980-2-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317232355.1554980-1-sre@kernel.org>
References: <20230317232355.1554980-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen INANBO Electronic Technology Co., Ltd. manufacturers
TFT/OLED LCD panels.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..33e1d65cf4b2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: Imagination Technologies Ltd.
   "^imi,.*":
     description: Integrated Micro-Electronics Inc.
+  "^inanbo,.*":
+    description: Shenzhen INANBO Electronic Technology Co., Ltd.
   "^incircuit,.*":
     description: In-Circuit GmbH
   "^inet-tek,.*":
-- 
2.39.2

