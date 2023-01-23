Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6107677F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjAWPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjAWPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC662A165
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so11117886wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLmObsXppjgTLUkZhDZMzzvYoZ4ldtBeVK82N/V1ME8=;
        b=hfBiygmVlAJt0R9lzJeH5P0qDkKbhbRy6bN3p/DPq6hX1m5UHzQ7nMYugF7tz8cOsb
         W3qfNCYhoGek1PmKhm1d2foxSnlcISbNYGCUz4n8fNJKLNYUUJM3JnJCAY8Ikda3YMQT
         iya4VJUFM8a2/jgjCToomlzO8z/njnxM6mYCqVcbn/HY20rV0rCM6Z2zXUxsdlj+85O2
         JTLjM3NyFrzQYbTAV49oFY2dvZyQ3OfSyppJP1HSw/ju8tHycLEN3ZzlGJqplyzDEmBx
         nFT9zZ1X6dFLY9Cs9M+KbqfsIhtkysomCiL1kqMlAND2vWsI7qt8CwahEtOZRlmdBZMs
         HxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLmObsXppjgTLUkZhDZMzzvYoZ4ldtBeVK82N/V1ME8=;
        b=lQ3msM1ubIuLagIbWEjzEc9KJhgTWT6bAESFvm0hsICn1lb7RfpGX5jQ3cFXzDobps
         AnjYyGEC2KLFiwNi4pqghA8TgbP5Ryp0IBNTAod0IS9RCUve8zoFS1aMaADcFK9354qI
         FN0Vb4SRo9Uqy20J93Cq+uyWNwCY9QbZVh9/SHgrU6v9oxYAxb4+pCmm5eAoMVIxLQLa
         FjVk0i9MYPcKhRhr9IPU0sWyt+1TM6LeFKwosAGAfD540lNu9jPcSyHeE8VitExtv3Ky
         F3Kyh1HOFFFThsdyk0zna99s8pyCW8R8XMIwhKjghDkHh0PqKGIQ10qvuKaPM66r/yu6
         gRJQ==
X-Gm-Message-State: AFqh2kogYj9FHWGP3mCsUK3/qdtw2pjCZmPnApTdmaDOxuGJ/1FJe3Uo
        tX62QMyUcygEYbdeGkQf0RCGtQ==
X-Google-Smtp-Source: AMrXdXugi8pgXRHUm9vL4l0OhAWclebho6mRorGDICtNbsmXSSdB78MDJJa4SaKwfsY74ygF9vqRKw==
X-Received: by 2002:a05:6000:608:b0:28f:29b3:1a7f with SMTP id bn8-20020a056000060800b0028f29b31a7fmr26175948wrb.36.1674486918440;
        Mon, 23 Jan 2023 07:15:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm18136718wri.96.2023.01.23.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: hisilicon: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:16 +0100
Message-Id: <20230123151516.369130-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index b8746fb959b5..8a9436ca2531 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1254,7 +1254,7 @@ ipmi0: bt@e4 {
 			};
 		};
 
-		uart0: uart@602b0000 {
+		uart0: serial@602b0000 {
 			compatible = "arm,sbsa-uart";
 			reg = <0x0 0x602b0000 0x0 0x1000>;
 			interrupt-parent = <&mbigen_uart>;
-- 
2.34.1

