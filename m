Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808126B9677
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCNNjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCNNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:38:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82262149AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:35:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s22so20042139lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHJQQDSSfg6kGfsi6pgfV3PKLyO1sa+tQqakRF9GWDc=;
        b=v/IjrKnAJus+TMT1ypkUmwsOpqhzUjX9i4SLpcKiUgogqoqFEKqhz5GCdMq9DPZZLV
         CAf9Vb5z2KunVvlQXt9P9J5tDp4YdMkm2mu+FkClQabatYRUN+yKahL9QN+gvyJ6ET06
         QEqn2jYoyFKXVGBv+mLal2wmKtwoh1W2GRKKXNeB/fVoKy8TnPyM24UhmxwC9JD+q69L
         6L/Do6/F974Llxj6I6//6c16yZFJmHn43XgRHr8fHd9Vpc60SJRbkiFnlFxWmi4IsM+8
         WKyODrgtLv3SrM8g0D/61jGJSppq5cYoFEeBRbTluzaOhp0u94PgRx7YZsYDD1BUuTmc
         aPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHJQQDSSfg6kGfsi6pgfV3PKLyO1sa+tQqakRF9GWDc=;
        b=wS732mvFRFdhkwgqPBEYjNtWosdEhyb9g/gCaDZ+ipATn/qPO7YtyOVEBTZDeAzrfE
         XsimZTGKDXJmackjF6+TpIrv65whXQhFj5SEbt/JqJdvbo9mZjj5nqf8TCHGnMzUXOkb
         74s57Ubjk5ca2xsjecDsyFMpqjH4foFltMmrj3OCrEhC4/+LCZX9GbDDwyB06Oon/nS9
         gTTAdq2fDRXjvPDX3bgvvOGGyHmXO9+sM4btqgvByARweeh7YDiFjiqbHJQgGkpnWU58
         FiB+/tVJ25iRDGKPsP+zDsUAOkCF3AkzXK6Y6fMMimEvTgIECZof+Cgw/TcD/joaas+p
         mPYw==
X-Gm-Message-State: AO0yUKUWpmtfg7buDWGdB+To1fdB6KmqDi1zZZKhCvDEyvbFqIKPsI2W
        eMztXB8IIxclJ6htiRxtWlWOKw==
X-Google-Smtp-Source: AK7set/UI4JbSdhtNIYW8lpHTngCmRMYkAy1qrnRS4qPNJeeY1E07yWSq7pkxOxk1RjcZ7rCCEmD6A==
X-Received: by 2002:ac2:5465:0:b0:4e7:fb5e:de24 with SMTP id e5-20020ac25465000000b004e7fb5ede24mr755491lfn.33.1678800924024;
        Tue, 14 Mar 2023 06:35:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id c20-20020a197614000000b004e841e52b48sm403556lff.117.2023.03.14.06.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:35:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 14:35:17 +0100
Subject: [PATCH 1/2] dt-bindings: nvmem: Add compatible for SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-nvmem_compats-v1-1-508100c17603@linaro.org>
References: <20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org>
In-Reply-To: <20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678800921; l=768;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=K7g3WEDvUMmDEucFGpxI4PLkYP5CoIY1rvegyX8shVM=;
 b=ttNvyhLSZtvbiziMkJajuTeQOgAf3u3iDv/4nz5eYZX6axR40A2deW7wbxjfoELimNudgHsTFI6X
 cyK2ac6xAbHZdFhHbkT/u/3YAgsd5qA6BIJPATwWhrWFT9O69clc
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

Docuemnt the QFPROM on SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2173fe82317d..cbc5a1ed7c6b 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
+          - qcom,sm6350-qfprom
           - qcom,sm8150-qfprom
           - qcom,sm8250-qfprom
       - const: qcom,qfprom

-- 
2.39.2

