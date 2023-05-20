Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEF70A7E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjETMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjETMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD7192;
        Sat, 20 May 2023 05:19:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso1778801fa.0;
        Sat, 20 May 2023 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684585190; x=1687177190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTDs5T5uCBqEAuJsK/qWf1YHHB6qWweCx58+58dFY6M=;
        b=Of4IIg1K+UDpULUhjv5cPFSXDvRipy7Y7jEdh6MXGzI150kUF8Hhk7tugF90O7y0lA
         ao4A9TFH9j+QXQDElIMC4Cr62774B19N2UDy2eBKsfLBbIO6hDLFF02j09mKUXCYBMlC
         bVDWWwlaK2mYob9FSDvIXqRs9bGEYSSSyo0hXr4NtekrpgBZJNbCYxmHE0IajzD+UPAS
         F8oEek2l0OorvEmKfzxps9sWTQvBQfyIi875yY5oEi8nZjlNIlJKxnm5zXFKj5w1nvRE
         qvZqRm1hMSKf3wkTe3A/sU23Ig+ZY2aRH04xPGYM/0cO4RhrML2gUJlLRvF0NnoMj47w
         XvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585190; x=1687177190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTDs5T5uCBqEAuJsK/qWf1YHHB6qWweCx58+58dFY6M=;
        b=WSxqB94IX2ZUUzkrSK2bHJ7McLk7ATWFYDaXsyiY92lqO2rmW4nwaP869oLl/wy8SA
         Bx+nLvGzZiv143HJFKP+GnfTb0ZhkC65QG/bvVAyQslSc0LAMVxizcNSPX2xZ4IUqHMR
         8J+2J51Hw+XB6o9pdH/76lfQI0u+KJSbnT68xvn3TfpVPTu/SM1ZkGPILbne+jmcEYrz
         tchwM/hSOEwvJk42S+JUCl5KrMwXAHRMzfJl6mlwK+5WqiqcWxsd0NQDDapYtNxNpz3j
         Efp0mbMQpw7r3eTapiiR1xYi5OKw09NqqfdjmoL2aprrsa0w2nbSb9ONBhf2zXzKyaaa
         O+5g==
X-Gm-Message-State: AC+VfDwj/BzEXpgtwmakX2zMsE9VUQHfI2wm9gmfVYSsfEjyaLmRsTAy
        HgNR2jx2H59nOoXr0WbaZ5+CBbzECyTYnA==
X-Google-Smtp-Source: ACHHUZ7QrfT/5BEmdGjiycLsgUYp3379mFZ57nb3ewc71UgOq/XL5au1ti4PjtbZ4KAqOFZko4dcsg==
X-Received: by 2002:ac2:5dfa:0:b0:4f1:36fb:7535 with SMTP id z26-20020ac25dfa000000b004f136fb7535mr1901973lfq.68.1684585190237;
        Sat, 20 May 2023 05:19:50 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b004edafe3f8dbsm260303lfc.11.2023.05.20.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:49 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: qcom: msm8226: Add IMEM node
Date:   Sat, 20 May 2023 15:19:33 +0300
Message-Id: <20230520121933.15533-5-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables userspace to signal the bootloader to go into the
bootloader or recovery mode.

The magic values can be found in both the downstream kernel and the LK
kernel (bootloader).

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
Changes in v2:
  - Always enable IMEM node
  - Move reboot-mode magic numbers to platform,
    those should be always the same
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 8644540f5aae..284b7c666fea 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -641,6 +641,20 @@ smd-edge {
 				label = "lpass";
 			};
 		};
+
+		sram@fe805000 {
+			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
+			reg = <0xfe805000 0x1000>;
+
+			reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x65c>;
+
+				mode-bootloader = <0x77665500>;
+				mode-normal     = <0x77665501>;
+				mode-recovery   = <0x77665502>;
+			};
+		};
 	};
 
 	timer {
-- 
2.34.1

