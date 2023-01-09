Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6F66267A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjAINHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAINHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:07:14 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959D32278
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:05:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so12815895lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UT5KZHFU2APdX6WKtUWfM1YWxYsapsClz8r4c1DQ7os=;
        b=u80RPEj9hQlJGcXwm1t2XIvOcnMdfARhIhM8YGRn/ro5bCNJwMRYFkRftGzRk70xFV
         xHjH+7NMt7OSjY2vM3kXfCiDpV8DidpF2dRpJNNua/yHqSrQEXmGdeaSjQDfHu6B76JA
         iYBCoCgeFoso5PWfy5CTLpu32kuoCSKN3Js5SCSu/qFTiuf6rABkKaXwB7mZZ5SPEd5q
         MKFRZJGwEhXnbpcgdbIkCSBnqkMTGzVC95IuLUOWtQW6LLuu2vXPqz5/qJjKZ/xnjOhI
         ZpoVLV739lrMjrfMKlCjZ49MvZcikTsrhTevWqFFNgNqMajTD4nOElJ3S08B61qArP9Y
         3KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT5KZHFU2APdX6WKtUWfM1YWxYsapsClz8r4c1DQ7os=;
        b=ZCSI0O+TPsmjDCuiDvER/fRutCAV4fQm08T1BHVFawFA9u0MyzpjZ85JafekJzcLWh
         3QUhcmU98jkC/uxerz30/4X53C2Pl2dcMnJLzDdiOIIQ12ebMEeQ3fUixtug6ZdABo9l
         6aVCa4M764jOL9G+hbxv6gujg1+LQCk2StQiKmEC/TlriltWN2dgK8F+gA0h/HoYK9q7
         6iO+Y7zg+NY94ZehXfgTZINJRwNA5SkfvtaIrsCYhsf2/iQErpExJc+7r+Cw3RGF/SBl
         FZYoorfhuPKqV2lKo6EOCtFGo5Mxn+bzy4Ct1iYPQ5T8ntljU6eZfilCX+zmFQeFP5xy
         ROlA==
X-Gm-Message-State: AFqh2kppItlkmEbxMXAntcuvs48do12bQ8Q/c/z9VIFgl+ECoun6JB17
        LDhGtPo/LkQ5hJ9Z8YaOZczNDw==
X-Google-Smtp-Source: AMrXdXvJoElnuck7QfwspDmIPoHohcnd+GMQiWGHC3zRmuSzILKv4e7Q+X+Na6wMs1ZDWVv40BTxrQ==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cc with SMTP id t4-20020ac243a4000000b004cb3a6065ccmr6877919lfl.5.1673269527885;
        Mon, 09 Jan 2023 05:05:27 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b004cc5e97d356sm1615031lfs.148.2023.01.09.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:05:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: reserved-memory: rmtfs: Make qcom,vmid an array
Date:   Mon,  9 Jan 2023 14:05:21 +0100
Message-Id: <20230109130523.298971-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
others really don't want that. Since it has to be conditional, turn
qcom,vmid into an u32 array so that we can handle the NAV case, as
well as other similar ones if they pop up in the future.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v3 -> v4:
- Constrain the vmid array

 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index 2998f1c8f0db..08eb10c25821 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -27,9 +27,11 @@ properties:
       identifier of the client to use this region for buffers
 
   qcom,vmid:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     description: >
-      vmid of the remote processor, to set up memory protection
+      Array of vmids of the remote processors, to set up memory protection
+    minItems: 1
+    maxItems: 2
 
 required:
   - qcom,client-id
-- 
2.39.0

