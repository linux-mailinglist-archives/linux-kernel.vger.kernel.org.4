Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363EA736A45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjFTLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjFTLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:05:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BBE10E0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso58003811fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259135; x=1689851135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b75FYxuvT/RTDVWXxiUHRtH4AAZYp/PYI//JWD1JyWw=;
        b=BU/Gjl3U+T+036VROq++4hCxSg0HX9YYLA6VJmupkKRRGmaQg47DjxNsIU5ajRMmDh
         bpsvoWuxJQ35JIqdKnNnCFS3zbmnlKJeHdRWe7KeRrOmH+zm37H91kSWsGMas0JPh9hT
         rwOFcj1wDl3fyV5wc4LTkzah7j+IXQgTJ/k9IAi5JEmW/X5HL4wN89SmRcAtOUW0wVaR
         5NotegZaoBrGCXLOGF5/PyylkRa4y0YhM7VKAgn4pINWtv756XQCcYy81QBQ/9eibokZ
         b4umxykDm0ZWig9vD2EGu23KjNt7+FSxCIOZchjn0hZsn3oR3rXTwb2MJypvpy2bHxFs
         Czgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259135; x=1689851135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b75FYxuvT/RTDVWXxiUHRtH4AAZYp/PYI//JWD1JyWw=;
        b=AUXzCcdiGlzfJVL1XNXdCURQgOpmimb5F4dVyaIqrjpjegfsN6wY2xIM3cjK87rMeT
         ibLBUyYpY6z4+ia9vx16ounpdgWzapJ6Cq34Lzek65tvyDD8Yed3Ynr36j3GiT+xdg/d
         WLinBP1ntznnnkan0UZ6lOHak2oIfj2xzmHhxzLxDwP8+RF546sm8t1jbapFgHqMBkSo
         oJYZzAYK55EGpkbphtrzlQXd+HZ0zpda6kzX+NJ80VoaDjyw20GNQj4JLzFlbpKgBi1k
         q1Qx9sPMLixMWT1MLSH2PHziqVJy+yxcgoJc0D58HzU4CjhXnlWfsN+7rkVlJXQKYVJJ
         NRSw==
X-Gm-Message-State: AC+VfDyi3nklvUwszu2UcsgaBEqyZ/6k5l8xfgYzMH7hlT+3PHRn96W8
        HdHxUzPvO8KJ3iCDyQDk4+Hadg==
X-Google-Smtp-Source: ACHHUZ7tWYoedG8hXxOX/lkMppk7hoaSV8JNZTqDLhxtxfFIuWplsbQoA45PSqsHLLPETYoP7tYnlA==
X-Received: by 2002:a2e:3513:0:b0:2b4:83c3:d285 with SMTP id z19-20020a2e3513000000b002b483c3d285mr2188693ljz.38.1687259135655;
        Tue, 20 Jun 2023 04:05:35 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c008b00b002ac7b0fc473sm369047ljq.38.2023.06.20.04.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:05:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] SM8250 Edo pins, keys & pmic
Date:   Tue, 20 Jun 2023 13:05:33 +0200
Message-Id: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP2HkWQC/4WNWwrCMBAAryL5NpJECcUv7yFF8ti0CzUbNrUop
 Xc39gJ+zsAwq6jACFVcD6tgWLAi5QbmeBBhdHkAibGxMMqcldUXOVPBICHSo2CuQ0EqzyZi6ny
 0SXsbvWixdxWkZ5fD2PL8mqYmC0PC9367941HrDPxZ58v+mf/fhYtlQyp65zyLhgbbhNmx3QiH
 kS/bdsXF7rITtIAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259134; l=1097;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lsxCpXK9lusbdQ0WpahHP1F9ZITtSHhAZWslr5vKO6U=;
 b=Lb+0br68Z6t46QCzFZr2gzNbxiUzsY5K/+HvKJs12oRpZzO46OnLShnLJuKcHfVACiJyonfkf
 A9CvlbEUVzdD8lV5zibHD0EZ2T3oqWrjUuynCI/wAZs56Q/QBIcGb9Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings fixes to the GPIO buttons, adds gpio-line-names and
introduces the SLG51000 camera on Xperia Edo devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Fix the Fixes tag in patch 4
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org

---
Konrad Dybcio (4):
      arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM
      arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sm8250-pdx203: Configure SLG51000 PMIC
      arm64: dts: qcom: sm8250-edo: Rectify gpio-keys

 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 364 +++++++++++++++++++++
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 243 ++++++++++++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |  61 +++-
 3 files changed, 655 insertions(+), 13 deletions(-)
---
base-commit: 9dbf40840551df336c95ce2a3adbdd25ed53c0ef
change-id: 20230614-topic-edo_pinsgpiopmic-df8bd6f1b6db

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

