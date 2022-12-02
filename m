Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2276401E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiLBIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiLBISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:34 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1EF585;
        Fri,  2 Dec 2022 00:17:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969043; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YnUPjnsuIe+0K04IK7XQmhRRfK2SNlpJMtnX0fxANCuZlPNalSovgjBoy4al2bdHmlUjFonc6ceHBbxhewlR0ipyEkT9DfwBLUIGpozo9AFJiSRKHyfRMhR56gfvpQ6cXnItQQ3rGYeOUsTSSym6g0hSSRvFnvsmGuF2VJTq4Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969043; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Rratc0OttPrJfv5oyD9jUDBZ1BW+JJIqS7W6aA3RiwM=; 
        b=RnQgn1KvbYcZ0Gpb4QyLihaYgoGaYwGjmVmu3kqRtIZjEyEiotY0IiS6MCu5KgMKGh1uWSYZNuAvT977IL8Pwy9ADnSvswxo9xeKHHteT5zjyQIOANxzmdLMlDmaTsYwLnLvgQkYcytvh/rsSbsznU6WGr45+ymAaHVK3IKus/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969043;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=Rratc0OttPrJfv5oyD9jUDBZ1BW+JJIqS7W6aA3RiwM=;
        b=Pt8k1vXB48VEjsvLG8jmk/IqR7ZjDfDdPMvjsHtUbuy1aoYkr9/WYq793TQfWSBA
        ClQtrKX8RfPP1azvStjDOW7gXktvhV0aLNUSGg6Y7jYImsdBmoLUbgFfOuXF6+u5oFG
        sxVGiw08G0XBhDU9CHz5ms0F6/4PR6Gy8psXK3m0=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969040692988.3765698302417; Fri, 2 Dec 2022 00:17:20 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/6] dt-bindings: vendor-prefixes: add Genesys Logic
Date:   Fri,  2 Dec 2022 16:16:42 +0800
Message-Id: <20221202081647.3183870-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202081647.3183870-1-uwu@icenowy.me>
References: <20221202081647.3183870-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genesys Logic, Inc. is a manufacturer for interface chips, especially
USB hubs.

https://www.genesyslogic.com.tw/

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
- Add Krzysztof's ACK.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..43359c0ccaf5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -488,6 +488,8 @@ patternProperties:
     description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
   "^gemei,.*":
     description: Gemei Digital Technology Co., Ltd.
+  "^genesys,.*":
+    description: Genesys Logic, Inc.
   "^geniatech,.*":
     description: Geniatech, Inc.
   "^giantec,.*":
-- 
2.38.1

