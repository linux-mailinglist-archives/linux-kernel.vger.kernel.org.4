Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA60662C77F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbiKPSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiKPSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:17:53 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA663BB2;
        Wed, 16 Nov 2022 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668622655; bh=BAISyk8kGHRtTm5nLUgo7ZXUxq/PfEWnuO/RpRSxSJk=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=Sf6m3og6lVcyRNaYo3bWT7q2aMAl5PXqz7L5ExOC0aAEa0EsDFyEudN+7uBbnNEfA
         lVXaudQI0XC8NayisnlxBGxdqnB7uVsxFRfH9qTZ5adJjMXYl9ZyY2QtStqbDVkZJK
         H8MdrVIxGh3tYS9i+R2dECa6kRYx/LykNWAPUKBY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 16 Nov 2022 19:17:35 +0100 (CET)
X-EA-Auth: wSipETKokjIuLHYQAap4EutWqlFb8Chg4dUum3LiaGfQJEUzOPndPQvG4HoXEnvkzwAr0ky2eQAT/d1XZV0VT/Jaaw+ubZCLet9MeL0/NT0=
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
Subject: [PATCH v5 1/2] dt-bindings: input: touchscreen: msg2638: Document keys support
Date:   Wed, 16 Nov 2022 19:17:11 +0100
Message-Id: <20221116181715.2118436-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116181715.2118436-1-vincent.knecht@mailoo.org>
References: <20221116181715.2118436-1-vincent.knecht@mailoo.org>
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

Document optional linux,keycodes support.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
index 2fb7e01bb65a..af4f954de958 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
@@ -36,6 +36,10 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  linux,keycodes:
+    minItems: 1
+    maxItems: 4
+
 additionalProperties: false
 
 required:
-- 
2.38.1



