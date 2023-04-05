Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBAA6D8295
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjDEPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbjDEPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:51:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC172B3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:50:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so47219306lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709855;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=va5MRDxVuFu6eUzgi939YwiVuVG9aH1QEsbzq9XOm98=;
        b=n75UKJQoNNNzYwLEHLfZ5sbeTrveWKjTakws0xmWE2JuXDLmX5n8AghdMT9pIIVAEP
         r6wZrcRE5NDid+LCzcqu4P6NibJiUhOHVFbnHLxyXQwFGj39ANiv4RRvkAwqT4Kdsf4F
         2H2F5fxALi54LdtZQBUhuzRCRzL8hB9LrExixhaHOhoU52w3x0iOxwaTTFDjudTAb+fG
         aHSffNbV09Yxiak032f1pq8kj7v2AfPvRDrZ391WtWVqM0JYkCdgMl7I6Oiz+9VPmiTr
         4bwT2jTrEEBXYfqTSgvoSzGfD00y7iGLrlyxBsTHX1EVcAl4gZzhebMcx1AMOo92Ze9B
         QvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709855;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=va5MRDxVuFu6eUzgi939YwiVuVG9aH1QEsbzq9XOm98=;
        b=B8RW3VJ8TSGEyunMVOZuy8ukqKQMCjh3Qj+ds5tQM7odQAUNNE4uSgc0eNhoYnGJfm
         krYn/2ETHYMny/rObKdI0KONbNYLEC/V7L3aMW1a/3If45m5rXkKK3MnPdboB66WycFU
         co08bzWEwd/gxtNvjMCbvMsfEjzQC3NRWC9ZlcaNdogIfvv5b6DekcJVCBmhOLAc2IrO
         uF0ZtMT5kQa7o8ESUp+9QaEcDdm9Fjx1EdVJ8apd/KJ1ZppodXMoXFTjh0qOIaWC54xZ
         +ihgIk6D3oINxavDybc8AWexQUzq7iHRm4m22U9LByAQTR6Lg1ZwXzEj7v6TyCRnSD3k
         bEKA==
X-Gm-Message-State: AAQBX9dzLM+eWJGLx5Ybatfu++gu2bvDWTOk82b9V7IbFRZ+36qpqwJ0
        WpBuXkEZgyrBW570a7adUsCHsA==
X-Google-Smtp-Source: AKy350Yj9SAzmkKn0xk8l8lX+Eo7ub1/dwwsT3hbSPTwD4FZmTXC1t5jq0YHdU9K+bCjQ2gWUz9XyQ==
X-Received: by 2002:a19:700b:0:b0:4e9:74a8:134c with SMTP id h11-20020a19700b000000b004e974a8134cmr1404797lfc.43.1680709855419;
        Wed, 05 Apr 2023 08:50:55 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id o28-20020ac2495c000000b004eb2db994e7sm2869344lfi.239.2023.04.05.08.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:50:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/5] RB1 + QCM2290 support
Date:   Wed, 05 Apr 2023 17:50:29 +0200
Message-Id: <20230403-topic-rb1_qcm-v2-0-dae06f8830dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWYLWQC/3WNQQ6CMBBFr2JmbU0pBKor72GImakVJsEWp0g0h
 Ltb2bt8L/n/LZC8sE9w2i0gfubEMWQw+x24HkPnFd8yg9Gm1JUu1RRHdkqouD7dQzUWrTU1lRX
 VkDeEySsSDK7Pq/AahixH8Xd+b5FLm7nnNEX5bM25+Nl/93OhtHJoqyPVhlA354EDSjxE6aBd1
 /ULKzpIS8AAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680709854; l=2336;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RJldwKTK4D0B/0AUI1O8Eofso4ljGxQhg+FQT9W7K3U=;
 b=mtFqbfhln8ap48BvCWZY1W4VHaDMlAqpLNxlbgcifpdCewMorsYyRYQQkNBiQBQjNblIAYnVSnz/
 lTWKyYteDQn5Wif4d2trphpVv+F+hDed/0kWWwIPmr9LKnVtYbrf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Fix missing newline in pm2250.dtsi
- Use an enum in [2/5] to allow for more QRB2210 boards
- Squash the dt patches into one per SoC, PMIC and board
- pick up rb on [1/5]

v1: https://lore.kernel.org/r/20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org

This series brings basic support for the Qualcomm Robotics RB1 board,
including but not limited to:

- TSENS-connected thermal management
- USB2
- eMMC (uSD depends requires regulators to work, will be sent separately)
- the necessary plumbing for *DSP + Wi-Fi (that also needs regulators)
- buttons

A compatible in the SCM C driver is not added on purpose, as:
1. it's not neccessary before we figure out disabling rpmcc, the dt
   part is in regardless (the clock it consumes is always-on today)
2. a point to get rid of SoC-specific compatibles in there was raised

See also:
https://www.thundercomm.com/product/qualcomm-robotics-rb1-platform/
https://www.qualcomm.com/products/internet-of-things/industrial/industrial-automation/qualcomm-robotics-rb1-platform

Dependencies:
- https://lore.kernel.org/linux-arm-msm/20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org/
- https://lore.kernel.org/linux-arm-msm/20230315183231.3562580-1-konrad.dybcio@linaro.org/
- https://lore.kernel.org/linux-arm-msm/20230323173019.3706069-1-dianders@chromium.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      dt-bindings: firmware: document Qualcomm QCM2290 SCM
      dt-bindings: arm: qcom: Add QRB2210/QCM2290 and RB1 board
      arm64: dts: qcom: Add initial QCM2290 device tree
      arm64: dts: qcom: Add initial PM2250 device tree
      arm64: dts: qcom: Add initial QTI RB1 device tree

 Documentation/devicetree/bindings/arm/qcom.yaml    |    9 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/pm2250.dtsi               |   63 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 1561 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  112 ++
 6 files changed, 1749 insertions(+)
---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230403-topic-rb1_qcm-78a8826b34b6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

