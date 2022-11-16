Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2362B9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiKPKon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiKPKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8351B31DE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1131881wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEGX8N1eRH1kfOPrsjp9HiNHdLke63i0SVJR0giHrEg=;
        b=GOPXinDwaFNdA21SdKmuBb5qkVZ3rVKjip7cn0eOIcsKUMSBtPNnFsWSfQFcgS8Kd0
         3KDa78ncF7u0miEEp9uG6ke6oBv0ty+DosSrADhHWZXpEUFhuk5VA70OzOlGKJFzWIGE
         W96C5pXeQnG74GI3XEl40xbvUm863Y5LigrzSIOZAJeWJzb47VhzPahR9i1fzyZsJDfk
         2UA64Ezcf5eA9fN3WtHUG3sctdXgFNbTlEm6hARVIIEIcqXKH3quJxxARzxe7kAUspF3
         VHi/osDKGZv6byPbXBm/k6MHdX1ZYvhNtN1NrBCQZCESNNBANpcJ7ej2hl3vtw9FyFbK
         k3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEGX8N1eRH1kfOPrsjp9HiNHdLke63i0SVJR0giHrEg=;
        b=fqnLJ1MywicNkZ4tuIJ46OLGAphfplPvadbFwGkw/NwYbracTcO8VG/67mhiTSWAzJ
         ozXlb784dh0NLa2fWSmBma9PQdNw/kIyjHQC2Bm4Q0lkg6PEKND6aSiDHx5iBSz2zLMz
         ro6dYZIlarsb2dW/FZgYMgI61qjIxLXCHUabSqZfJAUTjkOJPfX3zscw9TWxtQ8utUIf
         7r8Vl3G6bXlxjBteN9ptysGu9zUp/XD0LfWgfHl2LteOD/2YQQwQJ3LF6NM96J7Ln9Pv
         GoWL3MfLNeCJoiUSoon1peAbWUwY0rFfcTVBdG3Dl04G0/MAs95Tbzrx5C1VTzZC8BAq
         p+3g==
X-Gm-Message-State: ANoB5pnDGL9tUx6pX5RJP71do7k7jkleBVMo93Pda6ElOAhLK3XykaV8
        O9/GJoY8Tj+CTOqt5CseScmGew==
X-Google-Smtp-Source: AA0mqf5UQe8/AMHmocW0EDK9+NsY4rpFlV6SNWdCpNrpV5lX8Vo4PPxyW0g5pKcbHq2LmyLfFxNMcg==
X-Received: by 2002:a05:600c:1c12:b0:3c6:d8ba:eeb5 with SMTP id j18-20020a05600c1c1200b003c6d8baeeb5mr1645738wms.201.1668594741091;
        Wed, 16 Nov 2022 02:32:21 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022e36c1113fsm15107032wrb.13.2022.11.16.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:32:20 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] Add base device tree files for SM8550
Date:   Wed, 16 Nov 2022 12:31:36 +0200
Message-Id: <20221116103146.2556846-1-abel.vesa@linaro.org>
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

This series adds the base device tree files and MTP board support
for the Qualcomm SM8550 SoC, including the clock, pinctrl, smmu,
regulators, interconnect, cpufreq, and qup nodes.

The SM8550 is the latest Qualcomm Mobile Platform.
See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (3):
  dt-bindings: arm: qcom: Document SM8550 SoC and boards
  arm64: dts: qcom: Add base SM8550 dtsi
  arm64: dts: qcom: Add base SM8550 MTP dts

Neil Armstrong (7):
  arm64: dts: qcom: Add pm8010 pmic dtsi
  arm64: dts: qcom: Add PM8550 pmic dtsi
  arm64: dts: qcom: Add PM8550b pmic dtsi
  arm64: dts: qcom: Add PM8550ve pmic dtsi
  arm64: dts: qcom: Add PM8550vs pmic dtsi
  arm64: dts: qcom: Add PMK8550 pmic dtsi
  arm64: dts: qcom: Add PMR735d pmic dtsi

 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/pm8010.dtsi          |   84 +
 arch/arm64/boot/dts/qcom/pm8550.dtsi          |   59 +
 arch/arm64/boot/dts/qcom/pm8550b.dtsi         |   59 +
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi        |   59 +
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi        |  194 +
 arch/arm64/boot/dts/qcom/pmk8550.dtsi         |   54 +
 arch/arm64/boot/dts/qcom/pmr735d.dtsi         |  104 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  419 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 3986 +++++++++++++++++
 11 files changed, 5025 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550b.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550ve.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550vs.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmk8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmr735d.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550.dtsi

-- 
2.34.1

