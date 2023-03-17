Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAF6BEC72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCQPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjCQPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:08:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C2399D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:07:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso5329780wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065594;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWIjQ50fIVrAQRlofNeocAQLgnxtnHwBc4uhvYE9qPQ=;
        b=IcFlkPTLn7yAYtfjj/3+fWGiy36sOwr8k1qzkGkwQWlc4r2L0FvimQhQIqApE0xDpI
         is4hF9vEaCdfj6t2i8ZZepV96J1p3lNA/1KF8ZQDJ4ma4fUHDc0RH4qiT19zi++O8k1M
         vVX0EUM2vHi2QrBSa/5StXUCRbqJxE0S9/BVMZU51F3/WXrLBEGiZxGxm9PXYL9TdeIe
         IGm6phkVrUQThyP6THCnRqABFJsuxGRTzQrFfopmPZgI+m3fncdRNr3pHSGfosu372fR
         IskwZCcIoxky/ALbmcdf3+m9T2EphslouLxqNH0rY6dcvSAv1zv3GLzsbaAKyCz8acpm
         3s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065594;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWIjQ50fIVrAQRlofNeocAQLgnxtnHwBc4uhvYE9qPQ=;
        b=oQZKss0vHmYVc7KMlc1AvISB/MsiJMDcUQ/IZG75vSzbm3Cl4WO/Diou0xmARlgd80
         tHPEbl052mfY7HtHvAcwT3MmlT94J0akSFiRB+wcR8Bp5TOh7oqgTOyY1aLU/4C+j42a
         tLMLegt7lcJvcklwdk8yv868kDtYzF/oVtrVT1vhnysiL6TjkYyxzDWL/KgmUT24qpM6
         c46qRJyyljYj0KkxYk5mHE6Y8YABlZ5FapkdiPLzqqG97BZ0GeShY12g0UEsrsDtpcKC
         7v1pjdX20MFLSQ4Jo8MFxteqem0F7BOGI6470kkSm8ec/W+dFVnTEXJCaeT+kCXQh8t0
         qsYQ==
X-Gm-Message-State: AO0yUKVJLtAd0Sa8VwHpMzzy2hQMjuVnAcZa9w1OlxTYoE9edqHd7kxd
        I0mHpWchZyQbH3RWnI1yjuTI5w==
X-Google-Smtp-Source: AK7set//ZMCelRRmNvCpiTkkaLWE6bf8oxGkz8Z8HOhcyhzNfGJq8QxwrcJbk5EEak5v1YdsawJv0Q==
X-Received: by 2002:a05:600c:3584:b0:3ed:358e:c1c2 with SMTP id p4-20020a05600c358400b003ed358ec1c2mr8650770wmq.18.1679065594350;
        Fri, 17 Mar 2023 08:06:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d58ed000000b002c5493a17efsm2187902wrd.25.2023.03.17.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:06:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 0/5] arm64: dts: qcom: add DP Controller to SM8350 &
 SM8450 DTS
Date:   Fri, 17 Mar 2023 16:06:31 +0100
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeBFGQC/53Oy27DIBQE0F+JWJcKLo+YrPofVRc8rmMkAhY4V
 qvI/16SXeVVvZxZnJkHaVgjNnI5PUjFNbZYcg/67UT8ZPMVaQw9E2AgGDBNlzJHT9ttkIrR+9y
 WivZGw0x9yUstKWGlwJiS1sHAApIuOduQumqzn7qV7yn1cq44xu/X9OdXz1NsS6k/rycrf7b/G
 105ZXTkQqrhDBi4+Ugx21reS72S58AKB1DoqAITLAATWu1RcQAVHdVC42jQGCNgh8oDqOxo8Fa
 IUQmOLOxQdQBVHbVwHrkDjQ6HP+i2bb8gEBgIQAIAAA==
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
Changes in v6:
- Revert DP opp changes
- Fix SM8450 combo PHY memory reg range
- Link to v5: https://lore.kernel.org/r/20230206-topic-sm8450-upstream-dp-controller-v5-0-a27f1b26ebe8@linaro.org

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
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 121 ++++++++++++++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 121 ++++++++++++++++-----
 3 files changed, 203 insertions(+), 64 deletions(-)
---
base-commit: bf7a33dc3cca43baa4a4ecf86dcb6838fca09451
change-id: 20230206-topic-sm8450-upstream-dp-controller-20054ab280de

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

