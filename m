Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6609664D150
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLNUgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLNUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E0231376
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so445672pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct/3m2PY/FS9T1URKRfeRUFxhLFHkaGZAzLhD0lvuyA=;
        b=pWGr4QtMpreRigeqMX+I/wFjpKYI1x288BNobSD1qxsLyPMo2G12MMXhZfOuR/MWLy
         j2xET9aSD2dm6YCoUvGF8wk1sZXavwSK/RnpUyGZKgmG87bHZgsLKZznB4PNYiXZqSyM
         tH+wBVaquRCvPVyq9Sj1DDEuIQNH/YXvGl+tk/inOwm8ZQLW2DY0shs8kPp5wcnEY9rs
         S5zyTf+hoA9SE5F2xT6/KbQeo33WKZOg7x0yiREtJNLEF443zk6lI0glBDJR1SVp7Kop
         K9MIjnCs4Ig1HeoLy9WqRP7kagYyIt4flG9tmWceeG0iIOrp5BN0DGWnoOONfV8ZK6Z6
         dhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ct/3m2PY/FS9T1URKRfeRUFxhLFHkaGZAzLhD0lvuyA=;
        b=Tkd7LAS085PLcrMQ7JIreTr9TIJDNeIbWHDBOhqS/IwSX7h/5cmeOVoTpQBPYIiVOj
         5kPqIkgz6EBNvseZUNQQ05XokoxA1a+JplkaOXIY3iLc4yhNdl6uQFiNeyq7LTnAh1Hb
         d/GEUobDBFD5mfNux7rbm+L38iTja+kMP09t/YfT+E1NC5w3WbPAbJZiv1JYEcD2LOb3
         L38TfaFVnEnizaBmQwCSHpE+WzP7ebt7aWX1wvFU1VFUZhpOuj+o7yKfTBplb+xQ7Q0O
         yCW+Yg1/9p4/ZL1CyITYR1m2nKMgQsaU/rG4Rd+x+SvNhveXdfO1ilc7w89uIoeUljzM
         c/Zw==
X-Gm-Message-State: ANoB5pmtBmyohHAS1fhG0x/P2qzQiCgmaJ5CNxVH8zUpZQcaynCzADXY
        qR+btWnqfekLlOMpMs0FioPdPg==
X-Google-Smtp-Source: AA0mqf6oaWXA/LJq+F1qibT4R0ukuqqLdc/rX/PcMp201wLwAxIrgIrZtihIZNQ9UxXpzsjy21PmIQ==
X-Received: by 2002:a17:90a:7e93:b0:219:6626:3b63 with SMTP id j19-20020a17090a7e9300b0021966263b63mr27127615pjl.25.1671049904799;
        Wed, 14 Dec 2022 12:31:44 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b00219e38b42f5sm1812238pjb.26.2022.12.14.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:31:44 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v2 0/3] arm64: dts: sm6115: Add USB SS qmp phy node and perform some cleanups  
Date:   Thu, 15 Dec 2022 02:01:21 +0530
Message-Id: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20221213123823.455731-1-bhupesh.sharma@linaro.org/
- Addressed the review comments from Konrad and Krzysztof regarding the
  USB HS and SS Phy usage in sm4250 oneplus board dts ([PATCH 3/3]).
- Collected R-B received from Konrad on v1 patches [1/3] and [2/3].

This series adds USB SS qmp phy node for Qualcomm SM6115 / SM4250 SoC
dtsi and also performs some related cleanups for USB nodes.

Note that this series is rebased on linux-next/master and is also
dependent on the corresponding dt-bindings and driver series sent via [1].

[1]. https://lore.kernel.org/linux-arm-msm/20221213122843.454845-1-bhupesh.sharma@linaro.org/

Bhupesh Sharma (3):
  arm64: dts: qcom: sm6115: Cleanup USB node's label
  arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and
    'dr_mode' properties to dts
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node

 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 12 ++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 46 ++++++++++++++++---
 2 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.38.1

