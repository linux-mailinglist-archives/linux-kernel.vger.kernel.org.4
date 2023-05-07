Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FF6F9B61
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjEGUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEGUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A536269E;
        Sun,  7 May 2023 13:12:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so42079191fa.2;
        Sun, 07 May 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490368; x=1686082368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/R0mcMEc4aDzL1o3/ffY+gvjMVy2s/XzSb/ewVs8KA=;
        b=YpM7hBEFyBTH1OzGuI8HvkqRRif/GRjZT4iyn1FB+9IlZbTZIKihsnvQ5FkUq5z1Rm
         YxBd9Qg/E2z7tWNfMn0uCgVg7pjpOEdm51RIewcZMyOpxkoNN8+RBbtgTfAeDjkzqc2k
         YPsK1zFrMDupwWzujT4Q/rnJsfzTTQJSj7W4MWrpxQx12nkJ0TVQ2tZf9pI5ZtdcvilS
         cZGtkagTR7ZWCW2cs5zc5fAIp0dY332YsrcFKLuU1yyHNQ7EyHi07L31f2n8WAkOm7k4
         ZAVEhZg9GyEqk7Ln/iIXSxk9P8DtPMw8sT8ii5F1sEsp9pCJdxvGdCqWK4a9NcT+vXFn
         t6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490368; x=1686082368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/R0mcMEc4aDzL1o3/ffY+gvjMVy2s/XzSb/ewVs8KA=;
        b=U1FSCWWyS86gsVu+8SrKlLep7h6g0TlQKn+VIT6nSrc7iPyz9983VArLuvtZsHF0Ag
         rzxXbcdBcIBQtSD+arl0UD3jNNpJ/zJ4cF1n/th5t2XTiISxWPW1Fbptkw2cr7a6kdbX
         nYqEBUJWqZPQBdG/oNAKFNeSy7sBd3+TE/KhkNEEviIlJH62N64zKn+VEuahcnva6Ito
         jF996G+47aXQz9w2YyZNAss3HG005O2lBEvy17cXnVhWWg/hAgdHFZWRSTeBYNGjgQ8W
         SCzAF2Nir7O6tkJ/dG0cXQZA1rk40NRJ0NXLcyY3Ne7wm+PPGud84NqtUEsfU8fB/JUe
         5Tjg==
X-Gm-Message-State: AC+VfDzH7zgPVjaUlfadB1t4D+Li3K3F0S+AbcHOkF4usB2Mm+rGl2oj
        OTeGbg6CSEYFOBmmVuGhTbC4YywLcI5+4A==
X-Google-Smtp-Source: ACHHUZ49xXc3HaaMyxKl35IFOfvDlyfYwQYLqBLs1FR+e0+Pn4An2xGjUvBVn6uedHyyT0ETATCBuA==
X-Received: by 2002:a2e:9902:0:b0:2a7:a616:c39 with SMTP id v2-20020a2e9902000000b002a7a6160c39mr2020087lji.48.1683490367988;
        Sun, 07 May 2023 13:12:47 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:47 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: thermal: tsens: Add compatible for MSM8226
Date:   Sun,  7 May 2023 23:12:20 +0300
Message-Id: <20230507201225.89694-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
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

Qualcomm MSM8226 has tsens v0.1 block.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 926e9c51c93c..d6b2957d5137 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - qcom,mdm9607-tsens
+              - qcom,msm8226-tsens
               - qcom,msm8916-tsens
               - qcom,msm8939-tsens
               - qcom,msm8974-tsens
-- 
2.34.1

