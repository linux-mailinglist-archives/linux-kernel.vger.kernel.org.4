Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECF62BC56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiKPLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiKPLpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B0B1CC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so29404994wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJa49+SFGyPy4pWOg5tRkuaf73CkDKs/OmsmB/aVplI=;
        b=LLBoVeqte/yLUsYdwDnhxaquY6+svAq8TyvUw9tI/WGmiB9v5RzkcpqsNSl3yr3xNi
         jUv2ydVhLGZ+KmjjNTcO4KnIHwZhCIUwIXmRuF7rv+9AvOWEswenBJk8GFQTQaplj5rn
         yvqWw7KDGsK4pEuKieL0YiCKF0RYKVXth09/2V7FZzmdT2nm5EhAQZrOojk4iSA17Bw7
         46B87erOwDU1Xrq5rCwiVMALjqaSO3BbwZcY4DRmzBMo6TICNWgCbe3NwLxkD/dfunRy
         p/NTyywFXASmdxRLYW/he/8fVvkeb6eveq+Iywwyifhrv+Xy46l5RUSHbuq2HdoQ2D25
         lmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJa49+SFGyPy4pWOg5tRkuaf73CkDKs/OmsmB/aVplI=;
        b=AHRSIsCQwvx6VpXChCwiVNQ68vDLZ65t7++t4rFyVuSY95SpTL/WBBTuHmPIU5cBqw
         hSQHPKvNbi98o8x/gjE1cKSKNN8AUQR2RRvW7C2UKQnx1hxb7bFMd3b8uJORuXsdIBP3
         N2UBjfWmdqzxmCUJVZ9kXN2bS1QMxJqWJbBh6sfbWl9Ij4sRrQry6H+GJBMNu2baJjTG
         8XDY8xwv6Tt8SZvG98iPPUgKZQ7sn9z70nKoqQOsbxOmt+oGTm2tVqip8OAoBgnUkLMS
         4Qsb9XOgNaEMW9bhlTQ0jMAMmDFfLbMV2HleHyBOrlxiPwZsqGQLUnmacsO4QAg+yGxY
         agUg==
X-Gm-Message-State: ANoB5plH2VFyv3SuiSC07tzB4JKiJ0T/xm7iHrW7whbF1oNESJXQFjwT
        458IDm7B9tYY0shugbAjYXcAxw==
X-Google-Smtp-Source: AA0mqf4qu4RfnCrm4EvGiH3JczgbGLyHbZiqYpX4w3+S4kk4yyXSEcU8M1M/mz1+JliPDLijtZx68g==
X-Received: by 2002:adf:e3c7:0:b0:241:94bc:2796 with SMTP id k7-20020adfe3c7000000b0024194bc2796mr7013867wrm.184.1668598221870;
        Wed, 16 Nov 2022 03:30:21 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003b3307fb98fsm1929489wms.24.2022.11.16.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:30:21 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] soc: qcom: llcc: Add support for SM8550
Date:   Wed, 16 Nov 2022 13:30:02 +0200
Message-Id: <20221116113005.2653284-1-abel.vesa@linaro.org>
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

This patchset adds LLCC support for the new Qualcomm SM8550 SoC.
Since the SM8550 bumps the HW version to 4.1, add support for it
beforehand.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

Abel Vesa (3):
  soc: qcom: llcc: Add v4.1 HW version support
  dt-bindings: arm: msm: Add LLCC compatible for SM8550
  soc: qcom: llcc: Add configuration data for SM8550

 .../bindings/arm/msm/qcom,llcc.yaml           |   1 +
 drivers/soc/qcom/llcc-qcom.c                  | 166 +++++++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h            |  12 ++
 3 files changed, 172 insertions(+), 7 deletions(-)

-- 
2.34.1

