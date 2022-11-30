Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407863E157
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiK3ULJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiK3UKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:10:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C99492B;
        Wed, 30 Nov 2022 12:09:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so28632833lfu.11;
        Wed, 30 Nov 2022 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sc8kO01GqDD6/HcwuanEhTRskd8di+x6+a0ibeX+dww=;
        b=Z0mrGYbObj/vsr0YdYm78sVKlrPMXeltJNT55AdG4euBqwQdCO3M/pUiHQjiKtaARD
         J4m34uHhVfZAz/Zn3rN2UjuyzApZ8cHFf+OUM0SCwA2pgtNb1xniLibNUBvd6SnUPQKG
         cGGS+0Fuva7LwMN52YkrdxU8p9BEq59tTEYxuQ7YwdDpRUPavnFgXU5e8V9R1dJARxrX
         doAbU1IaRXm5zvBiulRtILWHuPBEy+qsyIuAvUYUmRn4kFAWLxOKhThskb7FhnYul9nG
         mf8pTGEKVxvtrwRMw3c0cjd6Me3KLiB90xGMU9nu8aOCk0ZM7DYCtkImyQG190YJUfrD
         8Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sc8kO01GqDD6/HcwuanEhTRskd8di+x6+a0ibeX+dww=;
        b=zIkmPphconLzYQqCCMMtpnULup/UyaWFK2wHgNauOFmDWz5KQVSeUGDR5Ybr4BJPV8
         DCRkqd2Out2taALxVOuJGfbC6IrnVaWYkRy+PT/bBVnE4O8d83arSV/AS/eIDkgmBc7b
         wx3XPmGL6M69/p+eaLq40QZ+FErYMSLPaHze3jmahGjOlcq+z88DbMA2lD2/Kry+ESVJ
         A7IGj4yN/zD+nwZwtvwA8d9hpI4kTp7CuqU0q8D+rH3cfzKvcpQFfHLjWl3VbYx8QnSH
         flYYJF6fAaLzK1CpwAnRdlZoupUAxE0A1CKwFCiRBX7o+jiuoIbVcmdCYa1aWhAQpccZ
         oLeA==
X-Gm-Message-State: ANoB5pmIZjweuJ6MD46uivZFDzLwfkWOjbmclbxTgQ4klHwi8VFWQZ9l
        pv+nLxDFnJBG9zMSrkxg6b2FVi0xFrc=
X-Google-Smtp-Source: AA0mqf7Nbyfq13CmWJAE4fQKtqOHUvwnOR4hNGvsQdiey5liE4mjym5n+HRpj5svMExCq8coX+7Riw==
X-Received: by 2002:a19:2d52:0:b0:4b1:dc42:6f85 with SMTP id t18-20020a192d52000000b004b1dc426f85mr20158596lft.568.1669838996495;
        Wed, 30 Nov 2022 12:09:56 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:09:56 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 00/12] SM6115 DTS changes
Date:   Wed, 30 Nov 2022 21:09:38 +0100
Message-Id: <20221130200950.144618-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds bunch of new nodes
also it fixes some small nitpicks in yamls and adds compatible.

Changes since v1
================
1. Changed title for mdss yaml patch
2. Added missing dmas to spi0
3. Wired freq domains to CPUs
4. Added R-b/Ack tags
5. Reworded smmu dts patch

Adam Skladowski (12):
  dt-bindings: display: msm: Rename mdss node name in example
  dt-bindings: thermal: tsens: Add SM6115 compatible
  arm64: dts: qcom: sm6115: Add cpufreq-hw support
  arm64: dts: qcom: sm6115: Add TSENS node
  arm64: dts: qcom: sm6115: Add PRNG node
  arm64: dts: qcom: sm6115: Add rpm-stats node
  arm64: dts: qcom: sm6115: Add dispcc node
  arm64: dts: qcom: sm6115: Add mdss/dpu node
  arm64: dts: qcom: sm6115: Add GPI DMA
  arm64: dts: qcom: sm6115: Add i2c/spi nodes
  arm64: dts: qcom: sm6115: Add WCN node.
  arm64: dts: qcom: sm6115: Add smmu fallback to qcom generic compatible

 .../display/msm/qcom,qcm2290-mdss.yaml        |   2 +-
 .../display/msm/qcom,sm6115-mdss.yaml         |   2 +-
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 573 +++++++++++++++++-
 4 files changed, 575 insertions(+), 3 deletions(-)

-- 
2.25.1

