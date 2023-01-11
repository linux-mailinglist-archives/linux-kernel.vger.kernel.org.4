Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B100666565
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjAKVOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjAKVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3E3F114;
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i15so24256002edf.2;
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ffgqh6sqzCFOnSQzAbx/Vng8jdSqSKDyu1AqPh4tw=;
        b=OzWMFZTWvoaLsPg3PGx/APgihyI84avP7Eyt4gAuuRnm7L6xBhtZjoCZOrIUmySrVd
         rEKcxcjymDhYrhg3dhbLUeQiJjI5zWd6J7IN7MWp+biSEb+sJ3plomb9UwxJvnrUwv4L
         Eo/lKTrGazVt/3n0X2Gq1txGODo/IVrf063NfpG2QHOYOIQWmei5WABbD5JTAEpIrtvP
         rBG42wAtzH5KFpbFDQCyvZyzru738mWVV/dPaLsbRi7U6Ij6TfymAz6kxWd5C0dlOUxo
         P2XxPaMy7ks0yxC1ufBztibGGf/jS7B4Sn+xux2CCASqX/lIvNn9TZ0d8bYqTXRstvoU
         cF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3ffgqh6sqzCFOnSQzAbx/Vng8jdSqSKDyu1AqPh4tw=;
        b=oQQPdDcMFNhl+BqlpbBmGPu9ChPYqrTiV/2eLVP6nrKxsUGS+QuTiWaJ8dGncsaNn1
         cTVhxL6U9jTRPBKy2RQ9lGVJRHNO8l6DCx7ZutfFVWsR1gidaka9KTsFy232MnvTSFXD
         spuHcx8bAo+qtcdQIlMEUL88HfbNIuE9XB2gBSax4XLQF36hie2zu0uQagXWt3ijQXdn
         9MKVstN3p9B3fnxSB6g7MU8J0U23SlDvQlXZr+uGq1c87f0bcS0AUW7ji8dHPfEiWC6h
         Zomz64JIMiOt7HiCOCfp67WW1q0p925NWihKkxykt9bMFD8K3Q6lIV+fGTffmOwzUMFl
         GUWg==
X-Gm-Message-State: AFqh2krA9xl+s3iE011i73OQk6XpVGX4de381BCEVZa6K4rToyPLIv8X
        c6Ax87QPGNNYCdax2hz16GY=
X-Google-Smtp-Source: AMrXdXtTWEfU2lAtIwS819Tw/jmj+Jzz2ngqgL1nRGsmz0XMhLEC9/1Gwbvxjq4qbRTKWCSK34AZQg==
X-Received: by 2002:a05:6402:501f:b0:46c:a763:5889 with SMTP id p31-20020a056402501f00b0046ca7635889mr85705323eda.25.1673471654804;
        Wed, 11 Jan 2023 13:14:14 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/6] arm64: dts: meson-g12a: Fix internal Ethernet PHY unit name
Date:   Wed, 11 Jan 2023 22:13:49 +0100
Message-Id: <20230111211350.1461860-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/net/ethernet-phy.yaml defines that the
node name for Ethernet PHYs should match the following pattern:
  ^ethernet-phy(@[a-f0-9]+)?$

Replace the underscore with a hyphen to adhere to this binding.

Fixes: 280c17df8fbf ("arm64: dts: meson: g12a: add mdio multiplexer")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- new patch

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 9dbd50820b1c..c95cf3afc666 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1694,7 +1694,7 @@ int_mdio: mdio@1 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					internal_ephy: ethernet_phy@8 {
+					internal_ephy: ethernet-phy@8 {
 						compatible = "ethernet-phy-id0180.3301",
 							     "ethernet-phy-ieee802.3-c22";
 						interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

