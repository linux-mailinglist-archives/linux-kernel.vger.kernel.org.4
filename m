Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9965A5E2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiLaRGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLaRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:06:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF761148;
        Sat, 31 Dec 2022 09:06:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z26so35941252lfu.8;
        Sat, 31 Dec 2022 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZuN1LxRja9IoziQ4hYPuG+gUEYeFJZkai3EMlidSdQ=;
        b=SV6Csk5E1lUiIDAMmVJfmyHpbAQHwX+TweuEANl2e7fapdY8E9goESoL3uqWiX3MUN
         v/qD/iEphEPD3n2Tq3iB4jLssDgCKP4Eco+BvkHarEWE5+PoIEMRZm7df9cLruqY4iUR
         PHnhSHIP54ST0ZDZI8euujFt4sNNQbCb7EO40rTH9e1CeIZTIAKHnWCXqf6YnOw00GkK
         rP2Hd18vHcCSurM1K44qMOPz3ED/otcQs5Ra3XRpCBhEdITr2H7y4TKU2MVRyTVNBM87
         QGo5/B5OXNu2zn3Z1ZiH8hWXA2A8oOPDincCNIQDi2AWsSiygL9BhJ1JMXW/AodpdKlu
         Mg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZuN1LxRja9IoziQ4hYPuG+gUEYeFJZkai3EMlidSdQ=;
        b=WP/6ZDoVm7HFCSVVvJGJD9C1A++yKDkjJujapO0KeWpIsnwVcfusSm315rCDTa5Dvo
         oGTaIDk6QWjd/m6FkzKrsX0xRgwPochvGpSGIx2nnm02iDaFws1hOSYIF24uaFGDem8H
         28cO6iWloBfaIHfmJfpP5/kDQJ8BBXyzEwySEEtu+IUg19/VtCdsIo9zLb4qIcnGywdf
         kZ6xTpCx8eNN9fpDjqDZm3LhKDRU+JG0RtSFNRDF5CN4nCUTr3V0ERWmGw/8cIjWgQdL
         Lqw+0imtR7/g4/s6my4JRQBsTgl4z4NrgPKEijp+leSgThq+2LbyqOxpg4ijPgIA8DEd
         84iQ==
X-Gm-Message-State: AFqh2krfyoF1pYDzitmtdCLXHp3FkYfYipxT7u09Atm611jmi/z4oo0k
        /a+88A6clieROr8Qr33zV1sDHf7GnmLRfA==
X-Google-Smtp-Source: AMrXdXs8Ll20pQVgnasU5JAgrg+bBenDu1rLCUUTtnOKPIxt8IoLCOU8Y7pbjnv4yTDLUROw7waFmA==
X-Received: by 2002:a05:6512:695:b0:4b5:8502:efb4 with SMTP id t21-20020a056512069500b004b58502efb4mr12391854lfe.69.1672506360068;
        Sat, 31 Dec 2022 09:06:00 -0800 (PST)
Received: from localhost.localdomain (byx211.neoplus.adsl.tpnet.pl. [83.30.43.211])
        by smtp.gmail.com with ESMTPSA id i3-20020a2ea223000000b0027dd8627ad2sm2868088ljm.69.2022.12.31.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 09:05:59 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: msm: dsi-phy-28nm: Document fam-b compatible
Date:   Sat, 31 Dec 2022 18:05:32 +0100
Message-Id: <20221231170532.77000-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document omitted 28nm compatible which will be used on MSM8976 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
index 3d8540a06fe2..b237abe859f0 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,dsi-phy-28nm-hpm
+      - qcom,dsi-phy-28nm-hpm-fam-b
       - qcom,dsi-phy-28nm-lp
       - qcom,dsi-phy-28nm-8960
 
-- 
2.25.1

