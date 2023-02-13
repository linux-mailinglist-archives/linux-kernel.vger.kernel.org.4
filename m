Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C840694F56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjBMS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjBMS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BC7D8E;
        Mon, 13 Feb 2023 10:26:29 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3I3QTYIuyzrQ3A+bJaoNzF1EtZg7ZI4nsXJsTGnwiGc=;
        b=NdYwNFY8zwmQQOHKJc1Zh70GPbw7Pgyz7XfJ/TySacIQDXPXKR4ctocYHhY/qGi6qkkhjJ
        nBCcYHMwnODpvhnpoe3gVXFdG1Kb4PAEWZuVksbBi/K9W6LtAIX/agVbKzOYAeTxr2bkqg
        Sg3rkh7mWTquUYogbixfyHRCzRK8NTC7n5SfYKk04hmx2e4BxbwMFyh6LRe7B88WxtPScS
        ljN0N3VFX+WkDae0xixkBa7mm72V+aSHm5Jxh46zdj1GXseEIQ+v1WKcb4Pr+CJwQ2eXJp
        fasC/i9VQ3vMvO7Y1HWVPJLuYrHsh2JMW08al+RHS74jdRQ6Wh5o5slAXzqmwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3I3QTYIuyzrQ3A+bJaoNzF1EtZg7ZI4nsXJsTGnwiGc=;
        b=azILJjOcMOH0VDiA1AgfujBhdtW+tMaSexm30hFFzzIsMWfpk7zqavMl6vXcjutwIkh/Le
        j7J03qZQB1W3QZBA==
From:   "tip-bot2 for Jagan Teki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: rk-timer: Add rktimer for rv1126
Cc:     Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123183124.6911-3-jagan@edgeble.ai>
References: <20221123183124.6911-3-jagan@edgeble.ai>
MIME-Version: 1.0
Message-ID: <167631278555.4906.1247098877750451831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b3cbfb7927922e4586f890a70a22f13130247b4e
Gitweb:        https://git.kernel.org/tip/b3cbfb7927922e4586f890a70a22f13130247b4e
Author:        Jagan Teki <jagan@edgeble.ai>
AuthorDate:    Thu, 24 Nov 2022 00:01:18 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:16 +01:00

dt-bindings: timer: rk-timer: Add rktimer for rv1126

Add rockchip timer compatible string for rockchip rv1126.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221123183124.6911-3-jagan@edgeble.ai
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index b61ed1a..65e5983 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -17,6 +17,7 @@ properties:
       - items:
           - enum:
               - rockchip,rv1108-timer
+              - rockchip,rv1126-timer
               - rockchip,rk3036-timer
               - rockchip,rk3128-timer
               - rockchip,rk3188-timer
