Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479D466D654
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjAQG01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjAQG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:26:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6E6422032;
        Mon, 16 Jan 2023 22:25:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80631C14;
        Mon, 16 Jan 2023 22:19:12 -0800 (PST)
Received: from R913NWR2.arm.com (unknown [10.162.42.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26E013F445;
        Mon, 16 Jan 2023 22:18:26 -0800 (PST)
From:   Faiz Abbas <faiz.abbas@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com, faiz.abbas@arm.com
Subject: [PATCH v2] ASoC: dt-bindings: simple-card: Document simple-audio-card,plat
Date:   Tue, 17 Jan 2023 11:48:08 +0530
Message-Id: <20230117061808.18422-1-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple card driver already has support for a simple-audio-card,plat
property but its not reflected in the documentation. Add documentation
for this plat property.

Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
Changes since v1:
1. Updated commit message to indicate the property already exists
2. Removed redundant example
3. Fixed formatting issue found by 'make DT_CHECKER_FLAGS=-m dt_binding_check'

 Documentation/devicetree/bindings/sound/simple-card.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..9abe99f15763 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -205,6 +205,8 @@ patternProperties:
     $ref: "#/definitions/dai"
   "^simple-audio-card,codec(@[0-9a-f]+)?$":
     $ref: "#/definitions/dai"
+  "^simple-audio-card,plat(@[0-9a-f]+)?$":
+    $ref: "#/definitions/dai"
 
   "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
     description: |
-- 
2.25.1

