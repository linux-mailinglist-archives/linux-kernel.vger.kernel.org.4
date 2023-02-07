Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFB68DC85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjBGPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjBGPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749740E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q8so11247154wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJHI3+tzcBtJVa9SUKbRsBZR0Yb4Ib5Z35Bs0YBTugg=;
        b=Lp80Jj1JkvrJJw8jZtJ9MI0KG/cilTe812kcTc73Mr69D0oS+csHSdc3WNMfqdgZFX
         Pax9E7A6lWboirgMrf68ekPLyPm2+/ZCDJU/5bzA9tt990PH1RatfKCgKDsABHXSKeWI
         s6atEjLASbSqIum66BXw3yN4o+dHGo9if68DbTYiMXUfUtjjdmUPvmwGocUifCpY9OgE
         Rp69uIoTwTTsLd40+ONXB6gnxXASak2pDyzyiVHlL86BY+Yrs7vjbsjghWvt8yMAgqzp
         a7lG3OFzJxhealVkZlNzrDKisoV3mFp66ljNRFY6nN7GaBNtXCYGY6dHPegdb5QT4fj1
         p6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJHI3+tzcBtJVa9SUKbRsBZR0Yb4Ib5Z35Bs0YBTugg=;
        b=nolWU9tLbz0byidzxGQNDdWRzxR7Ria3pb/ymzLUCtBpCTNkvwsqY8p6GZAAU5FMes
         bth1n1+2gaEyDiLWJvV36yZ3Nlf29UvNbzUCEqxnS86NGHstV3LB1YhTx+UQib1Lbn4u
         vgwdGkuUOTOCzFW5thSRQo5KKzy3qqSFPAe1si3or5ewCgf6whHFnYFEX3LRLzz3oqxs
         n6QMDIX0YLmaK3kDPIl+zzRLlpFZajXXEwnWd/DitDm3pUCEo+8Hd+0RMWtFW7gztqCm
         S50qBHbMBpk61VK785Ai2yfCTGJbKxTrL/BMeJvNWfIjDNZH5We8ilMHckFx2pRchICY
         mAiw==
X-Gm-Message-State: AO0yUKUpttMeIR8tqD86muKiLJ88oq+pydbu2LPmECx76xuVRVMI84TA
        g+RX6ObliPYPKlGeJROzpC4w6hJClWrulh52HRc=
X-Google-Smtp-Source: AK7set+vRmQtpopOfJ+0T5HMPbP02wvOfqk/B5wo/6PEyuk0BJKU9w0CoY+gPy/vEHuQPOBIbh54PQ==
X-Received: by 2002:a05:600c:706:b0:3dc:5ad1:583d with SMTP id i6-20020a05600c070600b003dc5ad1583dmr3320455wmn.18.1675782497610;
        Tue, 07 Feb 2023 07:08:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:17 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:56 +0100
Subject: [PATCH 3/8] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx:
 remove invalid #gpio-cells in onewire node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-3-93b7e50286e7@linaro.org>
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

Fixes the following bindings check errors:
 - #gpio-cells: [[1]] is not of type 'object'
 - 'gpio-controller' is a dependency of '#gpio-cells'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
index e1605a9b0a13..db605f3a22b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
@@ -159,7 +159,6 @@ map1 {
 	onewire {
 		compatible = "w1-gpio";
 		gpios = <&gpio GPIOA_14 GPIO_ACTIVE_HIGH>;
-		#gpio-cells = <1>;
 	};
 };
 

-- 
2.34.1

