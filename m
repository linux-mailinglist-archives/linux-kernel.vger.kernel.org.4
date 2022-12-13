Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D964BA95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiLMREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiLMRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:03:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05409C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:03:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z26so5943862lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9whwM05lxda1ZLYL23P+3imYfDYTBHNqamA4JNSFNFI=;
        b=denNa49m9X7502D9PP+mm3zEdhaFEkwFeb0OqDobKmiEJhPtkRw8O0sKZ2/3c7ocEq
         WwxlbFZafpNNrugpEnnjtsKX8GYHp6Zs6uBAQi7Qf2jEl5Vm8prDP1mUSUOL/cqfQiHo
         0pZTN8lZscPgYcsvZvB05nVyUJl3SoY29FeiwMQAA3UE8LNMoyLaZhBNhWFAU/x3loe2
         FXTK9w5ofKoZ1Mjz1BP/8rk6W4XLRNS5CvE/AfZFv39e/CGddqZBsP6mI3wq4KNwWlDJ
         D8oQDDldNe53tN2GLwxY+GCjiv+5VMVwhlP0XSMOy5Udrm7avwL+2MMBBeGUNwTlsTu0
         re9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9whwM05lxda1ZLYL23P+3imYfDYTBHNqamA4JNSFNFI=;
        b=SGae/olAMO2IyZyORKNHHF/Zybd3LlfiLvp0OK3Z+WWlUFKMunLcqQGA1HL0MzRjVW
         TnTykQmAnP05qORV4z1aIotXmcjQ8jAtaWQeGDGBpoZu0D1n1bsZOAGWICpHE+3WcJ5n
         OKBn9LomtJONpfNOdWqKle7zAoIN654LQpvg6x3csz1+lVF99Q62vaMPKhkcbmq1mcoH
         d8LDZZEd/CEMFTKuBCcbWhaU2Lgi+M3synHYR7iCW8shnSLNLNJJkqLF/dcHLCdAv29p
         28WAdI0xlMKW1poMVSVGZUaOACsbF7Pr4OkXnTcHI/OWoqGr7UQV7tzEJzmWZz9rLku0
         EsJg==
X-Gm-Message-State: ANoB5pmGWjCOsKmXatOMwdRkkALdLz1aJ5iKVXOnXxV4BlNV0EWiywkT
        OTECa7PagWzcriEiDqu/qzeU+Q==
X-Google-Smtp-Source: AA0mqf4jHH75SmQqWvHYvfNT7mfYPRnT7ZFgWdWH/FIcr6rzs+0QZDhPU790s+T0HexPk9lB/MgOFw==
X-Received: by 2002:a05:6512:1512:b0:4b6:f647:a98f with SMTP id bq18-20020a056512151200b004b6f647a98fmr1381190lfb.62.1670951032070;
        Tue, 13 Dec 2022 09:03:52 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b004b56bebdc4esm446874lfs.14.2022.12.13.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:03:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Document qcom,assign-to-nav
Date:   Tue, 13 Dec 2022 18:03:39 +0100
Message-Id: <20221213170340.456252-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
others really don't want that. Since it has to be conditional, add a
bool property to toggle this behavior.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index 2998f1c8f0db..1d8c4621178a 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -31,6 +31,11 @@ properties:
     description: >
       vmid of the remote processor, to set up memory protection
 
+  qcom,assign-to-nav:
+    type: boolean
+    description: >
+      whether to also assign the region to the NAV VM
+
 required:
   - qcom,client-id
 
-- 
2.39.0

