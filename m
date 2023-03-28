Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A96CBD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjC1LZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1LZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:25:29 -0400
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [IPv6:2001:41d0:1004:224b::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A496A66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:25:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680002718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yB0broTK4NnUke2AgkitBwlfXMZiqx+hknTbHQnvGFo=;
        b=aLSb6RZzErsLa4pRdK/Go3dP43kRzvUeOfSRRqBgBllKkmqUP8oSY9T7xyJMOLsBlv1/8g
        qV2Ba3x7ffMJA1Uhv0j3UQrZL5uARv1weiIRPfbE3N4Rw8RRVH8qrewgT2wMIF3B6JT4+I
        UGPipyZiTuLI5tveZd9cMktvNZ803Fo=
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Tue, 28 Mar 2023 13:25:14 +0200
Subject: [PATCH] ASoC: dt-bindings: maxim,max9867: fix example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-max9867_dt_example_fix-v1-1-cdf31c3fdfc8@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJnOImQC/x3NUQqDMBBF0a3IfDdFE01tt1JKGM2kDtQok1IC4
 t4b/bw8Dm+DRMKU4FFtIPTjxEss0VwqGCeMb1LsS4OutamN7tWM+d7bm/NfRxnn9UMucFbUGBs
 0th51BwUPmEgNgnGcDh4WUfbaHssqVMB5+Xzt+x/eVGh2ggAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=richard.leitner@linux.dev; h=from:subject:message-id;
 bh=rGmMpIgVP9TI8SKgVuuqiJ5yMUB6GNQe7ZL5e+fYMeE=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFKUzs2Vsmpbo/78Hy+/54QnvCphrgpyaiWpd+Yali+NDS0r
 XbC+o5SFQYyLQVZMkcXemKvdPbfsfaWiTi7MHFYmkCEMXJwCMJHZngx/5dmNMu7NcPhqPNEwsnXH7Z
 c8kVzJ9985famQ3nd4nVnqToZ/Ksefta0K5jMrZb/B5N3TfyW23zT/TvGJ+XdufplRWNPDAQA=
X-Developer-Key: i=richard.leitner@linux.dev; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the common clock node from the example as suggested by
Krzysztof Kozlowski in [1].

[1] https://lore.kernel.org/lkml/45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org/

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
index 6f27029b137d..0b9a84d33b6c 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -57,10 +57,4 @@ examples:
             clocks = <&codec_clk>;
         };
     };
-
-    codec_clk: clock {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <12288000>;
-    };
 ...

---
base-commit: ad58151fa04280a938c173bcba05ba42a4073d92
change-id: 20230328-max9867_dt_example_fix-e136f2a4da25

Best regards,
-- 
Richard Leitner <richard.leitner@linux.dev>

