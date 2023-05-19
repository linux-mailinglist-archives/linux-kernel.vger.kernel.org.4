Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3F70A145
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjESVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjESVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966BE1B3;
        Fri, 19 May 2023 14:09:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso1629079e87.0;
        Fri, 19 May 2023 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530553; x=1687122553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVkA29jSyaurdy8QAUjHMp4an2hLXRPvKPNQgP/t4Tw=;
        b=L/FIlUHlutnt/VijoA+z+ths1fWhaTk29AlM5ExUFKVIcKLBvW5bmign++6FNmoM4F
         R+upBMDYwkrXemLL7wZ7Wi1RMFqOdCG4Yvqkz/xZD9PmAz0UJ359Aec7WLGs4MBpOCnS
         qkL4J0IcB81TFj54bgG49LKmPNP1lIiIWP7tSUi0r5BQ5bBojD06IrvA7myCfaAhuG5S
         qwQu0/C7ad5Qde6/q49qe4e49n8yw5+s8LLMNcHesHyKias8heMa0GicDnnE5HF9ChNS
         l0bwmBhWlIF1wUNImjPWJI9zQC9RRd776HJurcHrErEdJVnV3cBhztVE16aBx8XMuX+C
         Uh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530553; x=1687122553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVkA29jSyaurdy8QAUjHMp4an2hLXRPvKPNQgP/t4Tw=;
        b=IaQqB9bqKNO4Mopx9wjPPrXxihpPMBaPd+gu9Yj2RMtRWR2Sy8MHENjfYinmeokZ6p
         DK8fqPQQiv2c2WJrn9qqOvKYl9ldnzuzkpmODHJG0ueNtCV/zvKYzcUsi8l+kSRvi18P
         kXikmS3DksX7Q418DFreU5fewnGX7dQVqalMyj1lAhR+xpQrHxdjrAqHum1CncE9ppUL
         LxDVVhiZHKIm0Ze3MsxYGsTBm3iVO2H2oh5RY3dYwQWOtGcPYngQLyxoNNACJSs/PeGZ
         xFh2J7TX8lOy0i2pbn5YNaHbfjROfwtMqq8dyW6iP3HjNHfgyVl/baV+1Rrfg9AGF3N2
         gXdw==
X-Gm-Message-State: AC+VfDwG0WqWj+hgQ6bmhz/UzXeNzyHpPTS0ltQJ2n56KtHBrbWBZoYS
        ndIrSFMEUSlde7aWjy5q8qj5OTnQNVhPqw==
X-Google-Smtp-Source: ACHHUZ5Im+v50IbU/kwY6yOXUDGqLA+gSP6h3sIyxewRLu3Cu9Q91DtpqAuuM4BlVDe+JakqqGzhZA==
X-Received: by 2002:a05:6512:1105:b0:4f0:3e1:9ada with SMTP id l5-20020a056512110500b004f003e19adamr1244564lfg.31.1684530552616;
        Fri, 19 May 2023 14:09:12 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:12 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: sram: qcom,imem: Document MSM8226
Date:   Sat, 20 May 2023 00:08:58 +0300
Message-Id: <20230519210903.117030-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for MSM8226 IMEM.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 0548e8e0d30b..d9599ee51204 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -18,6 +18,7 @@ properties:
     items:
       - enum:
           - qcom,apq8064-imem
+          - qcom,msm8226-imem
           - qcom,msm8974-imem
           - qcom,qcs404-imem
           - qcom,sc7180-imem
-- 
2.34.1

