Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F936D86B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDETTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjDETTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:19:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F45761AB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:19:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso38277466pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680722352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zlksD92y91W/zBiGYAiTH3OBW9sw1/DW7nrq7m6H8A=;
        b=Tl8NBWMiJl9vi0VjN3/5ExPfrReizRoo5kUk43xO2MZ4ES/Meyyl10g8bSByHqrnA7
         nXq8pLWn8eup0i1CwY3XfmnQM86lZQvv9y3Hgnfyd7LlO1iOSh6fj74qJWf5ZKnMu2LC
         UPjngBqvWGV2POebFrjV23T02xTWE/vlJArmaLwNMbCfsGZ+9Fic3gmBFtq8Goar2bmk
         VOD8Z0NY6OiRBjK3v10or97jKnbUTQdQJma2x4MFObp7E/4cVLWZVTzO0SRAh6AXIbW2
         QgD39X+nNeNPPjbNa93ExmFP3hH5/A86Qu3TDraeNoTx3vN3xa6pafG7Z31vC8UrvOkF
         WEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zlksD92y91W/zBiGYAiTH3OBW9sw1/DW7nrq7m6H8A=;
        b=fBLubpD7/Z+/2C0/gX3gkGB8QkRg47xUUekslTvo9/YNiQ92BTdg4onPjxYopuz+fC
         +6Pe0OumeC/2Ub5wf5ExNdL5ub7PLkhsXOdCoQjSRvXfC0B0SKgABsy6xq6+3Q0CMSN6
         GVWIr2aIvPcyJICDkvFdBJjqGhQqkTQL1VNPBDMR46G0X+6FA5Dk8SvhWCICBk/mm1cF
         dl4UxEqQw0TVMlZ6raUw5TO+dFOXEA/hD25MsR7fnNqHQf8a1h4XyOn6upgnDN2pZGGy
         WjlYOuIX6yqbss+wzmCCxIOc1jarq/OV4tXckLUDWgSKI4Llgj9t+ceEmFeLnFVVZhDL
         6tBA==
X-Gm-Message-State: AAQBX9fpkffPwa4v3mHT8smc76qehMsRFWADKRzA2rvhsByRVSyJhyX4
        uEQoksf3HBUHiEP+r/gnSibkTJ0oWw5SSaoFuwc=
X-Google-Smtp-Source: AKy350ZnCH0zsQ7BpkuAXwC/NfeSdLVgSm8Gk9+vTwYOmSnoat6y6vPz+7X6Fr1oyoUrhW00QR6npg==
X-Received: by 2002:a17:902:fb05:b0:19a:9610:b234 with SMTP id le5-20020a170902fb0500b0019a9610b234mr3167771plb.1.1680722352018;
        Wed, 05 Apr 2023 12:19:12 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001a1d7329235sm10478097plr.234.2023.04.05.12.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:19:11 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v5 0/2] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Thu,  6 Apr 2023 00:46:31 +0530
Message-Id: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Bhupesh Sharma (2):
  dt-bindings: phy: qcom,qmp-usb: Fix phy subnode for SM6115 & QCM2290
    USB3 PHY
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |  4 +--
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 4 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.38.1

