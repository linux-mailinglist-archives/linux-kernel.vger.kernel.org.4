Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6126C64D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCWKZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCWKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:25:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4B136E5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o32so6743854wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679567126;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHn9LOj3LUennLbrotyH9RAcC3peesavIxumXBNqtGI=;
        b=oTI0vmMM419/N7JVC4Vrcln3XBbpXf1EdxcX3+wAFgQaENApiOqHJBYpdG/KR11aYX
         AJT+iicsK7rFu1bob/i8F6Sf8AfP0hxtTNVqZwR1mX067nZCfz+P4g8hKXZAx6DjntwI
         0NRB41aPwSjAvGdLu+J12vLAU+a9IJCPiMZoiPFmyGiqUO7jSJ53GA5lkcXd68pfBZLD
         9WN9Gmf1ydbOG8/a4VkkJifvW6qBlujgmz6nBwJS6M5TCHLzw1wwWkmdvAoqVEvWFESd
         5xZXqKHyQqONcR7Rxny1jUo0j1fdWybsVm2hd+AdT+Mc4QOV6m00Gl3dPTxCNR3T6O7A
         Gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567126;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHn9LOj3LUennLbrotyH9RAcC3peesavIxumXBNqtGI=;
        b=XwYuT6XxyKEhNY0nN2suKI0YnywbqMcgsUg5afnUGZw7W+M8QD1Q9syorZODJ9P1Uw
         UiptgU7rv/me6NRSmkiRrTLO1kC4ALarbX2DPkVlRs58U3hHlWdzYkGeBrjHg5vnSF68
         YyvuTIUPH1iPaCap/MP92tB74WCwrhKN5tha5IBiYKsBFaViHOadNvF+A+/EE7j6mJ30
         Kxb29h0nJi7jeuynIW7tm3636ccNIkvVTp3axaB12U0Y+0qmCNvQ0d40VQa4E5SKFim8
         /bVpusBTEPs7tbUKX9t4ZxtbdhgX/R3Z658TsMHgntTykk9t+wJpKgrYwRXG2Jzyhkiv
         jGrg==
X-Gm-Message-State: AO0yUKX5iU9voKxPIRYigF2rBzbK3mbuiphB66d+G7qJX9mNZPVWoJYm
        1b9QODgbK63sCKgDFVejVSVSFQ==
X-Google-Smtp-Source: AK7set+qnEKd/C7PSYy2U+bBo9nWl1+ztXVMq+whW9CzH2XcIwXbrg5phWt9nVCwDU1EOtkYtvORYQ==
X-Received: by 2002:a05:600c:2211:b0:3ed:1fa1:73c5 with SMTP id z17-20020a05600c221100b003ed1fa173c5mr1880205wml.27.1679567125801;
        Thu, 23 Mar 2023 03:25:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm15753530wri.98.2023.03.23.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:25:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/8] arm64: qcom: sm8450: bindings check cleanup
Date:   Thu, 23 Mar 2023 11:25:15 +0100
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAspHGQC/x2MSQqDQBAAvyJzTsMsWSRfCR5m6WiDtjI9hoD49
 zQ5VlHUYQQroZhnd5iKHxJaWcFdOpOnyCMCFWXjrQ82+ABt3SiDLP31ZmHfpFWMC5QGibgQjwJ
 v+qJA7+7BPrxHDM7oLUVBSDVynvTH+zyr3Cr+azWv4Tx/QLNN9Y4AAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes to pass the DT bindings check successfully
for sm8450 qrd & hdk DTs.

The following are still needed to pass all the checks:
- https://lore.kernel.org/r/20230308082424.140224-3-manivannan.sadhasivam@linaro.org
- https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v5-5-552f3b721f9e@linaro.org
- https://lore.kernel.org/all/20230308075648.134119-1-manivannan.sadhasivam@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (8):
      dt-bindings: display: msm: sm8450-mdss: Fix DSI compatible
      dt-bindings: mfd: qcom,spmi-pmic: document pm8450 pmic
      dt-bindings: ufs: qcom: document the fact the UFS controller can have an ICE core
      arm64: dts: qcom: sm8450: remove invalid properties in cluster-sleep nodes
      arm64: dts: qcom: sm8450: remove invalid power-domain-names in pcie nodes
      arm64: dts: qcom: sm8450: remove invalid npl clock in vamacro node
      arm64: dts: qcom: sm8450: remove invalid reg-names from ufs node
      arm64: dts: qcom: sm8450: fix pcie1 gpios properties name

 .../bindings/display/msm/qcom,sm8450-mdss.yaml           |  2 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml          |  1 +
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml      |  2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi                     | 16 ++++------------
 4 files changed, 7 insertions(+), 14 deletions(-)
---
base-commit: b9e9869138880e668fa8cb3b186d04cd13bd57a6
change-id: 20230323-topic-sm8450-upstream-dt-bindings-fixes-81630722ee31

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

