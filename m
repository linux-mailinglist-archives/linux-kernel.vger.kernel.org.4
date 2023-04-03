Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D486D4F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjDCRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjDCRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6A0210C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x17so39121410lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543385;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgJjE+KvrFmAUSASYTKE46Q0Rh1x9INPUFBYXq75mYY=;
        b=nBX8sZqvPSn2BoLqUd21+B0CAXHZdTQ0ISH9Tcc73TxJxQPyv0AqgzoV2dQMkm3Bvi
         O3XD6pB+zaqy9VS2tzYJVWc6qACb9K4/KF9JRHU73iR2Nqa3WM+xlKkt3n3jhxgJcgMk
         exKrAL4Xc5Qnf/JgHz+n0elUBaX815aw9FzNJjCAghz2bY3jWnE2t/MioF94by5/NtPE
         XHJh3QiRyqvxvBanyH5F3BKMmmxwhbgL4/ZQ9EsM5Wrfn1st2WHOdBg1KptLB+aB2iYM
         cj2c5ocgfDzHW3IYcAqs3fJtWmElAZYPEamcEwzcXDWYxEvf3bdoLCr9II4u4sjrm9Gd
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543385;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgJjE+KvrFmAUSASYTKE46Q0Rh1x9INPUFBYXq75mYY=;
        b=rK5OZtA0ahwGsw3byQW+kLR5GyP7BlZ7FdNCVnYgz6FsHAMg4xgPmKVgnw9VJ6KWyD
         +Vy7iwA76WEwxuM0RCdudg4+5jgnsvz+r59zR8sMZjuSb2WmNTpd6RrYdLDHiFX656a+
         hC9lt7You5zEQtNKGo9Lhb/xiN+h0sFtcp5sYJs065a4ghPj5iUS5+r6I9nDBbGD8yjV
         sX9L3uS0cQQSrBxeNlsn9rJkFaX3OkT+IMGBPVEcH8LJ423TKWg6sBcaJbRrNLbhqYWn
         8zOd/HdhUJh8VBnyXOVs7ryAiGl8WIZzl5juEA0gQnssshAzcK9eYQ5NGnGBpEc2C10l
         SN/w==
X-Gm-Message-State: AAQBX9duvxNNpJEUnx7NanuPckc3TOkG4Q+bhlJAbL8kZf1SStkfi51W
        /bBEpDc1zlwc5y8t6Lj5azCqhw==
X-Google-Smtp-Source: AKy350bJXi16e3RU7z+3y153PGXst7YnIlzzbnKu4rGKbZ2jW0MjBgMeg2Fk0Y9DTYJYacDMfdJDdw==
X-Received: by 2002:ac2:592b:0:b0:4e9:9e45:3470 with SMTP id v11-20020ac2592b000000b004e99e453470mr9492416lfi.3.1680543385584;
        Mon, 03 Apr 2023 10:36:25 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/9] RB1 + QCM2290 support
Date:   Mon, 03 Apr 2023 19:35:58 +0200
Message-Id: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4OK2QC/x2N0QrCMAwAf2Xk2UDXjln8FZHRdNEFZjdTFWHs3
 w17vIPjNqiswhUuzQbKX6myFIP21ECeUnkwymgM3vngOhfwvaySUakdXvmJ55hi9D2FjnqwhlJ
 lJE0lT1aVzzybXJXv8jsm19u+/wFSZVRQdAAAAA==
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=2279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Oe8NOlqI6eJ+DsG/9HBWcEqSh9kVrB8UltmKWG7DjW4=;
 b=KETWvJB5B1cGRgGv6EoAEJegYxKMFx6xHznjKtlgvFvTQuslWNwkf5G4at9TQaf3wz3XUpTX50Kd
 Sd06EoJeCPz0VCyTDBMPw0UirD1i+FF17G8OpP6lhQ0tSyfGy/D6
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
Konrad Dybcio (9):
      dt-bindings: firmware: document Qualcomm QCM2290 SCM
      dt-bindings: arm: qcom: Add QRB2210/QCM2290 and RB1 board
      arm64: dts: qcom: Add initial QCM2290, PM2250 & RB1 device trees
      arm64: dts: qcom: qcm2290: Add most QUPs
      arm64: dts: qcom: qcm2290: Add thermal zones
      arm64: dts: qcom: qcm2290: Add SMP2P
      arm64: dts: qcom: qcm2290: Add ADSP & modem
      arm64: dts: qcom: qcm2290: Add WCN3990 Wi-Fi node
      arm64: dts: qcom: qrb2210-rb1: Enable RESIN Volume Down

 Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/pm2250.dtsi               |   63 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 1561 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  112 ++
 6 files changed, 1748 insertions(+)
---
base-commit: 31bd35b66249699343d2416658f57e97314a433a
change-id: 20230403-topic-rb1_qcm-78a8826b34b6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

