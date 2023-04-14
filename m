Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E56E21FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDNL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDNL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:26:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790E8A42
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:26:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i26so23290730lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471570; x=1684063570;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXayIhb48rpICvZhgV0WpLpWTGJfP5YGp0OUVXORCrU=;
        b=B+aAH7iwOvmQOPM5kAGyXrKGDpG3EgfK7vClDXgy1uEk2I98f/mWfScR07a1scB4fz
         NTjQ56u04nweoPFEM89XzKAkO3xZmFOcRFY0RbCaRTh2qSFhpId5RyZ/kmqSgNwJ0nNd
         QWp2sVBBuQYQaPb/BK3eWNhyNGrL0t86GFMYbQRQV5qFTOA9PhrRyMq9lBj7ZQAzJ7el
         NsGzuADabwE14EL52awSsYbyvUhMPCTuzucA4MH0vY/JKVdMdciB6hXkgRbEgyXPrXYs
         WBJrjGmnRIF4TNgqSRpo1086F9agmwjywSRuBZzdMIaDDKy1nuzBVPsQk2jve81DJhk8
         rONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471570; x=1684063570;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXayIhb48rpICvZhgV0WpLpWTGJfP5YGp0OUVXORCrU=;
        b=URqq7NFMNG30heVc9XE4ZdCbRhueNlrrULJ/oiLnsUR8eFtGr84XKvWaTcTWJdZTPa
         FxDRmrjVbVy9qy3mGG1PALZOC6cOOmtmP4gz9EL1LZlfHpRqrOsk9puqRm+UdLTPStsq
         10cLHhW2bCriCeYXRhrh2NxYw3kNQkmaF2P6tLrRP9hJHZgNzliHGHPyOofE9WDMiQ7F
         Ylq8GHcbfIpiA6q9cREEKsfdhBT2BYztU5Vomcp795IUaRUeObIBXBX8i+EPDat3+uk5
         qkFj/CUpVKmmIb/qoLW1By6ju/VfzfPJQAi7XJtIKCxRQzYXtyAmF/1qe/wpvEzo4qYt
         SVgw==
X-Gm-Message-State: AAQBX9deUBEbIWEDVrk7MKsgFVfCr0UmBaBR/lw/H/6bOcmzHtbMMGCk
        tTawcaJGUX83PsqKN0KbtFXLiA==
X-Google-Smtp-Source: AKy350YCD/gqeoFDnTa2Hdfa7XhbQnXeWkA78wnWZoK8ZEzi0mDfNEObzPujJARrty7gF92OloRWSQ==
X-Received: by 2002:ac2:5a4f:0:b0:4cb:4362:381d with SMTP id r15-20020ac25a4f000000b004cb4362381dmr2491545lfn.62.1681471570603;
        Fri, 14 Apr 2023 04:26:10 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id f2-20020a19ae02000000b004ecb06acbb3sm738430lfc.281.2023.04.14.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:26:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] SM8350 VIDEOCC
Date:   Fri, 14 Apr 2023 13:26:07 +0200
Message-Id: <20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE84OWQC/32NWwrCMBBFt1LybaR5FNEv9yFFJmnaDISkTGpQS
 vZu7AL8PPdyODvLjtBldut2Rq5gxhQbyFPHrIe4OI5TYyZ7qXotFN/SipYH8IARngUna7mxExi
 jL8OgJWumgey4IYjWNze+QmjjSm7G95F6jI095i3R5ygX8Vv/R4rgPRdKz1cjJQxG3UM7KZ0TL
 WystX4B1EoKpswAAAA=
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681471569; l=1143;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=b1Z8B5GLQvfM6ewcQNkW9peR5LT/DSelr7WkGl08+Z0=;
 b=76jbKqduayOAhCvGyK9OsQaZZi45ZFQ2hNbCxhFM+69mO3MOsGdnvnUZxZvpv9alD59wiz2tVLlt
 24W5MmekCF9GjBtxOpDEnBAyUBiHu0SjMYtWKN4qVMeF+JaFgpX2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
      dt-bindings: clock: qcom,videocc: Add SM8350
      clk: qcom: Introduce SM8350 VIDEOCC

 .../devicetree/bindings/clock/qcom,videocc.yaml    |  29 +-
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sm8350.c                  | 557 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    |  35 ++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    |  18 +
 6 files changed, 648 insertions(+), 1 deletion(-)
---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230413-topic-lahaina_vidcc-bcdabb475542

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

