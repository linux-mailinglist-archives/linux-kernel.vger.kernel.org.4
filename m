Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402885ECF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiI0VuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiI0VuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:50:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30E46DB7;
        Tue, 27 Sep 2022 14:49:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so17661211lfm.4;
        Tue, 27 Sep 2022 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=D0MLDmFCzrDHPaAoihQC4HNESIaoL+U9+T8O5T+wSr8rLLIJ4Cq8awtFVsYWR4ekDz
         eMiKi2Fz2sRkX1ItauA6IH8l++c4NHpUVNYMYr6aT3X77neUIb5gxdrxgsLt0jcq/Kvh
         +pr/BXE7kcZLJV9zHqXrO0SVoWMp1q9TjxP5b93Qg8Mp3AHp3kkj5s01lYJrQibhd75s
         vy539Eq5+pSqA5T7t0WLX7ljHfnZgcUIj0JATQlFLolIpT+JkAvZTTjWz+b/LHq0+ZmG
         abLVO/lGE+EmUbUUA7ISB2NJHIeBWN4x9/7sZ3dLfPw/Zu7EERURRVgEjhBAhMITGfD9
         AMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=zsTrXvWhiJkSFxEYAX4umkbYAecpWhfxK/QX00dQXftSA+QDs2GgYnwvGDo9DyISm4
         Nkx/qrTSfNHTvJGyhiUhO8cXk6IZs6yJfI9uTCY6sp+1YLo4AuXpFTc5sqB9n7fHUAjk
         cyLsdPBRHJJR9bJm4tk09NPkEqfko1xOGbRNUDdtEKhKn9U/M02skMiqce/9gojg8Zpf
         QGA1DteNqBQ996LXR8J1OFpf8epaUP3V9TaeJRwWXl/dRX0dYrYUUKMElHughGhvUOTX
         yVcBvd8qszOJGmfRxjnmvnIUdM2QHAR5QvHClCuOPQPs2ZPEWWW2GMmJoho/F4m6xLlZ
         ZBmA==
X-Gm-Message-State: ACrzQf1jxS4qFH69O/EnBc+cIy2PbWHWglCshlgbDL7rCZPthaPnYq7A
        8AFJiiEmpnCB1iWkpQO4tQRV7nQuCQE32A==
X-Google-Smtp-Source: AMsMyM5XF2Vp/tWGl1RAmm7JSsKWgOE3xh+phtDn9slW9iwn+q/Te+u3EFduCm0qsZyrOCiNxSDrpw==
X-Received: by 2002:a05:6512:15a9:b0:498:f17b:c733 with SMTP id bp41-20020a05651215a900b00498f17bc733mr11634981lfb.606.1664315394694;
        Tue, 27 Sep 2022 14:49:54 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id u25-20020a2e2e19000000b0025fe7f33bc4sm279901lju.49.2022.09.27.14.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:49:54 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
Date:   Wed, 28 Sep 2022 00:49:38 +0300
Message-Id: <20220927214940.244480-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
References: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) wifi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Change codename to matisse-wifi
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..883ba92f589c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -115,6 +115,7 @@ properties:
           - enum:
               - asus,sparrow
               - lg,lenok
+              - samsung,matisse-wifi
           - const: qcom,apq8026
 
       - items:
-- 
2.34.1

