Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8562BD23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiKPMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714814083
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h9so29576307wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29tsCGJuEUN4XZ/iXoF/gQwu9WmWjy4DDv26eITvgQY=;
        b=f6n3e3EwRdSwVEcT9LSkHfkr8V2Q04EwuYjeYT+ADPTjZ94m+rvJ0F35UOueWHyVbz
         yJwbiNzWWK0vz2Zp9unpHawFDqY9Mq5BpxqtGYGWUf0nkzDCD/EHeVRQlz52s3nXibCO
         itwVTkkzIQA8EyE960IX3IqnLotGtwSH57hPvR81pzLRXpwE9Uuzchd+6jqnZvg9Jokl
         x9yW31WW2HbGU/Xqbv4ecYqkqhVF/8ReoUXRz0+Y7FF+o/VtFujSo00CpBBlN3OtroBD
         80AVkFA6ejSEU2QO3Lhkk0plYFeMUuBkPxDYdSn3wotKTa0XrV3uq+zOprP53rBsCSwW
         0osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29tsCGJuEUN4XZ/iXoF/gQwu9WmWjy4DDv26eITvgQY=;
        b=jSIq4sQ43+Zi1axy+qYjmM4osvKZ1TKwY7EsT5AGvO5l24yZ01/wPAbhPAztMw7ajV
         wzlzxpdWLgwrNLg8gpAl7v0ES5lkocpYLh5M3tZl8Zou2XSPRWxxkr0fZfMF8M0Cku1R
         Bz+BEdZAVFVulXNzdbNEpdWmWFFiih9L4u+O5PksX07/SvJCb4vdkdx0CkcO8QYqemOv
         q9hRn3LOkaeyCIPhU09AX++w6s32mDM+p89jU5KxBeiiER785ubVFFYs4/JBEeSHXbYX
         nMDvhqsmEsApjGzUd9OQmWv9iXBCdsGwbjPfh6NXM1cOgI8urJ9rK9Xz0uhYPUNXk+6C
         bquw==
X-Gm-Message-State: ANoB5pmiuFfSeA3mwphFg29rgUuLkh0Hcns9WVHbIrKnj7bhhxdo1lyg
        6i1MSa1r6HchaQlL3DDXzFGN5w==
X-Google-Smtp-Source: AA0mqf79a8TCF+Ze96qE5qHGxYCKTidrM3e+XF+CYLCD4TV52wzEcUu0lswOIKV1PE9cZYuj1hx7Fg==
X-Received: by 2002:adf:fa01:0:b0:236:6aa2:12e5 with SMTP id m1-20020adffa01000000b002366aa212e5mr13588312wrr.227.1668600125393;
        Wed, 16 Nov 2022 04:02:05 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:04 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 04/10] dt-bindings: phy: qcom,qmp-usb: Document SM8550 compatible
Date:   Wed, 16 Nov 2022 14:01:51 +0200
Message-Id: <20221116120157.2706810-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116120157.2706810-1-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
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

Add the SM8550 compatible to the list.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index 0c6b3ba7346b..cba2a252baf8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -37,6 +37,7 @@ properties:
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
       - qcom,sm8450-qmp-usb3-phy
+      - qcom,sm8550-qmp-usb3-phy
 
   reg:
     minItems: 1
-- 
2.34.1

