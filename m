Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C06E1479
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDMSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDMSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:45:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECA86AA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:45:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x4so501087lfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681411502; x=1684003502;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C70yljSMkuFeZf8/ClCI7fC1wDnIxlSvZGT5yxn9eCQ=;
        b=ZT6OQbajUX9t0AcbsC4F922+uUj7h+pIVA8gzO/JgNwT7mKFGkW/AOWvkrdWz9Bshk
         fMhjZQar/Om25dsU+lptOJTeVVjGx4kUrM7vM51CaGu7WFILozfLol7ZKCEB3tSRc+2Z
         3ClF4FKJ27khht+K6+JDnw5/a61UPa8rph0gnDlDFWZiKCAUOCrc6X12IuuzR1iKJWGt
         Qmt6MI4KZr9gYTyrHCLX/LUWwjYyRGg6keX6e9N1tnlFpkJFvpSQpyKYLfLeNVrl0lpG
         QID0iosAygedVY65JPcULEC5VpzwhBTrBqaJGACAjJ8IGmdcfT8C3oSdkaZmykIxD5Ot
         N6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411502; x=1684003502;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C70yljSMkuFeZf8/ClCI7fC1wDnIxlSvZGT5yxn9eCQ=;
        b=eDe85m20wxAZ2nsObbEpFbR5Trt/lshJ9MLnLBBLJH/Dvrg2JCD7aUfLEh1Z2tBuVT
         QNaC3+6L1UCuDIeDGtC5b24Dt6RC9rJ9iSJAjE3yddqL7ud2800YPW6J/Yy2/ZCI6CH3
         viKd5CCz5yOjIPbieV++BihNITAUoa6Swpa7NNkmlpqLPkjVvFddX8nOEaKt+cqjcReD
         HMIpIV5CEPle06hzGZU3oKzjCDmtNfT3Z5TMFPXnTmNLawgoorfamPvpZ6nX7uYnbjJD
         WR8NY+VZ5q+mOQZ+t7qXR3cUslbkV7Kj1dGyBazToNHzij1ChRq1pZl1ots7IK8x8RYw
         KdAw==
X-Gm-Message-State: AAQBX9dUyvorA0l8S9VxVbuzpPDIhuXhV3Pe1tZJ0sUMsRr0TghmU67Q
        U0/nra2umk0WQKEyQibEWILqXg==
X-Google-Smtp-Source: AKy350bmJCD5sWKiQ4SZYS5hYaua2Wj26P+QZB0+ing6iXln9ikXVan8Wj6rPz2lae2ZFyIDpFkUKA==
X-Received: by 2002:ac2:532c:0:b0:4ec:8381:f8e6 with SMTP id f12-20020ac2532c000000b004ec8381f8e6mr1211763lfh.46.1681411502551;
        Thu, 13 Apr 2023 11:45:02 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id r12-20020ac24d0c000000b004e95f53adc7sm419621lfi.27.2023.04.13.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:45:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] SM8350 VIDEOCC
Date:   Thu, 13 Apr 2023 20:44:57 +0200
Message-Id: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlNOGQC/x2N0QqDMAwAf0XyvIDWymC/MsZI07gGSpV2ykD89
 wUf7+C4A5pUlQaP7oAquzZdisFw64ATlY+gRmNwvRt7P4z4XVZlzJRIC713jcwYOFII/j5N3oG
 VgZpgqFQ4WVu2nE2uVWb9Xavn6zz/bfSqO3oAAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681411500; l=885;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3YoV3IyxC0BvdlMQpRUMigDv3i7BMAqeSVbYbEew8tU=;
 b=eoAPSVadbEJXABNXYuptzQgIz8fTQKO7SYAAJLhv+2vYZ2+Tj0hjXG18KPeQEAdvoK0iF68WrfFp
 Ir+QZXEpDyyWyHauVtKj1M1dbU8cDlWHa3JzkwDcpquTOVUkZ07b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serires brings support for SM8350 videocc and updates the
related dt-bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: clock: qcom,videocc: Add SM8350
      clk: qcom: Introduce SM8350 VIDEOCC

 .../devicetree/bindings/clock/qcom,videocc.yaml    |  29 +-
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sm8350.c                  | 575 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    |  35 ++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    |  18 +
 6 files changed, 666 insertions(+), 1 deletion(-)
---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230413-topic-lahaina_vidcc-bcdabb475542

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

