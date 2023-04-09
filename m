Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582336DC14F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDIUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:09:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6992D47
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 13:09:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so8188552pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681070984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8A4KMRqswiSVoBTUCqWQOh29FItb4T+mQDuhm/yB/gc=;
        b=O6X9iRNaynxt6Ui8WBYuHJ7FkDcp4hu13dIwUfrsMJJqOsz2GaiPLnCmSeSiSPGhMb
         0c03gpsjOAdmdyV0KY25K68VJMokMta5X0BVv3z3CvUcLBJBBlzJ9wHoc17hZZRQBNOb
         tJKdahKvyxJGFax6f6Rwzqct5xBw/ELPQZfCHY3bHfqh2OyIagTXVSND3M9PWCu1F7xZ
         sJsWl8jSoT0ZkI6Ntscb4LngwQzIpYFq/f7jAirNwhqU+eMQ+hqhpmDmcG6QlLbJNeoD
         exRfAoAnl6xyg4rG7llGWbqJxte36gZufhpT9HpYK/Flyl9wCAkZtU+hq4VaZda+RbdC
         b4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681070984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A4KMRqswiSVoBTUCqWQOh29FItb4T+mQDuhm/yB/gc=;
        b=7VjSyt9niJrEADh3knHvdCXPxegRaA8uW7ABIMsgA3wQtx/uPgjVSjeVl/p/4ZjQdn
         qiMAOIRsp0QgtEH4MmfyVRyxmi8gZt3OF2C5mBw2RXDopoFc/hTKAZp08X6BQC/Xdwg+
         QR8+dGZqLNGqdZ15Mmln5hszQCRPIpLmM7bBXiboteLXlGZBXdz0iiZsvubPxEOXpwNx
         n6Qo2NIx/e8M4pNwIYPq8fwtBZapmGBbIUSMOX/+cpYW3Y5vyeXL6Lsue/CxX8lvuiF3
         GtMPRBY83CKPEmPTuj/qUxVcffX4xEEphMrLeVvlYXF/1RZCHiNvNW6OgfEbCVWIModC
         Wmdg==
X-Gm-Message-State: AAQBX9cETtmQHV93IGznO01B8uxqKegVZbr1YecgXwUuFKr+hcqsegmF
        7S8bApEQJyauacct6VDjWzapGA==
X-Google-Smtp-Source: AKy350YVj2o7rWdAQE/4+00ZqJXmAY0kxTBlWztMDF36iEsMbYF1xd4Ho/hZggqdIqZBDsuWQmJCLA==
X-Received: by 2002:a17:902:c94f:b0:1a5:27d2:b6de with SMTP id i15-20020a170902c94f00b001a527d2b6demr5816920pla.3.1681070984456;
        Sun, 09 Apr 2023 13:09:44 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b001a5260a6e6csm2876304plb.206.2023.04.09.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 13:09:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v7 0/2] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Mon, 10 Apr 2023 01:39:32 +0530
Message-Id: <20230409200934.2329297-1-bhupesh.sharma@linaro.org>
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

Bhupesh Sharma (2):
  dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer
    one (SM6115 & QCM2290)
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        | 27 -----------
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 45 ++++++++++++++++---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 27 ++++++++++-
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 5 files changed, 71 insertions(+), 34 deletions(-)

-- 
2.38.1

