Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA699679565
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjAXKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjAXKeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034640BC5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z5so13406452wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHJKEjRilp8mRaPerWa7dPp1FIIz68emRLTHzv0tFUM=;
        b=b5+zw97Sn1PkTyvEauJJ+UdsuR60bmf+b5L7fqHqvt6faZ5KCSg7jSYKaQ4FINf0Nx
         WOnCvQrZMVY0d76qmiDX7JP0Pc3ds1XIKybT80oQXhE/GBC9bRDuqkcRHJcCOoLNdLYT
         B5FvkvPHYOrT9sh/XwXB8RusdFpVAy2Mim+BCLOv0TbZUO8CBYGwVuctLgHLbVw1wsCv
         QMUEdwTud5CI1lVfoisS+l1wqmzs4beKWi9S4YZIDbOmFrdhDl9oORoLPbiG6fAYCKoj
         OaygFRWErcjFBwfa+cSq0JGnBpsD71SSAXgtiT7RhlOq614Xqfo42TeJh03R/09oftyj
         g95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHJKEjRilp8mRaPerWa7dPp1FIIz68emRLTHzv0tFUM=;
        b=T83vYOnnk9oWHnsk4DYhKcR/Oqd1w8m4EubzoAU4vJmoPxwHzSc+v0TIQejyjl99ES
         m9yQiZvnL32ZnWGpgoiDyNtl6KPrNg/4vCpZrmj8hUIBU5ztrsYutXOvJk3lRpWCYhes
         uyHCpB5rs+bPKnDIt84wQYLiW+kuqfekUmOJ8Lc2MeMdHzBsljwW6GyBqj4k/g8uWhlh
         XeLHCsnUSmlby+BZNOVmR4DY4Mg7QHWrKdFy3vlRzyZeIOQP0+iNB9OQN1Kf8wV7iFab
         0n27fCSL2U9bkDfgN0+WxvTrACKQZyjd/kVk8lnhRu0aem/YNhn0MT5e4v9To8Sqm9PZ
         5nsA==
X-Gm-Message-State: AFqh2kqcLTbCYZK5nZxtiMfTj78TOcFi8Hxey70dOqIsobAMLbDA+UC6
        hUmYroAljJ3bRJTwhRJZVQEK9w==
X-Google-Smtp-Source: AMrXdXs9Pb86KDUrM01Wgt4mguTTlkCTA9jd1adGiors3M7CTsWqXaoHUlqNYWRYWH9ipqtduCMSAw==
X-Received: by 2002:a5d:5a8f:0:b0:2be:53cc:ca5c with SMTP id bp15-20020a5d5a8f000000b002be53ccca5cmr15746127wrb.15.1674556476593;
        Tue, 24 Jan 2023 02:34:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:36 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:35 +0100
Subject: [PATCH 14/14] arm64: dts: amlogic: meson-g12b-odroid-go-ultra: fix
 rk818 pmic properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-14-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
pmic@1c: '#clock-cells' is a required property
pmic@1c: 'switch-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

The switch supply is described by vcc9-supply per bindings documentation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index 1e40709610c5..c8e5a0a42b89 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -381,6 +381,7 @@ rk818: pmic@1c {
 		reg = <0x1c>;
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
+		#clock-cells = <1>;
 
 		vcc1-supply = <&vdd_sys>;
 		vcc2-supply = <&vdd_sys>;
@@ -391,7 +392,6 @@ rk818: pmic@1c {
 		vcc8-supply = <&vcc_2v3>;
 		vcc9-supply = <&vddao_3v3>;
 		boost-supply = <&vdd_sys>;
-		switch-supply = <&vdd_sys>;
 
 		regulators {
 			vddcpu_a: DCDC_REG1 {

-- 
2.34.1

