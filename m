Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE62671FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjAROg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjAROgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:36:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0D56ED1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b7so8112505wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWLasllBt8L+W8aSA45MlLGDpRwzO0/LkpisHm1dxGc=;
        b=BeO6Oicnz5zfpstTsnTQ17Ds5VP0Xfz3wseFnDD3UuLn4sIK6QI2pVxgEdg06PB7mJ
         EHyY2A7nqHtDeg0mvsgXo88PtOqAif2Xc1nORl88AyMAlSHHaz4Q0AVvcp0YEAu6o3bp
         iwURrYOzjBCLK82xraBe8E0rMhib2GXQzc1EXqwkJOUtO3bUJ0L8vN1yzbrnuTpR7OrZ
         /DbN8Fvdbs8wJWBTWr7yITk9C+4LdD4IXe0P9VuSLpGwwdTmJhFqFIYjf/3Rmb9jVd5B
         CPwsP4uVBmK4VBMrt588nqNmG/0HK3P1Ug8SdJRdRYC2dHYk98V/DKP21xhmQRj/HOg7
         c9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWLasllBt8L+W8aSA45MlLGDpRwzO0/LkpisHm1dxGc=;
        b=EpD7yn/3mZhFZmztWeqUmxRF8A8/BaZHTd6Tp/kidHknqzqgaB4zsgrXQ326wX9UhO
         sroi1f2MPuYrfzEQGQCEA0HDBPsh82iDdWzUjTcdNq3IQdCemAumutGWV5Slg+MuYBxV
         aDyfKuF6/DFOFbiMJAsOoFFPjiZkVUzw1xC3VghfR3h19/j6jKpof8siLwPdNksraDAk
         0mrolq30IYnfgAYlbXM/4+Bo8mDj/ZuUYbvLm28SqNmWBGj4uPY4Tiasr+7VYsvkJ9x4
         gZetzmpn4iUVRb91H32/L/BIVq8Y/UTiIfQ/0Srqp9dx5/mwGdrLX4KlgEO/BFIw3e0s
         sH0w==
X-Gm-Message-State: AFqh2kqNsZa3oQ8t2yEvo3HyNNXpiLiTUiu9U08fOWDgmqwhHgxh9KHJ
        sUzkC43xjoCPJtqVtuCZ2vHbNw==
X-Google-Smtp-Source: AMrXdXsacfDxL627hntcR4B3fmKPC1/jv54AV+wSJLpJjVG+JJgk/L0luLtWPQfEOh60rTZ0+IjQ+w==
X-Received: by 2002:a05:6000:1c08:b0:2bd:f5bd:5482 with SMTP id ba8-20020a0560001c0800b002bdf5bd5482mr7661348wrb.28.1674051900675;
        Wed, 18 Jan 2023 06:25:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm10612919wrm.66.2023.01.18.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:25:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] arm64: dts: qcom: sm8550-mtp: enable DSI panel
Date:   Wed, 18 Jan 2023 15:24:56 +0100
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgByGMC/5XOO27DMBAE0KsYrLMBSYn6pMo9AhdLcWUtIJMCV
 xZiGLq7aXdBKpUzxZt5KKHMJOrr9FCZNhZOsYT646SGCeOFgEPJympbaaNrWNPCA8i1c07DbZE1
 E14hrAKBZZnxDojWetd0hKZVxfEoBD5jHKYixds8l3LJNPLve/jnXPLEsqZ8f//YzKs9MrkZ0IC
 Evm+d6W03fs8cMafPlC/qxW/2MGkL2Y/eG2ebinT4R1aHyaqQdTPqUJNrW2f/kPu+PwHTzKxpjg
 EAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for MDSS, DPU and DSI devices on Qualcomm SM8550
platform. Enable these devices and add the DSI panel on the MTP device.

Dependencies:
- [1] SM8550 base DT (applied)
- [2] MDSS/DPU/DSI bindings (applied)
- [3] DISPCC bindings (build dependency, applied)
- [4] VTDR6130 Panel bindings (applied)

[1] https://lore.kernel.org/all/20230106201047.337409-1-abel.vesa@linaro.org
[2] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org
[3] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-dispcc-v3-0-8a03d348c572@linaro.org
[4] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v4:
- fixed aligment in patch 1, added reviewed-by from konrad
- removed superfluous status in patch 3
- Link to v3: https://lore.kernel.org/r/20230104-topic-sm8550-upstream-dts-display-v3-0-46f0d4e57752@linaro.org

Changes in v3:
- rebased on https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git arm64-for-6.3
- Link to v2: https://lore.kernel.org/r/20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org

Changes in v2:
- reshuffled properties in the order konrad shared
- updated DSI PHY compatible
- renamed mdss@ to display-subsystem@
- added back dispcc bindings include
- added Reviewed-by on patch 2
- Link to v1: https://lore.kernel.org/r/20230104-topic-sm8550-upstream-dts-display-v1-0-aeab9751928f@linaro.org

---
Neil Armstrong (3):
      arm64: dts: qcom: sm8550: add display hardware devices
      arm64: dts: qcom: sm8550-mtp: enable display hardware
      arm64: dts: qcom: sm8550-mtp: add DSI panel

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  76 ++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 300 ++++++++++++++++++++++++++++++++
 2 files changed, 376 insertions(+)
---
base-commit: c326e851eed4e3ab1cc18deffb6505ce34560ba5
change-id: 20230104-topic-sm8550-upstream-dts-display-aa22b568ea17

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
