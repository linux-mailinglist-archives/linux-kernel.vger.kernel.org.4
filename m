Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDD6DD025
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDKDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDKDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:23:41 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9A172C;
        Mon, 10 Apr 2023 20:23:39 -0700 (PDT)
Received: from shark2.inbox.lv (shark2 [10.0.1.82])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 438E2480AB5;
        Tue, 11 Apr 2023 06:23:32 +0300 (EEST)
Received: from shark2.inbox.lv (localhost [127.0.0.1])
        by shark2-out.inbox.lv (Postfix) with ESMTP id 344D3C0058;
        Tue, 11 Apr 2023 06:23:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681183412; x=1681185212;
        bh=W3tRanFHINm18pybtDmwjdQ4Iu2c6+fwf0X84jhz/xk=;
        h=Message-ID:Date:From:X-ESPOL:From:Date:To:Cc:Message-ID:Subject:
         Reply-To;
        b=qRRYCYqrgzw+KpPeFhD7dtNIMt303zwWL2Musc+1VojZA3PBrmFF1WJBW4gKtcsQ2
         4mY9c2qBs4tBQ/U1bGEk8Q6sTitpPNNkUIo4oyB+zuyv4QwbAGZIYuMxVn3m78bl3c
         TtWXNxoNLnfGBAk4A7VfYuEMMf5LSiGTz9keVwRE=
Received: from localhost (localhost [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 2868AC00D4;
        Tue, 11 Apr 2023 06:23:32 +0300 (EEST)
X-Spam-Score: 2.974
X-Spam-Status: No, score=2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
Received: from shark2.inbox.lv ([127.0.0.1])
        by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id bVRgT1qa2noD; Tue, 11 Apr 2023 06:23:32 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 26A32C008E;
        Sun,  9 Apr 2023 20:40:38 +0300 (EEST)
Message-ID: <df9cdb26a0591289c268d79b07c3dc96.exkcmailist@inbox.lv>
Date:   Sun,  9 Apr 2023 20:40:34 +0300 (EEST)
From:   exkcmailist@inbox.lv
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3kB4BlLucG3NYZv4P3txci7V0ZQziqCtaFSnX9YsLvButt3c2iUB/eRFELmMmLD
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9e8d170e5a13717aa8961ed98fad216ee9798977 Mon Sep 17 00:00:00 2001
From: "@exkc" <exkc@exkc.moe>
Date: Sun, 9 Apr 2023 15:12:23 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add Xiaomi Mibox 3 binding

Add the board binding for the Xiaomi Mibox 3 Android Set-Top Box device.

Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..bc4da146a5de 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -99,6 +99,7 @@ properties:
               - libretech,aml-s905x-cc
               - libretech,aml-s905x-cc-v2
               - nexbox,a95x
+              - xiaomi,mibox3
           - const: amlogic,s905x
           - const: amlogic,meson-gxl
 
-- 
2.40.0

