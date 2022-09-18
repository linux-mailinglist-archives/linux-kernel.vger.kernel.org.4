Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46A5BBD31
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIRJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIRJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:57:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A9BC03
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:54:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f9so41580810lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=J+6gcPp9CDseK1qwaGJdlUm+d5gzsbdnc0Q6gwGr3SE=;
        b=qQCEJFzlCjO1qpQjOiEkN47TwRkRFxPpreRhxL0npTR5GNqdhjN094RMdNOugmPQbY
         4R2vmOInyW1+dLGTvCdlQrSnqCcr01s514zwezLPBAc4hYuePjZGq32pG7G/YleFVk4E
         nE1kQROPw1A62sG7tIE0vWOpFSlro85YEth9rZQT+PN6ndNceIscbw7bPQX1ce2yks+a
         VFlt7qmVhLGUD4wyiEp+sJsb+mmRUSGnaTzJufhJE7uWegqJL3cbX6MwOGqjSdh1BSyX
         Q+nf87qU0T2dK4ye/XvVUdve36lbwddIA18VAQt5I/haSa3vXA/7LrhN/5I7Ss9Z2uBZ
         4x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=J+6gcPp9CDseK1qwaGJdlUm+d5gzsbdnc0Q6gwGr3SE=;
        b=OeNaEcR+IVqgQMvCd+Ysfz9jFDp7j2jHU5r1eAKqESYwpNDbyItV6x1kV7l2nCnsyi
         nqfCxh3sU1+zi0RCjY3pCFGYhBVWNB7KIFNKXKbjTFiV+5SF0NVpPeyTIHLsLfR52i4P
         3WJuErgz0unbpadp8RBSLn6E4R8mMCdvlFg7mstyJtnIcCLAdnuF9Pi0L5pAGNLYuX/W
         /rDtnIA9DBzXrEeyu2VCKPx0OO5xDHotEF7pVVDea/JZW9atzoe0g+t6kP3IWLHuvuEs
         1D9VBTD9qFSbnx8vlJRQstYWbRfnbpr1Trr+tEvgcZHMPmM81DWFkKvBmn3TRJn6JyH5
         Qrug==
X-Gm-Message-State: ACrzQf1MsIGlDqxCyh1kZLGrsADEa14gbeN5+AtSWbowWPEwHSEI67t6
        zyM/5XbdjbWFHsvF7Y0SEPS0Sg==
X-Google-Smtp-Source: AMsMyM7Fu0B5u1LgnyhsPM/WSHOLR+bZcymDs4MF6UNhjHc53XbV/jvHtyZxuy1/vep2nJt/el3qCA==
X-Received: by 2002:a05:6512:21c9:b0:492:f0f7:d82f with SMTP id d9-20020a05651221c900b00492f0f7d82fmr4162301lft.588.1663494875313;
        Sun, 18 Sep 2022 02:54:35 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b00499d70c0310sm4403410lfr.3.2022.09.18.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 02:54:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: qcom: document Google Cheza
Date:   Sun, 18 Sep 2022 10:54:30 +0100
Message-Id: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Document Google Cheza board compatibles recently added.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..90637b425ce4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -674,6 +674,9 @@ properties:
 
       - items:
           - enum:
+              - google,cheza
+              - google,cheza-rev1
+              - google,cheza-rev2
               - lenovo,yoga-c630
               - lg,judyln
               - lg,judyp
-- 
2.34.1

