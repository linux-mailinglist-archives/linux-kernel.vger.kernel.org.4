Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7268B9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBFKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBFKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:17:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2420D03
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:17:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10389419wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECLgssVp2+bg2uFJklAasE7I/B347mZ8WaMyAeM0/jA=;
        b=hccyvptxNEdbZS2bFikl5YVsWsL9ysycwSeADpUl06MoB2uR6b9Fxgc/VD4sib2qNO
         AmtyrdLReL2DULKBTxMTc/yzOLCkxFogsmjWTdp+P5XQxjoHmnIaCljUsqHazPopv3zv
         a7YWUqZ1m/DoaXOfv7jOKcH0qnh6LKtUv2CQ6gjHA2C3bTtWwaOAxS1ZCsUI8cVelqq7
         TEkgaN5RpynBbg5AM69okYlVfX1jIpzkkIzlBnOnfwDnkwxE0hGdAR4DwulslX5axWId
         yNjoz8fccOmUOJnbdTcHoqJXnNT74cfPnJn4BVSNnSMNMAbflECWMgy4DgQs0UfnCMVo
         beAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECLgssVp2+bg2uFJklAasE7I/B347mZ8WaMyAeM0/jA=;
        b=vTeLcHQM9Z4e52aHCAVAD5c46Pc7XU9kZviSw0Mz3F/6sWZ+LoIvCYYhVw6ySOq9dE
         4ebiH5LYBlrcdRsGXvNplhrgDIBVC2HSBlxBcS3Wi/yNolWrn/mdTy+kxHrmiS8YK1ia
         u4WlcjMba2luK9/5G3aKbzYcF3JTZkrzVq8jW2VxFjZCFwPrVvP5aQvfgzFAnSlIhUU9
         1KWmP1vFZB40iVOXUu8wxWL/JS34hMlPxIDu12UPkJxSsB9vgf6+o/IzgaMuNgpQWhRD
         FIlugZa1MgxVtekPH6zmsOndqaGLLtaH98K7WG06bVGX7eERXfTRY/BdnJI/1shkB0XO
         RP/A==
X-Gm-Message-State: AO0yUKWqiuUSRKhiPoYdZCIa5xL0bO8z8cVqEEreOQQb8KXtT0zvCyYM
        9lEnIxID5OF/3i8KbhD9tFqy0bPSYxg/hYAn65s=
X-Google-Smtp-Source: AK7set9UcskWalsS526NI7k6oICy996A65UPdHGtRgLBl32BvJlhQmPMEkxrmg1d73XR3h35ORuOPQ==
X-Received: by 2002:a05:600c:5118:b0:3dc:1dc3:7a05 with SMTP id o24-20020a05600c511800b003dc1dc37a05mr18083029wms.10.1675678626774;
        Mon, 06 Feb 2023 02:17:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b003db0bb81b6asm11314201wmo.1.2023.02.06.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:17:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] arm64: dts: qcom: add DP Controller to SM8350 & SM8450
 DTS
Date:   Mon, 06 Feb 2023 11:17:03 +0100
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/T4GMC/x2NywrCMBAAf6Xs2YU1tlL8FfGQx2oDaRJ20yKU/
 rvB48xh5gBliazwGA4Q3qPGkjtcLwP4xeYPYwydwZC5kaE7tlKjR13ncSLcqjZhu2Ko6EtuUlJ
 iQUM0jdaZmQJDLzmrjE5s9ktv5S2lLqvwO37/6+frPH91MIoOigAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the QMP PHY to the newly documented USB3/DP Combo PHY
bindings at [1] and add the DP controller nodes.

The DP output is shared with the USB3 SuperSpeed lanes and is
usually connected to an USB-C port which Altmode is controlled
by the PMIC Glink infrastructure in discution at [2] & [3].

DT changes tying the DP controller to the USB-C port on the HDK
boards will be sent later.

Bindings dependencies at [1]

[1] https://lore.kernel.org/all/20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-1-ed849ae6b849@linaro.org/
[2] https://lore.kernel.org/all/20230201041853.1934355-1-quic_bjorande@quicinc.com/
[3] https://lore.kernel.org/all/20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (5):
      dt-bindings: display: msm: dp-controller: document SM8450 compatible
      arm64: dts: qcom: sm8350: switch to combo usb3/dp phy
      arm64: dts: qcom: sm8350: add dp controller
      arm64: dst: qcom: sm8450: switch to usb3/dp combo phy
      arm64: dst: qcom: sm8450: add dp controller

 .../bindings/display/msm/dp-controller.yaml        |   4 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 117 +++++++++++++++-----
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 118 ++++++++++++++++-----
 4 files changed, 190 insertions(+), 53 deletions(-)
---
base-commit: ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf
change-id: 20230206-topic-sm8450-upstream-dp-controller-20054ab280de

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

