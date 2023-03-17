Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03DA6BE519
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCQJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCQJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:12:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0112F3E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:12:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so2821718wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7c9JjlZJtBSyylkTITjEuLXDkbRdXKeg/7F2Np4VoK4=;
        b=xn4ySr462E77WN6Cn3meWVkqicL5GPL6OoJR8/j08mehD3RwTkhDZlBARcVLYaKX0a
         OqVYYbUHFWKbeirhwfIKeGE7dhDH9vGnz4/6WaBarvZlBHs1yBsP2YZoOQnODh6j/kg8
         8KmbrijJg/2Afsv7lOMAJMTqd7XgybPtnUHD1ZUQKxFcaUXiE9XkLTeIQAZYdQymQiqC
         buhLPWDH6lFEJEWiAoBwogvjVoJgH+DK3Ta0qhHIiLGO0pLJWit9MUc7HDwSLjLjLKOt
         gXKq+dfIb6BsVlIALLkm0Cyr3goXmVV+JRCQDwDAH0I3KkGfXWOBSx0cmP9WAXytWV9x
         rTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c9JjlZJtBSyylkTITjEuLXDkbRdXKeg/7F2Np4VoK4=;
        b=opfyxe/pQcD4xzPr/bbsOTKakeolulWSPCDij4yRrd6xM6pjWPCdTLyARGrA0WvPER
         mYidZsVUY2jPalsJF4jxD1kWZPX1dxjqKZR2GN6J1cLe6aenaqjOksoKAAGCsMGUbvGE
         BG7CPpwyDfJ58wwnuOIS/DC4uCx035dJlpSetzkekKxra3Vc+eRN3f0KAMsLPdVmPSwL
         6m4h4Ei/4aaEAc6CqwETwiHWUYYGp+owkSKv+fDz4824+IR5vQX6RqMcAr+l+NGWJzE/
         hmwx6DLV1U6DemvW/VeEVwmXejHLt7hhKlM+sXhFUo3x7yIv2HyIA7KdcpQ8iPFLJgRr
         Ok3A==
X-Gm-Message-State: AO0yUKW2cupnEutg5lnlYDJ5Z+etml8LUd2h/AJ4SiJMsNnFCPsDkTCZ
        MKT7Py/pmnExpD5/UxSiLmWXKA==
X-Google-Smtp-Source: AK7set9wS82lmwxJ2FaGmXLBW3ZcVfgDdtvU2c/fw/pgl2hG50W8e3fNXMlvw97WzyU99JYiYl65iw==
X-Received: by 2002:a05:600c:46d3:b0:3e2:a9e:4eaa with SMTP id q19-20020a05600c46d300b003e20a9e4eaamr24281346wmo.35.1679044369379;
        Fri, 17 Mar 2023 02:12:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm1467976wrs.81.2023.03.17.02.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:12:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/5] arm64: dts: qcom: add DP Controller to SM8350 &
 SM8450 DTS
Date:   Fri, 17 Mar 2023 10:12:46 +0100
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v5-0-a27f1b26ebe8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4vFGQC/53OwW7DIBAE0F+JOHcrvIBreup/VD1gWMdIBKzFs
 VpF/veS3Kqc6uPM4c3cRCWOVMX76SaYtlhjyS2Yl5Pws8tnghhaFihRSZQ9rGWJHupl0EbCdak
 rk7tAWMCXvHJJiRhQSqPdiIMMJJo0ukowsst+bla+ptTKhWmK34/pz6+W51jXwj+PJ1t3b/83u
 nUgYeqUNsMbUujsR4rZcXktfBb3gQ0PoNhQgzY4RKl684yqA6hqaK96mixZaxU+ofoAqhsavFN
 qMqojGf6g+77/AiRA6YnrAQAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the QMP PHY to the newly documented USB3/DP Combo PHY
bindings at [1] and add the DP controller nodes.

The DP output is shared with the USB3 SuperSpeed lanes and is
usually connected to an USB-C port which Altmode is controlled
by the PMIC Glink infrastructure in discution at [1] & [2].

DT changes tying the DP controller to the USB-C port on the HDK
boards will be sent later.

Bindings dependencies merged into v6.3-rc1.

[1] https://lore.kernel.org/all/20230201041853.1934355-1-quic_bjorande@quicinc.com/
[2] https://lore.kernel.org/all/20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Add review tags
- Fixed DP opp tables
- Link to v4: https://lore.kernel.org/r/20230206-topic-sm8450-upstream-dp-controller-v4-0-dca33f531e0d@linaro.org

Changes in v4:
- Updated trailers
- Fixed patch 4 compatible and reg sizes
- Link to v3: https://lore.kernel.org/r/20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org

Changes in v3:
- Added Reviewed-by, Tested-by tags
- Used QMP PHY constants for phandle parameters
- Dropped reordering of mdp ports
- Added p1 dp regs address space
- Link to v2: https://lore.kernel.org/r/20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org

Changes in v2:
- fixed the bindings
- cleaned up the usb_1_qmpphy &  displayport-controller nodes as requested by dmitry
- removed invalid mdss_dp0 change in sm8450-hdk.dts
- Link to v1: https://lore.kernel.org/r/20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org

---
Neil Armstrong (5):
      dt-bindings: display: msm: dp-controller: document SM8450 compatible
      arm64: dts: qcom: sm8350: switch to combo usb3/dp phy
      arm64: dts: qcom: sm8350: add dp controller
      arm64: dts: qcom: sm8450: switch to usb3/dp combo phy
      arm64: dts: qcom: sm8450: add dp controller

 .../bindings/display/msm/dp-controller.yaml        |  25 +++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 116 +++++++++++++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 121 ++++++++++++++++-----
 3 files changed, 198 insertions(+), 64 deletions(-)
---
base-commit: 6f72958a49f68553f2b6ff713e8c8e51a34c1e1e
change-id: 20230206-topic-sm8450-upstream-dp-controller-20054ab280de

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

