Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6011F65B550
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjABQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjABQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:50:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31F1F6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:50:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so42256666lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2X3LClvVib2/hNnEXNqeR2CvZH0rmRAd8DFSNKxgY5Q=;
        b=Y45y59OzI05LisjUASag+l5CMJMSN/UZaH9vfPtswX7N7TxqyneLfl2pw6WYJhCw6G
         jsb/ezF4j1nV8hZTxX9mvWMSskhHzYkNHYd4Fx6nDWM07v0/O3TsLXPgtk3owTfmTs87
         jJYHpHHg5Mz8oXt+3Oq+iOXSZxVvRWdxrRpW2Vm5hi13zJaSwfinXaDH6H+fx+dzMGKW
         ZkBe01H7+h/xHNmBPst4kdUxUMAst7O6+wNKLrcNaENRKpN8VzTzkFv5ga9C4Zr9IB+q
         s+k5wx8oEq8eUkO2IO8B5IMzXk5q+06lfXRnhTaem7e6SOcRi8MnCkGZmPBtTYXEmrVq
         lnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2X3LClvVib2/hNnEXNqeR2CvZH0rmRAd8DFSNKxgY5Q=;
        b=XZpxOdEyVl+edkwuo9m2LezFQT1zAguhcCt9lTYQu/1QPww1D8gctvSOfYQTmcpv1p
         OsVpJVTQEa64qlzzHk17f5rECKnZN73rwrl32r5MmWK7/bbPGmxXCG+/hTi8OxsNjFwf
         BXhmRSavm5xh84FslPnJXVJUxidR1oltx1AXY1ab3rzGJB5XNuugdzUbgqSticouaL6c
         AMN7ejINeZvlbsXye7GfnPk92Nd7pNGrdWSCyJ6ncNoayh3gSJcLzWPPjidRy0dm2jp9
         pP8L+jinycAkK53209YinwJ6Fpm9/ckuuxJCHZm4VYRx8sBrehCGadfUvguJk81VhV67
         vw5A==
X-Gm-Message-State: AFqh2kqkN7gue5hSWyP9pjvT6fzdRVFLHKFH6xC97FE9Q/IlRZ6rByhG
        Ny47Fn8cVK1KV1HIY7LsAuyK0A==
X-Google-Smtp-Source: AMrXdXvpFp/QqEMFzhlvlw9F1EmytinBUgmWeBn1onXB1ZylG8nB9w1epxkq0ZkZmIlMewmtq5QC7A==
X-Received: by 2002:a19:7b01:0:b0:4b5:a64a:4408 with SMTP id w1-20020a197b01000000b004b5a64a4408mr17292512lfc.48.1672678238609;
        Mon, 02 Jan 2023 08:50:38 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24348000000b004b49025f96dsm4510491lfl.187.2023.01.02.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:50:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: reserved-memory: rmtfs: Document qcom,assign-to-nav
Date:   Mon,  2 Jan 2023 17:50:33 +0100
Message-Id: <20230102165034.830620-1-konrad.dybcio@linaro.org>
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
v1 -> v2:
- Rewrite the newly added description

 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index 2998f1c8f0db..4026788a4e40 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -31,6 +31,12 @@ properties:
     description: >
       vmid of the remote processor, to set up memory protection
 
+  qcom,assign-to-nav:
+    type: boolean
+    description:
+      Whether to also assign the region to a third (NAV) VM, as opposed to
+      the usual 2.
+
 required:
   - qcom,client-id
 
-- 
2.39.0

