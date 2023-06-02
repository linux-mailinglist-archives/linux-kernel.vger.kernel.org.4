Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3B7202CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjFBNMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjFBNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:42 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6581B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:11:10 -0700 (PDT)
Date:   Fri, 02 Jun 2023 13:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685711466; x=1685970666;
        bh=bsHSAN20PI+leXRVPAKhT58R/jP9fMKdBTvAX0E8FqU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VbTmR5GEF39gofFS3uu66gadQF6UvyOwrWj9xebfMRmxOpeEv+PcVcncLZ6P+O3YW
         nTivcSGNGe5+x7HNfyRYeKz2IOx86mBsQEq3btIp1jXMYkHFFjNGYbd9bV7mooUl/m
         OyWZteVrsMr9D5CgwMdhZuKZNyRvjK2czFT6qW1V8X46ODedK1MIkWeD8Sw4UqAKIn
         0b5mGnV7ee0b7uQIir+qQYybA0MiFdop4Ug9q56msa2eZeQabzp0qLe5ecrij2uTTT
         HuVroeV+fygtMa+f5b8myrdLf+S4jWBk9ODoA91ufReIEm6CJBT8vprDvIF9h62RRJ
         hppGSN7F4vsNQ==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033 compatible
Message-ID: <20230602131009.260239-1-raymondhackley@protonmail.com>
In-Reply-To: <20230602130644.259933-1-raymondhackley@protonmail.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Richtek RT5033 Flash LED charge pump used for
camera flash LEDs.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Doc=
umentation/devicetree/bindings/leds/leds-sgm3140.yaml
index 4d2ffe5fcfc7..37d2a93780ab 100644
--- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - ocs,ocp8110
+      - richtek,rt5033-led
       - sgmicro,sgm3140
=20
   enable-gpios:
--=20
2.30.2


