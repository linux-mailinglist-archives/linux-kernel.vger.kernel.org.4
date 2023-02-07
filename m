Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAA68DC88
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBGPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBGPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684014233
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so13414507wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRydJH6k8VGu02JCc4SOJUqtsnIm9WmAs4kNKB8KP2g=;
        b=RrEwkUkiNXikVfBbsp0CnHs7rGIG0WsMmGjtVUOt9CJTEFUldICuNcKWptjxBmDPsR
         ExM/i6sMWEFPM27IEzR/Px4k1k7qMmIXk6EbZT7j4iwkUH0zRnhr7MiWP4jbFEMgHR7g
         qpU2CF0oYyvdvq+znj9ybFlzqQOGE7rfL5bYdD3TxknjNTJ20SmIqfbLfCXFkMCryEsz
         4BfQmG/W3bltPbCZnf7g0COhPjKZk8yB3C0kMZGiPuMqYe5aDQ6sgiYmFYCSawquiVIy
         VQD9M/TZzFE/5ffD0sMFR3NqQpDCrPZVIVPHD9iJf0gUvhCLSApV9DlJeXk/NvpQxp8d
         +mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRydJH6k8VGu02JCc4SOJUqtsnIm9WmAs4kNKB8KP2g=;
        b=PFleRmRpNyaIEyVl1JKByG5vS77dADkZgdWDqOnprPREB2wYbDVG+h4YGZpG2+tetT
         ao3XUXSf8UmKnsNZ4Kbmw079h8LvOt7EY+dDxXdKWpu20/o2jm2QLJ3q2+dfRcXRsZ+u
         +KSgUNFw6NDe6cF/F1bGM4CituWOX3xY7irLM/agB094yfS6jipYzqOlr8xsyysjhb64
         GA7wPRveJDmaAAgFFNLFJriPur2UsolsZSMolNwvvVIFuiEfORzePq9LpT3UCv/+Nz4m
         bLxiH/B7n4nXB9NhKFJ6dhhfYSn4dlcBRMe0xnu/RF5G154uOzb//PEgC+KBysiHaitR
         K3XQ==
X-Gm-Message-State: AO0yUKUSSWxpwnVA8Tfvfm+Y3deBKKQgIbhtdPew6ZbuVIM7ehBPsdxM
        wUR/EAX1JSKly+V2b5YqS1055g==
X-Google-Smtp-Source: AK7set/fPrVC6hzYUTUxefBmh0Szf/PnEdAC9bPokUbCArbe94doBh5aYwHLoVy8VC8BsRtAcZ3eTA==
X-Received: by 2002:a05:600c:4d26:b0:3dc:4633:9844 with SMTP id u38-20020a05600c4d2600b003dc46339844mr4197035wmp.17.1675782498704;
        Tue, 07 Feb 2023 07:08:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:57 +0100
Subject: [PATCH 4/8] arm64: dts: amlogic: meson-g12b-radxa-zero2: fix pwm
 clock names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-4-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
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

Fixes the following bindings check error:
 - pwm@2000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin4'] is too short
	'clkin4' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected
 - pwm@7000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin3'] is too short
	'clkin3' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected
 - pwm@19000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['clkin2'] is too short
	'clkin2' is not one of ['clkin0', 'clkin1']
	'clkin0' was expected

Fixes: d747e7f76a5f ("arm64: dts: meson: add support for Radxa Zero2")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 9a60c5ec2072..890f5bfebb03 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -360,7 +360,7 @@ &pwm_ef {
 	pinctrl-0 = <&pwm_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin2";
+	clock-names = "clkin0";
 	status = "okay";
 };
 
@@ -368,7 +368,7 @@ &pwm_AO_ab {
 	pinctrl-0 = <&pwm_ao_a_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin3";
+	clock-names = "clkin0";
 	status = "okay";
 };
 
@@ -376,7 +376,7 @@ &pwm_AO_cd {
 	pinctrl-0 = <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
 	clocks = <&xtal>;
-	clock-names = "clkin4";
+	clock-names = "clkin1";
 	status = "okay";
 };
 

-- 
2.34.1

