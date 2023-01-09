Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4D6621E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjAIJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjAIJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:44:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC22AF1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:44:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w1so7530956wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoqLzlWf2FVjBU4YmocAX609vh7FvzwfhcklcWz/0+g=;
        b=nLi4pEE/LCadghHKoliVTP5FbIefibSxeIvEJuEwqHogGr3WSTbpEMYAJ93W5S77cr
         FmP4rrx3vdh3nyDjITTAcVi8bp/Y0UeJFuNz1UDzaaN6LSbpOvVsAlY+mCujLE2aNueD
         nz1nrrFMq2pcZ5eHOrQBvp/nMm/ZzlIsw7TtclOgwLX9nYYh2pS5yuOs3Gvh3NIbXNw9
         B2cemAPitrmPdOvdEvd3pKHBa4en0FwQmgD0N2DgAncKPhgnBgVoDs1inL+CnfB8sWXX
         uV+nK1R+WVdStAet5CvY4xPePdHuO2Ymi7dqLffISOrost5Wy2i/BQwuHixzFymCySZT
         W1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoqLzlWf2FVjBU4YmocAX609vh7FvzwfhcklcWz/0+g=;
        b=EvP6r7zFwnqz0Mlk6krimVbgyIDASOznitEsSCfKtQg4z9/4fofz8Bg39fW54OqnAs
         pRHsGHCgqaBTk1tbP8+45Jz5La08VKz0vncF4S8W3SQGjMfBMvX7LXO/gpEBsnNQZGIY
         lQh1oUhIehGPMTYceUlUgRCqB5+pJ1MSxAkSvD3PNgfIvQ5Nk/ClKTtDrGJ9BD812UX8
         /6uAfmB8M/CEhuJUmDZLUQ2xeUnI9W2hDD3JRce70SRLLhiLvtvOZdM21Nn5XjhYeTc1
         sqjVEKm30N+ZZgNLTsHH+ZgFYU/yp/Vpu9SJY7uJOVQXenmp3Yc/Tx4TlWizWJhL3UtS
         uZgw==
X-Gm-Message-State: AFqh2krAqamE4jSPpLZdtthq5uFwBSenp2izhNlplHOrTaJwN6f5cbe9
        HCZeIMHsNBXQGQPToec+tI/VT76SNujWF0bb
X-Google-Smtp-Source: AMrXdXvMiR17IWkiGOkif1JXzzS+CHguer5+/C+as3oQcRy/A/7HkECuAeS1JI8LgoU8p8vmZ0BtWA==
X-Received: by 2002:a5d:4a4f:0:b0:2bb:f255:6bb4 with SMTP id v15-20020a5d4a4f000000b002bbf2556bb4mr1936397wrs.25.1673257452153;
        Mon, 09 Jan 2023 01:44:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm2965185wrw.91.2023.01.09.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:44:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] clk: qcom: Add DISPCC driver for SM8550
Date:   Mon, 09 Jan 2023 10:43:28 +0100
Message-Id: <20230103-topic-sm8550-upstream-dispcc-v2-0-786ddd8785a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMDhu2MC/42OQQ6CMBBFr0K6dkxbQIkr72FYtEOBSaBtpkA0h
 LtbOYGbn7y/eP/vIjkml8Sj2AW7jRIFn0FfCoGj8YMD6jILLXUplSxhCZEQ0tzUtYQ1poWdmaGj
 FBGhUsqWFeaQd5EV1iQHlo3HMUv8Ok25jOx6ep+brzbzSGkJ/DkvbOrX/rm2KZDQKNsj6pvVHT4
 n8obDNfAg2uM4vt4SrRjeAAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Display Clock Controller controller based on
downstream and upstream SM8450 driver.

To: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Removed clocks minItems
- Added Konrad's Reviewed-by on patch 2 & 3
- Switched to parent_hws & devm_pm_runtime_enable()
- Link to v1: https://lore.kernel.org/r/20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org

---
Neil Armstrong (3):
      dt-bindings: clock: document SM8550 DISPCC clock controller
      clk: qcom: clk-alpha-pll: define alias of LUCID OLE reset ops to EVO reset ops
      clk: qcom: add SM8550 DISPCC driver

 .../bindings/clock/qcom,sm8550-dispcc.yaml         |  105 ++
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    1 +
 drivers/clk/qcom/dispcc-sm8550.c                   | 1807 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-dispcc.h     |  101 ++
 6 files changed, 2024 insertions(+)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230103-topic-sm8550-upstream-dispcc-411b34c1b307

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
