Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560768DC80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjBGPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjBGPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B4B760
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so11724711wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDLwb0REi9aot4lgydSdtlAMRDoMfdfENb6eT6jp90c=;
        b=kPywqcfJTHgGHxa1YybpYJzz7kO1W9HMTE03kle3f/D+vUsbuRoG0QYvACeDglQcc/
         BkBwgincRlPKuS9S3zGcMuae4Y9TBA9WSmTJjHATV5wI6S3DvHbAuE5tUgNCUk1CA7mg
         NQQHVD4hJgJyVPKn2XZPrA6XKwXWzfOdgpB+Vw2xe9yHaUVeJm4wTZklwovMCtaDh3U6
         z5mc9WoXcnxQmAgtxlkKyvztLIlZ35GLPLdqY6n/dLK8hCmEVHEjuaKH1uiWAffAPHMu
         VIqq1X0f2+ZDrEMrmm9y1cia/KWqq3p4P46QRr9WByvlWwuegerqwnNFFLvXKnuI9kAY
         gssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDLwb0REi9aot4lgydSdtlAMRDoMfdfENb6eT6jp90c=;
        b=vxKNQDx4BiJ+n3G+Rb51cEQTn53tRxs9t9mX7KKdqXU5FUZyT3GapIog6/HVt0WfCF
         Z3Ql71aBeZlkAT7j7q1id6V4DlTs3Rj4AecQyk/yI9HePA8Eahjz2QMXV3ghRANYM5Ux
         D5X6Iz3qsLpfQPUfe6iJS1imx5f4bzEKql0YNsi/oVh1JHWLvOZFr1paMkc58i1bXDXU
         FU5K4upIpq266rjptYuo8B48eVNMiy5CwtZ38YcBbBFDxBfvjBv8MRWJKz1Jxndciw2r
         wHfM+uLPboRq3hs+prxeTzwyYKzlPZPMUvP71USnlKntPnqUzn6Uq87npxAMpcMfb92s
         3PEQ==
X-Gm-Message-State: AO0yUKWcKDcIGUiD5xOR7AyAHZ0SyRVj2hrj9uz1MK9IKPEgWiWwyuWh
        9ypNSEXncFRuuzHaPrrGdvt++g==
X-Google-Smtp-Source: AK7set/O+biA2CMO3jm0lUhOJVP7Z8n6pcHfSafJGyVwdEGd6XrBPnDvCgUt1Z3W0/UOA2Ch3FnkGA==
X-Received: by 2002:a05:600c:1e8a:b0:3df:e57d:f4ba with SMTP id be10-20020a05600c1e8a00b003dfe57df4bamr4101626wmb.7.1675782495124;
        Tue, 07 Feb 2023 07:08:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:14 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:54 +0100
Subject: [PATCH 1/8] arm64: dts: amlogic: meson-sm1-bananapi: correct
 usb-hub hog node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-1-93b7e50286e7@linaro.org>
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
usb-hub: $nodename:0: 'usb-hub' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
index bb492581f1b7..e1683e0630b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
@@ -316,7 +316,7 @@ &gpio {
 	 * be handled by a USB specific power sequence to reset the Hub
 	 * when the USB bus is powered down.
 	 */
-	usb-hub {
+	usb-hub-hog {
 		gpio-hog;
 		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.34.1

