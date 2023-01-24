Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3D679557
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjAXKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjAXKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89451CAF0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so13403568wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDkw5uUSHahK6uimGKGD6b5XhPSy/LFSBRYACRQcStY=;
        b=kt/au7mwf0gCHZKYy+JaOKZpWYolFimMoXam6j0giar2upY3miaBvXo4a4eUjzBXDB
         pUtrlyM0iGpwERlpLlGoL5RIHFIoZUNwk/S/98o7SDJsv9Ak7hxScuVzX7xQIQQOPh2P
         G4DZg8YkboQcDgTnSzBuXA/PGhRmCqWb1s4Z95cPEejONOvnOp2slR43vWHLjkwSibFM
         IJJFaSPFIntyxJK8YbphfeBnv3VEcpiaSROODZ6Hp5HFX8RadIimxJlYrI5a0br8GRIq
         Rr9MQQeiCLmTTCIN4AYKbjNA6XCBo7URIL1pnz8PPrm8x6/7+hkLuU/l9DOvKk9XgXI4
         N91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDkw5uUSHahK6uimGKGD6b5XhPSy/LFSBRYACRQcStY=;
        b=VhBrgn52aD9JfJOVwONlQ6VGhVVr8tmYBUx5pyGP79506Lv8Fqi0RYD7Lvfd58Pj4K
         m/qyT/tq+GucACwajF5irYNqjblBEPpeC/+TERuu4DsLYj4EpzQhmFT+oNLWbNMXeTIM
         q7VPLhDgXZgaCzHc0jgQFIlBjAMZ4vpUflsSMwgG6P6sqZxwbcL9XUyTHX6AgGMIDJiK
         4WWkVAwkgPdDU8jLYtWvgaOz2sTbU8rit9emlgp77ujD8K1PpZw1aonWr+rfHE0b8gEk
         QwscfrY+aF4xPJ8EV4dxyQrkDn94DBOwSDqlGCLd3PmHbrT1OVY24Btk41bs5/286f9p
         aDOQ==
X-Gm-Message-State: AFqh2koLo5yXWNigtQNZgaUDGv4OIXfSZ+h9HiT+nfdVGcn9ZBX2obs/
        Fzy5LNSOSZ7LSyNQeY9ViRMp4A==
X-Google-Smtp-Source: AMrXdXtAp92ghy5/k/AzItdKvXr7s9bAcSnSJRYodLxhm2vU7SRRWwkJdontVZaqS+WSag/snj4FCw==
X-Received: by 2002:a5d:6b50:0:b0:2bd:f17b:bfd3 with SMTP id x16-20020a5d6b50000000b002bdf17bbfd3mr24830132wrw.4.1674556469040;
        Tue, 24 Jan 2023 02:34:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:28 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:26 +0100
Subject: [PATCH 05/14] arm64: dts: amlogic: meson-gxl-s905d-sml5442tw: drop
 invalid clock-names property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-5-44351528957e@linaro.org>
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
bluetooth: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
index b331a013572f..c490dbbf063b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
@@ -79,6 +79,5 @@ bluetooth {
 		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-		clock-names = "lpo";
 	};
 };

-- 
2.34.1

