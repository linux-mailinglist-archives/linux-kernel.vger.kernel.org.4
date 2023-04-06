Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A06D967E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjDFL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjDFL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:56:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D72CA0E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:54:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so50525373lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680782048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6l0BLvsSWDtkRz9aUFi9SPl6s8wHflLgsTf9M4sGzY=;
        b=VpRvDS6I2j9ZGNfd6eTalAUFSUsn9koI9Ian09vQPED8vKdvjsCIF5Fu1SWKpkP0bf
         vpz9hDindB4QpEPaPB7QJkB9pQAqatYB4kDNB4lcQiJLLNEKgZNuPKs4Qv5HWwT00tgp
         66PeA2z8H9nOGJdt/NmTJU4jgoEQMEOdCwq7wV3+BAR0HD3v8G9e4RRBhEG2WncZPHed
         1y2Y7NFfBsIqjdGClDAghvkspFg3EgjeviUuNtEz1yH8AH2rr+1Tkybfm0iGFRia1dY5
         kTbiUFYPwyZUY4KYohy+0GETM4nQN2PHQmb8sKFQwedHIf9YAhAe3ft8lw0ME4/+mZWR
         5Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6l0BLvsSWDtkRz9aUFi9SPl6s8wHflLgsTf9M4sGzY=;
        b=DWgwv79LMPdgoWDnJ0+P1skdjt9N6b/O6yPzK5YPikx3UqJaJAnyvRwVwvE6EvgZci
         ZpWsJfpqfRR2OXVu9yWAz/Oq5r6nKxFUjPL33CNU7Tv/oRBYub2aGRQg65LShWnZehdo
         PUX1Knn+Zv4wN9e+rd5oQg9gxHzT1f7SLnJTM+wdXsFVPbSWScUJcKQGRjh8ia0zA7do
         sFIgheNGJ4u2WnQ6LmbSYmgiGh1YWl9ilVbzQY1v0BpBNml8/TvetLMrVZuM5+IkYr4A
         eOV2I3ggVUiMk7v+JzCYwY0WLIkBZj1e20z5XtgoQ4nIqGBKaRj19zrU68+w2qnGlwF9
         wOiQ==
X-Gm-Message-State: AAQBX9ecuDNEUDaWaH62mZSe1Gm7VAG75LMXLlvueo1Xl0d689LudmqW
        jLDH7M75INhUHm9JyHb6xGuiJg==
X-Google-Smtp-Source: AKy350Zh6vcE5UnLaiImstkVryfvKxUr33qlr+VPS1jLGGlCPEgbn7sSgvSI9t4ILDdqaqZJoa8+uQ==
X-Received: by 2002:ac2:5d2d:0:b0:4eb:1008:6063 with SMTP id i13-20020ac25d2d000000b004eb10086063mr2220897lfb.55.1680782048531;
        Thu, 06 Apr 2023 04:54:08 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id q27-20020ac246fb000000b004eb2cc16342sm237513lfo.21.2023.04.06.04.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:54:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] ATH10K YAML conversion
Date:   Thu, 06 Apr 2023 13:54:03 +0200
Message-Id: <20230406-topic-ath10k_bindings-v2-0-557f884a65d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuyLmQC/4WNWwqDMBBFtyLz3ZQkPrD96j6KlBgTM1QmklhpE
 ffeqRvo57ncw9kgu4Quw7XYILkVM0Zi0KcCbDA0OoEDM2ipS1nJRixxRivMEpR8PnqkAWnM4mJ
 87U1bVrqsgd3eZCf6ZMgGtuk1TTzOyXl8H7F7xxwwLzF9jvaqfuu/zKqEFMp51Spb87W5TUgmx
 XNMI3T7vn8BIrms3tAAAAA=
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680782047; l=1344;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DD6FViUVUcssXUqtTtIT5cucIdZI183Y5KfYcExKX2s=;
 b=LtDRqLSySben0gRtpKCibrMbBVd8LsDQiiPxSGvgNhiosTTH0H+bs8YoXF0yI1n38dZ+Ew9Yv1mG
 tYGUwRCQCOZn8JFNK+Ceen6aJB2g91dOKePIkA+fCR5kochUpC/a
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:

Dropped:
- '|' in /description
- /properties/resets/minItems
- Unnecessary level of 'items:' in /properties/ext-fem-name
- reserved-memory in examples
- status in examples
- labels in examples

Added:
- /properties/wifi-firmware/additionalProperties: false
- /properties/wifi-firmware/properties/iommus
- /properties/qcom,coexist-support/enum (and reworded the description)
- wifi-firmware and supplies in the SNoC example

Patch 2 is unchanged, picked up rb.

v1: https://lore.kernel.org/r/20230406-topic-ath10k_bindings-v1-0-1ef181c50236@linaro.org

This is my attempt at (finally) moving ATH10K to YAML.
One inexistent dt property came out as part of that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: net: Convert ATH10K to YAML
      arm64: dts: qcom: sdm845-polaris: Drop inexistent properties

 .../bindings/net/wireless/qcom,ath10k.txt          | 215 ------------
 .../bindings/net/wireless/qcom,ath10k.yaml         | 359 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   2 -
 3 files changed, 359 insertions(+), 217 deletions(-)
---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230406-topic-ath10k_bindings-9af5fa834235

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

