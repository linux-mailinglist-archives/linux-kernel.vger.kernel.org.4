Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802163D39D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiK3Kjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiK3Kja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:39:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC84667B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1046316wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=nCuwCuLO3/O7+9Nm+Ck23Y5cGWFMododv9DDC+E+S10=;
        b=zOv78npEAAJfT6kzD5JNYDGDbX+MwtTMOXB6+igVjNjboSAKFx0Ie/dVuYzwr6cJkG
         MqYKNS2uJDDJdDzKOoQxmQFAmlNRiZ86/cumKi21Qr5g1yEMIWw69QHiiuoSjcarA12w
         UY0uo0wWhMpfzN+uIwEj3tBiYaPO3pjeymQ8sB8b0zQB7nEIhmFJexqA4zOF6kDf14G3
         YLRJEJYCRkkQX8/M9GoBei3srnq5iuWJ5Is1QkbZzetciRjVBcKeECqjaeX6Ih2nj4Ha
         dPUtnHrolNm9s3giT22HlYVAupouupZ7O2CXkEkpkMgziI6JRJlu3zk/1ox3IiTbsGS/
         8JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCuwCuLO3/O7+9Nm+Ck23Y5cGWFMododv9DDC+E+S10=;
        b=xPsW7e+Gl3vs84a8exXFnDhPVGmtrOT2COfNHHIvLgY3AhKVFZ9gUHkmDtocYsiR+d
         IbzKYbO2QMfAvn7RML4IuDbM8E3d8wtD4fPoNu7KXYJrAL8YJe1tm9YN3aAmGRZIFMHR
         FJ4gpLNKjg0IxI4W0SyFDr1eV306zCrFhM1gNRsmd/qtl0kK2REWX1U221rt6ZkpOSHx
         UobABkZlRnBtq5S345kNsP/8pawidohnNvhtobJ+lOgWbb0q+J2s1GHid21zMwTVb9Uj
         cipan+QSmaS40ID2z/VtUAwnPnzXFNLg+vt5ezbPyVCAp9tIU0zwflV3uxROGDfAXMuD
         yA8w==
X-Gm-Message-State: ANoB5pndTMuDSVVaIcutboya4TwwCaKJ2rv45MES/dqDgvOYSNaUNWdg
        jvYoiPWLk92ZnO1XQnHW261WxQ==
X-Google-Smtp-Source: AA0mqf5daXB/AxeOh3K7wuMJNqzhEVlAib12/62q5Xb1GHlkJtdaUONFN15K+TEn0R1PZC/tWx7gvw==
X-Received: by 2002:a05:600c:2213:b0:3cf:a6eb:3290 with SMTP id z19-20020a05600c221300b003cfa6eb3290mr37641996wml.116.1669804765098;
        Wed, 30 Nov 2022 02:39:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b00241f632c90fsm1261174wrn.117.2022.11.30.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:39:24 -0800 (PST)
Subject: [PATCH v2 0/3] arm64: dts: qcom: Add ADSP, CDSP & MDSS support to SM8550 and MTP board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANoyh2MC/5WNQQqDMBBFr1Ky7pRMbFC76j1KFzEZNKCJzEShiHdv6A26+ry/eO9QQhxJ1ONyKK
 Y9SsypgrlelJ9cGgliqKyMNgYRLZS8Rg+ydNZq2FYpTG6BUASYllxo5ezBms6GVmNHTa+qanBCMLBL
 fqqytM1zPacoJfPnl96xzuvPyo6goWl7Io8Yujs+55gc51vmUb3P8/wCIi5rst4AAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 30 Nov 2022 11:39:22 +0100
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v2-0-98f7a6b35b34@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the aDSP, cDSP and MPSS Subsystems found in
the SM8550 SoC.

The aDSP, cDSP and MPSS needs:
- smp2p support nodes to get event back from the subsystems
- remoteproc nodes with glink-edge subnodes providing all needed
resources to start and run the subsystems

In addition, the MPSS Subsystem needs a rmtfs_mem dedicated
memory zone.

Finally the firmwares file paths are added in the MTP board DT.

This patchset depends on:
- bindings changes at [1]
- base SM8550 DT at [2]

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

[1] https://lore.kernel.org/all/20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org
[2] https://lore.kernel.org/all/20221130101744.2849294-1-abel.vesa@linaro.org

---
Changes in v2:
- Dropped dependency on MPSS DSM patchset
- Added DSM memory to MPSS memory-region
- Added DTB firmware name to firmware-name property
- Added reviews and fixes according to Konrad reviews
- Link to v1: https://lore.kernel.org/r/20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org

---
Abel Vesa (1):
      arm64: dts: qcom: sm8550: Add interconnect path to SCM node

Neil Armstrong (2):
      arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes
      arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp & mdss

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  18 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 338 ++++++++++++++++++++++++++++++++
 2 files changed, 356 insertions(+)
---
base-commit: 2bc2ef9dfc2e9fe7d45b85e4825f338cdef42723
change-id: 20221115-topic-sm8550-upstream-dts-remoteproc-5285d7018e39

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
