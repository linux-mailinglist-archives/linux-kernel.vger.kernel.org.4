Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C565C77A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjACT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbjACTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:25:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E915F04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:24:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso14125952wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlV4V45c8yMejAxcwXlspx6FmQAhAXfePv/niq6cvW4=;
        b=iW0tP6U4j8zgaSNJR/QyYhQ0apHiuAPd3YuC03zfUnpZt1soz3oSRiT5t/9qvvbAQJ
         jZzibiFZzxGJq5eMeJP76Os9+ULSBNE6S8dQfxNZURGt4rNF4v88iU+dESwbRuzuCeIC
         DVcQHQoeGbW3OZecfJR3Yy0UPIMHn4HrcO3KDkYCsMdscYe0ixMSfx2QlloyTzcZT1Sr
         LXXNmMrPM+rE2Yjf6WCHOZFmneu18WbIznqKRyjUlSm/0+pgxifIuLEj/jvxv70EGGfP
         dDUV6H/3yptyj4wJ9dubtbOtqQ9ZJePh61hchuhiJnEMLG8JvzG/9MFECClVuHjKBStA
         u9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlV4V45c8yMejAxcwXlspx6FmQAhAXfePv/niq6cvW4=;
        b=mKVuou2ZFIQLSTez0Y4JobPPtgWG4nxLqSbQRz/2EO+YBE9q1lTB92+XnlbshQ2A/c
         yNkIHE24DSg0oq1U6e4CMwcS2o8ohV2znSpIQUWlTBZbxa8yQA+TyBWtSqunlnC7qjXk
         d0kozf0QHBfAWjOfd+yGF91Ddh+01mMIfYBQcJb7oXVWGLwzDNmhJX9fQR5Spib12mSV
         M6LZn8i7v3bkHP57FzeDcWCG42bSnKkeDRqsgpwSlHseU/bsAOMKZAJuqCLavSGHC5i/
         0O/1G3K5yQu5slRpU4Ih/GUH8MRRCj9yogKiWhewjc22XHtAL3HYOxrYKWK54eFHGtN0
         VYpw==
X-Gm-Message-State: AFqh2kpicziAKSTVfHFB0JmMP5hkN6Pdo3xjDbzB1l28ZCgISQZhWJ+m
        kk7qJSQwEc83KqbUMrFvrRU0RA==
X-Google-Smtp-Source: AMrXdXv9pnniyNCaYeT4Q5DpMz2ZntS6fOSyLoxon5RWiXAwUs32eND58KJnn1MtAwcLhKWmAtlung==
X-Received: by 2002:a05:600c:b92:b0:3d9:779e:9788 with SMTP id fl18-20020a05600c0b9200b003d9779e9788mr22825631wmb.37.1672773847836;
        Tue, 03 Jan 2023 11:24:07 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm70803660wms.2.2023.01.03.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:24:07 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 0/4] clk: qcom: Add support for SM8550
Date:   Tue,  3 Jan 2023 21:21:54 +0200
Message-Id: <20230103192158.1155197-1-abel.vesa@linaro.org>
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

This patchset adds more clocks support for the Qualcomm SM8550 SoC,
It adds the TCSR clock controller driver and the rpmh clocks.

Changes since v7:
 * dropped the first patch which was adding the RPMH_CXO_PAD_CLK and
   RPMH_CXO_PAD_CLK_A IDs
 * dropped the fixed factor divider clocks from RMPh CC, since the
   dividers will be added in devicetree as child nodes of the RPMh CC node.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (4):
  dt-bindings: clock: Add SM8550 TCSR CC clocks
  dt-bindings: clock: Add RPMHCC for SM8550
  clk: qcom: rpmh: Add support for SM8550 rpmh clocks
  clk: qcom: Add TCSR clock driver for SM8550

 .../bindings/clock/qcom,rpmhcc.yaml           |   1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml      |  55 +++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clk-rpmh.c                   |  36 ++++
 drivers/clk/qcom/tcsrcc-sm8550.c              | 192 ++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-tcsr.h  |  18 ++
 7 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h

-- 
2.34.1

