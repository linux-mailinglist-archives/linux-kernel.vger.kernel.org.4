Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B737675A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjATQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjATQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:51:31 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512DC79E1;
        Fri, 20 Jan 2023 08:51:24 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id t7-20020a05683014c700b006864760b1caso3438742otq.0;
        Fri, 20 Jan 2023 08:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JyVBvaS8DArRG+fD+qTBA6qqHnG1DMVyMIdYWWgn5w=;
        b=3+NE+UT0xFdLtHYk884r1tlLMxFPtcREGI2f4npPSfb4H1zj7xZGCzsEkmHasQrKZv
         3eJ0ljrsDD+MvMoU+S/b4oJo4h8ZdfWnZU3NfClEjY0e+oOZynKZn7Ua/20q2NSC+/AO
         KZIcnaQnmJpCbO+6IYqEm1ZxqRjQfhW857mv5TfsqEfNfx3XIoxGcLTfTXazR3gJw9+g
         TRefCONMLCAW53YPy7p1TwFvVGhuzZDhznVeqTNhC5VJfrEv+4QKR+HW9CszxmYOwOKV
         5wbK8rePalGeXH5vUs13ZXL7sSYlPbK2nXuokYbAPfDT2JruvQDiTAvM2OiJ/DtnX2WZ
         pzpQ==
X-Gm-Message-State: AFqh2koLgdVve2D/m9lyVcqXyuo+WlDAB/b1/O/2pyNzYm285p4d1Lwr
        iIrDMifbT4DMUaxhrndiKA==
X-Google-Smtp-Source: AMrXdXtvg2V3G0yxbmgEB+KrdS1tOkEadr/sIZhX0jZxK0pLPYEtLBN4aQajSJpzcHAtqtFtCNKaCA==
X-Received: by 2002:a9d:6310:0:b0:686:5397:3388 with SMTP id q16-20020a9d6310000000b0068653973388mr6303745otk.37.1674233483755;
        Fri, 20 Jan 2023 08:51:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b0068664355604sm2911801otr.22.2023.01.20.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:51:23 -0800 (PST)
Received: (nullmailer pid 1279302 invoked by uid 1000);
        Fri, 20 Jan 2023 16:51:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node names to "-pins$"
Date:   Fri, 20 Jan 2023 10:51:03 -0600
Message-Id: <20230120165103.1278852-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just 'mpp' is a bit ambiguous for a pattern as it allows any prefix or
suffix. Change the node name pattern to "-pins$" to align with other
Qualcomm pinctrl bindings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Use "-pins$" for pattern instead
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 72cce38bc1ce..9412b9362328 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -74,7 +74,7 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-pmic-mpp-state"
       - patternProperties:
-          "mpp":
+          '-pins$':
             $ref: "#/$defs/qcom-pmic-mpp-state"
         additionalProperties: false
 
@@ -179,7 +179,7 @@ examples:
       };
 
       default-state {
-        gpio-mpp {
+        gpio-pins {
           pins = "mpp1", "mpp2", "mpp3", "mpp4";
           function = "digital";
           input-enable;
-- 
2.39.0

