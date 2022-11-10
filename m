Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68484624831
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKJRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKJRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:20:28 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652F41E8;
        Thu, 10 Nov 2022 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668100815; bh=l55fHkNn8Ed89kT7xAtVgMNLiNafpAVdJsmDgQTK+/8=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=LioxLxCUBHBZrWWy/b/IpoPERHBTwK7sC2b6qnEnhYps3GQttJ+gMcftoct6yhWXu
         PHwnyZbnHv9NFR/BS+bE5FhahtHzuAo7ISzakLYTe5Cf2Qk7PK+K7al6mMeSK13sEu
         s/EEW3p0Q1fIMqyc9YNMG8QxRjCCr5kIR9H+Z6AM=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Thu, 10 Nov 2022 18:20:15 +0100 (CET)
X-EA-Auth: znNgnLi0uPOB+XwA8c325fqpkSkngoH5vtNXHzfQ94/jCIFwQcinGDBIxE0xn36YRvY3SFMZiYwk6pr6EnFUxvgy6J8TN3WiZrKvswbxTXU=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: input: touchscreen: msg2638: Document msg2138 support
Date:   Thu, 10 Nov 2022 18:19:45 +0100
Message-Id: <20221110171952.34207-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110171952.34207-1-vincent.knecht@mailoo.org>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document msg2138 support by adding mstar,msg2138 compatible.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
index 3a42c23faf6f..2fb7e01bb65a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: mstar,msg2638
+    enum:
+      - mstar,msg2138
+      - mstar,msg2638
 
   reg:
     const: 0x26
-- 
2.38.1



