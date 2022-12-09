Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B76485D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLIPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLIPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A542326E8;
        Fri,  9 Dec 2022 07:47:24 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaCOYLZODq1zR9A0KgYsAR23HIBI/NpAug2vkbrXSTQ=;
        b=VztUpcFL1PF+1QpbLEyDLUToIhJpX57Nc+TpGQTYl8qx9wK+7KRx0cZGl+sFGnK2T80628
        YKx4T4O2YcYmEboBI1Cv+gs737kI3G6cVvKcnM8o/BvSBoZ1NDM4bc6R000RWGS8/pVm8v
        9ma4f6H0n2pvtAKo7s3RRsOol7WTZWPwvOSaTlu/QQP9hrnyC0aTFk/Dg5ZCN79QxSruzV
        ttLulSziEv8uRBEltUWv8rSU8tK3J+w1m7rEVUNG37S2DJFnLS6wY5cDk+skC/u/iNpdem
        C61sPaJLxJspzU2wHUcYjsKgQpcaZYFXWUBIUyh0XwwIPnOxWRCabW2fqE47Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaCOYLZODq1zR9A0KgYsAR23HIBI/NpAug2vkbrXSTQ=;
        b=2+mZpRd1zAfLfBIguqIpr1u7HNsQFNua876AIxvshXLNG5VGXt+P4bvgb+tMbuifsOEAtb
        9KR83aA6w8CQNuCQ==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
References: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <167060084204.4906.10697198480362491711.tip-bot2@tip-bot2>
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

Commit-ID:     83571a4389039b1be2d77655b2ce47543d407e41
Gitweb:        https://git.kernel.org/tip/83571a4389039b1be2d77655b2ce47543d407e41
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Fri, 04 Nov 2022 16:06:42 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:42:32 +01:00

dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221104150642.4587-1-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index bde6c9b..a0be175 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -102,12 +102,14 @@ properties:
           - enum:
               - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
               - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+              - renesas,r8a779g0-cmt0     # 32-bit CMT0 on R-Car V4H
           - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
 
       - items:
           - enum:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
               - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+              - renesas,r8a779g0-cmt1     # 48-bit CMT on R-Car V4H
           - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
 
   reg:
