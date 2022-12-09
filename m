Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84E6485CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiLIPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLIPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1030578;
        Fri,  9 Dec 2022 07:47:23 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpe52wfuJOhmU4CtGGoywjK6BPcAajUSMekDJwyvslI=;
        b=PjB29/cc4hQTQASb+DV4IDWQOR1lexzgSkIvKgj+5/evA7mW3ekMQOHfbY+uP8fnXBXxlg
        kFZRbmDz+7vbgbSEnucnQZmina7jbSTDqq6+J4v3xdL5WHR2biTjyguWUMwCrcI6meP+H5
        ZKqTMf8E0OsNNEDbWpYjD6dgD3HBsuNxv2YZcT+FpoOekz8aAN5ui9jhJOiht89ssi+Oyb
        Z1p0X8svCmCubd3rItoZoPcEcjseKie7+z2l0RuPEOTC/sjToyJ65+408l9lGjxT+/ypKG
        Uj9tz2gizxWLiLbgOhLDkxDoHrJnfE48j1d4WnIUshGqjN3g0tzRu4B8NFK+og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpe52wfuJOhmU4CtGGoywjK6BPcAajUSMekDJwyvslI=;
        b=8xaaia5RfnP2YwPyx4qOsvY/EK79EIfdUVGyCefQG1W+8/htV/niqln0c21AkbOICkoy7p
        ZdgWmopw89xn1SDA==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,tmu: Add r8a779g0 support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
References: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <167060084231.4906.14198788118831066497.tip-bot2@tip-bot2>
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

Commit-ID:     bbf687daab58ef8d09916d69537ff6fa2c849e88
Gitweb:        https://git.kernel.org/tip/bbf687daab58ef8d09916d69537ff6fa2c849e88
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Thu, 03 Nov 2022 21:48:58 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:29:34 +01:00

dt-bindings: timer: renesas,tmu: Add r8a779g0 support

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221103204859.24667-1-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
index 60f4c05..a67e427 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -38,6 +38,7 @@ properties:
           - renesas,tmu-r8a77995 # R-Car D3
           - renesas,tmu-r8a779a0 # R-Car V3U
           - renesas,tmu-r8a779f0 # R-Car S4-8
+          - renesas,tmu-r8a779g0 # R-Car V4H
       - const: renesas,tmu
 
   reg:
