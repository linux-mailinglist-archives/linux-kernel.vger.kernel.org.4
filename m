Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499B612057
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ2FPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ2FPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE284B4AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m2so6287693pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pArkSGVoS9iqAmWsRYyb2sl/TCPPkWftFwEeBSdaKEI=;
        b=qJGPtGjjreVjLjcYSoHb0DAjeHbTozhrFzXzvSkIYpOG7kKFd8u4TjI1nW8Wnlw8ld
         tJBsyduFD8kbGNYu49Ckc025mKJFDbLMcJ7ZDZDjbfD0AGoEq0ib/3Kxnnb1j3Vs4+7o
         RfE0Wy/p47F6no02QrQ1GyeP/NMECYz3yEf92hWD8tAq2pPit9EmgIcggXQPMyld9bsg
         GLAipBg9vgQt1VJdX4AIipIAsC1if0cOqT1r86sUof91SqeK/1hDE1x0xR0kChWNgoim
         mL8W+m2YwuiCVm/2KbXLQWFny3dWyVDRAVJid5ozf0nGqADLTxCy+ZIOAnow7VvJJz5s
         UNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pArkSGVoS9iqAmWsRYyb2sl/TCPPkWftFwEeBSdaKEI=;
        b=NznlDD6bmcLXa5WlffjUDmCKMLUPT0GQFefp/9Ebn3UiS+PkSY3NpzHVAAQ/DXYJtn
         S6T4z6k1ZTnMDT848Es8BIUSRFkCLGHRgKVpx9JF2pGUEAI8WXi9FMPHSfl0KrOKNLYT
         Z9mG/SjMxm9L5q4a4ZUjoLJySidIwCwOJP/uDCOwjQKCn15HvCgrdgpl2CqSjSuKJGC5
         NOEUYNbjrwmAWGykAHg4MPyQSR71uCTp9qDwAOtohaG8SCnt/JMZumQqkLBnAlAf43/L
         aVU6qK3lfBYhvjcuN0jHds8pasPBfpPBQTYiEY64OmK1zB3SEVqz8WMBmyqZUrf4NScf
         5BpA==
X-Gm-Message-State: ACrzQf0mYrnJzpD5LqgeN/4lRuEuO7dN6ienRwMjgeQs1AaPFJcUKdol
        1Sf6uGEbs9RP6HbC3bHjRiDo
X-Google-Smtp-Source: AMsMyM4DvK7vpo8PHlP5u7V0V01mh+xh+1Mrqkwp8uapSgz1xDxbhSYPIKw2CPTrRFjWdfoamsD4kA==
X-Received: by 2002:a17:90a:cb96:b0:213:1dc2:b1de with SMTP id a22-20020a17090acb9600b002131dc2b1demr19571746pju.21.1667020504441;
        Fri, 28 Oct 2022 22:15:04 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/12] sc8280xp-pmic updates and X13s thermal zone support
Date:   Sat, 29 Oct 2022 10:44:37 +0530
Message-Id: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series adds below updates to sc8280xp-pmics:

PM8280_{1/2}:
- Temp alarm
- Thermal zones
- VADC channels
- ADC_TM5 channels

PMK8280:
- ADC7 block
- VADC channels
- TM5 block

PMR735A:
- VADC channels

Also adds the thermal zone support to Lenovo X13s based on the thermistor
SYS_THERM6 that provides the laptop skin temperature.

The sc8280xp-pmics is based on the new PMIC7 architecture. In this, all the
ADC/TM5 measurements are collected by the primary PMIC PMK8280 from other
slave PMICs PM8280_{1/2}, PMR735A using the Programmable Boot Sequence (PBS)
and exposed them over the individual channels.

PMK8280 uses the Slave ID (SID) for identifying each slave PMICs in a system.
This ID is not static for each PMIC but rather set for each platform by the
hardware designers. So this series allows the configurable SID by modifying the
binding to accept SID values instead of hardcoding them.

This series is tested on Lenovo X13s laptop by monitoring the temperature of
the 8 on-board thermistors through IIO interface. The thermal zone support is
validated by adding loads to the CPUs and making sure the skin temperature stays
below the threshold provided in DT.

Thanks,
Mani

Changes in v2:

* Fixed issues reported by Krzysztof and "make dtbs_check"
* Collected reviews from Krzysztof
* Added the Lenovo X13s thermal zone patch

Manivannan Sadhasivam (12):
  dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for channels
  arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2}
    PMICs
  arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/2}
    PMICs
  arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN input
  arm64: dts: qcom: sc8280xp-pmics: Add PMK8280 ADC7 block
  arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK8280
  arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
  arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
  arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} VADC channels
  arm64: dts: qcom: sc8280xp-x13s: Add PMR735A VADC channel
  arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} ADC_TM5 channels
  arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 204 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  83 +++++++
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   |  90 ++++----
 4 files changed, 333 insertions(+), 50 deletions(-)

-- 
2.25.1

