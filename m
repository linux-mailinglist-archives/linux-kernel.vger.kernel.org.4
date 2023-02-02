Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613368840F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBBQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBBQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1234009
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4104995wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYAWqJvDoRygWTEoiFjYQelcbvmOngriBQBL9Sj+pUQ=;
        b=PnkWbsKDXqvff8X61o3pe5etTAzX8wapifMWxPveQ11DcvcYF68CUR/qWVD3D8DGh1
         ZAxmCrTqmokg1liAYkNdVpX1yQVumX2ATwWdUrWODQK4Rh4k//mh+9VAkvyKH5Oz+xd8
         tRdI9ykIYZS0xUomUeI0c4ohRZGgygmJPivgARD8iHzhCgg6DEPZkZVnZ0MjxzTqUcq/
         bYAFV57QiZb4bbUF9heFrEoqymmwOaW29O8E3DgPSW7fIh7W60yczAy+muBU12j2rpWM
         dCRFc3Ok1zSs+HiHluc7sbns3O1Pb7dmS8KHS218EPbH45hmJf2R8k7w9AUHasxjZIx/
         ndXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYAWqJvDoRygWTEoiFjYQelcbvmOngriBQBL9Sj+pUQ=;
        b=AIj6H1hyghsv14ly5jwVU1xgRY5xySf/f12Twhm9F4Cpy8dbTickgvc13JDuuNBiZy
         Fazs0U3wN/xF4k5WGEYBrie1OGjtlYFWiXdotFz/U/7tpCJ3O9MVuQy5x5kwHm4cWDAz
         Ti0bOInnopI7Y04KpHRRZq2VTe+egknXDqpe6DeMOfw6IG2r1TL0t2PJ9d5eFZTH8BoI
         9JQAS2Lh9/QarC1gpkXOZ2MQVfftjYQXb2YVpzrbq+TuP6RCPlRcvUfSTIn9yh7GRbIt
         hadNg4Ksdrar/dhO96FxnJO6+JYKtddWzP8Pt5keaTPPYlgHe6XwASbuSuBfF273aYeE
         /VTA==
X-Gm-Message-State: AO0yUKXJDnk9C2mtwR6SdnPK6wWkNEy0fGa1mpo4VbcZWTNew1tRvcnm
        2oAWoCYJraKZEXlMDnPqqxPVlA==
X-Google-Smtp-Source: AK7set/laZAa6VUPzgbwPB+HtPYzztQCFJurYP1QEN75sOYFz6EBJrICRlv5hY9V1wrfv2qa24Vqkw==
X-Received: by 2002:a05:600c:2e06:b0:3dc:51f6:8f58 with SMTP id o6-20020a05600c2e0600b003dc51f68f58mr6746120wmf.6.1675354776333;
        Thu, 02 Feb 2023 08:19:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/13] mailbox/arm64/ qcom: rework compatibles for fallback
Date:   Thu,  2 Feb 2023 17:18:43 +0100
Message-Id: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

If entire approach is accepted (and correct), there are no dependencies and
patches can be picked independently.  Although the best in the same cycle, so
there will be no new `dtbs_check` warnings.

Best regards,
Krzysztof

Krzysztof Kozlowski (13):
  dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
  dt-bindings: mailbox: qcom,apcs-kpss-global: document missing sdx55
  mailbox: qcom-apcs-ipc: do not grow the of_device_id
  arm64: dts: qcom: ipq8074: add compatible fallback to mailbox
  arm64: dts: qcom: msm8976: add compatible fallback to mailbox
  arm64: dts: qcom: msm8994: add compatible fallback to mailbox
  arm64: dts: qcom: msm8998: add compatible fallback to mailbox
  arm64: dts: qcom: sdm630: add compatible fallback to mailbox
  arm64: dts: qcom: sm6115: add compatible fallback to mailbox
  arm64: dts: qcom: sm6125: add compatible fallback to mailbox
  arm64: dts: qcom: qcs404: add compatible fallback to mailbox
  arm64: dts: qcom: sc7180: add compatible fallback to mailbox
  arm64: dts: qcom: sm8150: add compatible fallback to mailbox

 .../mailbox/qcom,apcs-kpss-global.yaml        | 67 +++++++++++--------
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  3 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       | 11 +--
 12 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.34.1

