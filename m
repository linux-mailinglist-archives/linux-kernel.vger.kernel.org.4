Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546860E593
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiJZQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJZQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:43:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355573C35
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e15so11847068qvo.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzWvOz4xlS7L3D9T4rYd7JcZn+pzJHU2kPLw2mhBPuM=;
        b=KOkEfP2xpRurEbYg+xQTVNwiZfGj3RiNZiEcehd4CgcqnnG4IFx3UKtOjlGSemDbPQ
         0OnIs/LTiX2qwceK4CMeaxVEwrzkEfSRa8S7l5FS1SdMXA5GTBkMXY/24hwIPJXP2eQb
         s3bYfXUbUpb65zOyBbZC0B7YfrgaMcFn6rz01Wc1k82pcL3/hBFEyLa01MUXlcQLmNZB
         i1oIVykGn16gBLLLlq4lAx2i1M8SqQykQ2EfLg6o7i0OQOewgwOpuwUERwW74CSMc1X0
         eO6iX0gjFeuplDPso9WHI8nrpFIr0kjWVwS1ldABtBxDnwKiGyR3MWaUN1UvUdbXdKFq
         2EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzWvOz4xlS7L3D9T4rYd7JcZn+pzJHU2kPLw2mhBPuM=;
        b=Utpus0f+/sxlh4gE5eE0Q0m78AL2yMaxvGPf4jhqIMCU3F2wTcC94efAfjSYz714Oc
         uxQCYJGGyQwgnhZv9TQQ4tJ25fKa7EH9efxAimnDsBgxyDOmGhBcrB2MS/s4TNW2jEH+
         An6tKkYm//XzdPtwt1wXYZ5xUPfhmugrQy6cbj/yhUTR2/61zhazvi14fhXxVqm7ShlN
         xWFQlqy+5yefyGEb5dm38nDWs/cIeZ52z3T3Fbjnat0paFxsmiSPQNt7nMgMR4xTcJoz
         DLK5GqKot+yyz6EZIcNqQjN/r4EbafnS+cD7KDJkjZavmhZjqGzWdvr8BRwGBqRjhKpt
         bKfg==
X-Gm-Message-State: ACrzQf0YgJmU63ZpAwKDi0IKdhhXiM/6b4zOfM6X0HRz4z8yAXoqq8gX
        aCKrvGwLWcLHNN0l5eW6D41tXw==
X-Google-Smtp-Source: AMsMyM4iAG3FrGgLa5u3fVo4ArWXqF/ECAWI08B9jzMkRd9NbPYsZvn6nwCH0MlU4TpX4OF79c3ACQ==
X-Received: by 2002:a05:6214:d42:b0:4bb:75aa:7d7 with SMTP id 2-20020a0562140d4200b004bb75aa07d7mr13016281qvr.22.1666802599432;
        Wed, 26 Oct 2022 09:43:19 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j6-20020a37c246000000b006eed47a1a1esm3989938qkm.134.2022.10.26.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:43:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/3] arm64/slimbus/dt-bindings: convert to DT Schema, minor cleanups
Date:   Wed, 26 Oct 2022 12:43:12 -0400
Message-Id: <20221026164315.39038-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. None, rebased and dropped applied patches.

Changes since v1
================
1. Fix commit title typo (Steev).
2. Add Rb/Tb tags.

Dependencies
============
No dependencies. Binding patches are independent from DTS.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: slimbus: convert bus description to DT schema
  dt-bindings: slimbus: qcom,slim: convert to DT schema
  dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema

 .../devicetree/bindings/slimbus/bus.txt       |  60 ---------
 .../bindings/slimbus/qcom,slim-ngd.yaml       | 120 ++++++++++++++++++
 .../bindings/slimbus/qcom,slim.yaml           |  86 +++++++++++++
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  84 ------------
 .../bindings/slimbus/slim-qcom-ctrl.txt       |  39 ------
 .../devicetree/bindings/slimbus/slimbus.yaml  |  95 ++++++++++++++
 6 files changed, 301 insertions(+), 183 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml

-- 
2.34.1

