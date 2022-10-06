Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA985F640C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJFJ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiJFJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:58:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39248991C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:58:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso605537wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=nih6K/iOH4NWZI3ARD7h83GsYopkCtps47Aq4lvZzNg=;
        b=JMM7jKixtXMGtXillk7/AJX3GCp2mUoK5P3vRzS2xwfMcMRSmqa2d1B4g4SO9GTFuA
         MYOarfSDLmml7ydx+hdZ020adhnILXB8ZIpWJ1IJY63mM3m2oFaJqos8Wtco/SO7TFgX
         dUNwXTj+PePl9OJpNpv4oT/EXM83QwKyT6iWOpkCXEHpabxdJhilbH0n7RbMaOxpagtr
         H5e3A0m4YGqjNi80/DHT5JG5NpHy5wvQ9mRhTPzcha2hLQZWzyhJr8g8BN9/VgwjufrJ
         dlNdpn2kewsvO73R0/UKyPC8FYZd/FU2n7esXtRpYvXGzwD73coNdXCXkEH5f2001Ewx
         Z3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nih6K/iOH4NWZI3ARD7h83GsYopkCtps47Aq4lvZzNg=;
        b=IzgeyDinYyc+Sn5hC2Z7MM9kkRtq73sU5HWCPjIMKDIefmpctjXPBvKXB4+yqHYg37
         5Xgi0yf2b/CG5N7w9RWcRGSwMAkaWm5Z8IOUkmt9ZbuWdrx5IxjvD68n8TDlxy8ZvXHC
         vTZgEljudz6QyCryix6MuDp1ChGmry3JfH8vS8QlMGr1HnI+upz73C2pTk7J7LYJIjod
         WbupVQ3cWg5o8M7vpbq0pEvQ7ADnoHC6dGAcDF1X/5sTqJbGap64hwQ82wMzRma9wi7Y
         MX250LQKI1XryoW3pwfUFZc2paA53oKHayyo8WAsmU3TEIAHBMDahjm6yXH4dNWFNntO
         Xenw==
X-Gm-Message-State: ACrzQf08YPAGxkE6AMgMPW23NSrK+M9vctzhN6HLpuvyMeKFX6grCwJQ
        6X2bg8cQdOI6oxfaqYyvN2mKeanoB11TZGs3
X-Google-Smtp-Source: AMsMyM4sjs3gknfpIApTwoNfjyL3v4ulJKadJBMHIxN8VrMkfyx7G2Cpnnf9LaLRw2P974Z5/miUcw==
X-Received: by 2002:a05:600c:4209:b0:3b4:fb11:3b8b with SMTP id x9-20020a05600c420900b003b4fb113b8bmr6077837wmh.144.1665050286353;
        Thu, 06 Oct 2022 02:58:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm17935603wre.58.2022.10.06.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:58:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Oct 2022 09:58:03 +0000
Subject: [PATCH 6/6] dt-bindings: soc: qcom: ipc-rpm: refer to
 qcom,ipc-rpm-regulator.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v1-6-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have bindings for the expected regulators subnode, refer
to the right qcom,ipc-rpm-regulator.yaml bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
index d416950189d1..d18200d5c5b5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
@@ -47,7 +47,7 @@ properties:
 
   regulators:
     type: object
-    $ref: /schemas/regulator/regulator.yaml#
+    $ref: /schemas/regulator/qcom,ipc-rpm-regulator.yaml#
 
 required:
   - compatible

-- 
b4 0.10.1
