Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFAC68DC81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjBGPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjBGPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C053C1F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg26so11274123wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zE+dKl+sL3pb9GnFpnoaxbVtKqrHW1hzZtIQmyAek0U=;
        b=RQuUonvDuqF+3CCi+dn4x7dFkdKWYIEB+M4zklnLUsccDEck76Uy3uhC6xY4cFsRmr
         ut7f8/XvU/T605Hw0g4ZIEbY0v+2HLkQuCnQLDXlHIS/eHfXD4fgrG0CWSO/METEIxQo
         qD898z3aoriCToruKGEgcGnMsQOi4pgihLD63WksRsC3N7A3z+JmD0PNLw/VDXG1Uxfm
         /XSsr0uV355Wp8OlDrY/pact49VBHPB1xofVWu+UZo7NOAhv7KcKqyOwy/1PnaKyUy62
         6iyxRVvSIooTvdn/Ex2a3dgmVxZy39dESoOOrAl1Z+5BuqhacBS8WmEbejT4nRBPwdRl
         UWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE+dKl+sL3pb9GnFpnoaxbVtKqrHW1hzZtIQmyAek0U=;
        b=LdwF7BH7taYfA6z+UnVhRfhJhj3KvxtgCFd8d7yxD2LcxwdWZMi3KX8OSfENUs4eZV
         nvQqxUK5eSbKcH54RTi+H/ipc+gMWsANZM6YP/Dnz5QnBG++NvHv1lyE77x3jsoT7j2V
         cgDRCOsWYWKXvR5cFc3zd4K+LAGAWQ4gQr16LOS3lFYmgIpfUSO6sIGO/6RKznUXy/dW
         C20L4DpnV4fWJ4c1IKraIKdDKHphyp5NsHe6nue+wThMNNrQkC7pJXCNO+Q1xs8i2YZL
         HUKWNX/CHb0Vu2zfnzvT+OCNaGTagHetMBRJ/VNH9eRymHUqjOfASxFFrEqH88lmGPpd
         kTrw==
X-Gm-Message-State: AO0yUKVHFzpuVrXG7ZX7OPHEMg5I96BDvesMvDxNWgep4ix9zkecC0Iu
        fBtnk3rSTcWfe29x0qX9+2fkeQ==
X-Google-Smtp-Source: AK7set/UpZz7GRnd79XenBIyRDwl2WBcPb+uvydZaMYj9J8t38c1xeJk+630ye1zxrpBmTat97VEcw==
X-Received: by 2002:a05:600c:993:b0:3dc:4fd7:31e9 with SMTP id w19-20020a05600c099300b003dc4fd731e9mr3528250wmp.7.1675782496107;
        Tue, 07 Feb 2023 07:08:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:15 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:55 +0100
Subject: [PATCH 2/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc: add
 simple connector node in fusb302 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-2-93b7e50286e7@linaro.org>
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
fusb302@22: 'connector' is a required property

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
index 444c249863cb..4eda9f634c42 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
@@ -54,6 +54,10 @@ fusb302@22 {
 		vbus-supply = <&typec2_vbus>;
 
 		status = "okay";
+
+		connector {
+			compatible = "usb-c-connector";
+		};
 	};
 };
 

-- 
2.34.1

