Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA570A7D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjETMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjETMTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239C10D;
        Sat, 20 May 2023 05:19:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efd6e26585so4688194e87.1;
        Sat, 20 May 2023 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684585185; x=1687177185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkz39YrJHA4xIA+wIv9InZQXMShtNvAlPjiM6h9FHQQ=;
        b=oJZL2xeV5jZKi2Zf0gOHAxSMitVyO366EKtNBay2+RRwq8iC8FjvEnuz6Niqb0MIZE
         3bg4ATRkJMeIiFgz2fxmU/x2hNsaM7OZo0xLgwYBZB32ZV5quEXUU3PcFSm56ab0odwN
         sBF1HXgl134CDTVjWnWQDmXnknmnR7cb48vhSL6XSmT4utZtdF7QaXWg2lFP4LzXPN9J
         JJVm8DNwghVpVgCchsGIvZ4hrTnDNrvj3n8gD387VhnBs8dIk+nXTOOqbQb7HWD/eynM
         Rpfe/LPe2GRaaiNCIBZ8iuG7EqIRQPaxLRMJ9e2Cp9LpmP0/PmM7F/R0/GVlTJhLDISq
         t8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585185; x=1687177185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkz39YrJHA4xIA+wIv9InZQXMShtNvAlPjiM6h9FHQQ=;
        b=OHO5+VcLE3nOTSDu7gYAV9GPzhGyhHO9HeW6NqCHMbqwmy2iyHBOr3VbKoqt6oIB7t
         PUwl/WvgBYP2Lyen0XEQvZwjF8SvKbeJUkXJIn1C1EMl7ju2kCYI/LciEY/LN366xI4k
         mzWnzbC2OKWxFgo9LwJmgK8GPYUiCSR3S5q6SGhpwb4n7X6vG0738k4bsLxCYfUKPjfp
         OgBUeuExY2PayR+gNstgd2FrUY5MC5pjvBTgpqluSOJLSiJu61Sd1TCcbS3+u002cQT+
         hr2sz8vLs5lkqIxMwedH11dSqJWW27bTrLHcE2NKkOhwxBfEczImrwpqyjnpKnh6VlYl
         U7nw==
X-Gm-Message-State: AC+VfDy5la0VqcNR32dbSsQYiqukpbA9TGuVqBE9zuP1HKaS6ruiT8k7
        A+8bpZ+byyqcVwQIqEnnl7HqYOWuxxRgwA==
X-Google-Smtp-Source: ACHHUZ4/bsJPqVib7++CjiTgiXi2IxIr1/ObQB2O5YQ0geFqM2sUwJQ2iwohfd9ZPU77cgyJwhoe9w==
X-Received: by 2002:a05:6512:21a6:b0:4ef:f3bf:93a6 with SMTP id c6-20020a05651221a600b004eff3bf93a6mr1832282lft.51.1684585184854;
        Sat, 20 May 2023 05:19:44 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b004edafe3f8dbsm260303lfc.11.2023.05.20.05.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:44 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: sram: qcom,imem: Document MSM8226
Date:   Sat, 20 May 2023 15:19:30 +0300
Message-Id: <20230520121933.15533-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index ba694ce4a037..318acd129ff9 100644
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

