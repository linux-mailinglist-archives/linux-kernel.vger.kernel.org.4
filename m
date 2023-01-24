Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6567955D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjAXKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjAXKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8341B50
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so13406137wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf92k+BW04Wt2vsFzZg0r4ZmptHsw49XtqGj3I0e/gc=;
        b=jvsJwzM/WIeTejyhikwsX5mpm0TVybiCfIxP/71kr1GZMc7/ezpjsa8XUhFkGX7puh
         ZMuOv/5ZiCFMtAZ1uZzgmWt97VxMfRXWPhJO9VfNifWHv1ifJiOywmu4Av3NhB2km6xZ
         3ur6XeX2eyxBZ37FC2jeyuLFWTWBVe4adkx8cAyQ0+VwndjrT+2Yt/hUNVq3aU2285w2
         7k73fV6TapSmRZ2hXupU75EVU/NHjMkyPgrVz8qp4Rv+lLZSDvYmdrRwFIy4ZVTeAvQJ
         nLa7Xw21MO+kfVmP+QRWYqc4bvknfe7A6JFUnFPGXKzGtXfaPpIuVz5iA/TsQTpuxn1X
         CxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kf92k+BW04Wt2vsFzZg0r4ZmptHsw49XtqGj3I0e/gc=;
        b=sHr+YgSorT3RfN9JIxIXaRN5a+aoMyLpAkokLnFaGkrPX0baifgIXkZcjfS78yQwLH
         KRI3m9iUvujyFcC5pXo0i382SVMvWpl7WJQUxMFO0LGF51NfWcr1D6nXX1Ch7iDFVgLX
         J/+4PcnhShCkEcHLLB8eZsDi4OfoMdch4fR3PE91nK5M50avPneXGsWbZFwX07oPMKdp
         z9zJdZGMwysfvKEuSQl6NcP85Q/N3pdaetgJR8/PrBRD1Dss/J9ZwpjO9xVPQ6q27Fl7
         XfQaJG0oncAqQ96eNF+rqOeD/PyYBDmQr3zkEH0lFKWQTK6u+emRvJ5JvUBSSCOVKop8
         K42g==
X-Gm-Message-State: AFqh2kqzMc5rYkiU8G2b6W4e+IOgoEtNpYvifhmqkQk6kmMHbLzzYzxd
        Fgg2UWgGLbGWgT/BkC3B4rD9Zg==
X-Google-Smtp-Source: AMrXdXtFdlMAU+HvZRltbYof9inRjog/t9q6bI6+HheCM54YOdhqSLbC4id1iR0wJiRra4F20MtkCw==
X-Received: by 2002:adf:f3cd:0:b0:2be:c5d:3564 with SMTP id g13-20020adff3cd000000b002be0c5d3564mr25812727wrp.19.1674556470022;
        Tue, 24 Jan 2023 02:34:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:29 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:27 +0100
Subject: [PATCH 06/14] arm64: dts: amlogic: meson-gx: add missing unit
 address to rng node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-6-44351528957e@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
bus@c8834000: rng: {...} should not be valid under {'type': 'object'}

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 11f3b3a4df97..1f9cfbf4fa0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -532,7 +532,7 @@ periphs: bus@c8834000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8834000 0x0 0x2000>;
 
-			hwrng: rng {
+			hwrng: rng@0 {
 				compatible = "amlogic,meson-rng";
 				reg = <0x0 0x0 0x0 0x4>;
 			};

-- 
2.34.1

