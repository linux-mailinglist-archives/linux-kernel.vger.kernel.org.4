Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2846485DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLIPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLIPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231C379FE;
        Fri,  9 Dec 2022 07:47:26 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWhPFQaF7u4DJr+B6nu29bDhBVH9d+i6oLF6X/1Nlmc=;
        b=ejf9GsbtK8AK1hKqLUwVCXc4CDKaVLHQimSgsyRmm+VHhOxjuXvnpDdDWpXZvfHa8mWewJ
        bvJGBZpKNqHnnnMrg92ymbftewHNIsb1WKHtVdfAX3FyYGm/ZQLDzp/leKybiCf9bbavC7
        ALChGBba14G5RqmQTCjAWODokaweJ7vCn5arFlHJe7n7ab6zouoK2f+ODSLMJgQEbtr6dD
        KtBzjGglgPy7LKCS74wRncyTBsPuD1l7mJrHL1DPA8TG+65ossSs4pZ/0EQ9EP7TdAAxUw
        DMDAD5Dei+Vd7AsPfTE6JOG0KaBpYLFGONPLcQZoNEUZddFdPlazXtfYxS4cMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWhPFQaF7u4DJr+B6nu29bDhBVH9d+i6oLF6X/1Nlmc=;
        b=QUv1RTcDb9m9qmQMtyHi2lX56pmR9dD8a5kK6z0z0EvpoAU3j94Wx/bUTNMX5sQcLp0usA
        5EiU6tjRpTYryhAA==
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow
 specifying all clocks
Cc:     j.neuschaefer@gmx.net, Rob Herring <robh@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104161850.2889894-2-j.neuschaefer@gmx.net>
References: <20221104161850.2889894-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <167060084366.4906.15959650150118240047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aa3f72ea9410f8c9394a5d25bbf40a4cfb56f5a0
Gitweb:        https://git.kernel.org/tip/aa3f72ea9410f8c9394a5d25bbf40a4cfb5=
6f5a0
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Fri, 04 Nov 2022 17:18:45 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 12:48:28 +01:00

dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks

The timer module contains multiple timers. In the WPCM450 SoC, each timer
runs off a clock can be gated individually. To model this correctly, the
timer node in the devicetree needs to take multiple clock inputs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20221104161850.2889894-2-j.neuschaefer@gmx.net
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml | 8 +++++=
++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.ya=
ml b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
index 737af78..d53e1bb 100644
--- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
@@ -25,7 +25,13 @@ properties:
       - description: The timer interrupt of timer 0
=20
   clocks:
-    maxItems: 1
+    items:
+      - description: The reference clock for timer 0
+      - description: The reference clock for timer 1
+      - description: The reference clock for timer 2
+      - description: The reference clock for timer 3
+      - description: The reference clock for timer 4
+    minItems: 1
=20
 required:
   - compatible
