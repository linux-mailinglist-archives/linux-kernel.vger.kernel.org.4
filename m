Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B136E9ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDTRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjDTRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:32:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F846A6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:32:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l15so3652748ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682011973; x=1684603973;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMu93c2gYoXnO7B9slEwJygFJeopiwqYcQo4P3f1t+8=;
        b=iOcSFGPT5NJMqkObNfENlnMWQuLzr8RN5hOMtxdkuzAlNCuVD2FzhRLMQfJHnD/rcL
         9vYI7APHo51IEmPTUGT9PWxkRFkt14t1iIm4ZTKCuRRTtByxzY8NUgGNU8iaE7qspKJO
         cJ9t75rLBwYhMeSNGlDJJgIsLCql7UQCEhGmSLxT2StD12AIJtomZy+GI+GHpMQm7/M7
         cWW8ZJO0A7o2r/4Jmeu1x96MVBHq1QzLRQK870r4N1jZdFLg0iA/8BNf/VK/YRxb7TMi
         lfhT1kzv0N2abbRC4Y43TryISMWJEtgnXDHZ9xU5+qOnM8t5lMojeoAKC+UCKnqofrFq
         +Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011973; x=1684603973;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMu93c2gYoXnO7B9slEwJygFJeopiwqYcQo4P3f1t+8=;
        b=i7pTRRMti4B0TVpG2KfyMYzqTobHZSTDzeVCNDKwu/ZXMUbZPT1L7OI8b2G1UdgxN/
         wqTWQsIy+G49QgifyL5uRcQCuLKM9htaPySv1N/Swo3PvI+usw5M7ibr0Oi+VJrZPT+i
         YKT61sIWIpfWqSuzZLUu+h3E4Bxke+9LVEjn9grWsrSitDzXSJY+ygRD363p2mVGVGcD
         6K8AMm1Rr4f0eR6P86ZIaBgh93qANBEcct5ZbO37hGfB5B4TwgUhkolI5vm0bAsAztHK
         yBT7CRji5rTmp6RKra8C7BQXpaGRgxqTPNvd7UECC4gA0FnWo/B+mZJ58JPLziy7EO1a
         76IA==
X-Gm-Message-State: AAQBX9fWeImM844AiIr/bBEar3plb9Nbg7IzTFJfNT7P9zewnT83uRc5
        VEorFzh3PZl81QfAjHx0a5u7kw==
X-Google-Smtp-Source: AKy350YCIvzoC3bQqiv88BMnSKxCl7YsUyoUIg1If3KsIYiPncBILvB5mXz90XG0MQbAiVWdugjCnw==
X-Received: by 2002:a05:651c:312:b0:2a9:7985:b2f5 with SMTP id a18-20020a05651c031200b002a97985b2f5mr1705522ljp.24.1682011973237;
        Thu, 20 Apr 2023 10:32:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id e22-20020a2e8ed6000000b002a8c1462ecbsm309597ljl.137.2023.04.20.10.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:32:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 0/2] SM8350 VIDEOCC
Date:   Thu, 20 Apr 2023 19:32:49 +0200
Message-Id: <20230413-topic-lahaina_vidcc-v4-0-86c714a66a81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEF3QWQC/43NTQrCMBAF4KtI1kbya6kr7yEiSZq2AyUpSQ1K6
 d2ddieCdPlmeN+bSfYJfCaXw0ySL5AhBgzqeCCuN6HzFBrMRDAhmeKSTnEERwfTGwjmUaBxjlr
 XGGtVpbUSBJvWZE9tMsH12A3PYcDjmHwLr23qdsfcQ55iem/Lha/X/yOFU0a5VG1thTDayuuAz
 xRPMXVkBYvYgQhE2krwRrPKa61/ELkDkYgwr5iqzrqt1TeyLMsHXkaHplYBAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682011971; l=1530;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=93PGuTesqpL9Pwcb1WJp1xK9V1diRq1o/c76V6de+NU=;
 b=ythZ0cYRp+yVZKrwisW/OSq+a6uSM+i7d5ETgnwQsvLfui6DeWGYKABlE3Yf43lH9+ay5jIDl7eU
 Vs9qZAFZAUXPBo6iysebo1QLgFiDr+5ymi1OHNoKskgLFDYIKNoV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
- pick up rb
- include qcom,gcc.yaml in the binding

v3: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org

v2 -> v3:
- Use a consistent VIDEO_CC_ prefix for resets
- Separate out the binding (and don't pick up the rb as a consequence)
- drop all pm_clks code

v2: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org

v1 -> v2:
- "){" -> ") {"
- subsys_initcall -> module_platform_driver
- constify lucid_5lpe_vco & .hw.init
- devm_add_action_or_reset -> devm_pm_runtime_enable

v1: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org

This serires brings support for SM8350 videocc and updates the
related dt-bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: clock: Add SM8350 VIDEOCC
      clk: qcom: Introduce SM8350 VIDEOCC

 .../bindings/clock/qcom,sm8350-videocc.yaml        |  68 +++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sm8350.c                  | 552 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    |  35 ++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    |  18 +
 6 files changed, 683 insertions(+)
---
base-commit: 67d5d9f013d6c3829383c08162939cabff14fccc
change-id: 20230413-topic-lahaina_vidcc-bcdabb475542

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

