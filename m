Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590EF694F49
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBMS0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBMS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469021702;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLCWW0kqHwupS7L0F+qxBfen0pMEijdMQGMd9xe8Xkw=;
        b=WYbnzMTUQiDeypkfpJWNyRvUGkEOTXb1IMhJ9upjrT+CfAEj7iX0MW56KTdLC8KUZLZodo
        cLBCpDiDtfUiojMYTyxjgXMkuFH8LpNPRGKbBL28G7JTSpVFpErtZuMlnm0Qy1BoOdyFO2
        zP87sU8RKpSCc5tuTyuHZ2ks+1FFpZ+cHKvGFzjHzqqkBcFcz8TeuJplysdPVJliA2uMuJ
        trZt5Sk21fcGEA68H7DHn5bRK98xE28EYLcFo9sKDc7IjCsNdIjNWCyBLfdu6Btt1kSGTd
        AdBVvgPMEzj8pTc09Hnw7ym7fug4xtav6lGZHe+pLC1xrpHUl4UNTxFGoo47TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLCWW0kqHwupS7L0F+qxBfen0pMEijdMQGMd9xe8Xkw=;
        b=0UPQ3nN/6f8yoKwDak6cQ1nryJ8H1eHEz4T1dSIBB7Ykwb+8wnQ3MR12YQDp4EcwVfzTIX
        MQDS30igQBUHOEAg==
From:   "tip-bot2 for Icenowy Zheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: sifive,clint: add comaptibles
 for T-Head's C9xx
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230202072814.319903-1-uwu@icenowy.me>
References: <20230202072814.319903-1-uwu@icenowy.me>
MIME-Version: 1.0
Message-ID: <167631278317.4906.9154845972759763827.tip-bot2@tip-bot2>
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

Commit-ID:     abd873afc889c0b4348ec4b567d83f97df8edaf6
Gitweb:        https://git.kernel.org/tip/abd873afc889c0b4348ec4b567d83f97df8edaf6
Author:        Icenowy Zheng <uwu@icenowy.me>
AuthorDate:    Thu, 02 Feb 2023 15:28:14 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

dt-bindings: timer: sifive,clint: add comaptibles for T-Head's C9xx

T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
compliant to the newcoming ACLINT spec) because of lack of mtime
register.

Add a compatible string formatted like the C9xx-specific PLIC
compatible, and do not allow a SiFive one as fallback because they're
not really compliant.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230202072814.319903-1-uwu@icenowy.me
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 +++++++-
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index bbad241..aada695 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -20,6 +20,10 @@ description:
   property of "/cpus" DT node. The "timebase-frequency" DT property is
   described in Documentation/devicetree/bindings/riscv/cpus.yaml
 
+  T-Head C906/C910 CPU cores include an implementation of CLINT too, however
+  their implementation lacks a memory-mapped MTIME register, thus not
+  compatible with SiFive ones.
+
 properties:
   compatible:
     oneOf:
@@ -30,6 +34,10 @@ properties:
               - canaan,k210-clint
           - const: sifive,clint0
       - items:
+          - enum:
+              - allwinner,sun20i-d1-clint
+          - const: thead,c900-clint
+      - items:
           - const: sifive,clint0
           - const: riscv,clint0
         deprecated: true
