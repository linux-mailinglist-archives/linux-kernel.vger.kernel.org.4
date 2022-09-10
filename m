Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74E95B46BF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIJOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIJOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9F3E775;
        Sat, 10 Sep 2022 07:32:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so7821791wrp.11;
        Sat, 10 Sep 2022 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WZGv5+CGP+UkP4jlKo58CfTz8aX4C3qCae9y2y3t8As=;
        b=nfgyIXeug1H0nh4LxjaRRSC8P4WpjxvttxgNogoM5FYHNcnY9rJ20YLcoWU2+MlVxj
         lWmKkTOAwOLc4Z44nCAthInNDwkwEKjJMkdEaBjTQuLE2dEi+QDwVje4LYpgxkQ5Gpd4
         RhA+HExI4t7Le2hE6cLfmfdex+cgvIYmTU2NOMxLX+Hl0zW66X7NVjGhrf6ZBi70NFxc
         YXE8zegycoUtqWtzAEsg3PlzrT5btdrHob75zb4spJz9rmcezVng3pv/sLM0nA/mk75p
         FchA3SPuEa6+yn6MPOzueHpukiXYvhzuSJCtUZ/PK9h2fjYkvb4+U9nM2svfann0MU2F
         lKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WZGv5+CGP+UkP4jlKo58CfTz8aX4C3qCae9y2y3t8As=;
        b=H3p6EYj4ytVnVuZaqxq7hyL6M5uWFJVUi1/fyfRK4/q2TEtbownaBhalQeUVEVz5Pj
         X4q+zf6rt8dGqYymCE7jhXt62T39f/xZGFJcmwVFjnVxjGO9h3PoOsG8IAKwcUzWXN+H
         ivXHeDUkwlXOWdC+bfix0urcd5QNa70O1debKve+nTo+eK4N7sXj3IPDBb2Nami7Ynej
         lMGD0e1c0bb7KDQ82Lx3hPUWRxtEIzta9+4MyB+jdsMGSYRUGjdhR/cumG1eRnrJyArL
         W3PgdsMlTVafZIvj8esfkyO42unR7PbX9OKMl0PYh2AlIH708Ngxdqq1v+90r+spXxDz
         fZtw==
X-Gm-Message-State: ACgBeo1HdjRLt5mu3ecfibtX08bBhKeEvrE0af5NJ6mfhtdau+ty3iam
        Zoug+lE9aK+OKN9Nplmh86FEjrbBegaDtQ==
X-Google-Smtp-Source: AA6agR7MyKnaA7EwxSNL/mLn7cVOzByK2oFDJ2FRMAZt1/A0oMKoRi5VKPdaKQK0JRLHVCJWWIEuBQ==
X-Received: by 2002:a5d:47a6:0:b0:22a:3764:cdfa with SMTP id 6-20020a5d47a6000000b0022a3764cdfamr6010285wrb.547.1662820343258;
        Sat, 10 Sep 2022 07:32:23 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a54d610e5fsm4398240wmq.26.2022.09.10.07.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:22 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] dt-bindings: usb: qcom,dwc3: Fix SM6115 clocks, irqs
Date:   Sat, 10 Sep 2022 17:32:08 +0300
Message-Id: <20220910143213.477261-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
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

SM6115 has 6 clocks and 2 interrupts.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index cd2f7cb6745a..4ca07c79819d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -294,6 +294,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm8150-dwc3
               - qcom,sm8250-dwc3
@@ -348,7 +349,6 @@ allOf:
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
               - qcom,sm4250-dwc3
-              - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm6350-dwc3
               - qcom,sm8150-dwc3
@@ -380,6 +380,7 @@ allOf:
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
+              - qcom,sm6115-dwc3
     then:
       properties:
         interrupts:
-- 
2.37.2

