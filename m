Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F26C7BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCXJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjCXJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:38:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C312365A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:37:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l37so726430wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679650676;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo+N+zh7l2Lx3IrEo7K+kadeIQouJNq22XibHO/II/E=;
        b=euR8iyBOS7GSUEIvAnONkwpFddBnabdrZW2vsdAQpYiSivWX15hbHfdWbBk9aBRhhx
         g/QrYs2NfN+ixKmILhdMfW3PRfSSiOz4mmNKAYlR++x8LqQLKeLUUG371mpqqlXQtfhT
         EkOOtG3PkXyjv0zZVCxqCdlxShertr9Ng26j48hR+QqDTX0WWHCrcigx39uiSJlSk6uw
         Y6fJv/dLxuclxC5mcA3Sm00iO20BpWa5A3KqHbWbK8S7BAXlheemhWOxugP+14C9T5tD
         yFTFdJAZsC13iBu72lgecUn/Jnp6yT0zn32b2tmLTCTVfsdFmkCEkVuvELd4sDk4X1yp
         gIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650676;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xo+N+zh7l2Lx3IrEo7K+kadeIQouJNq22XibHO/II/E=;
        b=71XPsR97gwgQuHJB02QCtjmmKjOlFoXbR2o9vOez3RyuQRdPHniTjCzaXbo6Vvhpdt
         Mvr0wYt5EtuJUzv2DcuBJYC/c4BLYNv8zP+roxGan+h1bNZCKM4NHT2Fg0cwm3QahHlA
         1P+LFjBCPDCK+bMdvn089TO9Czvd3GI08+EJZLAJ3FsYgmJr//uPTDJ4aL9VAF/HRcqR
         ldI5Str0j31xzIXPSp6EoMMlZb++ouirrUljPV44idcfH4rhLcrR4ReSPyOikY8qRFIX
         NGpjD6mXov6s8/qMWj3cPrePXrTCOpZbr5GqIU5yV39tJXAeReAPqXWpZGzWVm9I29Hw
         Dk5A==
X-Gm-Message-State: AO0yUKUos8JjhNMWZEgJhMyOPzTV7bNSOC4sO0bmRU3AxTBXzeIjj8Hf
        coM9A6KS0xBBmCeldlmLTaetXw==
X-Google-Smtp-Source: AK7set/ctZ50Tt1iJTlpemO+Af8Nfpb00/mJ9XozvF8VCFFVkLMpJwQGxdngulEu6b8lGYZPW4zvlQ==
X-Received: by 2002:a1c:7412:0:b0:3eb:98aa:54cd with SMTP id p18-20020a1c7412000000b003eb98aa54cdmr1814451wmc.17.1679650676045;
        Fri, 24 Mar 2023 02:37:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b003ee9c8cc631sm3406853wmo.23.2023.03.24.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:37:55 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Mar 2023 10:37:54 +0100
Subject: [PATCH] arm64: defconfig: remove duplicate TYPEC_UCSI &
 QCOM_PMIC_GLINK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-topic-sm8450-upstream-defconfig-fixup-v1-1-2d75cc9b3c3d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHFvHWQC/x2NywqDMBBFf0Wy7kAexj5+RbqIcaIDmoSMKQXx3
 xu6PIfLuadgLIQsXt0pCn6IKcUG6tYJv7q4INDcWGipjTS6hyNl8sD7o7cSauajoNthxuBTDLR
 AoG/NYKwanA3P++CUaK3JMcJUXPRrq8W6bU3mgm39Px/f1/UDkteAMowAAAA=
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both configs were already applied by 2 separate changes,
fix this to avoid:
arch/arm64/configs/defconfig:989:warning: override: reassigning to symbol TYPEC_UCSI
arch/arm64/configs/defconfig:1232:warning: override: reassigning to symbol QCOM_PMIC_GLINK

Fixes: 4ffd0b001956 ("arm64: defconfig: add PMIC GLINK modules")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b6e437486537..c4f231b70898 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -274,8 +274,6 @@ CONFIG_BLK_DEV_NVME=m
 CONFIG_QCOM_COINCELL=m
 CONFIG_QCOM_FASTRPC=m
 CONFIG_BATTERY_QCOM_BATTMGR=m
-CONFIG_QCOM_PMIC_GLINK=m
-CONFIG_TYPEC_UCSI=m
 CONFIG_UCSI_PMIC_GLINK=m
 CONFIG_SRAM=y
 CONFIG_PCI_ENDPOINT_TEST=m

---
base-commit: eba6ffc6c33353bb95c5d2bde35bb80e21c1f713
change-id: 20230324-topic-sm8450-upstream-defconfig-fixup-3516a5f976a1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

