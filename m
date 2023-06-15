Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FE7323D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjFOXq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFOXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:46:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B04296E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:46:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b4544200dcso415761fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686872778; x=1689464778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSmSYkeq+QNcZQ7h8FW75deWm/CDvZRtWyO4MTWmeIk=;
        b=NLfcD8fqHiliXE/BMbuQEW4m9tLQzhH/jJ9uQ7w/z8TkQFHxvlrtS4zaj+RcrTZJyq
         HtYrwbtrW3SVXth+g3CozCwYakIhmLQ7zeefXedsa/+cahWf5nlgxtPI3iMvtmQRuefz
         YoIjg4JSp1LRwP2tBDQ9ux1AS4v3FXDBY0K8T4i44bJDAS0DyE3+L++0y1hXKW6v6FzR
         qJIA7HaurBB9VA1VnvuDPa4putqP4mwYvcxid0W15EIgTuLkW7KcUoCo4vx65Vl+dvIE
         jVBOzk30J2Q4FuLN+OD7afnOyI75hEGgbZ3OVQ5YVxfAbKhBMWqEJMSEDjQkTEjSx0Sp
         ++pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872778; x=1689464778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSmSYkeq+QNcZQ7h8FW75deWm/CDvZRtWyO4MTWmeIk=;
        b=apDX6/hJhH4M+4TYrfBe8SiVzqRUpcSuU3RnCGPTotk5GvnXBMTjqdPI0fuNU9aEAD
         lWEi9yHJHk5zNzgEtVFqrVMUhTY4jZm97EEMpS6NiJzDSrBGDFAvPET/Ee0BUGiyEYj2
         xC8jzZ2Mh414FaXsea+pyrTGg1ef5LUrf/6+swGxgBI2peN4pE+88dX8JP4mzrJHD6Ca
         v6yzIEh8CV8DkSFNAIe1tOP4nLqFmRAcufjIxDD14caIOPNfoA6yjDNECplwMaFcXfG4
         rk+0vBPhIgpRgGMmVXbFbQ1ekG7URs5Z0JocqFckVaR/6QdeK5Y66LzIpz1cdjNOU5KF
         jLHw==
X-Gm-Message-State: AC+VfDwdU/pAc3j3obOY+twUietaYoE7i306KZb1dPTccv8cPe58zBHQ
        Cn8AYS/iCdY8m9AsyP96eWYkBg==
X-Google-Smtp-Source: ACHHUZ4XsUbmUKnRxW2zlp21UO1PTkx/Pup2CEYgq1AcMTbWpRmE3jkIsEUHw5pglRHBXE2EYh1F2Q==
X-Received: by 2002:a2e:9297:0:b0:2b3:451c:5998 with SMTP id d23-20020a2e9297000000b002b3451c5998mr572190ljh.18.1686872777858;
        Thu, 15 Jun 2023 16:46:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y16-20020a05651c021000b002ac82a995fcsm3344596ljn.23.2023.06.15.16.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:46:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] SC7180 BWMONs
Date:   Fri, 16 Jun 2023 01:46:08 +0200
Message-Id: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCii2QC/x2N0QrCMAwAf2Xk2UA7pTp/RYa0WXSBmY5GN2Hs3
 y0+3sFxGxgXYYNrs0HhRUyyVvCHBmiM+mSUoTK0rj264AO+8yyERmd/cfe0vrIaUtcNiRwFOkW
 oZYrGmEpUGmurn2mqci78kO9/dev3/Qe5+PtDegAAAA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686872776; l=792;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kNYhWdb44I3voqaX2T/WN7kLO+5rpettsuRmGA3+XnY=;
 b=YOtAevNgRb65QMjUw+sro0h2INGn0CtITRqFMUr0KJhjjYB4kMR/MHTnWR5w+RP5f0YyrDM8i
 uhdGVFwtNpsCeo5ocL1EX9mri6RaYwVD8U6cycloep/preez+9QLS2A
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

SC7180 has been using static DDR votes for the longest time. Time to
switch to BWMON (which accidentally results in up to 50% perf gains in
glmark2)!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interconnect: qcom,bwmon: Document SC7180 BWMONs
      arm64: dts: qcom: sc7180: Hook up BWMONs

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   2 +
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi          |  10 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 161 +++++++++++++++------
 3 files changed, 126 insertions(+), 47 deletions(-)
---
base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
change-id: 20230616-topic-sc7180_bwmons-c99dbc0c6c4a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

