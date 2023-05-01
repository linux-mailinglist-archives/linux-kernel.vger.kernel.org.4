Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5842A6F36B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjEATYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjEATYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:24:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91F1FCE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:24:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b60365f53so3412196b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682969083; x=1685561083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKHzO/Hrbfl8nlBv+K49ojgRoBGcaLETpzBjfih2Yvg=;
        b=awtZMcboczzRmO3k/WSOtdFLkLw9ZCqipy/kj2LXYAAMC1JZaRS6Ip3gC8v06l/qhg
         UwqM0M1FuhLUgHyVxQCdRcKFnfI+WayRvCFymL5DAHZooTfZAzaLd2jjnMasqUlEuUC2
         LGJw/JSN+xq6UwI5BiiQTsdFBWqhByWOBLTP1La42194h3tacWJA3pxlOqQtEdNlSJgs
         jnVBHDHMTzVaIap55BSazUpKs7QSI9J68JFU0uEdgMUeS75Xm7aClxG1lPbb9+MdEN2z
         DiExM/H32yKb4yE1zceXoDw9Q5yovSdZXgZ2aUEB3Le4ZQaIZxcUHzEihEytRjnzaZGX
         CHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969083; x=1685561083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKHzO/Hrbfl8nlBv+K49ojgRoBGcaLETpzBjfih2Yvg=;
        b=PYaNXLmr81Nwm4xXmWTvMmGAggDqBGuKwGld4I1zI4desAQ4T73q6HST0d3oBoa+V9
         W+PfO86LmiJA7SUUaL0XuTVgdUqd4tbuImoyNnanXZChPjvngN2Q+dkLape8P5zFpf+i
         5krdYtOba0ySCry4LoA2SOAkhap0Qfdz2u0asLCFeu9+JsLyaRdK+ZyRQl+ytydLZ+Wa
         86MFUSIiJ74Beml4dRmopGQh7y/bnQqfRngDzfF2/labNt5jUsTQO3rSv578x/3/FM1U
         28ATBsVEkue33T23QvVIyVuAazC82zCDgDde2FWxriwNm64IMFAMaNL7N2nSIWNSmqhx
         aQbA==
X-Gm-Message-State: AC+VfDxTdWQUcMPCGJJne2/RFptVs/ZM1sgEucd35RKJ7H4IXVH1Lppl
        D6jHp5heIvCFarBkXDJXsUBsMg==
X-Google-Smtp-Source: ACHHUZ7N3WIvP6+tHaTNd0enhURzMFBWQ3KuY9zg8E5vcGdwuA4Shp9ovocQHS+38FvwLQypJIrGBg==
X-Received: by 2002:a05:6a20:1616:b0:ee:f5a4:c064 with SMTP id l22-20020a056a20161600b000eef5a4c064mr18108068pzj.62.1682969083200;
        Mon, 01 May 2023 12:24:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id 189-20020a6304c6000000b00513cc8c9597sm17459144pge.10.2023.05.01.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:24:42 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v9 0/4] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Tue,  2 May 2023 00:54:28 +0530
Message-Id: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
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

Changes since v8:
-----------------
- v8 can be seen here: https://lore.kernel.org/linux-arm-msm/20230410171010.2561393-1-bhupesh.sharma@linaro.org/
- Added driver change for new bindings used for sm6115 / qcm2290
  devices.

Changes since v7:
-----------------
- v7 can be seen here: https://lore.kernel.org/linux-arm-msm/20230409200934.2329297-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry and added "pipe clk".

Changes since v6:
-----------------
- v6 can be seen here: https://lore.kernel.org/linux-arm-msm/20230407061122.2036838-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Bjorn and Dmitry and dropped old bindings in this
  version.

Changes since v5:
-----------------
- v5 can be seen here: https://lore.kernel.org/linux-arm-msm/20230405191633.1864671-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry and made [PATCH 1/2] compatible with his 
  'split away legacy USB+DP code' series:
  <https://patchwork.kernel.org/project/linux-phy/cover/20230324215550.1966809-1-dmitry.baryshkov@linaro.org>

Changes since v4:
-----------------
- v4 can be seen here: https://lore.kernel.org/linux-arm-msm/20230401154725.1059563-1-bhupesh.sharma@linaro.org/ 
- Collected Krzysztof's Ack for [PATCH 1/2].
- Added more descriptive commit logs as per Dmitry's comments on v4.

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-4-bhupesh.sharma@linaro.org/
- Fixed v4 as per the downstream driver code: https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
SoC. For the previous versions of this patch there were conversations
on irc as to whether this was a 'qcom,usb-ssphy-qmp-usb3-or-dp' or a
'qcom,usb-ssphy-qmp-dp-combo' as per downstream code and hardware
documentation.

But after a careful look at downstream dtsi (see [1]) it appears that
this indeed is a 'qcom,usb-ssphy-qmp-usb3-or-dp' phy and not a
'dp-combo' phy.

[1]. https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

Bhupesh Sharma (4):
  dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer
    one (SM6115 & QCM2290)
  phy: qcom-qmp-usb: add support for updated qcm2290 / sm6115 binding
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node
  arm64: dts: qcom: qrb4210-rb2: Enable USB node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        | 27 ------------
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 44 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 24 ++++++++++
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++-
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 22 ++++++++++
 7 files changed, 118 insertions(+), 34 deletions(-)

-- 
2.38.1

