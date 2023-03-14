Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC26BA18B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCNVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCNVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:41:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412ED10AAA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:41:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br6so3671513lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678830088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yvEUWBXdbCRFY8TAESh7SInKeyaYHHG8L4zlkeW7cI=;
        b=SCfhJRF/A+HNm2Kfok4EDJ8/gUFPpv8OxPX+6jy3blR/c6gLi2mjn0LV02hs5KOyUA
         KvnFl9TkPgZFfTEjvf0997chPsKQT07MCbdFNNvVyTXH67mVIYvYE/na0tXGuFFK8Qx2
         iF2l9R+UPU95HMctQz+aVLjY2pYMQggXgnM42fE7j3AgHwL7ScIzasgQq3r2irS+N67Y
         GQRXDqBKEDMMvjqwPHlfsnZK8awOTGQIQa5U+HRFzZ2MhEbpr/opBTY3jvziHhqyTUvx
         uzwMkytAjNwPU8CwJxH1O+1cefhJofgnsTPAjPZO0LeP8VDsnrCbhEKWMbiD8vfQEEAO
         Ptsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678830088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yvEUWBXdbCRFY8TAESh7SInKeyaYHHG8L4zlkeW7cI=;
        b=tfRRgetk2i7pH4/yZxIy5PmYLSwhLiBAwldP0kYYKSQ2r4ihHOZL6GOlGEo9DHesgh
         7jAZDNYRrtQDNzdHbqWo6hHMiI5jGQMqVl++wgXyyvOiqNwT3st6L5+NPLo5cdEm5TOV
         GILGfIQx1BJ+kIiQBjj89ugBWPXAhGvrTQIKyz8blYwBZ78b/CDRTGj6Yev6YnSYWJRI
         m+crktdFHP+qy4DrRZDz6IdFbZ1PmndEdyVqAi6oJxzvQEz7KKXTVtQ9n/z6GBemoeX5
         DAqcfnTWfhpKUnqgwcYqbllmi6Y/NdlI5qtcaujbg67L7jtLTXyyrGQ1WU3sMrFuH8Di
         +EqA==
X-Gm-Message-State: AO0yUKWVYyLzSsyOQEoBD6x4h1s2h6fOqV5Fn6EzSDFYBxePpYN7D24e
        L15rH+/R0PCr/WrPHFzalPVFww==
X-Google-Smtp-Source: AK7set/QaT/Ej6tdSlrzaSgawCGAEqd/mhYaTLfFmwlmc84w7Gk6qGEEy6bcobqqaydfR8Dv1deOZg==
X-Received: by 2002:a05:6512:20a:b0:4db:4b7a:d6de with SMTP id a10-20020a056512020a00b004db4b7ad6demr1419149lfo.63.1678830088520;
        Tue, 14 Mar 2023 14:41:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id g20-20020ac25394000000b004e81e9d77c7sm549081lfh.107.2023.03.14.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:41:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 22:41:15 +0100
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for
 QCM2290/QRB2210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-scuba_socinfo-v1-1-acd7a7ab9d46@linaro.org>
References: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
In-Reply-To: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678830085; l=908;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Lkz7DjNOoFEWDNkzuEDF9ckber2Yn0iVwvxKGNTqpx0=;
 b=VlBitLvY9P4tfp2UTkXZTx+GoJvGpluTVlgLBUsoWGhNYgYDfCStDac6LMYpSngSXAQlbvuXxJ//
 TfwFrIH7AJEEDJ6i2J7bHqNfOt3Tbwd9R5/DOA0jNHWitJ4lIHOf
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

Add the missing IDs for scuba and its QRB variant.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index aa95439708dc..0ce2fb3d4ca8 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -213,6 +213,7 @@
 #define QCOM_ID_QCM2150			436
 #define QCOM_ID_SDA429W			437
 #define QCOM_ID_SM8350			439
+#define QCOM_ID_QCM2290			441
 #define QCOM_ID_SM6115			444
 #define QCOM_ID_SC8280XP		449
 #define QCOM_ID_IPQ6005			453
@@ -229,6 +230,7 @@
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_QRB2210			524
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_QDU1010			587

-- 
2.39.2

