Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B56AFC43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCHB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCHB1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:27:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C920898DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:27:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g17so19500904lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238836;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnkuEnGdkuVKTgCNdaVXaPdrwyMARXY+OCtr+H09yOk=;
        b=SO8rsVQb7F8kyhL8IL4sklmWEmag8ksGKG9KXYX8J7XW6uz5MMN8Cv5jkwwjnvMeRb
         zzbUVcPk6wsgzo3zwSPBy+oiD+KTfpx9nMOpEsE6su2NsGFXRNF9VhOO7YhdtSi0GZ81
         GUtxZY0QBgfMEsiuctE7rPV4Sd4+YcntUhzJcVEa1eh9Gmdwn29JiB343rit3oWCwIEN
         k5bYnEzwC91x+hGr2VRBFMYCUqjJwQJ/MBdLPAbYGkmAPwXgxv9ubUVA6bbzFsov+o5f
         OoLh6S7HKopaevgtcunc35L+8x6gWGTK/FqorJrQAqeGiJTlwF/3L5Bka6VlfeYqUS0D
         HIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238836;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnkuEnGdkuVKTgCNdaVXaPdrwyMARXY+OCtr+H09yOk=;
        b=psuqIKGidOgi37dS9dGNtkz0517k3kaD7sjhBRRdn93ot/1D17dnW/+cWzuxr8SrlE
         CR2YVrNz/96JCz9eVcTggIfOboYMB8vPq816kn336x8KP73YvzbZ3Ru0z0JFZA9JCj4X
         BRdIg1leNAOZFwsxijKUMDGBaS2KQQMs/H2M2ssPUgbqFh1G3zFRZl4xeq0EwyHEFK2D
         jqkE5eqkQiQGfK00lozkVLh9Wts5y96bYpgUd5DBYK3zWb8NQM4dwtO2XNhQ0/9Tod+J
         dVbTTQvGZ+lwvwxrdGJNmg/doHaOYiSchYepASOZwQZphTrJxM4Q3FcN4Ywn0MP/lQCK
         aBcA==
X-Gm-Message-State: AO0yUKUjD/rL6rLvFtDYcH4X2m7QqX1eJ4ccz7AXcpSer8YTlZ1vx0c5
        PF7VQ0gZkiBbw/F3QfPqG0noEEubq58JsD/vZHU=
X-Google-Smtp-Source: AK7set/RGVBfMaBWTEVNbiNbTiWzRl6Q/cw6AtLGHBJGzwGHwR46rq/MiE6MhHcZHekKWQViNwv3hQ==
X-Received: by 2002:a19:c214:0:b0:4ca:98ec:7d9a with SMTP id l20-20020a19c214000000b004ca98ec7d9amr4386825lfc.15.1678238836571;
        Tue, 07 Mar 2023 17:27:16 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:15 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/8] qcom-cpufreq-hw binding improvements
Date:   Wed, 08 Mar 2023 02:26:57 +0100
Message-Id: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHkB2QC/x2N0QrCMAwAf2Xk2UBdmU5/RUTaLt0CI6uNk8HYv
 xt8vIPjdlCqTAr3ZodKX1ZexOB8aiBNQUZCHoyhda133vX4WQonTGXNld6vyDKwjIpdvvbkQ75
 dogeLY1DCWIOkyXJZ59lkqZR5+98ez+P4AXvYZLZ9AAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=1470;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xI1zlOQmpQoj7NqQfsUAGQS5w5X6WW+TqN5bUGAVdZY=;
 b=KxPHiETKTjI7JvF17ebvbBEqnysNlVPhuiU5/ZPy9YqTyLKrLtTimseEW+3EgQJVTkWkzL2/kHRh
 eXcQejQyDxudWrEVbEFwRqbb6v1h4Em4I5Njl0fnmEezETDLXh2j
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to better sanitize what's actually allowed on which
SoC and lowers the minimum frequency domain count to 1, as that's what's
present on at least QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (8):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1 frequency domain
      dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290
      arm64: dts: qcom: sc7180: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sdm845: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm6115: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm6350: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm8150: Add SoC-specific compatible to cpufreq_hw

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 118 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 6 files changed, 120 insertions(+), 8 deletions(-)
---
base-commit: 709c6adf19dc558e44ab5c01659b09a16a2d3c82
change-id: 20230308-topic-cpufreq_bindings-5f78e3af96b3

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

