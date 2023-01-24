Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206367954D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjAXKes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0940BEF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so9406931wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5KCrVUjHQ7CYQCved0mtIgwVFkff6FVL28Qru4rupM=;
        b=rCHaNlocN7UnOx+q/fVQ5SEbuhKfeF9jie2UTKZPysV7MvyMx8qdsfYucf+FzLeGW+
         XQow12ijzfN8tOGmmQCu9VK2DwoaT++sLWlnYM/taPHrMIrkHFHNPL/lB6BkLXHvpDpE
         kwie4sPqo08mZV7x0zsnagzTmxsVD9nk6ul9IX24QZ374UeAada8VOTmjMV3AzopNYaw
         bxndBkTMYMnJg5DlH8SXJ1am2cSbj5CSAW2DyLaIxNQ/Lrr19lDszsaonoOFmh3L5XtE
         9YG/J5vCMoHu4JOLzIMc0PSi+P3MTvKmoQ8qc3kcbquqJRPNtkHWetgTLf4YUo6Ptj5q
         Pf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5KCrVUjHQ7CYQCved0mtIgwVFkff6FVL28Qru4rupM=;
        b=n7YDT1B5TLP+z3Fvmg1g689kgTWw/pwSPtAML+XsQIsfc9oG6ZtwqXKFXzSzRUy7zR
         wMWss8xF2GKc/Y63t7i7pSt6VpjX5rTy9sPGnCsIGpW+g34nOt73ctQ8FKlsxSpDIEvr
         /HJVSHltShYf5ktBW7WTB3nI8XHElqwZHoJt2zh7lYL+HnGBXQA+zecOS23ZHxeYOoZ2
         oD2K3HHyn428eMNszwoFnks6njsVQn30LO4uca89ixf5COVSd6GuiL80ynPWzxrs4rVP
         rbzEJXTD2f7/VdfVG9lcHySx2To5O0uMlRdrq3XtOxVdkZlRk+afBJat/zJ/MQ9N038w
         BkUw==
X-Gm-Message-State: AFqh2kpCeTUyB5nmQn4u4XgDg82MgFuPpKEqPGtTEb9nl6bJONlJGGMA
        07mjtYYtfrEXkBHxsDQkwrZ41A==
X-Google-Smtp-Source: AMrXdXu0RDV0SkAYheTBT/4bnxJuE8twYoMFEyzsJF7QeXPO+ys2zWHaXTXjFDK+IBzalzIZSdWVww==
X-Received: by 2002:a5d:5383:0:b0:2bd:ca3c:344e with SMTP id d3-20020a5d5383000000b002bdca3c344emr22956013wrv.7.1674556466425;
        Tue, 24 Jan 2023 02:34:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:26 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:23 +0100
Subject: [PATCH 02/14] arm64: dts: amlogic: meson-axg: fix SCPI clock dvfs
 node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-2-44351528957e@linaro.org>
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
scpi: clocks: 'clock-controller' does not match any of the regexes: '^clocks-[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 1648e67afbb6..13f8d483c61a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -153,7 +153,7 @@ scpi {
 		scpi_clocks: clocks {
 			compatible = "arm,scpi-clocks";
 
-			scpi_dvfs: clock-controller {
+			scpi_dvfs: clocks-0 {
 				compatible = "arm,scpi-dvfs-clocks";
 				#clock-cells = <1>;
 				clock-indices = <0>;

-- 
2.34.1

