Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF316F7D13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEEGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjEEGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:40:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF815EE7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:40:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab032d9266so12854155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268848; x=1685860848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3boSRNK29dqqYTac8eSxe1gjUYm4xAi8jG9J+p9oaDE=;
        b=OFGHhovtmhOjP1O8/vsgF3t5DFacPKtQf9gX+WesO89c1qPbQlyCcD8vUyeguYjJMr
         bETl9CKLYT8jngkNuQe3krbm3aZs4IwlDrUZTBO2b4J7eFp/luIxavQApeRoXDLhQ2U/
         3eh/mmEJshZxzXwVgbHUXPk+CcmHvaImi9tDa/K/MxVEFZyyfz/XSyGPMQma3nRUbKR5
         92jjWqLB5tTNSmdo/+Gi8KqjwkULyI/CI5s4mxa10GZ7cSER6sHJKHo1j3qcS6e96CEJ
         lgFsAfcgULd7LzAZw4Y6T7W0ICoSRe78F3wFYARvIeQAcJufOS8mAF0R2szehjld0pOk
         SvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268848; x=1685860848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3boSRNK29dqqYTac8eSxe1gjUYm4xAi8jG9J+p9oaDE=;
        b=VXa9kyP2oDQFuiFkKqal5cj81uVeU2shWPd0SDvh2Soo21xncZqdA91wEeiyZAeni4
         yIEU2kiV/3HmD1n9P6vEjAQEqsXQnryznQZuw7Y/8+eZk2s7VJnGxEdu1X8HrTMWtIHE
         cLzHhUBU1VJhMgrwkoxRcMQPOHZeLu9KDfJzpkBO/HTG4YBO0pS2zWvOndy1w4ll1ygG
         L64JXbFJ6pe7Kwt7DHmE8hNp5I6Tnvpo1AQfLvVu8EqU3+YvozQDo7xEnB6MTLG4uoG6
         qATlUxFfVkDs3WmYGbzxylzLKt8JCybgwhx/jvb5vyRjviZHxVtx7u4M73muqb6VB0Rk
         Ks9w==
X-Gm-Message-State: AC+VfDzBalzpqPaIH8JpuAcva5u3qTNKvqD9gq2IRS3d0Yb9lqE94pSA
        fitmNJbG9SShbh0vDL3z52AQ6w==
X-Google-Smtp-Source: ACHHUZ4nt5L3LYSG9x+kMcvsOsz4iw7yGJs81w3ClNhCYroFcqw2F+Nri86RuSvliMPFWNAd5gqklw==
X-Received: by 2002:a17:902:ea07:b0:1a9:a408:a502 with SMTP id s7-20020a170902ea0700b001a9a408a502mr628708plg.1.1683268847764;
        Thu, 04 May 2023 23:40:47 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902848400b001ab0b2dad2fsm816251plo.211.2023.05.04.23.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:40:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 0/5] Add Qualcomm SM6115 / SM4250 EUD dt-bindings & driver support
Date:   Fri,  5 May 2023 12:10:34 +0530
Message-Id: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
----------------
- v3 can be viewed here: https://www.spinics.net/lists/linux-arm-msm/msg137025.html 
- Addressed Konrad's review comments regarding mainly the driver code.
  Also fixed the .dtsi as per his comments.
- Also collected his R-B for [PATCH 1/5].

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
 .../bindings/soc/qcom/qcom,eud.yaml           | 16 ++++
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 27 ++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 51 +++++++++++++
 drivers/usb/misc/Kconfig                      |  1 +
 drivers/usb/misc/qcom_eud.c                   | 74 +++++++++++++++++--
 6 files changed, 162 insertions(+), 9 deletions(-)

-- 
2.38.1

