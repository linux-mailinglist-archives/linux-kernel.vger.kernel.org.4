Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513A872FC87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjFNLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjFNLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:35:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98C1BE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8289290e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742547; x=1689334547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8KZM/F5g0Sr267RV/S9m6olNEra+NdUFalrdFIdYQw=;
        b=mpHyDAKVCq1eVhSWEhGnB0BOvkUh9SqUoWX5vqdFyz/08za/0Kry77C1uqoGt6Mooy
         9cdAPXqJKe8/L+4dodWqztgVV2IOzBE6XqYvm+p5e7tFeCK9DFUoDLawsq/vnvCmoWdN
         UJtC4eNOrDh77MSP6QpXHLKjcnxpRjzehupP5GExHoEW4XESXbalNUAD67Ayp+MOrOu8
         WGu9B+dr+iC19o9jcU2tJtu0iOyQGDPWPXdVPP6KjufSvG5QAS+IapIugY7J0EOCtTqU
         kpHCqZSq9dtd7wO7s6vlhljcPoceRoDTMKCeDVH9T+wdLUmySory2NoWxy916uMCH7GF
         XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742547; x=1689334547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8KZM/F5g0Sr267RV/S9m6olNEra+NdUFalrdFIdYQw=;
        b=a4/x5GD/XAB5jNyEM6DnAdSHdrF5IQzmySkmjpRePR2uwwNe7fE5e/nHCMtEARUWeR
         b39zGbzlHZ5P7pAD09vq2ZZC1jW47tfsBdhFeNxVo6yAA/odnNyzq75Gv7gkaZ33+/mX
         eKgpAfGYy0AzzMWOFe06YR9GLZ6qR9/U2A1BWT2tV1lU521mkYLLVS8ogn5kSg+M3uPX
         5G5qMitwP6r3z4D91QsEC6l+TPUELK4UMBHonNkmYRPTYBd2uuNyEo9cJvWnLcdfUAL6
         TgQY441SrLiwmgBwAWkaQjPh74fr6TSt3NbcyXo6Xrt0PkZE+170cdkWuA7U8Hfgcon2
         4rqg==
X-Gm-Message-State: AC+VfDyus2WmQs+ObvWfa2UCjbNbQ5IBPujuOZ1AGCtPFk21XVSEo64T
        37KZVqDQ1ebcAtc/2/LmLEifWw==
X-Google-Smtp-Source: ACHHUZ7KXLv9kmJ+cdzMkqHWV+lomjVVpBW3xt6ULmH9+l9wsJjlmE0rldrrUDIzcGYfb8RLzy9B2Q==
X-Received: by 2002:a05:6512:32aa:b0:4f6:2e5c:de65 with SMTP id q10-20020a05651232aa00b004f62e5cde65mr7601565lfe.28.1686742547496;
        Wed, 14 Jun 2023 04:35:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:35:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/7] SM6350 GPU
Date:   Wed, 14 Jun 2023 13:35:31 +0200
Message-Id: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOmiWQC/32NWwqDMBAAryL5bopG+6BfvUeRstmucSFkQ6LSI
 t69qQfo5wwMs6pMiSmrW7WqRAtnllDAHCqFIwRHml+FlalNW7fNSU8SGbUHJxKeLs76igYsosU
 zWVUyC5m0TRBwLGGYvS8yJhr4vX8efeGR8yTps2+X5mf/HJZG1xouHVrCjnDAu+cASY6SnOq3b
 fsCrWAwX8YAAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=1513;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Zj6EKpI9LyjJLvwEHwqcCLEiQUgWc1gxPnuUuffY2/g=;
 b=REH0Yu7DJoufQBzafbTcHqja8hly3sLq7yU4EtTvyEhzgxq8NBvoWzl8NYb8tCbLsdhZ18DMC
 w8tIAtoHF9HAmmKgKM7XJ15oATMACRjPgEMqkd9qG59bVTRgDlQOPWG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the required nodes for SM6350's A619 and fix up its GPUCC
bindings.

This has been ready for like 1.5y now, time to finally merge it as
the display part will take some more time (due to the HW catalog rework).

Depends on (bindings, admittedly I could have organized it better):
https://lore.kernel.org/linux-arm-msm/20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org/#t

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- gpu_speed_bin@ -> gpu-speed-bin@ [3/5]
- Order GPU nodes properly [4/5]
- sort out the clock-names issue
- throw in the dpu patch, as the driver part has been finally merged
- pick up tags
- Link to v1: https://lore.kernel.org/r/20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org

---
Konrad Dybcio (7):
      clk: qcom: gpucc-sm6350: Introduce index-based clk lookup
      clk: qcom: gpucc-sm6350: Fix clock source names
      arm64: dts: qcom: sm6350: Add GPUCC node
      arm64: dts: qcom: sm6350: Add QFPROM node
      arm64: dts: qcom: sm6350: Add GPU nodes
      arm64: dts: qcom: sm6350: Fix ZAP region
      arm64: dts: qcom: sm6350: Add DPU1 nodes

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 394 ++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/gpucc-sm6350.c      |  18 +-
 2 files changed, 402 insertions(+), 10 deletions(-)
---
base-commit: b16049b21162bb649cdd8519642a35972b7910fe
change-id: 20230315-topic-lagoon_gpu-8c2abccbc6eb

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

