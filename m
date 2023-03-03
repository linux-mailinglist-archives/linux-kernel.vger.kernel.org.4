Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C56AA556
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjCCXFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjCCXFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:05:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5379580F1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:05:04 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k14so5548248lfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677884700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zYQ3skwAEHOvompoY+3GuWuwGeQIAvA/EjO/BVgsgY=;
        b=rWNMruAitaay/YoO4XDoBh5dzMsSYwKaboldA0mYNRKzIi2ZrYvh9yLUHcL9Px0aQr
         1l/s6FsZVrP8F/BF5l0Zh4CgaOBwuWzb+8AOPXbkz8K30zIAowRL6yKLu7ur0pragxhE
         /N+OXHYAF2SSww2yNXAyAusVHGduCBSYsMm7rA+ToRELhoc2ovJZl+yQVzsOkdUuVFN/
         YbDaEBE0wcjVIfD7NbSEr78d8+ci+pumDevJeAExZR8uewIcm3s6EKXCeKR9/C+nWT7V
         LavhAuylSxye7u4aGbxTXCrrgHexYXklWKtXR59IPrI86vVYPb8hzEoCZ6cU4n+7KN7R
         D2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677884700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zYQ3skwAEHOvompoY+3GuWuwGeQIAvA/EjO/BVgsgY=;
        b=Dzj/xzeMa5u1NZL3PZqyNgr9DmJHozTmsMkQPk6VEo4mBPR0Lht6o549PSCk2YcI3x
         SXXC4vh3LsScSbHxqMjC0WM4pcmXfaiTOnoqxDg1VjGRGlJD76SoYdYuUNygvXPwsSQn
         HAePBrVN67H3d5Y1L0cQZjegyaG7yFVaaqc79gVmAXcGqLyHSfuClW4Tn596UNQdyfoH
         tP75Rw/DpgVJQ/BqGD2xqDVq95yU/znN0tmLbEXVc0n7Hc4VImDHl11dEVIa1OSoAqcj
         vRDXdVRz2XTwnzw/ZD8p4ZHs8dsBZ6B4z7A/soZlwx4MJgBl6M5Z8UmBwgSGc38/8gDb
         Ae5g==
X-Gm-Message-State: AO0yUKXBS6POiTNF/TOKwf6SexIw2QlEpnmpHrKNWbjL21wz3Xw+iMPk
        XpiuUMxLYj3PYXUxLjTSYS3QpSxSG3zQ1eum1z8=
X-Google-Smtp-Source: AK7set8f12aonoxUzlpGEG2/nm7YPQGB8a0NJgf3ypQXowEGKP9YToDW510dvym5GNm6WwC0V7JIng==
X-Received: by 2002:ac2:52a9:0:b0:4db:3877:8176 with SMTP id r9-20020ac252a9000000b004db38778176mr900653lfm.21.1677880691336;
        Fri, 03 Mar 2023 13:58:11 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:10 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/15] SM6375 feature enablement (round one)
Date:   Fri, 03 Mar 2023 22:58:00 +0100
Message-Id: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhtAmQC/x2NQQrCMBBFr1Jm7UDaaI1eRaSkycQO1LRkUhFK7
 +4gf/X+4r0dhAqTwL3ZodCHhZes0J4aCJPPL0KOytCZzhod1mXlgPLu7fUyJPJ1KyRmiFXQ9eZ
 mzsm2LjpQweiFcCw+h0kVeZtnPddCib//4uN5HD/Dhy8pgQAAAA==
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=2518;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Egy2VKD4mfvEIpdAdK5E3xwo2gNISIBJS/J9ay8jtsU=;
 b=bKfXxUIiQeHXAV25G6OFhYAItp7N3vMhcw90rjLkYsx3VPZGThfxL5ABmEIGmxzzKvtMZgwjFgsm
 AM4vEQLIDP2ZJh1YJY/iGdJ2pO/NHIswBEWmfW01nA5onFWp5u3N
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This series brings support for a couple of nice things on SM6375, namely:

* 2 TSENS controllers & associated thermal-zones
* RPM sleep stats
* IMEM
* WCN3990 Wi-Fi (Bluetooth doesn't wanna play ball yet)
* MPSS & RMTFS
* L3 scaling interconnect (not yet hooked up in this series, but it works,
  still assessing the best scaling configuration)
* MPM (big!; also implicitly fixes some interrupt lanes due to my earlier
  misunderstanding of the downstream MPM<->GIC mapping)
* Additional CPU sleep state (gated clock, power rail still on)
* V- key on the Xperia

It does *not* bring support for GPU, MDSS, icc and various other scaling
parts which are still in progress of being upstreamed.

More PDX225-specific patches, along with Wi-Fi enablement will come after
that. But hey, we already know it works great ;)

Tested on the only sm6375 device we support, the Xperia 10 IV (PDX225).

Depends on:
https://lore.kernel.org/lkml/20230109135647.339224-5-konrad.dybcio@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (15):
      dt-bindings: thermal: qcom-tsens: Add compatible for SM6375
      dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP compatible
      dt-bindings: sram: qcom,imem: document SM6375 IMEM
      arm64: dts: qcom: sm6375: Add RPM sleep stats
      arm64: dts: qcom: sm6375: Add IMEM
      arm64: dts: qcom: sm6375: Add RMTFS
      arm64: dts: qcom: sm6375: Add wifi node
      arm64: dts: qcom: sm6375: Add modem nodes
      arm64: dts: qcom: sm6375: Add CPUCP L3 node
      arm64: dts: qcom: sm6375: Add TSENS
      arm64: dts: qcom: sm6375: Configure TSENS thermal zones
      arm64: dts: qcom: sm6375: Introduce MPM support
      arm64: dts: qcom: sm6375: Bump CPU rail power collapse index
      arm64: dts: qcom: sm6375: Introduce C3 power state for both ARM clusters
      arm64: dts: qcom: sm6375-pdx225: Add volume down GPIO key

 .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |   1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  |  27 +
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 936 ++++++++++++++++++++-
 5 files changed, 952 insertions(+), 14 deletions(-)
---
base-commit: 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1
change-id: 20230303-topic-sm6375_features0_dts-860904f318d8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

