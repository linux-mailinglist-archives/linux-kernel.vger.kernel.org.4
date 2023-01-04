Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB765CF5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbjADJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjADJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:18:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA81C128
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:18:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay40so25116662wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fn5vH+KW5nEUuinnNq/HTPC59xGXcsOGx6a+Sxen6fw=;
        b=srUASbNGcVfYiHEQXkkQWVUp5h3p9GhJZ3PqATn0zStqZIkjl01ERAnYbbPHoSK++A
         SD1uUVJ2L0MtRQddKAUi32WuHE0COiSSIqsa5Dv/UofHSc5rtrBKWQNii6rRKMRmsBAO
         SPcI2/V60qsLw8NRTH2LH1qqiXE+UubPLFYJwgt56Wt8MKmemGv47py6FCkLykKmgGS0
         RMxLJX/q+Mpq5PYz7KlnK1PziLhGp6fx1Pj4gHy+hcUJZcqbFPonD4NnQrbniE2mq7RR
         cCix2y1PV3HU5oYGOhG+4MtZjygUbSSdpwYTswXx3KFYjmyGKsOLbG43RpCzONc0bZdH
         HiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn5vH+KW5nEUuinnNq/HTPC59xGXcsOGx6a+Sxen6fw=;
        b=7KJgeqq7Gvqnwgsw/3U0jM6mpFUfqynhkX2rs9mlR4uZRLBztl1JiB1jVXdtKGm1qb
         OFp+BkrqngPZDBX3vQHO9SdN3HWS6JOei74dt2cQEXMNouI660hel+X8UbxMnoXUiiOt
         k4xRXddYuSF/rAD5u4rCv0Y3S22LfhKA9IUidV5ZX/6wBR0TCEu9AxjQa79kSeN/eyx9
         4zEaaW5ihyJ5gBLfZUFY4OWf6bgjsrvGOZIc4HU83wMKvN0VcA+MXtRhzxXpLEb26Vhr
         rcB5smeh8yRC3f3nVe5VhtTRPTjxWa4nhsaD2J4mwSFU7yGuIzwUao9nuelWfB1TKism
         XC7Q==
X-Gm-Message-State: AFqh2kprYhHxP1joSV+M9VKgZK/Wr3XXJ3gJtJqll+TjX4921TwGh1Bp
        JGeK2TdaJYvQYIXXJV7OLxj/lw==
X-Google-Smtp-Source: AMrXdXsPNN6g1WFooyrHyZAnJcaS+fc4Rn5GkgGFP+7x5/4Gp0ugZzFcgfKyWmgikV9puL8IqTZSQw==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr36597223wmb.30.1672823902446;
        Wed, 04 Jan 2023 01:18:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k6-20020adff5c6000000b002a01e64f7a1sm3488656wrp.88.2023.01.04.01.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:18:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sm8550-mtp: enable DSI panel
Date:   Wed, 04 Jan 2023 10:18:20 +0100
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v1-0-aeab9751928f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxEtWMC/x2NQQ7CIBAAv9JwdhNA0cavmB4WWO0mlBKWGk3Tv
 0s8zhxmdiVUmUTdh11VerPwmjuY06DCjPlFwLGzstqetdEXaGvhALKMzmnYirRKuEBsApGlJPwC
 orXeXUdCc1O941EIfMUc5l7KW0pdlkpP/vzHj+k4fuysq62IAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for MDSS, DPU and DSI devices on Qualcomm SM8550
platform. Enable these devices and add the DSI panel on the MTP device.

Dependencies:
- [1] SM8550 base DT
- [2] MDSS/DPU/DSI bindings
- [3] DISPCC bindings
- [4] VTDR6130 Panel bindings

[1] https://lore.kernel.org/all/20221230202230.2493494-1-abel.vesa@linaro.org/
[2] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org/
[3] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org/
[4] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-vtdr6130-panel-v1-0-9b746b858378@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (3):
      arm64: dts: qcom: sm8550: add display hardware devices
      arm64: dts: qcom: sm8550-mtp: enable display hardware
      arm64: dts: qcom: sm8550-mtp: add DSI panel

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  78 +++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 295 ++++++++++++++++++++++++++++++++
 2 files changed, 373 insertions(+)
---
base-commit: 3413711161cca59e1247d3c5ba0c6261d2b20dc6
change-id: 20230104-topic-sm8550-upstream-dts-display-aa22b568ea17

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
