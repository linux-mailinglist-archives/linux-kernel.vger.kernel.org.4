Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3F74166E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjF1QaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjF1Q3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:29:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1567268F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8383872e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687969787; x=1690561787;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv+nnH2B7s3Kiy0RTUWblii9XdXfwfCtrzuvTKHkpeU=;
        b=CZcejYtHPILXXQToUbqjBhLbjLUpOKCuKoNjV3bSegFYY/Vt0r+4lVQyemyBzgoo61
         uzPQZbDZituIdChBvflV0LBSBDeaUOuXp6uBD2Qcr8UJbCiePE+jfktc01SFzcVvzISL
         5HSX4oNYw3j9btjxkiIgqdSvqiirIKmIescYShQ3ODKkP1QyN7y1RLzovz8paKLEi4Xi
         uhKeJqliTAnLodjQuUlJOEuTdmL9qn1CcuxHcF/aBeXD+m9OrMMn3NfEzypldmpcHMcf
         DmOW5Q7Pl9zfbykk7J/Ij2f2g9K4x9QmWkJz+Wm9c3/r0RElF/lhxdV4akvGlTJEBuaI
         M11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969787; x=1690561787;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fv+nnH2B7s3Kiy0RTUWblii9XdXfwfCtrzuvTKHkpeU=;
        b=CjF6hgsSjBU/MoE9lgzpeT5upol9OPNDrqWrBzo05rVwcBfGYtIdVp/gS3xIt3NyGF
         sFuIOLvAwFjq3jxWc38dQQEMh9+Vi95gZu/Bo9Sv2R8b26xQkOxA0zyt6Iuf/sM0RnVt
         br2F4f/A9dFqwrOcDFJJbzSF33uj5BXgp3uY/Vlwe2ly3Du5ZoWSM7gcTXnn/lW2uvj3
         SzfqxmWC3HXtvUHF7UhpPDWM+SxqyFiu84wKZkaP1YpjDPz51v+y3MHYS66udSDXdACd
         yv9qTBlWupi275PHCSlWJGwNhyv6yNJ/8sq6BOBlKxbeQzI82IiYYFu53NSSHqWrmOON
         hc4w==
X-Gm-Message-State: AC+VfDzOo4X8sjVVnULUK0dT/i0Ti/8uVH9HxEWZFFZONR0sMTZ/Ga4C
        RcP88UaDt3iEkOyGvAHs75NpjQ==
X-Google-Smtp-Source: ACHHUZ7NMzvXP35Yr8l/CMTU4UY0aUmkhMEQ89vTtZYdjgV08nImSjfbvDaWNhHOfv1D56iCp3DsTw==
X-Received: by 2002:a05:6512:3b1e:b0:4fb:976f:c3ed with SMTP id f30-20020a0565123b1e00b004fb976fc3edmr344569lfv.69.1687969787104;
        Wed, 28 Jun 2023 09:29:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id v28-20020a056512049c00b004faeedbb29dsm1678783lfq.64.2023.06.28.09.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:29:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Qualcomm REFGEN regulator
Date:   Wed, 28 Jun 2023 18:29:44 +0200
Message-Id: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhfnGQC/x2NSwqEMBAFryK9tiGJv2GuIi6S2GqDtJLMiCDe3
 cZlFa94F2RKTBm+xQWJDs68iYItC4iLl5mQR2VwxlWmdR/8bTtHTDTNJGjrKZjQtc7aBjQJPhO
 G5CUuGsl/XVXuOubz/eiH+34AX5jDUHMAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687969785; l=1224;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UePCk4lk29C4m1NxcwF4mvfWHL33pC6ic/uMKeTErak=;
 b=1+YjJdCXaHWqHIJzXWRTL6yHKudHs5qrlQHXSCz/uTdOGv6PoEUPTid8RoPtf8Le0vRoEDv2Q
 ZjKIU6O+0BlD1xHOIUN3oFp4+RmQ4co4kDHo+em0s6u+S5NeeU/V8Qd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Qualcomm SoCs have a REFGEN (reference voltage generator) regulator
responsible for providing a reference voltage to some on-SoC IPs (like DSI
or PHYs). It can be turned off when unused to save power.

This series introduces the driver for it and lets the DSI driver
consume it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      dt-bindings: regulator: Describe Qualcomm REFGEN regulator
      regulator: Introduce Qualcomm REFGEN regulator driver
      dt-bindings: display/msm: dsi-controller-main: Allow refgen-supply
      drm/msm/dsi: Hook up refgen regulator

 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../regulator/qcom,sdm845-refgen-regulator.yaml    |  56 ++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |   2 +
 drivers/regulator/Kconfig                          |  10 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-refgen-regulator.c          | 187 +++++++++++++++++++++
 6 files changed, 260 insertions(+)
---
base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
change-id: 20230628-topic-refgen-14fb0b762115

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

