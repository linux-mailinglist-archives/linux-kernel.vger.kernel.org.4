Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643696F599A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjECONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjECONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:13:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE355A3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:13:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3062678861fso3003456f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683123211; x=1685715211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwALSkvKDHtujUw26080EGh0+IX6T4U1b0JJECQI5Yg=;
        b=K65F2ABVlyAL5wa9u9bqzQLkeyIIggK7j19+oSao42j1/RNz7OyFUTMGo3LtjYJpKP
         OTpY+8jveYg9IWMFwE4REgNuutGIa+llCy6+orIq9KHAwsHztZ+DKdMZq85Bqtfeweus
         i/bSo7quw4zNEjFdZiHT9Gw/XQFVO+Gl7YOnyXevNfV/cL5PagfdU1umZZKnQaY0+y4V
         UJJsf2x0UJa8v+vNywF/UwVJy/bKTPtRNh0ykMRgy79a2zTYozLz9X7glDyNKBalbdUv
         v8VRlruHc2KTDRPAQ/rh60rrltoFbjc9rZ94c3bAXXsL2+tdpg/4c9+K0zxdIqfQyzow
         m0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123211; x=1685715211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwALSkvKDHtujUw26080EGh0+IX6T4U1b0JJECQI5Yg=;
        b=Bmtm1xNPe+25MrnuZS1Z9BcLUtqJDkbcVgQ8d+lc/a4AEwJcLSWbgLOUTGYKxfjgkp
         NImeNmJ0D8G4lg+wLFDAzqtcc5m7q+ZZifIBTRERBoj/5GeE1wQg28WG+MGG+SDERa3p
         1Gpw+WKMgsszJxlF/rOydpmS3hU6yGwsBjXqJa0FGUtRl/WJNt9IO7oH91MkSDKycxOT
         Ei63gjPZTJDMZM6oAUI9OkbNbUX9Z1fUMVBMKJKIDASva9Ku62yWGiCVhimTOxFQMknn
         AYCk1hUbBXwGgHY332/ONcRLXkXDIw+3C7n7PYgTC3xOKoRj14JFF/h5Ki0evPwooNoY
         Y/uA==
X-Gm-Message-State: AC+VfDykVOwRCZyUTJDYu9GPZL66pKUuYgctPUTL2dRFrhhWup3jsFFx
        21rwKK9Tf54ZH16SaVCm38Z4UA==
X-Google-Smtp-Source: ACHHUZ6MOkzQkyGfaWvMMNk9dao/O7ohimeenJ7zgWo1S0c9nTeu1hwQA5p6/NQlOj2aDZe7xu4+PA==
X-Received: by 2002:a5d:6241:0:b0:306:2c47:9736 with SMTP id m1-20020a5d6241000000b003062c479736mr175182wrv.15.1683123211117;
        Wed, 03 May 2023 07:13:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a056000100d00b003063c130ef1sm3028638wrx.112.2023.05.03.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:13:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: pmk[345]50: enable reboot reason
Date:   Wed, 03 May 2023 16:13:27 +0200
Message-Id: <20230503-topic-sm8450-upstream-reboot-reason-v1-0-c5ac3dd5b49f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdsUmQC/x2NQQrDMAwEvxJ0rsB1ahL6ldKD7SqNILGD5JRCy
 N8relpmDzMHKAmTwr07QOjDyrUYXC8d5DmWNyG/jME737vgemx144y6jrfgcN+0CcUVhVKtzSZ
 qLUhhyqMfUsx+ADOlqIRJYsmzucq+LHZuQhN//+nH8zx/SDjG5ooAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EON79yjoVMWcDaKmyYQsV72yLHaegDJtRDFwAQR7DHY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUmwJNcUBNiXogIwF9iTh1raJDqEw4lawPumc4Gho
 oVJOnDyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJsCQAKCRB33NvayMhJ0W6gEA
 DHQvGUX2jQtEO4t9fk6Y4boD3lb2ELVyTrZK/sTFkmJI9HcN5eEDeX+lmSIGy9+DKRBHn5DpZ34FUt
 fVpH2PQcZJtiUBYr/4FvO60VpJc4qjlLxXu8i6wn+fdpUoLBw2EYHIU4CUvYd5vHIfDfi4zFF8sPIu
 yRr+9EuJFDQZM394NdR9R83uc4LT5GM2WY0LO1xCeS/LjdsmXjcVCz+8sS1OwyffcyqsQR8nhyimiZ
 tFnyyPcXIv0EZphFRhIi8xiYR9wc8Mmf/X5BwxQ/Bf3wAGTh1uT1MzUmizFDdlmr3ENg0svEiQe8eH
 V6HUacMQy7+I6efzIwOleolRy61IiA+voPu8Ppr1MHVDZWs+JvRzYvMht9opTcmjXVboJqOKVRYQBx
 sG1q+h2RmEi4rQqBOfxzyRa+inEG+XDxNTnHZAevo44HYjBagqQAEAUSjNOx+XQ3FAm6j/baKdBzZs
 0v9egFp7p1a1rb8eL2g6vmTxO/F5jX+OKNwU7bXS4jGq/vMD3htRfV1Iugy4MeAD/FGXrREawZbLFt
 Vwv5ic5AzhI9LSjwgL1a327U8Tn8jeImLtxrrqh2jHu4ymV58Aa4wZv89p87FeflM0za9O79nt4aaQ
 dHuC7V/OpyPgZ0eWvRJNPgH10dE3uye+zJMIpK7HIM7Ks9ek1Sl0oNJkDQlg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like SA8775P (at [1]), the SM8350, SM8450 & SM8550 platforms uses
the SDAM2 nvmem to pass the reboot reason.

This simply adds the sdam2 and reboot reason nodes
in the pmk8350 and pmk8550 dtsi.

Tested with:

and

triggering the following ABL logs on HDK8450:
  KeyPress:0, BootReason:2
  Fastboot=1, Recovery:0
and
  KeyPress:0, BootReason:1
  Fastboot=0, Recovery:1

[1] https://lore.kernel.org/lkml/20230417145536.414490-1-brgl@bgdev.pl/T/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: pmk8350: add reboot-mode node using sdam_2 nvmem
      arm64: dts: qcom: pmk8550: add reboot-mode node using sdam_2 nvmem

 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 23 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)
---
base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
change-id: 20230503-topic-sm8450-upstream-reboot-reason-e5fc827bac27

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

