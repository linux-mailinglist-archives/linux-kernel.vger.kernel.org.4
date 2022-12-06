Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C0643CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiLFFyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiLFFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:53:58 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E027142;
        Mon,  5 Dec 2022 21:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670306020; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LtRxaus840eTgSFHKHI4FiRq3Sc28LDH0d/vsir1aLsM47Dz5lTsmzu9KAKU9UaUn70G3vMEVybA19G2NMezI3cxJeNnXPctmgsredCuDwcU2INW0D6GvUPfE6Ay/U4Ke07sJ8aaLB3EIP93ewd6jY7B+luxviKo9UfqI41kHU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670306020; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/k1Z2WEqHllTXos8B4dmbQlQ4/WttliYjSasnsZMvhQ=; 
        b=aZgxRZV+Ut4+VNrJQIBc6M3Ogxo/14bI9TvtCotaf8hrbakldORtxHAntcopZzbE/u3h+WJ+lbcGHbmPJEUPtkK1sAF+SmCqW//vkqIpgugVSJ6CHAKmKrXw77bnJQkKWvvVec3dgTkQDgiDo0oe/rSG98vI66VPOshpnOjb1mk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670306020;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=/k1Z2WEqHllTXos8B4dmbQlQ4/WttliYjSasnsZMvhQ=;
        b=N/qlKYX8tYoyB7VdKKHgswYT4lcoDv2xLKWQP2j+JWExnbTnCRCQCrCg5KzDlOHE
        m7pjEqIlcUMMMUTLGuNwnRP/J7cnP6n3ARLuuyk+wO4YE3QdHsiHwdRtA/w5s8Z3fTb
        IcL6O8waDQp2ylfJh6vFFeVMWuQ/kcMIAfz9zWAA=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 167030601851298.70551810068184; Mon, 5 Dec 2022 21:53:38 -0800 (PST)
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
Subject: [PATCH v3 5/6] dt-bindings: arm: sunxi: add Rongpin RP-H6B board
Date:   Tue,  6 Dec 2022 13:52:27 +0800
Message-Id: <20221206055228.306074-6-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206055228.306074-1-uwu@icenowy.me>
References: <20221206055228.306074-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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
Reviewed-by: Samuel Holland <samuel@sholland.org>
---
Changes in v3:
- Add Samuel's Reviewed tag.
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

