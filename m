Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644AC6F6772
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEDIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:30:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FA6A60
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:27:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b50a02bffso189102b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683188830; x=1685780830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dtXpIHsf8HhXYxkkEaWjrnt2Jd8Ht3xr81JX4hMlcQ=;
        b=p29Gmm0Fdg+GEgF2b4MD0yK+ugICJM4CLI3wmw2xlq0duglICQjK3XTy/2vSvg4N3j
         /sKN+KnQ1K7H9jvdZYm524/YYu/L1Y5Exkmp7KE93s9vzbsgobLGs5gXLNBSBYM+8WXN
         OkPexcdbkxteu5QVHYVNg8+G9PQb1Uj/T6rtlonGkhEr9VNU98fKN+XrkfSNiMWu4UO0
         i76plCvHW7xeIwdcLX0pEGt6zM+dpnczMGi1dT6MQOE2au54aRZ82XpJIP0h2mp7/4iH
         OZo+lpRq4p+r/Prd+ut8FUA2BLljrz288kIS7B8r4593Ziu8FpFyeF/6eA8UZkejXQcA
         eBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188830; x=1685780830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dtXpIHsf8HhXYxkkEaWjrnt2Jd8Ht3xr81JX4hMlcQ=;
        b=MM8YTvhXucbOVeom37cGybe10yxZqxFVjxrVHeY17KoZfS+vmTjqivGq/BmJqTptdh
         A7cUWLw88wpckGQiLnGo3+hflk6k6aEDpvfDlW2wAWI0oK0ujK/rqNDBLaR5jKrkSfnM
         3rebFY+pIDjdSS8hl0L/jwq69ZHdgyyYOJU7Slx7ikgKGdMlIqJSpwVkPxXQ/Fmll89z
         0C4B/yubnCyclZ0B+lIz7SfCoBbP4Wdy6KNyIhjTD5j9ROt9Lxq9GrmPcvhgl7AOT8iU
         c7lbuaSH91AfZVu5RCflBZpnEH8BP3GzY27zpfYNEeg540dC2E4lgsS7kp6AHSD/otXP
         PqgQ==
X-Gm-Message-State: AC+VfDxd7PURxhxUNcsottcrEi9ssfrIdC6o+ymcjZ7pywjXXyzqghLd
        xQwrjP/N9/cPTtWWiK2HMjig+Q==
X-Google-Smtp-Source: ACHHUZ7StNANc/fM+kaiVcC8kHbqaHz9hbMa/DQmPb/0QJ1VagnznMT8jbmJEnPaS2n6hZrsCg1CnQ==
X-Received: by 2002:a05:6a00:2395:b0:63a:cefa:9d44 with SMTP id f21-20020a056a00239500b0063acefa9d44mr1564981pfc.14.1683188830471;
        Thu, 04 May 2023 01:27:10 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b00625d84a0194sm24913973pfg.107.2023.05.04.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:27:10 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 0/5] Add Qualcomm SM6115 / SM4250 EUD dt-bindings & driver support
Date:   Thu,  4 May 2023 13:56:39 +0530
Message-Id: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
----------------
- v2 can be viewed here: https://www.spinics.net/lists/linux-arm-msm/msg137025.html 
- Addressed Bjorn and Krzysztof's comments.
- Added [PATCH 1/5] which fixes the 'qcom_eud' sysfs path. 
- Added [PATCH 5/5] to enable EUD for Qualcomm QRB4210-RB2 boards.

Changes since v1:
----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org
- Added Krzysztof in Cc list.
- Fixed the following issue reported by kernel test bot:
  >> ERROR: modpost: "qcom_scm_io_writel" [drivers/usb/misc/qcom_eud.ko] undefined!

This series adds the dt-binding and driver support for SM6115 / SM4250
EUD (Embedded USB Debugger) block available on Qualcomm SoCs.

It also enables the same for QRB4210-RB2 boards by default (the user
still needs to enable the same via sysfs).

The EUD is a mini-USB hub implemented on chip to support the USB-based debug
and trace capabilities.

EUD driver listens to events like USB attach or detach and then
informs the USB about these events via ROLE-SWITCH.

Bhupesh Sharma (5):
  usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')
  dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
  usb: misc: eud: Add driver support for SM6115 / SM4250
  arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
  arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral

 Documentation/ABI/testing/sysfs-driver-eud    |  2 +-
 .../bindings/soc/qcom/qcom,eud.yaml           | 16 +++++
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 27 +++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 48 ++++++++++++++
 drivers/usb/misc/Kconfig                      |  1 +
 drivers/usb/misc/qcom_eud.c                   | 66 +++++++++++++++++--
 6 files changed, 153 insertions(+), 7 deletions(-)

-- 
2.38.1

