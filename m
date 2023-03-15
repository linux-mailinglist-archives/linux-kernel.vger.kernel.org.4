Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB756BAD66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjCOKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjCOKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:18:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C47BA1D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:17:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y20so1028174lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678875452;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=792LmDJ8teRcLiduMYOOEMxllJ02PudSpNSa8LCDDHM=;
        b=bwSGf0FV7ufH7RT9ZFZ2xd7Sn1KtkQe0s03CActWUMnnypvzsoFAs8RvuPJg/pTxr0
         pxb/4bj70qt74OlwiW+RHrfNlf3GoF/lTJXcXVhWrzpHgURxcGoUdziWe3PeiniVwb7/
         PbdSo05/u+2lcNtindMj+MTEkn96BITECda6XkNH3UpIc3EPciLOyFHZNHA50+MMhYW5
         QwIMSup72IzByTaJESAdSYujLT3LW2mBuA9F0BEGnGGfPiIIJ36ZgMLwuM5WNu2Xp0F+
         UqKNe0Z/pxg9CIai2PcEGmTEZmOx2crZP5BKL7WvyIDpH4aQzQ81yIPINQEDuq32ZOIF
         mX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678875452;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=792LmDJ8teRcLiduMYOOEMxllJ02PudSpNSa8LCDDHM=;
        b=o0kzkmHAiXRSopbxG7/xubbIrP1zrGZJCBKCFFzTmVobcn2oolb1J/mQ4C97eKigdu
         Hj1T3oPPSYA+08r/lgKsAGPmkH0Xq7TqlNXEUAx5bwynGIIRJ3frVoq3I6qIxYlpXtG/
         N+xdOh3yJOueAFM6exNjqkzkK705bhiOUjMaO7QHT1pH3AxmaVYHxo2niLmsVjqXHPJe
         FC91lyoqIRvo/FxLq7/1M9lPgD5bWIzPPdSoQh/j4Q/tcTzN9iUlIFEpUHR4n/n4p5BF
         iYoUBMlmP0Qg9A+h7z4Wt7W00D5v5KQmiBesV7twkAcPVV+4pA16DNNudQIGK3yq5xi7
         6qjA==
X-Gm-Message-State: AO0yUKXKQ+TkylnsUaWLuMm9kRgcXdvfMPOh2zP8OnWhI++kTPF4wyGE
        i55rkcL9qFKCGibPmCO75SYQpQ==
X-Google-Smtp-Source: AK7set8rFwncD8iA/3PesTIVjEOf27A2NKy3L2s4ixDSEGnXIzOFKKd9Y+tGHO8wYfJXFc34Qc9Jyw==
X-Received: by 2002:ac2:4142:0:b0:4d8:75f8:6963 with SMTP id c2-20020ac24142000000b004d875f86963mr1705962lfi.38.1678875452148;
        Wed, 15 Mar 2023 03:17:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f16-20020a19ae10000000b004ccff7c56a8sm764350lfc.27.2023.03.15.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:17:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] QCM2290 socinfo
Date:   Wed, 15 Mar 2023 11:17:25 +0100
Message-Id: <20230314-topic-scuba_socinfo-v2-0-44fa1256aa6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWbEWQC/32NQQqDMBAAvyI5d0uMaa099R9FymYTdUESSVRax
 L839QE9zsAwm0guskviXmwiupUTB59BnQpBA/reAdvMQklVyarUMIeJCRItBl8pEPsuAElN6mJ
 t0+ibyKXB5MBE9DTk1i/jmOUUXcfvY/VsMw+c5hA/x3ktf/b/ZC1BApKtsUbTWH19jOwxhnOIv
 Wj3ff8C1wodU8wAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678875450; l=712;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nvMg5I/+zuiIK7gm8cXtuKG7ykD3i/oATwQYOBTYkcU=;
 b=oe/4n5BFev5DbiOUKniIbjRCZaZnxjvrCQX4Sl1LJCcRUlVHrCk5pu05OLzv52Ag5AZb/PJy+Mqd
 dJmLUrnqAEJeBfIeRgEU3AA+U/nejE16ljuhaeXqr7G1eU4rcmVx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Sort entries by ID [2/2]
- Pick up tags

v1: https://lore.kernel.org/r/20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org

Add missing SoC IDs for QCM2290 and its robotics variant.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: arm: qcom,ids: Add IDs for QCM2290/QRB2210
      soc: qcom: socinfo: Add IDs for QCM2290/QRB2210

 drivers/soc/qcom/socinfo.c         | 2 ++
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 2 files changed, 4 insertions(+)
---
base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
change-id: 20230314-topic-scuba_socinfo-c04c25dd9948

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

