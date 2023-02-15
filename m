Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8766976E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBOHER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBOHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:04:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33E234E9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bg2so8043880pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSwftWU2F5+UTSHoENK8S8rRksgligsrF8ZnqH0Z/+c=;
        b=xw3/WRq4ksYn4+KjHibG+jFHzEFv9vvksIDHUEId/SKl5rEZB9mQu7iMZyguZbZcfn
         z/pQ13ViWNpz7pfSS8GrsUqMRxcIdLTI9ldm1RM71UvqhkD4TGaDelLcxKNf4u/8h3KR
         eXAnkHdiiHl99scHhi1Zey4tfeiPWK9j/ccg8LcLWAPx3OoefQg8Ouckq8AqJKfsNGwu
         BivWJiAThGaMPzvdmwY8A7McOZJ0NnZ9Ogak2mZ0RD0G0sGvAJfYmwoMT6d9qYRRMwoZ
         NaU2Qy48/tTuelg8TNJWg5ZeeHIRBviwlMg8LV2Jq54AtolYUKLSbGy6PhbvdmTzV5Ck
         UfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSwftWU2F5+UTSHoENK8S8rRksgligsrF8ZnqH0Z/+c=;
        b=lQlhF3YrQbMIMJu7P9FmuZ7QGMg8Hu+wmYj6DlUlt8ZqsRfxv3YSeYCzU7ZRbA5i7m
         WrOL6J/OGI9p7NYpDzlMcLH99CJCRbpoaUU5MOODtP6HBoI2waPKh8pcnZKcZR68U04g
         9EYtfjNRCwhq4wtuwzmjRAOnStXM3x4/ne2o/SjkMPiXPXYf7JG5wJT5mDz258ustAYw
         c5r52zZAcKmqIcvMBe/rvCeUhW2xvKfS7gyTHGVIYDU/aevZQmR1PU8lymvfEJGY4fS+
         nb3ojK+nI7Cd6YnuJbcPB6fQRS6QI4Vs5vv74XsmyTIt7i7UbWa4+rscAWVebm/ty9AD
         +BSw==
X-Gm-Message-State: AO0yUKXfDY7UVezbeEXcsxMadz6qgNgIGVbmK8uVNHPJQAV60oHkrn78
        MEhxVHuwPm2edTd0gB5p8ovi
X-Google-Smtp-Source: AK7set9eiVSTAEYNuI+v+GGG6D4c2nh12FOt1d2hVkSxs6wNdRjAX8EyGozOE27ZKGxtIFtDyaOFOg==
X-Received: by 2002:a05:6a20:7fa3:b0:b9:46a1:7f14 with SMTP id d35-20020a056a207fa300b000b946a17f14mr1085241pzj.56.1676444652322;
        Tue, 14 Feb 2023 23:04:12 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 00/12] arm64: dts: qcom: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:48 +0530
Message-Id: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a follow-up of [1], this series adds support for supplying clock from
cpufreq node to CPUs for rest of the SoCs.

This series has been tested on SDM845, SM8450 and SC8280XP based boards.

Thanks,
Mani

[1] https://lore.kernel.org/linux-arm-msm/20221117053145.10409-1-manivannan.sadhasivam@linaro.org/

Manivannan Sadhasivam (12):
  arm64: dts: qcom: sdm845: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sc7280: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm6350: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm8550: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm8250: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: qdu1000: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sc7180: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm8150: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm8350: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sc8280xp: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm6375: Supply clock from cpufreq node to CPUs
  arm64: dts: qcom: sm6115: Supply clock from cpufreq node to CPUs

 arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 5 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 9 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm6375.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 9 +++++++++
 12 files changed, 104 insertions(+)

-- 
2.25.1

