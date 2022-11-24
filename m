Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB0636ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKXAR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:17:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231B19C3D;
        Wed, 23 Nov 2022 16:17:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s8so190789lfc.8;
        Wed, 23 Nov 2022 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYsSNCXWhpFs7o4x2IkqFxSQUbarPP9Op1/XKXYtDBY=;
        b=mO8gD1Uq4kFyJckqBAStesA4EMzaLVQ9SgJ0grZsFpjIsTvd02FQAgKAxa9v6/u+CF
         BN6XSSaPVq+OoDOnEVtxg0sEoV48DSp/2fgD9+GLjxNSEDWCP+L+tk9XhZHll1ZAPPTf
         8uVGsIL07M26DlMzU1u53ta1rYqKeHlLOvfIMCNfY3N42+nZLmC0nUUHtXOWBjLpuKYK
         YuFzTrHTbKF+8wlto5dYW5HeeifxP+WZdN2C+hERORQOem13X83mU/wJ1EHzIKAsp2Iy
         l2G1hMj/d8M/oWvk/hcC45WS1wFNufg3xnZe9PKolAiwobxkVFM4UDO5VmOU5vnrKRDy
         SIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYsSNCXWhpFs7o4x2IkqFxSQUbarPP9Op1/XKXYtDBY=;
        b=L5vi2K3drPOEJOuGDvMuEpbN/slvmcyhsw1S+wKExfDvsE+zHPKljV/7zfDYNRYm2p
         snRXeJKWhZdd+fZjQHkvGql+mTZNZm073B/JqIiZVGyQigU/Ig/bP9t/ijnUC6Hmc9pe
         tzg2u/OzB/tJtgEXiPeien8UuiZwslU7/1ZX1eSeFws1aMRz9oHZ0UzTEabmSF40wQXw
         f/FzS0yCYE/tRiJmk0/PUR1a0PAufQkqkowu8qINkkzvTD681YrF7nAzGr9Cjh4WMUZN
         ajETd3SujO1QKzycOzpipKJ5OZlTW8gu5fQnKITBmZCFTuCtZuyL0kWqzXQk6HWUUocK
         bz1g==
X-Gm-Message-State: ANoB5pkukmpZK5QPRLaoTu+/MJV7yRfMoYkQ594QwNZqhSJBpE9tGqaD
        kC5S0WvG5cUmV3i24ebX95+edJbl/Hg=
X-Google-Smtp-Source: AA0mqf7qCd7dpkyoK6YOZrAt8Il3y3aOCsCuSaTgXZRgDwiIVGU+E0Q3JF+W1YU83f5PZvHiHOSe9Q==
X-Received: by 2002:a05:6512:c09:b0:4ac:2fae:8a9e with SMTP id z9-20020a0565120c0900b004ac2fae8a9emr9855039lfu.413.1669249067646;
        Wed, 23 Nov 2022 16:17:47 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id p8-20020a19f008000000b004ac980a1ba1sm3054388lfc.24.2022.11.23.16.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:17:47 -0800 (PST)
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
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add SM6115 MDSS/DPU support
Date:   Thu, 24 Nov 2022 01:16:30 +0100
Message-Id: <20221124001708.25720-1-a39.skl@gmail.com>
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

This patch series add support for MDSS and DPU block found on SM6115.
These patches were tested on Xiaomi Redmi 9T smartphone.

Changes since v1
================
1. Adjusted YAMLs per requests.
2. Changed MDP regs to lowercase hex.
3. Rebased series over latest next and SM8450 patches.

Adam Skladowski (2):
  dt-bindings: display/msm: add support for SM6115
  drm/msm/disp/dpu1: add support for display on SM6115

 .../bindings/display/msm/qcom,sm6115-dpu.yaml |  94 +++++++++
 .../display/msm/qcom,sm6115-mdss.yaml         | 182 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  87 +++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                |   5 +
 6 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml

-- 
2.25.1

