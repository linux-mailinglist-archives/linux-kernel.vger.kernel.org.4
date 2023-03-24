Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC26C7B52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCXJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:28:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC2273F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so1054971wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679650129;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe6xkVW/LwNnSr0qXJhAQ9MlrUZGEMQPRfSGh9j4qrQ=;
        b=pvrGPWA/YRlHFpq2pgubC7K7Wz159BTtXW1nold76ETFYVsNHJq0KLt5ho23Rm/GbZ
         wrrBJxjgefV1wsa/1CJF2LzZaArGvqprKvWpKyXwfXfvDCFhe0HlGEZo40acZ9gl6hg4
         G74NJw7afWFPy8ousSRa3Xd5zuFBLoReJAeoeTw4FgjJjdctgOuple7iNXAA4TaPE9Je
         iK3TETjd+nQYCERBu0cpgGnNeACZDefAmT1f/OAU3kVd/78bYxGgenOUzfw29OMRUUny
         lZuiXc3wvlFmZ2y0IID7YttoMweJGjk5ciNzlweou5tiEIQE+0GyhA2yhgHiotySnSUh
         YD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650129;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe6xkVW/LwNnSr0qXJhAQ9MlrUZGEMQPRfSGh9j4qrQ=;
        b=K+v/+uJkEZADpoTOTWYl/cA2XCBM6pHDrwki9BB5zQBTO40LyHllQRBIDDoRvZm2fo
         nh4XFSEKN6kXeSb0w2VKjBqnhIlKNNKI0KFWBphSJ4SKljEBiu9aYzbMTB6f0A39kLQZ
         atzoDaQ4AiLebcHv7s8baqeLaDDVIOmGHHGYtGswKhuSZqVRFMCgocspu78zHKTpX76w
         S8LmFyuL6SBV9lY02oWDu/SgAucOFS3OdfrIgCcTA9S0Bl5inlxZm3nO6nPenIdwML04
         1EFKRC6mfWphNJEIgwHH3YYsMhFUDKllfd1JPjgcsnjqriND+ZteT1tEfN8dTxXQuODB
         Ly4A==
X-Gm-Message-State: AAQBX9eYH1G73XhxND0pHiy8UMt2aXtPxly/FutaNVsBDKQ29rnRwD5D
        BTBt7aQkwbqxDNpSP4VxbECNYrdwQhOSgooz1whHeA==
X-Google-Smtp-Source: AKy350ZPhLrsgllqoWa7OK8+vEdPLlF/AzIB3IxOzcqgJtDgt1Cf0B3PK9hkTPs7esoGyotLah7zjA==
X-Received: by 2002:adf:df83:0:b0:2ca:175b:d850 with SMTP id z3-20020adfdf83000000b002ca175bd850mr1655308wrl.11.1679650129542;
        Fri, 24 Mar 2023 02:28:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b002c5a790e959sm18029980wri.19.2023.03.24.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:28:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/4] arm64: qcom: sm8450: bindings check cleanup
Date:   Fri, 24 Mar 2023 10:28:45 +0100
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1tHWQC/5WOSw6CQBBEr0JmbZv5oBJX3sOwGKCBTmCGdA9EQ
 7i7ozdw+V4qVbUrQSYUdS92xbiRUAwZ7KlQ7ejDgEBdZmW1ddpZByku1ILMVXnRsC6SGP0MXYK
 GQkdhEOjphQKVuTp9sxbRGZXbGi8IDfvQjrkvrNOU5cL4S2fzrDOPJCny+/dmM1/7//BmQIND3
 xksTdVj+ZgoeI7nyIOqj+P4APDdCe70AAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
- https://lore.kernel.org/r/20230306112129.3687744-1-dmitry.baryshkov@linaro.org
- https://lore.kernel.org/all/20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com/
- https://lore.kernel.org/all/20221118071849.25506-2-srinivas.kandagatla@linaro.org/

A tree with the applied & rebased patches is available at:
- https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8450/upstream/dt-bindings-fixes

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- updated patches dependency to pass tests
- fixes dt-bindings examples
- added review tag
- dropped already sent patches (2,6,7)
- Link to v1: https://lore.kernel.org/r/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org

---
Neil Armstrong (4):
      dt-bindings: display: msm: sm8450-mdss: Fix DSI compatible
      arm64: dts: qcom: sm8450: remove invalid properties in cluster-sleep nodes
      arm64: dts: qcom: sm8450: remove invalid power-domain-names in pcie nodes
      arm64: dts: qcom: sm8450: fix pcie1 gpios properties name

 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml      |  6 +++---
 arch/arm64/boot/dts/qcom/sm8450.dtsi                           | 10 ++--------
 2 files changed, 5 insertions(+), 11 deletions(-)
---
base-commit: 207ecce2dffa48a738c1c4d17f889d25b7629655
change-id: 20230323-topic-sm8450-upstream-dt-bindings-fixes-81630722ee31

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

