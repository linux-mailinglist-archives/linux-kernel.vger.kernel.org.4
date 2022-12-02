Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACE3640203
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiLBIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiLBITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:19:03 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3EAD309;
        Fri,  2 Dec 2022 00:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969089; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=T+W1DalycLhYAsP18ryuYYn1E279/0FGYrDbYa3YRlub3YY8OhAqVj4l1HxdbI3g40UzacYWltrai15yIlu8d7Rm/Xep6/Y9q1/PW9KxWGRJLDbLa3IwuZhPWTKa7/b+vjQgT0uRn9IEJei/i9tMzOyWY1o5PAX8jEf3B7obn0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969089; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YjVqQPVDrMTTPaH9XdK31p0qv5gXWSbzArYnoQvmmro=; 
        b=Ndoxzwt8sLT8CMt+jVtcdBL5F7aW2pkoY6vC2ZLCzBXESgSlTiY3kdmHa0N7yXYM8A6M1YHAlcMUPPYmgMxYh0hkOUFKFYeEeXDJTy3FWoS1Wgc/wC84H6vFIZGVJCirzjX5VdcxUvOhtBpHxhLbTdC8BHnbjhrIXTlEFYsxxPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969089;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=YjVqQPVDrMTTPaH9XdK31p0qv5gXWSbzArYnoQvmmro=;
        b=VlmV1t/XKncTo1U6jeIZIR/HKuLZ4msDuzF3DmGPgIebxazVNGjjTyN+06yjcyrb
        U0TXaKHg2fopS1/Zqb0LingVkcpOWW04lolWdlhl/ZZYDAflz0BDlui5KD7dB168G2P
        MOyIcG19y1bolehREdKbPlCas58T9OD8lkXEJTOc=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969087734695.9599994502184; Fri, 2 Dec 2022 00:18:07 -0800 (PST)
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
Subject: [PATCH v2 5/6] dt-bindings: arm: sunxi: add Rongpin RP-H6B board
Date:   Fri,  2 Dec 2022 16:16:46 +0800
Message-Id: <20221202081647.3183870-6-uwu@icenowy.me>
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

Rongpin RP-H6B is a development board with RP-H6C SoM, which uses an
Allwinner H6 SoC.

Add compatible strings for it, including the board-specific compatible
and the SoM compatible.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
- Add Krzysztof's ACK.

 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 3ad1cd50e3fe..482631815f2f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -792,6 +792,12 @@ properties:
           - const: rervision,h3-dvk
           - const: allwinner,sun8i-h3
 
+      - description: Rongpin RP-H6B development board
+        items:
+          - const: rongpin,rp-h6b
+          - const: rongpin,rp-h6c
+          - const: allwinner,sun50i-h6
+
       - description: Sinlinx SinA31s Core Board
         items:
           - const: sinlinx,sina31s
-- 
2.38.1

