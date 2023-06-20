Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13179736CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFTNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFTNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BD19A9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so43780571fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687267082; x=1689859082;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVOdNiEd3QtveZDzDg3FsMJG7kxU4f80fKhWvEhaEaM=;
        b=vaXlCq4mGEiZSlvEza4Habx9SP/IfH2ZIfp57+w94uElLSArC5U2D5cVcE1HNVadKp
         NsoYpFT/T2SfnFNlbyqoEGaxgMZmpT6Mx+rDQ1MX1Jb+q8cFTFo20YCwxOl76kse0pCD
         Q1J/+sO/KVGTLLHiS1PuCr7Siy6NwN9cZm/gy8EmFDmtVDKpZJnwAy0htnUTez+pPd3Y
         8c3rNl/uAt3HxtXW/GtsxdP6lUI21W8Too/JDKyTH3et4WPJROVSFhnwSe0PP5eUFj9N
         GgSTvBJ10W6WUKC5icGx6OnVh2ruLkFET/VqkjVm/KTaXoCoI2cd9zsnAx5b6aPPmRgE
         JZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267082; x=1689859082;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVOdNiEd3QtveZDzDg3FsMJG7kxU4f80fKhWvEhaEaM=;
        b=d0B8hA0jjvq8/XKXzCRyNQmhSjthIZxZOyxaTbGoEcgRL6i5F3cQJh3R922vGnlbj+
         tUCjMg1L4NI8vWsJXhpzz3H4FYfpZ/2erH8bPmXsWwiGlQHl06wY+LBUvouGLmath1MI
         77WQxORc13fpkpfp0LkrcONLLH0opbrTpCROi0fx82N226FIt2RiFB1wC9FeRbjrAuT3
         Vm+maz5RBe/DC8mRruCtSZtRDpJEdf8YdlfKQp+YrCDc8E3iDL5o65TZVqhz5bJY+HmF
         sq7RkaA1/WX+rQ80CEKmlWKxhz6pp5vKg0Ua54qC6AIH3LsCGGXb4l7WY7qKp1wnN22Z
         tK0w==
X-Gm-Message-State: AC+VfDwTbZit8s8Mp3BtCj3vhn3Edmi6goLEzjFCzjv8R6AExc9s/kSW
        Mm3tQuXq/oNZ2IVwZhtrWnrC7g==
X-Google-Smtp-Source: ACHHUZ79ZlCn0m4GZ9VNXHrUz7bP9VIrjrMLch6qLGBufeZH5e0N65/dSWFpYQgWpd3LgCZnu0t9Mg==
X-Received: by 2002:a2e:b0f0:0:b0:2b4:8251:7c89 with SMTP id h16-20020a2eb0f0000000b002b482517c89mr3028384ljl.28.1687267080873;
        Tue, 20 Jun 2023 06:18:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b3318c8d6fsm414433ljl.28.2023.06.20.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] A610 enablement, J606F display
Date:   Tue, 20 Jun 2023 15:17:44 +0200
Message-Id: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPimkWQC/x2N0QqDMAwAf0XyvELtVNh+ZQxJ00wDpZa2joH47
 ws+3sFxB1QuwhWe3QGFv1JlSwr9rQNaMS1sJCiDs+5uJ2dN27KQWfI+N/SR2xykZkOBJsLxMfQ
 0gLYeKxtfMNGqddpjVJkLf+R3zV7v8/wDgOGlM3wAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687267079; l=846;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zivfHVW7lha8lc01hiAsybuK9fAUZIvzRT5Lhvc+9EQ=;
 b=vcPPYNv0dOWEXpk3byHiurjBTlH7DgDagTMg5Dw8ar23lf3hZhW/NS+ORSay13wqPOOzf/kXN
 UxEpUwQ8Oh2Cr3i68027Usz7Og5UgW04e59NBtxmC9rujiFz8/K006N
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the A610 GPU on SM6115, as well as on the RB2 and J606F boards.
Add display support for the latter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      arm64: dts: qcom: sm6115: Add GPU nodes
      arm64: dts: qcom: sm6115p-j606f: Hook up display
      arm64: dts: qcom: sm6115p-j606f: Enable GPU
      arm64: dts: qcom: qrb4210-rb2: Enable GPU

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts          |   8 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi              | 103 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts |  65 ++++++++++++--
 3 files changed, 171 insertions(+), 5 deletions(-)
---
base-commit: 9dbf40840551df336c95ce2a3adbdd25ed53c0ef
change-id: 20230620-topic-gpu_tablet_disp-cdc6ca5941c4

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

