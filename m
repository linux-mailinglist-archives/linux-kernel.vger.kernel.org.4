Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC647496B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjGFHmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGFHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:42:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021081BD9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:42:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so395637f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688629350; x=1691221350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2xJf6LtXqb+cG1cn+98PpU58/TQ6QjsGiq0akTtyxM=;
        b=g4/A9XOBZHSO3Z6bDesCK4elOmLEmIZ7+L/qFWQHNuiNXob2dL9fuYzHxAm/OicC5v
         59K6qoFWYMv4t6aQjBFPViHiW6xZGpuO/qUWmGUjMXmi40MCtiCxA/wDWMVg46nx51kW
         lRfmVR4MrqdEziav2zTnDkjPZ15zqCzZe3/fNJE0BzQ8otcQCVTOUi1ouiICOEdZsPLP
         gUNUTYLmyM/vgDbDdsPegV+HgT0evxIesGFjVjqBpU236ZTgXnXDqs736UqPRufCXvf9
         p/sOF7oHllcDCX/lk9NSKk+jfEjiJmHQtmGdgNcycluclfkoLQQb3Ns3GkaiyIvuT7m4
         n05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629350; x=1691221350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2xJf6LtXqb+cG1cn+98PpU58/TQ6QjsGiq0akTtyxM=;
        b=UzPDsPxUsbrkFMxKX3HonkMv0J7PE9Dnu4vcob8JkVMxW4nKq2dJ5lVsOTcVsjo0O4
         UXFy3K/j60SBVBqzO+U5aJyUt8aIbKo98TA2GkGwAh1OLMdgGSmOc4rvEJD74Bfy4d7Z
         nqhGoQpOxaD5CIQ+1QhYchKWUoCbpLrhQOqMrMhEUoKhwZLHzjfUz+CNwaMViLERTw4p
         sFQ9RR+xrMHOo0D9yorJNX7w75l++7DbfQiNpGCyCus/HDdJCGDADTE71bObgclqXsZ+
         1gcWIiM6SyiaqKTXEY8MJHUnMFosBDnnl15mRUo+9eUGSOaI57A28mA+ni/bdDb6PTE+
         Oe4Q==
X-Gm-Message-State: ABy/qLae17uMSe9oIH/Jw0Yn1ENGH03CeyJAxzt1+iebVWmwu6c0xNA7
        AgsOvuLVG2Op4yOiLgGFpraU2w==
X-Google-Smtp-Source: APBJJlFdWl/gUJixYmUhLPEj9ueBHY4XZg/xbYJXSAIyxIpr63uH1eXk6svgJovoAwwTNEnsYGwR3w==
X-Received: by 2002:adf:f845:0:b0:311:19a2:e7f8 with SMTP id d5-20020adff845000000b0031119a2e7f8mr1528509wrq.1.1688629350449;
        Thu, 06 Jul 2023 00:42:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h5-20020adffd45000000b00313f07ccca4sm1076798wrs.117.2023.07.06.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:42:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 09:42:26 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 allow gpio-line-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-1-fa442d5aae91@linaro.org>
References: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
In-Reply-To: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CvISq8m77qzrDepKN/pgIE8kK1poDrLznvCC1KuRa9c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpnBjuLrmzrKiIGe2f0Y08BKK5wT7jr6WDunTysTt
 ALbPD/6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKZwYwAKCRB33NvayMhJ0Xh8D/
 9Y9YZvHA5/qdF73W+DZOgviI/MlPr/M81wGeixqyfxgrNpRCVVDqD4vPhDrGTjN51jrgz2a4OBe3il
 BFBBsq3/rMrptLfOOr2gCw6y9aEFPpPbGcxky7rn5f0Df2eq5+Di3VIjAnxaR8r8R22/rorya8Ys+S
 MSHixtMF452I9n06+nWl3DfE9P539cKgWYBnp8uUXwyTtZgz57hyqR4x06Znjnv8QkcQGYj1q377R1
 dawUxCUEnWyQxKHZQMTpHCuUjPGwRUja3yl7Af8GoXwDFXUMNXOvVQckicr9Vye7Bf3bSZXVkCt/67
 p9p/y7h4zCrwVsZV94KMZTwDO0gw8ybeEm5alQvEBXhKWGTjUybGH2mlwNmGthPvWbaf0GFIveC9SC
 R3P0JX/snQWOX0oNbJumCPrcOZE333nFl7SP2bNsSAdsfIanUO1iS/TdoPqALS0hyxCRyqSJurijgI
 BhcAhILnlLCKnQjTi7NUUA2KSnX6kNXR8BxAgWmVbrUj5etgUB9qeYvGxLD01KgLblyIxcGDUMU3Sb
 kz6qNO3G+5E2FXMVj83hjNFbBVlG6NfprWoQOY6LqBE8GrTDXW6QYAkYR/dRleYE87oLBtitlMasED
 Eud3II2rH5fVd1D+7xwvRljmT+1oIbzRafjVcffYJe0wglRLNGcow7d3jJtQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow gpio-line-names property for the gpio subnode.

Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
index a7b29ef0bab6..28659f0389a5 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
@@ -34,6 +34,7 @@ $defs:
 
     properties:
       gpio-controller: true
+      gpio-line-names: true
 
       "#gpio-cells":
         const: 2

-- 
2.34.1

