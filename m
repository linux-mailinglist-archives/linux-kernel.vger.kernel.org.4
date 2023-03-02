Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EE6A81AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCBL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCBL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:57:26 -0500
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [IPv6:2001:41d0:203:375::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1834007
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:57:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677758241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AR5vfcbTzXg9GS9xts3Lxqv5/GJy7ozqxusymEf3afo=;
        b=xEL5MwbqhEW/vkHHggpCjUihFiwwscme7Ym7cn7njoh9i5up9Qq5IN3roJUWuLzSrwAafy
        6nuRb4mUGB2rYjivL9tVTqWqY5tLYIXPLoUSW9Vz2vB7CDL6bQzXpkO3bkIBiZEbAM1xoJ
        yA+F9n/NbDz/Uhp8IWXq03+Y4rYqF+M=
From:   richard.leitner@linux.dev
Date:   Thu, 02 Mar 2023 12:55:02 +0100
Subject: [PATCH 2/3] ASoC: dt-bindings: maxim,max9867: add "mclk" property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v1-2-aa9f7f25db5e@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
In-Reply-To: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=bMNg7GqHmP3qmoCg4huIjZzqkxCE2jKo6J6fNpJ+8ks=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIY+uUZl4XzaBlcvvyYkbF0S63p1x1bTl9f5Xlnb0Dkcb27
 GZ9+dJSyMIhxMciKKbLYG3O1u+eWva9U1MmFmcPKBDKEgYtTACYiu47hv/fyK+tYfm98tmiN8OOAnI
 qsGz/bv/7fPXeyr52E2+cH6rqMDGt92Cs2bOXVTyg35Ih2NQlPrZJ1vR6+MKpgV/9tVg45DgA=
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Leitner <richard.leitner@skidata.com>

Add clocks and clock-names properties to require a "mclk" definition for
the maxim,max9867 codec.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
index cefa43c3d34e..152340fe9cc7 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -35,9 +35,17 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: "mclk"
+
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
 
 examples:
   - |
@@ -46,6 +54,8 @@ examples:
                     compatible = "maxim,max9867";
                     #sound-dai-cells = <0>;
                     reg = <0x18>;
+                    clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+                    clock-names = "mclk";
             };
     };
 ...

-- 
2.39.2

