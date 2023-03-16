Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7426BD1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCPONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCPOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C54D62F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b10so1872054ljr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975980;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkFEog4APZRdHeT2q4GaSqDGIc5SgyK33RTmMqwtReY=;
        b=kFMBNcVnPi6z72HcIvse712jYOKaSucHb0BKbGJfosXlFmHctGwtfcwg+7AnMcdk/S
         eOaMg1ccm4YROtE89oJsvhbm+5ZALTcfjY6u0No94VX/HGzHIv5XknXvZ/OBKDjBWkii
         Xy76YkaBWke139YAK4y/ZCZCZTZ+5YcEFEgX4vYpTEJIlq4T3V5FwAN+IPdXtcsJaj9R
         P4ED9TzLkci6fiFRzFZCLxZPGs2m26fbIl7w4nYyVgNAVqyE+4Nsq8hrZEUAeaawyDU9
         5NyssS6Wsg2rA1TnJAzr88XFkh9nLDJOG/kxEWgsL4OXYt+AK7SqScnwZAUZ6iD32kz1
         +84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975980;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkFEog4APZRdHeT2q4GaSqDGIc5SgyK33RTmMqwtReY=;
        b=E2UrnkBDPlALulMMJuJShe0fabrvRRr7C7gAgWs1Gyxh/GI0iyYSCYbMZw1EXy9dp4
         n3uJtST4CWSuLlwiOoCUubKAmNOwkgn0niYFd1W3RCfSaRdKFTbx7Cef1obj162qeY6I
         2Ef75sI5ASsmZOW6f/2uCaBNMjT9Q9Ywm5l4BsNGelR/oHXvECfrLgMvBWXy84pys8AI
         F75mLOOXjnKvVJA/JE8tlfhLzrYFPcdbS3J8rW8i6BIr6QdBHYR635XnpVN/RcPiJw85
         VEdLligH9ZUBL5qP0b3gqXAnh6ivb9LwDPMefsHYVqag8kM2Dz19N9P5tdFQY/+zWENZ
         FYWg==
X-Gm-Message-State: AO0yUKVSmvjQfmCFE1mAnq1v54LjnPaFVDB3PE8M01J3v/3sZCf0tjRU
        aH+SSQVY5+LN1hshDYu+ynQFyw==
X-Google-Smtp-Source: AK7set+EQ7JhP/5dKR8j1Cl9Eas3CNLuBDSy5ysOErliFuBvLjMMtZcOUp7SKZatRaQkZWKc1Ga+JA==
X-Received: by 2002:a2e:9402:0:b0:298:97d7:8fc3 with SMTP id i2-20020a2e9402000000b0029897d78fc3mr2205383ljh.4.1678975979734;
        Thu, 16 Mar 2023 07:12:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:12:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/14] SM6375 feature enablement (round one)
Date:   Thu, 16 Mar 2023 15:12:49 +0100
Message-Id: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIjE2QC/42OTQ6CMBCFr2K6tqb8iMWV9zCElHYKk2BLZoBoC
 He3cgLzVt9bfO9tgoEQWNxPmyBYkTGGBPn5JOxgQg8SXWKRq7xQKXKOE1rJr6q4XVsPZl4IWLV
 uZqkrVavSF5l2WiRBZxhkRybYISnCMo6pnAg8vo/FZ5N4QJ4jfY4Da/Zr/9paM6mkttrVpe9M5
 dVjxGAoXiL1otn3/QujVWdE2gAAAA==
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=2737;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RARjhqs3QRBTIsfJeubTjOqbRYf1ouM92C7DgsRRzD8=;
 b=yKm4H5uqTeUJhy5/okAPw6qEwM4lVp6yo4kzkK3Z5im1UmNWPD5bAqgfeFLSGDhOxCY7xFCvQly0
 aRbUzcZXANLqEShRIRatVISSA9vks4PEWnXREpxOHfiMjYtcb9HK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Reword CPUCP L3 commits to indicate that CPUCP != the L3 scaler within
- Pick up tags
- Drop the MPM introduction as we work on resolving RPM MSG RAM bindings

v1: https://lore.kernel.org/r/20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org

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
Konrad Dybcio (14):
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
      arm64: dts: qcom: sm6375: Bump CPU rail power collapse index
      arm64: dts: qcom: sm6375: Introduce C3 power state for both ARM clusters
      arm64: dts: qcom: sm6375-pdx225: Add volume down GPIO key

 .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |   1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  |  27 +
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 904 ++++++++++++++++++++-
 5 files changed, 926 insertions(+), 8 deletions(-)
---
base-commit: 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1
change-id: 20230303-topic-sm6375_features0_dts-860904f318d8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

