Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3FB702D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbjEONEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbjEONEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:04:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD719AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so14772414e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684155866; x=1686747866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qOOVLoZ7d6iq9QnLmohIqCF7YVgFgLufY2UtX31c3g=;
        b=B5Vn7Ga9RZniHwlLDAnbYNQc8kuaMZtBduHxR0kgmW2NZALzTTpPeBfvbQqttM7iOe
         zgmbfN6kXLDMKYIlDWk+B8egrg/2M0teG9fX22RQtfX4U7gFwU188i+K0dhpO+UKaUqG
         nPvFSeL4w7lhfwLCPWrrTmSSiktDW7kLYftj0h/dkMiN3kJFijdaSSY/+0zi58rcjBS0
         pDEP/JW2R1B5XDbqKxXt2XBJl810VgbAVBARBIF96rs2kAAjVJciTegUMKz9CV0Jku7c
         /pWJNsBEj46TGaiHH6gLyG02aXqnDuwRjXpRahJTr+OdLYEgrCZ8E+b2a/GM9sHzcCgQ
         LEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155866; x=1686747866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qOOVLoZ7d6iq9QnLmohIqCF7YVgFgLufY2UtX31c3g=;
        b=TVv3i2fAnumwhJnHv8XDjlTjAsdVUBZzHV1RVIyimu5gjPVL67ETKC9U1OYa6Ky00b
         NtFIrEASj7YC6bFSn1pa01i16C59bbHL5CyP1YOQmSk5Jbbld0x+H35K3YoAm73fPUwa
         fTLezJOhdfYgBCJOeEWGw/ahrtLZdgqff5ANdY1aXbAUSdi6z2NB5Siapy0YvvXAi5Jy
         YGXdTd7sKjLt0WwYOgjMe8b1qkq2JU4IWPe4fHSxFU6N6Tq8FgBHPlKw5AtFy+n20Qy7
         tVkTWIbWUjvF9z/mqhdE5lZBoTCm5glbGmlt7NosODw99E/UGEIQfXe+15asokI5oQC8
         R2PA==
X-Gm-Message-State: AC+VfDxD80LttKMDE6XOpgeL9m1P0FxBkuxJHZI4wOvgnYS72/gS2fLh
        kMD3V/y6R41z8yzdpiEBNygfFg==
X-Google-Smtp-Source: ACHHUZ6vEwnZNt2axy9SRST7z7k7A1Bf61I67GfYaA9QHnBQUFUtK4OlRnQ9zZED2nRm+tbAIQXOXA==
X-Received: by 2002:a19:ac0c:0:b0:4f2:5f41:438f with SMTP id g12-20020a19ac0c000000b004f25f41438fmr5215956lfc.30.1684155865959;
        Mon, 15 May 2023 06:04:25 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x27-20020ac25ddb000000b004f37a64c90asm785823lfq.303.2023.05.15.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:04:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] QTI RB2 features
Date:   Mon, 15 May 2023 15:04:11 +0200
Message-Id: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMstYmQC/x2NQQqDQAwAvyI5N6CpW6RfKT1s1lgDskpiS0H8e
 0OPMzDMAS6m4nBvDjD5qOtaA7pLA2XO9SWoYzBQS9c2dQn3ddOCxoSsuyOR3IbE/dQPI0TE2QX
 Zci1zZPW9LCE3k0m//8vjeZ4/E2B3LnUAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684155864; l=1058;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AvI1J3YBY2mPSZd4zpFBwmRREycIcg0BtXWH7GN1nso=;
 b=LdzsWIHvDeAki6bxoFRwHxJm3yCF16X2wn3VwyH1xX/d6wT3uDQjVUsWRccYV8XytOwGR1d3q
 msHAPRzkWbnCu2CX38C13iO6/1xMar3Mq5lSBKyK0NbIYDF7J0HFZXO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series brings a couple of fixes and features
(such as display out) for the QTI RB2 board. Similar patches
for the RB1 should be expected soon.

Depends on and based atop (in order):

20230505075354.1634547-1-bhupesh.sharma@linaro.org
20230502053534.1240553-1-bhupesh.sharma@linaro.org
20230505064039.1630025-1-bhupesh.sharma@linaro.org

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      arm64: dts: qcom: qrb4210-rb2: Describe fixed regulators
      arm64: dts: qcom: qrb4210-rb2: Enable display out
      arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
      arm64: dts: qcom: qrb4210-rb2: Enable load setting on SDHCI VQMMC
      arm64: dts: qcom: qrb4210-rb2: Enable CAN bus controller

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 ++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 3 deletions(-)
---
base-commit: c768c054f1a722d4b973ddab81ee580b7e24a891
change-id: 20230515-topic-rb2-bits-22e685b4f48d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

