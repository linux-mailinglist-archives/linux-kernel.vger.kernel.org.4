Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F769517F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjBMUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBMUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:13:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BA1E2B0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:13:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v13so14555677eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjkVhik+WAb3qRRzojzZY2lXz1Voe6DUEDylRx+4D4g=;
        b=gtAjqWUBcWV4xgjaQ6CAAHoh6HLPZGuo6WxOY1i/c0Cb8YBdgt4jHiRINMV0EOfSSV
         xhawLvVfeZzETlmlBND5n/h99oFVun41/16CVAjdgvLkgC3g6u/Tvd0+W2YcoE7p3omL
         MwJwF60PRCJdBanXtFHLYmoYrGV5N0u/QU8BFqMQVancxIV+1yR9WrjlawBpF1DaFL9/
         mhWSZVQwKl6X0bDmN7RrA6kAmpsRZGGYTK//4T5AJesVWua8Z5oYxZ/1//eszrxTAf9E
         ik8/drFLxn/XL/bu9O+11ATqoSnpjLRD6Odp7xMwBQyVBIQ9LzbG4vuZJIE7smRZWryl
         f3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjkVhik+WAb3qRRzojzZY2lXz1Voe6DUEDylRx+4D4g=;
        b=P3RCJeB+OnQJl5I7S3QEB87nTNtuhs2H7CCs0KQIGWd0w07E+1HWTVi3x9PGMoatdE
         fXD13kveoCStZh0SPiCzplApbvYWYpVllTckqSc2vB4RdT4rC4OgSef5PXKEkZJsDzdf
         JK9KZRFayL7ZWbuy3Faok+QYi2dmPW0s5lD4LglMoH9NpO91WYjhDFDlQY+v/pyqHcTr
         HoPIEFSeCN/PMmtqJD1SVTnN57rYikvuzmL5A0It7jtF1BtpAVihpo+dPvhe6LcP0Ur8
         uIUO9Uw34GgEM3tmsdHOPGKz3VM01Fu3sQGDibM+Jg79Lup+dTeuz5miClV5B/kwAWxZ
         acZw==
X-Gm-Message-State: AO0yUKWDW+nlPBUX/83bHMfxQsHAHGUTxosDkcSXleznTiA2FQ5NeaCh
        ggZENzjez4noieapjVAL9g5+bw==
X-Google-Smtp-Source: AK7set9YU/NO+OmXrRLklZNzwVxNdZpEKT2OWpwGXr5FiZTDGEzYKQ9G2j6wtaKeCPUKm4U5C9JYAA==
X-Received: by 2002:a50:c006:0:b0:4ac:d2b4:5e37 with SMTP id r6-20020a50c006000000b004acd2b45e37mr2423427edb.39.1676319220217;
        Mon, 13 Feb 2023 12:13:40 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d0d4000000b004acc1374849sm2810440edf.82.2023.02.13.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:13:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Allow RRADC as adc@ subnode
Date:   Mon, 13 Feb 2023 21:13:37 +0100
Message-Id: <20230213201337.2089970-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

This was omitted when adding the RRADC bindings.

Fixes: 7ea58c951ab3 ("dt-bindings: iio: adc: document qcom-spmi-rradc")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index adf88245c409..8f076bb622b1 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -115,6 +115,7 @@ patternProperties:
     type: object
     oneOf:
       - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
+      - $ref: /schemas/iio/adc/qcom,spmi-rradc.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
 
   "^adc-tm@[0-9a-f]+$":
-- 
2.39.1

