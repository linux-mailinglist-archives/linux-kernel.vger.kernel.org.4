Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590FB6A94C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCCKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCCKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:16 -0500
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [IPv6:2001:41d0:203:375::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42709136C3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:04:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677837852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcYJmRGskfPRmhAdzc8S9FcZG/yfwAAq4mWaDd/Lugo=;
        b=rd7E5pCyZo37krxzehhlmD8gXrWZwmbdUMFvbrp5i9bDxMKlI0Kc5NyoCp1VzrEkLFV+sX
        zrFtUmqhONVRfp0Kf/fkeivHwOZWJbvgacU9S9x8tZsfZrwS6e/SKi7nwAczGrUORuoXge
        vJplx83DQ7aWwI3+pCGEmXnybm7CFIE=
From:   richard.leitner@linux.dev
Date:   Fri, 03 Mar 2023 11:04:02 +0100
Subject: [PATCH v2 2/3] ASoC: dt-bindings: maxim,max9867: add clocks
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v2-2-fd2036d5e825@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
In-Reply-To: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=Iw/3nRyv551zpvZ9GVbHR0uIwA0KwrzA9i3bmK0aYNU=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIYj0k9KNl0Scd945wXUcxPbVI3u8f7HnqVNbO4qWraz02s
 E8PbOkpZGMS4GGTFFFnsjbna3XPL3lcq6uTCzGFlAhnCwMUpABMpn8PIsOXiWQPl98q7PjyZs2PFzN
 fb/574dlby0Qol92zDb/7KGW0M/x36pip5rDGsn5FlEb95gul5/Ys/05V2Xjp0x9njZei9XzwA
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

Add clocks property to require a "mclk" definition for the
maxim,max9867 codec.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
index 74cd163546ec..6f27029b137d 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -35,9 +35,13 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg
+  - clocks
 
 additionalProperties: false
 
@@ -50,6 +54,13 @@ examples:
             compatible = "maxim,max9867";
             #sound-dai-cells = <0>;
             reg = <0x18>;
+            clocks = <&codec_clk>;
         };
     };
+
+    codec_clk: clock {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <12288000>;
+    };
 ...

-- 
2.39.2

